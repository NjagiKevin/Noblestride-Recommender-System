from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.http.hooks.http import HttpHook
from airflow.models import Variable
from datetime import datetime, timedelta
import requests
import logging
import json

logger = logging.getLogger(__name__)

default_args = {
    "owner": "noblestride-team",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=3),
}

def check_services_health(**context):
    """Check if both Node.js and FastAPI services are healthy"""
    try:
        nodejs_base_url = Variable.get("NODEJS_BASE_URL", default_var="http://host.docker.internal:3030")
        fastapi_base_url = Variable.get("FASTAPI_BASE_URL", default_var="http://host.docker.internal:8010")
        
        # Check Node.js service
        try:
            nodejs_response = requests.get(f"{nodejs_base_url}/health", timeout=15)
            nodejs_status = "healthy" if nodejs_response.status_code == 200 else "unhealthy"
        except:
            nodejs_status = "unreachable"
        
        # Check FastAPI service
        try:
            fastapi_response = requests.get(f"{fastapi_base_url}/health", timeout=15)
            fastapi_status = "healthy" if fastapi_response.status_code == 200 else "unhealthy"
        except:
            fastapi_status = "unreachable"
        
        health_report = {
            "nodejs_service": nodejs_status,
            "fastapi_service": fastapi_status,
            "check_timestamp": datetime.now().isoformat()
        }
        
        logger.info(f"🏥 Service Health Report: {health_report}")
        context["ti"].xcom_push(key="health_report", value=health_report)
        
        # Only proceed if at least one service is healthy
        if nodejs_status == "healthy" or fastapi_status == "healthy":
            return True
        else:
            raise Exception("❌ Both services are unhealthy or unreachable")
            
    except Exception as e:
        logger.error(f"❌ Health check failed: {str(e)}")
        raise


def extract_noblestride_data(**context):
    """Extract data from the noblestride PostgreSQL database"""
    hook = PostgresHook(postgres_conn_id="noblestride_postgres")
    
    try:
        conn = hook.get_conn()
        cursor = conn.cursor()
        
        # Get list of tables in the database
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
            ORDER BY table_name;
        """)
        tables = [row[0] for row in cursor.fetchall()]
        
        # Get counts from each table
        table_counts = {}
        for table in tables:
            try:
                cursor.execute(f"SELECT COUNT(*) FROM {table};")
                count = cursor.fetchone()[0]
                table_counts[table] = count
            except Exception as e:
                logger.warning(f"⚠️ Could not get count for table {table}: {e}")
                table_counts[table] = "error"
        
        # Push data to XCom
        context["ti"].xcom_push(key="table_counts", value=table_counts)
        context["ti"].xcom_push(key="total_tables", value=len(tables))
        
        logger.info(f"📊 Database Summary: {len(tables)} tables found")
        for table, count in table_counts.items():
            logger.info(f"  - {table}: {count} records")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        logger.error(f"❌ Data extraction failed: {str(e)}")
        raise


def sync_with_fastapi(**context):
    """Send data summary to FastAPI service"""
    try:
        health_report = context["ti"].xcom_pull(key="health_report", task_ids="check_services")
        table_counts = context["ti"].xcom_pull(key="table_counts", task_ids="extract_data")
        
        if health_report.get("fastapi_service") != "healthy":
            logger.warning("⚠️ FastAPI service is not healthy, skipping sync")
            return
        
        fastapi_base_url = Variable.get("FASTAPI_BASE_URL")
        
        # Prepare data for FastAPI
        sync_data = {
            "source": "noblestride_database",
            "table_summary": table_counts,
            "sync_timestamp": datetime.now().isoformat(),
            "total_records": sum(count for count in table_counts.values() if isinstance(count, int))
        }
        
        # Send to FastAPI model endpoint
        try:
            response = requests.post(
                f"{fastapi_base_url}/api/model/training-complete",
                json=sync_data,
                timeout=30
            )
            if response.status_code == 200:
                logger.info("✅ Successfully synced data with FastAPI")
            else:
                logger.warning(f"⚠️ FastAPI sync returned status {response.status_code}")
        except requests.exceptions.RequestException as e:
            logger.warning(f"⚠️ Could not sync with FastAPI: {e}")
        
        context["ti"].xcom_push(key="sync_result", value=sync_data)
        
    except Exception as e:
        logger.error(f"❌ FastAPI sync failed: {str(e)}")
        raise


def generate_report(**context):
    """Generate a comprehensive report of the integration"""
    try:
        health_report = context["ti"].xcom_pull(key="health_report", task_ids="check_services")
        table_counts = context["ti"].xcom_pull(key="table_counts", task_ids="extract_data")
        sync_result = context["ti"].xcom_pull(key="sync_result", task_ids="sync_fastapi")
        
        report = {
            "pipeline_execution": {
                "dag_id": "noblestride_integration_pipeline",
                "execution_date": context["execution_date"].isoformat(),
                "run_id": context["run_id"]
            },
            "services_health": health_report,
            "database_summary": {
                "total_tables": len(table_counts) if table_counts else 0,
                "table_details": table_counts
            },
            "integration_status": {
                "fastapi_sync": "completed" if sync_result else "skipped",
                "report_generated_at": datetime.now().isoformat()
            }
        }
        
        # Save report to file
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        report_path = f"/tmp/noblestride_integration_report_{timestamp}.json"
        
        with open(report_path, "w") as f:
            json.dump(report, f, indent=2)
        
        logger.info(f"📋 Integration Report Generated:")
        logger.info(f"   - Services: {health_report}")
        logger.info(f"   - Database tables: {len(table_counts) if table_counts else 0}")
        logger.info(f"   - Report saved to: {report_path}")
        
        context["ti"].xcom_push(key="final_report", value=report)
        
    except Exception as e:
        logger.error(f"❌ Report generation failed: {str(e)}")
        raise


# Create the DAG
with DAG(
    dag_id="noblestride_integration_pipeline",
    default_args=default_args,
    description="Integration pipeline connecting Node.js database with FastAPI recommendations",
    start_date=datetime(2025, 9, 18),
    schedule_interval="0 */6 * * *",  # Every 6 hours
    catchup=False,
    tags=["integration", "noblestride", "nodejs", "fastapi"],
    max_active_runs=1,
) as dag:

    # Task 1: Check service health
    health_check = PythonOperator(
        task_id="check_services",
        python_callable=check_services_health,
        provide_context=True,
    )

    # Task 2: Extract data from database
    extract_data = PythonOperator(
        task_id="extract_data",
        python_callable=extract_noblestride_data,
        provide_context=True,
        pool="ml_training_pool",
    )

    # Task 3: Sync with FastAPI
    sync_fastapi = PythonOperator(
        task_id="sync_fastapi",
        python_callable=sync_with_fastapi,
        provide_context=True,
    )

    # Task 4: Generate integration report
    generate_integration_report = PythonOperator(
        task_id="generate_report",
        python_callable=generate_report,
        provide_context=True,
    )

    # Set up task dependencies
    health_check >> extract_data >> sync_fastapi >> generate_integration_report
