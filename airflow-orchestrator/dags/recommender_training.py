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
    "owner": "recommendation-team",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}

def check_fastapi_health(**context):
    """Check if FastAPI service is healthy before starting the pipeline"""
    try:
        fastapi_base_url = Variable.get("FASTAPI_BASE_URL", default_var="http://host.docker.internal:8010")
        response = requests.get(f"{fastapi_base_url}/health", timeout=30)
        response.raise_for_status()
        health_data = response.json()
        logger.info(f"✅ FastAPI service is healthy: {health_data}")
        return True
    except Exception as e:
        logger.error(f"❌ FastAPI health check failed: {str(e)}")
        raise


def extract_data_from_postgres(**context):
    """
    Extract investor and business data from PostgreSQL database
    """
    hook = PostgresHook(postgres_conn_id="noblestride_postgres")
    
    try:
        # Extract investors count
        sql_investors = "SELECT COUNT(*) as count FROM investors;"
        conn = hook.get_conn()
        cursor = conn.cursor()
        cursor.execute(sql_investors)
        investors_count = cursor.fetchone()[0]
        
        # Extract businesses count
        sql_businesses = "SELECT COUNT(*) as count FROM businesses;"
        cursor.execute(sql_businesses)
        businesses_count = cursor.fetchone()[0]
        
        # Push counts to XCom (simplified approach)
        context["ti"].xcom_push(key="investors_count", value=investors_count)
        context["ti"].xcom_push(key="businesses_count", value=businesses_count)
        
        logger.info(f"✅ Found {investors_count} investors and {businesses_count} businesses")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        logger.error(f"❌ Data extraction failed: {str(e)}")
        raise


def call_fastapi_preprocessing(**context):
    """
    Call FastAPI endpoint for data preprocessing
    """
    try:
        # Get data counts from previous task
        investors_count = context["ti"].xcom_pull(key="investors_count", task_ids="extract_data")
        businesses_count = context["ti"].xcom_pull(key="businesses_count", task_ids="extract_data")
        
        # Prepare data for API call
        fastapi_base_url = Variable.get("FASTAPI_BASE_URL")
        
        # Simulate preprocessing
        processed_data = {
            "investors_count": investors_count,
            "businesses_count": businesses_count,
            "total_records": investors_count + businesses_count,
            "preprocessing_timestamp": datetime.now().isoformat()
        }
        
        context["ti"].xcom_push(key="preprocessing_metadata", value=processed_data)
        
        logger.info(f"✅ Data preprocessing completed: {processed_data}")
        
    except Exception as e:
        logger.error(f"❌ Preprocessing failed: {str(e)}")
        raise


def train_model_via_fastapi(**context):
    """
    Trigger model training via FastAPI endpoint or train locally
    """
    try:
        preprocessing_metadata = context["ti"].xcom_pull(key="preprocessing_metadata", task_ids="preprocess_data")
        
        # For this example, we'll simulate model training
        fastapi_base_url = Variable.get("FASTAPI_BASE_URL")
        
        # Simulate training result
        model_metadata = {
            "model_type": "recommendation_model",
            "training_samples": preprocessing_metadata.get("total_records", 0),
            "training_timestamp": datetime.now().isoformat(),
            "model_version": f"v{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        }
        
        # Save model metadata as JSON (no pickle needed)
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        model_path = f"/tmp/recommender_model_{timestamp}.json"
        
        with open(model_path, "w") as f:
            json.dump(model_metadata, f)
        
        # Notify FastAPI about new model
        try:
            response = requests.post(
                f"{fastapi_base_url}/api/model/training-complete",
                json=model_metadata,
                timeout=30
            )
            if response.status_code == 200:
                logger.info("✅ FastAPI notified about model training completion")
            else:
                logger.warning(f"⚠️  FastAPI notification returned status {response.status_code}")
        except requests.exceptions.RequestException as e:
            logger.warning(f"⚠️  Could not notify FastAPI: {e}")
        
        logger.info(f"✅ Model training completed: {model_metadata}")
        context["ti"].xcom_push(key="model_metadata", value=model_metadata)
        
    except Exception as e:
        logger.error(f"❌ Model training failed: {str(e)}")
        raise


# Create the DAG
with DAG(
    dag_id="recommender_training_pipeline",
    default_args=default_args,
    description="ML pipeline for recommender system training with FastAPI integration",
    start_date=datetime(2025, 9, 18),
    schedule_interval="0 2 * * *",  # Daily at 2 AM
    catchup=False,
    tags=["ml", "recommender", "fastapi", "training"],
    max_active_runs=1,
) as dag:

    # Task 1: Health check
    health_check = PythonOperator(
        task_id="check_fastapi_health",
        python_callable=check_fastapi_health,
        provide_context=True,
    )

    # Task 2: Extract data
    extract_data = PythonOperator(
        task_id="extract_data",
        python_callable=extract_data_from_postgres,
        provide_context=True,
        pool="ml_training_pool",
    )

    # Task 3: Preprocess data
    preprocess_data = PythonOperator(
        task_id="preprocess_data",
        python_callable=call_fastapi_preprocessing,
        provide_context=True,
        pool="ml_training_pool",
    )

    # Task 4: Train model
    train_model = PythonOperator(
        task_id="train_model",
        python_callable=train_model_via_fastapi,
        provide_context=True,
        pool="ml_training_pool",
    )

    # Set up task dependencies
    health_check >> extract_data >> preprocess_data >> train_model
