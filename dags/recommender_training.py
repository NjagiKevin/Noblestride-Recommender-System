from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime, timedelta
import pandas as pd
import os
import pickle

# Project imports
from app.ml.train import preprocess_data, train_model

default_args = {
    "owner": "winfry",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

def extract_data(**context):
    """
    Extract user info from Postgres into a Pandas DataFrame
    and push to XCom for downstream tasks.
    """
    hook = PostgresHook(postgres_conn_id="my_postgres")  # <-- configure in Airflow UI
    sql = "SELECT * FROM users;"   # adjust to your schema
    conn = hook.get_conn()
    df = pd.read_sql(sql, conn)
    
    # Save to temporary file (Airflow-friendly way)
    file_path = f"/tmp/user_data_{datetime.now().strftime('%Y%m%d%H%M%S')}.csv"
    df.to_csv(file_path, index=False)
    
    # Push path to XCom so next tasks can use it
    context["ti"].xcom_push(key="raw_data_path", value=file_path)


def preprocess_task(**context):
    """Preprocess the extracted CSV and save processed file path to XCom"""
    raw_path = context["ti"].xcom_pull(key="raw_data_path", task_ids="extract_data")
    df = pd.read_csv(raw_path)

    processed_df = preprocess_data(df)

    file_path = f"/tmp/processed_data_{datetime.now().strftime('%Y%m%d%H%M%S')}.csv"
    processed_df.to_csv(file_path, index=False)

    context["ti"].xcom_push(key="processed_data_path", value=file_path)


def train_task(**context):
    """Train the model using processed data"""
    processed_path = context["ti"].xcom_pull(key="processed_data_path", task_ids="preprocess_data")
    df = pd.read_csv(processed_path)

    model = train_model(df)

    # Save model locally (could also push to S3, GCS, MLflow, etc.)
    model_path = f"/tmp/recommender_model_{datetime.now().strftime('%Y%m%d%H%M%S')}.pkl"
    with open(model_path, "wb") as f:
        pickle.dump(model, f)

    print(f"✅ Model saved at {model_path}")


with DAG(
    dag_id="recommender_training",
    default_args=default_args,
    start_date=datetime(2025, 8, 20),
    schedule_interval="@daily",
    catchup=False,
    tags=["ml", "recommender"],
) as dag:

    t1 = PythonOperator(
        task_id="extract_data",
        python_callable=extract_data,
        provide_context=True,
    )

    t2 = PythonOperator(
        task_id="preprocess_data",
        python_callable=preprocess_task,
        provide_context=True,
    )

    t3 = PythonOperator(
        task_id="train_model",
        python_callable=train_task,
        provide_context=True,
    )

    t1 >> t2 >> t3
