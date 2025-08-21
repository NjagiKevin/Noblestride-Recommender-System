from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

# Import your training function from your app
from app.ml.train import train_model, preprocess_data, extract_data

default_args = {
    "owner": "winfry",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="recommender_training",
    default_args=default_args,
    start_date=datetime(2025, 8, 21),
    schedule_interval="@daily",
    catchup=False,
) as dag:

    t1 = PythonOperator(task_id="extract_data", python_callable=extract_data)
    t2 = PythonOperator(task_id="preprocess_data", python_callable=preprocess_data)
    t3 = PythonOperator(task_id="train_model", python_callable=train_model)

    t1 >> t2 >> t3
