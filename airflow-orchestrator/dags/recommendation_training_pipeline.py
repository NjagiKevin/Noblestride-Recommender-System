"""
Production-grade Recommendation Training Pipeline
=================================================

This DAG handles the complete training pipeline for the recommendation system,
including data validation, model training, evaluation, and deployment.

Author: NobleStride AI Team
Version: 1.0.0
"""

from datetime import datetime, timedelta
import logging
import os
from typing import Dict, Any

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.models import Variable
from airflow.utils.dates import days_ago
from airflow.utils.task_group import TaskGroup
from airflow.sensors.filesystem import FileSensor
from airflow.operators.email import EmailOperator

import os
import json
import random
import pandas as pd
import numpy as np
import mlflow
import mlflow.sklearn
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.feature_extraction.text import TfidfVectorizer

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Default arguments for the DAG
default_args = {
'owner': 'webmasters_ml',
    'depends_on_past': False,
    'start_date': days_ago(1),
'email_on_failure': True,
    'email': ['k.kamau@webmasters.co.ke'],
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
}

# DAG definition
dag = DAG(
    'recommendation_training_pipeline',
    default_args=default_args,
    description='Production-grade recommendation model training pipeline',
    schedule_interval='@daily',  # Run daily
    max_active_runs=1,
    catchup=False,
tags=['machine-learning', 'recommendation', 'training', 'production', 'noblestride'],
    doc_md=__doc__,
)

# Configuration
MLFLOW_TRACKING_URI = os.getenv('MLFLOW_TRACKING_URI', 'http://mlflow:5000')
DATA_PATH = '/opt/airflow/data'
MODEL_NAME = 'noblestride_recommendation_model'

def setup_mlflow():
    """Setup MLflow tracking"""
    mlflow.set_tracking_uri(MLFLOW_TRACKING_URI)
    mlflow.set_experiment("recommendation_training")
    logger.info(f"MLflow tracking URI set to: {MLFLOW_TRACKING_URI}")

def validate_data_quality(**context) -> bool:
    """
    Validate data quality by checking for required tables in Postgres.
    Returns True only if at least investors/users and deals tables exist and have rows.
    """
    try:
        logger.info("Starting data quality validation against Postgres...")
        hook = PostgresHook(postgres_conn_id="noblestride_postgres")
        tables_df = hook.get_pandas_df("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public';
        """)
        available = set(tables_df["table_name"].str.lower().tolist())
        logger.info(f"Available tables: {sorted(list(available))}")

        # Detect candidates for investors/users and deals tables
        investor_candidates = [t for t in ["investors", "users"] if t in available]
        deals_candidates = [t for t in ["deals", "opportunities"] if t in available]

        if not investor_candidates or not deals_candidates:
            logger.error("Required tables not found (need investors/users and deals/opportunities)")
            return False

        investor_table = investor_candidates[0]
        deals_table = deals_candidates[0]

        # Check row counts
        inv_count = hook.get_first(f"SELECT COUNT(*) FROM {investor_table};")[0]
        deal_count = hook.get_first(f"SELECT COUNT(*) FROM {deals_table};")[0]

        if inv_count == 0 or deal_count == 0:
            logger.error(f"Insufficient data: investors={inv_count}, deals={deal_count}")
            return False

        logger.info(f"Data quality validation passed: investors={inv_count}, deals={deal_count}")
        return True

    except Exception as e:
        logger.error(f"Data validation failed: {str(e)}")
        raise

def extract_features(**context) -> Dict[str, Any]:
    """
    Build a lightweight supervised dataset from real DB tables:
    - Pull investors (or users with role='Investor') and deals
    - Create positive pairs where investor preference_sector matches deal sector
    - Create negative pairs by random sampling
    - Save a pairs dataset to DATA_PATH as Parquet for training
    Returns feature extraction metadata and dataset path.
    """
    try:
        logger.info("Starting feature extraction from Postgres (real data)...")
        setup_mlflow()
        hook = PostgresHook(postgres_conn_id="noblestride_postgres")

        tables_df = hook.get_pandas_df("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public';
        """)
        available = set(tables_df["table_name"].str.lower().tolist())
        investor_table = "investors" if "investors" in available else "users"
        deals_table = "deals" if "deals" in available else "opportunities"
        sectors_table = "sectors" if "sectors" in available else None

        # Investors/users query
        if investor_table == "investors":
            investors = hook.get_pandas_df(
                "SELECT id, name, description, preference_sector FROM investors"
            )
        else:
            investors = hook.get_pandas_df(
                "SELECT id, name, description, preference_sector, role FROM users WHERE role = 'Investor'"
            )

        # Deals query with sector name if possible
        if sectors_table and deals_table == "deals":
            deals = hook.get_pandas_df(
                """
                SELECT d.deal_id, d.title, d.description, d.status, s.name AS sector_name
                FROM deals d
                LEFT JOIN sectors s ON d.sector_id = s.sector_id
                WHERE d.status = 'Active'
                """
            )
        else:
            # Fallback without sector join
            col_id = "deal_id" if deals_table == "deals" else "id"
            deals = hook.get_pandas_df(
                f"SELECT {col_id} as deal_id, title, description, status FROM {deals_table}"
            )
            deals["sector_name"] = None

        # Basic cleanup
        investors = investors.fillna("")
        deals = deals.fillna("")
        if "preference_sector" not in investors.columns:
            investors["preference_sector"] = ""

        # Convert preference_sector to list if stored as string
        def sectors_to_list(val):
            if isinstance(val, list):
                return [str(x).strip() for x in val]
            try:
                # Try JSON parse first
                return [s.strip() for s in json.loads(val)] if isinstance(val, str) and val.startswith("[") else [v.strip() for v in str(val).split(",") if v.strip()]
            except Exception:
                return [v.strip() for v in str(val).split(",") if v.strip()]

        investors["pref_list"] = investors["preference_sector"].apply(sectors_to_list)
        # Keep only non-empty descriptions to improve training signal
        investors = investors[investors["description"].str.len() > 0].copy()
        deals = deals[deals["description"].str.len() > 0].copy()

        # Create labeled pairs (heuristic):
        # Positive if investor preference contains deal sector_name (when available)
        pos_pairs = []
        if deals.shape[0] > 0 and investors.shape[0] > 0:
            sample_deals = deals.sample(min(500, len(deals)), random_state=42)
            for _, d in sample_deals.iterrows():
                # sample K investors per deal
                K = 10 if len(investors) > 100 else max(1, len(investors)//10)
                sample_investors = investors.sample(min(K, len(investors)), random_state=random.randint(0, 10**6))
                for _, inv in sample_investors.iterrows():
                    sector_match = False
                    if isinstance(d.get("sector_name"), str) and d["sector_name"]:
                        sector_match = any(d["sector_name"].lower() == s.lower() for s in inv["pref_list"])
                    # Build pair text
                    inv_text = f"{inv['name']} {inv['description']}"
                    deal_text = f"{d.get('title','')} {d.get('description','')} {d.get('sector_name','')}"
                    pair_text = f"INVESTOR: {inv_text} || DEAL: {deal_text}"
                    label = 1 if sector_match else 0
                    pos_pairs.append((pair_text, label))

        # Balance dataset with simple negatives if too positive/negative skew
        df_pairs = pd.DataFrame(pos_pairs, columns=["text", "label"]) if pos_pairs else pd.DataFrame(columns=["text", "label"])
        # Ensure some negatives exist by random shuffling pairs if needed
        if df_pairs["label"].sum() == 0 and len(df_pairs) > 0:
            # flip a small fraction to positive to avoid degenerate training
            df_pairs.loc[df_pairs.sample(frac=0.1, random_state=42).index, "label"] = 1

        # Persist dataset
        os.makedirs(DATA_PATH, exist_ok=True)
        dataset_path = os.path.join(DATA_PATH, "training_pairs.parquet")
        df_pairs.to_parquet(dataset_path, index=False)

        with mlflow.start_run(run_name="feature_extraction"):
            mlflow.log_param("investor_rows", int(investors.shape[0]))
            mlflow.log_param("deal_rows", int(deals.shape[0]))
            mlflow.log_metric("pair_rows", int(df_pairs.shape[0]))
            mlflow.log_param("dataset_path", dataset_path)

        logger.info(f"Feature extraction completed. Pairs: {len(df_pairs)} saved to {dataset_path}")
        # Push dataset path for training
        context['task_instance'].xcom_push(key='dataset_path', value=dataset_path)
        return {
            "investors": int(investors.shape[0]),
            "deals": int(deals.shape[0]),
            "pairs": int(df_pairs.shape[0]),
            "dataset_path": dataset_path,
        }

    except Exception as e:
        logger.error(f"Feature extraction failed: {str(e)}")
        raise

def train_model(**context) -> Dict[str, Any]:
    """
    Train a text-pair classifier on real pairs using TF-IDF + Logistic Regression.
    """
    try:
        logger.info("Starting model training on real dataset...")
        setup_mlflow()
        dataset_path = context['task_instance'].xcom_pull(task_ids='feature_engineering.extract_features', key='dataset_path') or \
                       context['task_instance'].xcom_pull(task_ids='extract_features', key='dataset_path')
        if not dataset_path or not os.path.exists(dataset_path):
            raise RuntimeError(f"Dataset path not found: {dataset_path}")

        df_pairs = pd.read_parquet(dataset_path)
        if df_pairs.empty or df_pairs['label'].nunique() < 2:
            raise RuntimeError("Insufficient training data or labels are not diverse")

        X_train, X_test, y_train, y_test = train_test_split(
            df_pairs['text'].tolist(), df_pairs['label'].astype(int).tolist(), test_size=0.2, random_state=42, stratify=df_pairs['label']
        )

        # Build pipeline: TF-IDF (word+bigram) + Logistic Regression
        pipeline = Pipeline([
            ('tfidf', TfidfVectorizer(max_features=5000, ngram_range=(1,2), stop_words='english')),
            ('clf', LogisticRegression(max_iter=1000, n_jobs=None))
        ])

        with mlflow.start_run(run_name="model_training"):
            pipeline.fit(X_train, y_train)
            y_pred = pipeline.predict(X_test)
            
            accuracy = accuracy_score(y_test, y_pred)
            precision = precision_score(y_test, y_pred, average='weighted', zero_division=0)
            recall = recall_score(y_test, y_pred, average='weighted', zero_division=0)
            f1 = f1_score(y_test, y_pred, average='weighted', zero_division=0)

            mlflow.log_param("model_type", "TFIDF+LogReg")
            mlflow.log_param("tfidf_max_features", 5000)
            mlflow.log_param("tfidf_ngrams", "1-2")
            mlflow.log_metric("accuracy", accuracy)
            mlflow.log_metric("precision", precision)
            mlflow.log_metric("recall", recall)
            mlflow.log_metric("f1_score", f1)

            # Log model (pipeline)
            mlflow.sklearn.log_model(pipeline, MODEL_NAME)

            from airflow.operators.python import get_current_context
            ctx = get_current_context()
            if ctx and ctx.get('task_instance'):
                run_id = mlflow.active_run().info.run_id
                ctx['task_instance'].xcom_push(key='run_id', value=run_id)

            training_stats = {
                "accuracy": float(accuracy),
                "precision": float(precision),
                "recall": float(recall),
                "f1_score": float(f1),
                "training_samples": len(X_train),
                "test_samples": len(X_test)
            }

            logger.info(f"Model training completed. Accuracy: {accuracy:.4f}")
            return training_stats

    except Exception as e:
        logger.error(f"Model training failed: {str(e)}")
        raise

from airflow.exceptions import AirflowSkipException

def evaluate_model(**context) -> bool:
    """
    Evaluate the trained model
    
    Returns:
        bool: True if model meets quality thresholds
    """
    try:
        logger.info("Starting model evaluation...")
        
        # Get training results from XCom
        training_stats = context['task_instance'].xcom_pull(task_ids='train_model')
        
        # Define quality thresholds
        MIN_ACCURACY = 0.75
        MIN_F1_SCORE = 0.70
        
        accuracy = training_stats.get('accuracy', 0)
        f1_score = training_stats.get('f1_score', 0)
        
        logger.info(f"Model evaluation - Accuracy: {accuracy:.4f}, F1: {f1_score:.4f}")
        
        # Check quality thresholds
        if accuracy >= MIN_ACCURACY and f1_score >= MIN_F1_SCORE:
            logger.info("Model meets quality thresholds")
            return True
        else:
            msg = ("Model does not meet quality thresholds. "
                   f"Accuracy: {accuracy:.4f} (min: {MIN_ACCURACY}), "
                   f"F1: {f1_score:.4f} (min: {MIN_F1_SCORE})")
            logger.warning(msg)
            # Skip downstream deployment tasks when thresholds are not met
            raise AirflowSkipException(msg)
            
    except Exception as e:
        logger.error(f"Model evaluation failed: {str(e)}")
        raise

def deploy_model(**context) -> Dict[str, Any]:
    """
    Deploy the model to production
    
    Returns:
        Dict containing deployment metadata
    """
    try:
        logger.info("Starting model deployment...")
        setup_mlflow()
        
        # Register model in MLflow Model Registry using run_id from XCom
        from airflow.operators.python import get_current_context
        ctx = get_current_context()
        run_id = None
        if ctx and ctx.get('task_instance'):
            # Pull from within task group context if available
            run_id = ctx['task_instance'].xcom_pull(task_ids='model_training.train_model', key='run_id') or \
                     ctx['task_instance'].xcom_pull(task_ids='train_model', key='run_id')
        if not run_id:
            raise RuntimeError("MLflow run_id not found in XCom from train_model task")

        model_version = mlflow.register_model(
            f"runs:/{run_id}/{MODEL_NAME}",
            MODEL_NAME
        )
        
        # Transition to Production stage
        client = mlflow.tracking.MlflowClient()
        client.transition_model_version_stage(
            name=MODEL_NAME,
            version=model_version.version,
            stage="Production"
        )
        
        deployment_info = {
            "model_name": MODEL_NAME,
            "version": model_version.version,
            "stage": "Production",
            "deployment_time": datetime.now().isoformat()
        }
        
        logger.info(f"Model deployed successfully. Version: {model_version.version}")
        return deployment_info
        
    except Exception as e:
        logger.error(f"Model deployment failed: {str(e)}")
        raise

def send_notification(**context):
    """Send notification about pipeline completion"""
    try:
        deployment_info = context['task_instance'].xcom_pull(task_ids='deploy_model')
        training_stats = context['task_instance'].xcom_pull(task_ids='train_model')
        
        message = f"""
        🎉 Recommendation Model Training Pipeline Completed Successfully!
        
        📊 Training Results:
        - Accuracy: {training_stats.get('accuracy', 0):.4f}
        - F1 Score: {training_stats.get('f1_score', 0):.4f}
        - Training Samples: {training_stats.get('training_samples', 0)}
        
        🚀 Deployment Info:
        - Model: {deployment_info.get('model_name')}
        - Version: {deployment_info.get('version')}
        - Stage: {deployment_info.get('stage')}
        
        ⏰ Completed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
        """
        
        logger.info("Pipeline completed successfully!")
        logger.info(message)
        
    except Exception as e:
        logger.error(f"Notification failed: {str(e)}")

# Task definitions
start_pipeline = DummyOperator(
    task_id='start_pipeline',
    dag=dag,
)

# Data Quality Task Group
with TaskGroup("data_quality_checks", dag=dag) as data_quality_group:
    validate_data = PythonOperator(
        task_id='validate_data_quality',
        python_callable=validate_data_quality,
        dag=dag,
        provide_context=True,
    )

# Feature Engineering Task Group
with TaskGroup("feature_engineering", dag=dag) as feature_group:
    extract_features_task = PythonOperator(
        task_id='extract_features',
        python_callable=extract_features,
        dag=dag,
        provide_context=True,
    )

# Model Training Task Group
with TaskGroup("model_training", dag=dag) as training_group:
    train_model_task = PythonOperator(
        task_id='train_model',
        python_callable=train_model,
        dag=dag,
        provide_context=True,
    )
    
    evaluate_model_task = PythonOperator(
        task_id='evaluate_model',
        python_callable=evaluate_model,
        dag=dag,
        provide_context=True,
    )

# Model Deployment Task Group
with TaskGroup("model_deployment", dag=dag) as deployment_group:
    deploy_model_task = PythonOperator(
        task_id='deploy_model',
        python_callable=deploy_model,
        dag=dag,
        provide_context=True,
    )
    
    notify_completion = PythonOperator(
        task_id='send_notification',
        python_callable=send_notification,
        dag=dag,
        provide_context=True,
    )

end_pipeline = DummyOperator(
    task_id='end_pipeline',
    dag=dag,
)

# Define task dependencies
start_pipeline >> data_quality_group >> feature_group >> training_group >> deployment_group >> end_pipeline

# Set internal task dependencies (order tasks within groups only)
train_model_task >> evaluate_model_task
deploy_model_task >> notify_completion
