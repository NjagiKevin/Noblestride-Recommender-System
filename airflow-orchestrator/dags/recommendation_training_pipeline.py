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
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.models import Variable
from airflow.utils.dates import days_ago
from airflow.utils.task_group import TaskGroup
from airflow.sensors.filesystem import FileSensor
from airflow.operators.email import EmailOperator

import pandas as pd
import mlflow
import mlflow.sklearn
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Default arguments for the DAG
default_args = {
    'owner': 'noblestride-ai',
    'depends_on_past': False,
    'start_date': days_ago(1),
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
    'max_active_runs': 1,
    'catchup': False,
}

# DAG definition
dag = DAG(
    'recommendation_training_pipeline',
    default_args=default_args,
    description='Production-grade recommendation model training pipeline',
    schedule_interval='@daily',  # Run daily
    max_active_runs=1,
    catchup=False,
    tags=['machine-learning', 'recommendation', 'training', 'production'],
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
    Validate data quality before training
    
    Returns:
        bool: True if data quality is acceptable, False otherwise
    """
    try:
        # Simulate data quality checks
        logger.info("Starting data quality validation...")
        
        # Check if data files exist
        required_files = ['user_interactions.csv', 'product_data.csv', 'user_profiles.csv']
        missing_files = []
        
        for file in required_files:
            file_path = os.path.join(DATA_PATH, file)
            if not os.path.exists(file_path):
                missing_files.append(file)
                logger.warning(f"Missing file: {file_path}")
        
        if missing_files:
            logger.error(f"Missing required files: {missing_files}")
            return False
        
        # Validate data integrity (simulate)
        logger.info("Data quality validation passed")
        return True
        
    except Exception as e:
        logger.error(f"Data validation failed: {str(e)}")
        raise

def extract_features(**context) -> Dict[str, Any]:
    """
    Extract features for model training
    
    Returns:
        Dict containing feature extraction metadata
    """
    try:
        logger.info("Starting feature extraction...")
        setup_mlflow()
        
        with mlflow.start_run(run_name="feature_extraction"):
            # Simulate feature extraction
            logger.info("Extracting user interaction features...")
            logger.info("Extracting product features...")
            logger.info("Creating interaction matrix...")
            
            # Log feature extraction metrics
            mlflow.log_param("feature_extraction_method", "collaborative_filtering")
            mlflow.log_param("num_users", 10000)  # Simulated
            mlflow.log_param("num_products", 5000)  # Simulated
            mlflow.log_metric("feature_density", 0.05)  # Simulated
            
            feature_stats = {
                "num_features": 150,
                "feature_density": 0.05,
                "extraction_time": 45.2
            }
            
            logger.info("Feature extraction completed successfully")
            return feature_stats
            
    except Exception as e:
        logger.error(f"Feature extraction failed: {str(e)}")
        raise

def train_model(**context) -> Dict[str, Any]:
    """
    Train the recommendation model
    
    Returns:
        Dict containing training metadata
    """
    try:
        logger.info("Starting model training...")
        setup_mlflow()
        
        with mlflow.start_run(run_name="model_training"):
            # Simulate model training with RandomForest as example
            logger.info("Loading training data...")
            
            # Generate synthetic data for demonstration
            import numpy as np
            np.random.seed(42)
            X = np.random.rand(1000, 20)
            y = np.random.randint(0, 2, 1000)
            
            X_train, X_test, y_train, y_test = train_test_split(
                X, y, test_size=0.2, random_state=42
            )
            
            # Train model
            model = RandomForestClassifier(n_estimators=100, random_state=42)
            model.fit(X_train, y_train)
            
            # Make predictions
            y_pred = model.predict(X_test)
            
            # Calculate metrics
            accuracy = accuracy_score(y_test, y_pred)
            precision = precision_score(y_test, y_pred, average='weighted')
            recall = recall_score(y_test, y_pred, average='weighted')
            f1 = f1_score(y_test, y_pred, average='weighted')
            
            # Log parameters and metrics
            mlflow.log_param("model_type", "RandomForestClassifier")
            mlflow.log_param("n_estimators", 100)
            mlflow.log_param("test_size", 0.2)
            mlflow.log_metric("accuracy", accuracy)
            mlflow.log_metric("precision", precision)
            mlflow.log_metric("recall", recall)
            mlflow.log_metric("f1_score", f1)
            
            # Log model
            mlflow.sklearn.log_model(model, MODEL_NAME)
            
            training_stats = {
                "accuracy": accuracy,
                "precision": precision,
                "recall": recall,
                "f1_score": f1,
                "training_samples": len(X_train),
                "test_samples": len(X_test)
            }
            
            logger.info(f"Model training completed. Accuracy: {accuracy:.4f}")
            return training_stats
            
    except Exception as e:
        logger.error(f"Model training failed: {str(e)}")
        raise

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
            logger.warning(f"Model does not meet quality thresholds. "
                          f"Accuracy: {accuracy:.4f} (min: {MIN_ACCURACY}), "
                          f"F1: {f1_score:.4f} (min: {MIN_F1_SCORE})")
            return False
            
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
        
        # Register model in MLflow Model Registry
        model_version = mlflow.register_model(
            f"runs:/{mlflow.active_run().info.run_id}/{MODEL_NAME}",
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
    )

# Feature Engineering Task Group
with TaskGroup("feature_engineering", dag=dag) as feature_group:
    extract_features_task = PythonOperator(
        task_id='extract_features',
        python_callable=extract_features,
        dag=dag,
    )

# Model Training Task Group
with TaskGroup("model_training", dag=dag) as training_group:
    train_model_task = PythonOperator(
        task_id='train_model',
        python_callable=train_model,
        dag=dag,
    )
    
    evaluate_model_task = PythonOperator(
        task_id='evaluate_model',
        python_callable=evaluate_model,
        dag=dag,
    )

# Model Deployment Task Group
with TaskGroup("model_deployment", dag=dag) as deployment_group:
    deploy_model_task = PythonOperator(
        task_id='deploy_model',
        python_callable=deploy_model,
        dag=dag,
    )
    
    notify_completion = PythonOperator(
        task_id='send_notification',
        python_callable=send_notification,
        dag=dag,
    )

end_pipeline = DummyOperator(
    task_id='end_pipeline',
    dag=dag,
)

# Define task dependencies
start_pipeline >> data_quality_group >> feature_group >> training_group >> deployment_group >> end_pipeline

# Set internal task dependencies
data_quality_group >> validate_data
feature_group >> extract_features_task
training_group >> train_model_task >> evaluate_model_task
deployment_group >> deploy_model_task >> notify_completion