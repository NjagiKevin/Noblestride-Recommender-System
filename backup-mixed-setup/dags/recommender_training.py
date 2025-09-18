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
    Extract investor and business info from Postgres into separate Pandas DataFrames
    and push their file paths to XCom for downstream tasks.
    """
    hook = PostgresHook(postgres_conn_id="my_postgres")  # <-- configure in Airflow UI
    
    # Extract investors
    sql_investors = "SELECT * FROM investors;"
    conn = hook.get_conn()
    df_investors = pd.read_sql(sql_investors, conn)
    investors_file_path = f"/tmp/investors_data_{datetime.now().strftime('%Y%m%d%H%M%S')}.csv"
    df_investors.to_csv(investors_file_path, index=False)
    context["ti"].xcom_push(key="investors_data_path", value=investors_file_path)
    
    # Extract businesses
    sql_businesses = "SELECT * FROM businesses;"
    df_businesses = pd.read_sql(sql_businesses, conn)
    businesses_file_path = f"/tmp/businesses_data_{datetime.now().strftime('%Y%m%d%H%M%S')}.csv"
    df_businesses.to_csv(businesses_file_path, index=False)
    context["ti"].xcom_push(key="businesses_data_path", value=businesses_file_path)
    
    conn.close()


def preprocess_task(**context):
    """Preprocess the extracted CSVs and save processed file path to XCom"""
    investors_path = context["ti"].xcom_pull(key="investors_data_path", task_ids="extract_data")
    businesses_path = context["ti"].xcom_pull(key="businesses_data_path", task_ids="extract_data")
    
    df_investors = pd.read_csv(investors_path)
    df_businesses = pd.read_csv(businesses_path)

    # Preprocess both dataframes
    processed_investors_df = preprocess_data(df_investors)
    processed_businesses_df = preprocess_data(df_businesses)

    # For this example, we'll just concatenate them. 
    # A real-world scenario might involve more complex merging or feature engineering.
    merged_df = pd.concat([processed_investors_df, processed_businesses_df], ignore_index=True)

    file_path = f"/tmp/processed_data_{datetime.now().strftime('%Y%m%d%H%M%S')}.csv"
    merged_df.to_csv(file_path, index=False)

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
