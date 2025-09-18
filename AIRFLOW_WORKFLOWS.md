# 🔄 Airflow Workflows Documentation
## ML Pipeline Orchestration

### 📋 Overview
This document provides detailed information about all Airflow DAGs (Directed Acyclic Graphs) used in the Investor-Business Recommender System for orchestrating machine learning pipelines and data integration workflows.

### 🌐 Airflow Setup
- **Framework**: Apache Airflow with Astronomer
- **Location**: `C:\Users\User\recommendation-service\airflow-orchestrator\`
- **Web UI**: http://localhost:8080
- **Version**: Airflow 2.x with Astronomer Runtime

---

## 📊 Available DAGs

### 1. Recommender Training Pipeline
**File**: `dags/recommender_training.py`  
**DAG ID**: `recommender_training_pipeline`

#### 🎯 Purpose
Train and deploy machine learning models for the recommendation system using the latest business and investor data from the Noblestride database.

#### ⏰ Schedule
- **Frequency**: Daily at 2:00 AM UTC
- **Cron Expression**: `0 2 * * *`
- **Timezone**: UTC
- **Catchup**: Disabled
- **Max Active Runs**: 1

#### 🏗 Workflow Architecture
```
┌─────────────────┐
│ Health Check    │
│ FastAPI Service │
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Extract Data    │
│ from PostgreSQL │
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Preprocess Data │
│ Clean & Feature │
│ Engineering     │
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Train Model     │
│ & Notify FastAPI│
└─────────────────┘
```

#### 📋 Tasks Details

##### Task 1: `check_fastapi_health`
- **Type**: PythonOperator
- **Purpose**: Verify FastAPI service is healthy before starting pipeline
- **Timeout**: 30 seconds
- **Retry Policy**: 2 retries with 5-minute delay

**Implementation**:
```python
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
```

##### Task 2: `extract_data`
- **Type**: PythonOperator
- **Purpose**: Extract investor and business data counts from PostgreSQL
- **Database**: Uses `noblestride_postgres` connection
- **Pool**: `ml_training_pool`

**Data Extracted**:
- Investor count from `investors` table
- Business count from `businesses` table
- Data pushed to XCom for downstream tasks

**Implementation**:
```python
def extract_data_from_postgres(**context):
    """Extract investor and business data from PostgreSQL database"""
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
        
        # Push counts to XCom
        context["ti"].xcom_push(key="investors_count", value=investors_count)
        context["ti"].xcom_push(key="businesses_count", value=businesses_count)
        
        logger.info(f"✅ Found {investors_count} investors and {businesses_count} businesses")
        
        cursor.close()
        conn.close()
    except Exception as e:
        logger.error(f"❌ Data extraction failed: {str(e)}")
        raise
```

##### Task 3: `preprocess_data`
- **Type**: PythonOperator
- **Purpose**: Prepare and clean data for model training
- **Pool**: `ml_training_pool`

**Processing Steps**:
1. Retrieve data counts from previous task
2. Calculate total records
3. Generate preprocessing metadata
4. Prepare data summary for training

##### Task 4: `train_model`
- **Type**: PythonOperator
- **Purpose**: Train ML model and notify FastAPI service
- **Pool**: `ml_training_pool`

**Training Process**:
1. Simulate model training with latest data
2. Generate model metadata with version timestamp
3. Save model information to `/tmp/` directory
4. Notify FastAPI service via POST to `/api/model/training-complete`

**Model Metadata Generated**:
```json
{
  "model_type": "recommendation_model",
  "training_samples": 1500,
  "training_timestamp": "2025-09-18T02:00:00.000Z",
  "model_version": "v20250918_020000"
}
```

#### 🔧 Configuration

**Default Arguments**:
```python
default_args = {
    "owner": "recommendation-team",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}
```

**Required Airflow Variables**:
- `FASTAPI_BASE_URL`: URL of FastAPI service (default: `http://host.docker.internal:8010`)

**Required Connections**:
- `noblestride_postgres`: PostgreSQL connection to Noblestride database

---

### 2. Noblestride Integration Pipeline
**File**: `dags/noblestride_integration.py`  
**DAG ID**: `noblestride_integration_pipeline`

#### 🎯 Purpose
Integrate data between the Node.js backend and FastAPI recommendation service, providing continuous data synchronization and health monitoring.

#### ⏰ Schedule
- **Frequency**: Every 6 hours
- **Cron Expression**: `0 */6 * * *`
- **Timezone**: UTC
- **Catchup**: Disabled
- **Max Active Runs**: 1

#### 🏗 Workflow Architecture
```
┌─────────────────┐
│ Health Check    │
│ Both Services   │
│ Node.js + FastAPI│
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Extract Data    │
│ from Noblestride│
│ Database        │
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Sync Data with  │
│ FastAPI Service │
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Generate        │
│ Integration     │
│ Report          │
└─────────────────┘
```

#### 📋 Tasks Details

##### Task 1: `check_services`
- **Type**: PythonOperator
- **Purpose**: Verify both Node.js and FastAPI services are healthy
- **Timeout**: 15 seconds per service

**Service Health Check**:
- **Node.js**: http://localhost:3030/health
- **FastAPI**: http://localhost:8010/health
- Continues if at least one service is healthy

**Health Report Generated**:
```json
{
    "nodejs_service": "healthy",
    "fastapi_service": "healthy", 
    "check_timestamp": "2025-09-18T14:30:00.000Z"
}
```

##### Task 2: `extract_data`
- **Type**: PythonOperator  
- **Purpose**: Extract comprehensive data from Noblestride database
- **Pool**: `ml_training_pool`

**Data Extraction Process**:
1. Connect to `noblestride_postgres` database
2. Query all table names from `information_schema.tables`
3. Count records in each table
4. Generate database summary statistics

**Sample Output**:
```json
{
    "users": 1247,
    "businesses": 150,
    "investors": 75,
    "deals": 89,
    "feedback": 542
}
```

##### Task 3: `sync_fastapi`
- **Type**: PythonOperator
- **Purpose**: Send data summary to FastAPI service

**Sync Process**:
1. Check FastAPI service health from previous task
2. Prepare sync data package
3. POST to `/api/model/training-complete` endpoint
4. Handle connection timeouts gracefully

**Sync Data Package**:
```json
{
    "source": "noblestride_database",
    "table_summary": {
        "users": 1247,
        "businesses": 150
    },
    "sync_timestamp": "2025-09-18T14:30:00.000Z",
    "total_records": 1397
}
```

##### Task 4: `generate_report`
- **Type**: PythonOperator
- **Purpose**: Create comprehensive integration status report

**Report Components**:
1. Pipeline execution metadata
2. Service health status
3. Database summary statistics
4. Integration status and results
5. Timestamp and run information

**Report Saved To**: `/tmp/noblestride_integration_report_{timestamp}.json`

#### 🔧 Configuration

**Default Arguments**:
```python
default_args = {
    "owner": "noblestride-team",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=3),
}
```

**Required Airflow Variables**:
- `NODEJS_BASE_URL`: URL of Node.js service (default: `http://host.docker.internal:3030`)
- `FASTAPI_BASE_URL`: URL of FastAPI service (default: `http://host.docker.internal:8010`)

**Required Connections**:
- `noblestride_postgres`: PostgreSQL connection to Noblestride database

---

## 🔧 Setup & Configuration

### 📋 Prerequisites
1. **Astronomer CLI** installed
2. **Docker** and **Docker Compose**
3. **PostgreSQL** databases running
4. **FastAPI** and **Node.js** services operational

### 🚀 Airflow Initialization

#### 1. Start Airflow Services
```bash
cd C:\Users\User\recommendation-service\airflow-orchestrator
astro dev start
```

#### 2. Access Airflow Web UI
- **URL**: http://localhost:8080
- **Username**: `admin`
- **Password**: `admin` (default)

#### 3. Configure Airflow Variables
Navigate to **Admin > Variables** in the Airflow UI and add:

| Key | Value | Description |
|-----|-------|-------------|
| `FASTAPI_BASE_URL` | `http://host.docker.internal:8010` | FastAPI service URL |
| `NODEJS_BASE_URL` | `http://host.docker.internal:3030` | Node.js service URL |

#### 4. Setup Database Connections
Navigate to **Admin > Connections** and configure:

##### Noblestride PostgreSQL Connection
- **Connection Id**: `noblestride_postgres`
- **Connection Type**: `Postgres`
- **Host**: `localhost`
- **Schema**: `noblestride`
- **Login**: `postgres`
- **Password**: `password`
- **Port**: `5436`

##### Recommender PostgreSQL Connection  
- **Connection Id**: `recommender_postgres`
- **Connection Type**: `Postgres`
- **Host**: `localhost`
- **Schema**: `recommender_db`
- **Login**: `postgres`
- **Password**: `password`
- **Port**: `5438`

### 🏊 Resource Pools

Configure resource pools to manage task concurrency:

#### ML Training Pool
- **Pool Name**: `ml_training_pool`
- **Slots**: `2`
- **Description**: `Pool for ML training tasks to limit concurrent resource usage`

**Setup via Airflow UI**:
1. Navigate to **Admin > Pools**
2. Add new pool with above configuration

---

## 🔍 Monitoring & Troubleshooting

### 📊 DAG Monitoring

#### Key Metrics to Monitor
1. **DAG Success Rate**: Track successful runs vs failures
2. **Task Duration**: Monitor individual task execution times
3. **Queue Times**: Check for resource bottlenecks
4. **Error Patterns**: Identify common failure points

#### Airflow UI Navigation
- **DAGs View**: http://localhost:8080/home
- **Task Logs**: DAG > Task > Logs tab
- **Gantt Chart**: View task execution timeline
- **Task Duration**: Analyze performance trends

### 🚨 Common Issues & Solutions

#### 1. Database Connection Failures
**Symptoms**: 
- Tasks fail with connection timeout
- "Connection refused" errors

**Solutions**:
```bash
# Check PostgreSQL containers
docker ps | grep postgres

# Verify connection strings
docker logs recommender_db
docker logs noblestride_db

# Test connections manually
psql -h localhost -p 5436 -U postgres -d noblestride
psql -h localhost -p 5438 -U postgres -d recommender_db
```

#### 2. Service Health Check Failures
**Symptoms**:
- Health check tasks consistently fail
- HTTP timeout errors

**Solutions**:
```bash
# Verify service status
curl http://localhost:3030/
curl http://localhost:8010/health

# Check Docker network connectivity
docker network ls
docker network inspect airflow-orchestrator_default
```

#### 3. Resource Pool Exhaustion
**Symptoms**:
- Tasks stuck in "queued" status
- Long wait times between tasks

**Solutions**:
1. Increase pool slots in **Admin > Pools**
2. Optimize task resource usage
3. Consider task parallelization

#### 4. XCom Data Issues
**Symptoms**:
- Downstream tasks fail to retrieve data
- "Key not found" errors

**Solutions**:
```python
# Debug XCom data
def debug_xcom(**context):
    ti = context['ti']
    data = ti.xcom_pull(task_ids='extract_data', key='investors_count')
    logger.info(f"Retrieved data: {data}")
```

### 📋 Best Practices

#### 1. Error Handling
```python
def robust_task(**context):
    try:
        # Task logic here
        pass
    except SpecificException as e:
        logger.error(f"Specific error: {e}")
        # Handle gracefully
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        raise  # Re-raise for Airflow to handle
```

#### 2. Timeout Management
```python
# Set appropriate timeouts
response = requests.get(url, timeout=30)

# Use task-level timeouts
task = PythonOperator(
    task_id='api_call',
    python_callable=make_api_call,
    execution_timeout=timedelta(minutes=10)
)
```

#### 3. Resource Management
```python
# Use connection pools
hook = PostgresHook(postgres_conn_id="noblestride_postgres")
try:
    conn = hook.get_conn()
    # Use connection
finally:
    conn.close()  # Always close connections
```

---

## 📈 Performance Optimization

### 🚀 Task Optimization

#### 1. Parallel Task Execution
```python
# Use task groups for parallel execution
with TaskGroup("data_processing") as tg:
    extract_investors = PythonOperator(
        task_id="extract_investors",
        python_callable=extract_investors_data
    )
    extract_businesses = PythonOperator(
        task_id="extract_businesses", 
        python_callable=extract_businesses_data
    )
```

#### 2. Efficient Data Transfer
```python
# Use efficient XCom for large data
def push_large_data(**context):
    # Instead of pushing large objects
    # Save to shared storage and push path
    file_path = save_to_shared_storage(large_data)
    context['ti'].xcom_push(key='data_path', value=file_path)
```

#### 3. Resource Pool Configuration
```python
# Optimize pool sizes based on system resources
# CPU-intensive tasks
cpu_pool_size = cpu_count() - 1

# I/O intensive tasks  
io_pool_size = cpu_count() * 2
```

### 🗄 Database Optimization

#### 1. Connection Pooling
```python
# Configure connection pools in Airflow
# airflow.cfg
[database]
sql_alchemy_pool_size = 10
sql_alchemy_pool_recycle = 3600
```

#### 2. Query Optimization
```python
# Use efficient queries
sql = """
    SELECT COUNT(*) 
    FROM investors 
    WHERE created_at >= %s
"""
cursor.execute(sql, (start_date,))
```

---

## 🔐 Security Best Practices

### 🔒 Connection Security
1. **Encrypted Connections**: Use SSL for database connections
2. **Secret Management**: Store credentials in Airflow Connections
3. **Network Security**: Limit database access to specific IPs

### 👥 Access Control
1. **RBAC**: Configure role-based access control
2. **API Authentication**: Secure Airflow REST API
3. **Audit Logging**: Enable comprehensive logging

### 🛡 Data Protection
1. **Sensitive Data**: Avoid logging sensitive information
2. **XCom Encryption**: Consider encrypting XCom data
3. **Temporary Files**: Clean up temporary files after use

---

## 📅 Scheduling Best Practices

### ⏰ Schedule Optimization

#### 1. Avoid Peak Hours
```python
# Schedule during off-peak hours
dag = DAG(
    dag_id="training_pipeline",
    schedule_interval="0 2 * * *",  # 2 AM UTC
    catchup=False
)
```

#### 2. Resource-Aware Scheduling
```python
# Distribute resource-intensive tasks
dag1_schedule = "0 2 * * *"    # 2 AM
dag2_schedule = "0 4 * * *"    # 4 AM
dag3_schedule = "0 6 * * *"    # 6 AM
```

#### 3. Dependency Management
```python
# Use external task sensors for cross-DAG dependencies
wait_for_upstream = ExternalTaskSensor(
    task_id='wait_for_data_pipeline',
    external_dag_id='data_ingestion_pipeline',
    external_task_id='data_validation'
)
```

---

## 📊 Reporting & Analytics

### 📈 Custom Metrics

#### 1. Model Training Metrics
```python
def track_training_metrics(**context):
    metrics = {
        'training_duration': end_time - start_time,
        'data_samples': sample_count,
        'model_accuracy': accuracy_score
    }
    
    # Send to monitoring system
    send_metrics_to_datadog(metrics)
```

#### 2. Data Quality Metrics
```python
def validate_data_quality(**context):
    quality_metrics = {
        'completeness': calculate_completeness(),
        'consistency': check_consistency(),
        'timeliness': check_data_freshness()
    }
    
    context['ti'].xcom_push(key='quality_metrics', value=quality_metrics)
```

### 📧 Alerting Configuration

#### 1. Email Alerts
```python
# Configure email alerts for failures
dag = DAG(
    dag_id="ml_pipeline",
    default_args={
        'email': ['admin@company.com'],
        'email_on_failure': True,
        'email_on_retry': False
    }
)
```

#### 2. Slack Notifications
```python
def send_slack_alert(**context):
    slack_msg = f"""
    🚨 DAG {context['dag'].dag_id} failed
    Task: {context['task'].task_id}
    Execution Date: {context['execution_date']}
    """
    send_to_slack(slack_msg)
```

---

*Documentation Last Updated: September 18, 2025*  
*Airflow Version: 2.x with Astronomer*  
*Documentation Version: 1.0*