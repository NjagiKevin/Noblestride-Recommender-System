"""
Recommendation System Monitoring DAG
=====================================

This DAG monitors the recommendation system performance, processes real-time data,
and triggers retraining when model drift is detected.

Author: NobleStride AI Team  
Version: 1.0.0
"""

from datetime import datetime, timedelta
import logging
import os
import json
from typing import Dict, Any, List

from airflow import DAG
from airflow.operators.python import PythonOperator, BranchPythonOperator
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.sensors.s3_key_sensor import S3KeySensor
from airflow.utils.dates import days_ago
from airflow.utils.task_group import TaskGroup
from airflow.models import Variable

import pandas as pd
import mlflow
import numpy as np
from sklearn.metrics import mean_squared_error, mean_absolute_error

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Default arguments
default_args = {
    'owner': 'noblestride-ai',
    'depends_on_past': False,
    'start_date': days_ago(1),
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=3),
}

# DAG definition
dag = DAG(
    'recommendation_monitoring',
    default_args=default_args,
    description='Monitor recommendation system performance and data quality',
    schedule_interval='@hourly',  # Run every hour
    max_active_runs=1,
    catchup=False,
    tags=['monitoring', 'recommendation', 'production', 'data-quality'],
    doc_md=__doc__,
)

# Configuration
MLFLOW_TRACKING_URI = os.getenv('MLFLOW_TRACKING_URI', 'http://mlflow:5000')
MODEL_NAME = 'noblestride_recommendation_model'
DRIFT_THRESHOLD = 0.05  # Model drift threshold
PERFORMANCE_THRESHOLD = 0.1  # Performance degradation threshold

def setup_mlflow():
    """Setup MLflow tracking"""
    mlflow.set_tracking_uri(MLFLOW_TRACKING_URI)
    mlflow.set_experiment("recommendation_monitoring")

def check_data_quality(**context) -> Dict[str, Any]:
    """
    Check incoming data quality
    
    Returns:
        Dict containing data quality metrics
    """
    try:
        logger.info("Starting data quality check...")
        
        # Simulate data quality checks
        current_time = datetime.now()
        
        # Mock data quality metrics
        data_quality_metrics = {
            'total_records': np.random.randint(8000, 12000),
            'null_percentage': np.random.uniform(0.01, 0.05),
            'duplicate_percentage': np.random.uniform(0.001, 0.01),
            'schema_compliance': np.random.uniform(0.95, 1.0),
            'freshness_score': np.random.uniform(0.9, 1.0),
            'completeness_score': np.random.uniform(0.95, 1.0),
            'check_timestamp': current_time.isoformat()
        }
        
        # Log to MLflow
        setup_mlflow()
        with mlflow.start_run(run_name="data_quality_check"):
            for metric, value in data_quality_metrics.items():
                if isinstance(value, (int, float)):
                    mlflow.log_metric(f"data_quality_{metric}", value)
            
            mlflow.log_param("check_time", current_time.strftime('%Y-%m-%d %H:%M:%S'))
        
        logger.info(f"Data quality check completed: {data_quality_metrics}")
        return data_quality_metrics
        
    except Exception as e:
        logger.error(f"Data quality check failed: {str(e)}")
        raise

def monitor_model_performance(**context) -> Dict[str, Any]:
    """
    Monitor model performance in production
    
    Returns:
        Dict containing performance metrics
    """
    try:
        logger.info("Starting model performance monitoring...")
        
        # Simulate performance monitoring
        setup_mlflow()
        
        with mlflow.start_run(run_name="performance_monitoring"):
            # Mock performance metrics
            performance_metrics = {
                'response_time_avg': np.random.uniform(100, 300),  # ms
                'response_time_p95': np.random.uniform(200, 500),  # ms
                'throughput': np.random.randint(800, 1200),  # requests/hour
                'error_rate': np.random.uniform(0.001, 0.01),
                'prediction_accuracy': np.random.uniform(0.75, 0.95),
                'mean_prediction_score': np.random.uniform(0.6, 0.9),
                'cpu_usage': np.random.uniform(30, 70),  # %
                'memory_usage': np.random.uniform(40, 80),  # %
            }
            
            # Log metrics to MLflow
            for metric, value in performance_metrics.items():
                mlflow.log_metric(f"performance_{metric}", value)
            
            # Store in context for downstream tasks
            context['task_instance'].xcom_push(
                key='performance_metrics', 
                value=performance_metrics
            )
        
        logger.info(f"Performance monitoring completed: {performance_metrics}")
        return performance_metrics
        
    except Exception as e:
        logger.error(f"Performance monitoring failed: {str(e)}")
        raise

def detect_model_drift(**context) -> str:
    """
    Detect if model has drifted and needs retraining
    
    Returns:
        str: 'retrain_needed' or 'no_action_needed'
    """
    try:
        logger.info("Starting model drift detection...")
        
        # Get performance metrics from previous task
        performance_data = context['task_instance'].xcom_pull(
            task_ids='model_performance_monitoring.monitor_performance'
        )
        
        # Simulate drift detection logic
        current_accuracy = performance_data.get('prediction_accuracy', 0.8)
        baseline_accuracy = 0.85  # Stored baseline
        
        accuracy_drop = baseline_accuracy - current_accuracy
        error_rate = performance_data.get('error_rate', 0.005)
        
        setup_mlflow()
        with mlflow.start_run(run_name="drift_detection"):
            mlflow.log_metric("current_accuracy", current_accuracy)
            mlflow.log_metric("baseline_accuracy", baseline_accuracy)
            mlflow.log_metric("accuracy_drop", accuracy_drop)
            mlflow.log_metric("error_rate", error_rate)
            
            # Determine if retraining is needed
            if accuracy_drop > PERFORMANCE_THRESHOLD or error_rate > 0.02:
                logger.warning(f"Model drift detected! Accuracy drop: {accuracy_drop:.4f}, Error rate: {error_rate:.4f}")
                mlflow.log_param("drift_detected", True)
                return 'trigger_retraining'
            else:
                logger.info("No significant model drift detected")
                mlflow.log_param("drift_detected", False)
                return 'no_action_needed'
                
    except Exception as e:
        logger.error(f"Model drift detection failed: {str(e)}")
        raise

def trigger_retraining_pipeline(**context):
    """
    Trigger the retraining pipeline
    """
    try:
        logger.info("Triggering model retraining pipeline...")
        
        # In a real scenario, this would trigger the training DAG
        # For now, we'll simulate the trigger
        
        retraining_info = {
            'trigger_time': datetime.now().isoformat(),
            'reason': 'model_drift_detected',
            'triggered_by': 'monitoring_dag'
        }
        
        logger.info(f"Retraining pipeline triggered: {retraining_info}")
        
        # Log to MLflow
        setup_mlflow()
        with mlflow.start_run(run_name="retraining_trigger"):
            mlflow.log_param("trigger_reason", "model_drift_detected")
            mlflow.log_param("trigger_time", datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        
        return retraining_info
        
    except Exception as e:
        logger.error(f"Failed to trigger retraining: {str(e)}")
        raise

def update_monitoring_dashboard(**context):
    """
    Update monitoring dashboard with latest metrics
    """
    try:
        logger.info("Updating monitoring dashboard...")
        
        # Get metrics from previous tasks
        data_quality = context['task_instance'].xcom_pull(task_ids='data_quality_checks.check_data_quality')
        performance = context['task_instance'].xcom_pull(task_ids='model_performance_monitoring.monitor_performance')
        
        # Create dashboard update payload
        dashboard_data = {
            'timestamp': datetime.now().isoformat(),
            'data_quality': data_quality,
            'performance': performance,
            'status': 'healthy'  # or 'warning', 'critical'
        }
        
        # In production, this would send data to your monitoring system
        logger.info("Dashboard updated successfully")
        logger.info(f"Dashboard data: {json.dumps(dashboard_data, indent=2)}")
        
    except Exception as e:
        logger.error(f"Dashboard update failed: {str(e)}")
        raise

def send_alert_if_critical(**context):
    """
    Send alert if critical issues detected
    """
    try:
        performance = context['task_instance'].xcom_pull(task_ids='model_performance_monitoring.monitor_performance')
        data_quality = context['task_instance'].xcom_pull(task_ids='data_quality_checks.check_data_quality')
        
        # Check for critical issues
        critical_issues = []
        
        if performance.get('error_rate', 0) > 0.05:
            critical_issues.append(f"High error rate: {performance['error_rate']:.4f}")
        
        if performance.get('response_time_p95', 0) > 1000:
            critical_issues.append(f"High response time: {performance['response_time_p95']:.0f}ms")
        
        if data_quality.get('null_percentage', 0) > 0.1:
            critical_issues.append(f"High null percentage: {data_quality['null_percentage']:.4f}")
        
        if critical_issues:
            alert_message = f"""
            🚨 CRITICAL ALERT - Recommendation System Issues Detected
            
            Issues:
            {chr(10).join(f'- {issue}' for issue in critical_issues)}
            
            Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
            
            Please investigate immediately.
            """
            
            logger.critical("Critical issues detected!")
            logger.critical(alert_message)
        else:
            logger.info("No critical issues detected")
            
    except Exception as e:
        logger.error(f"Alert check failed: {str(e)}")

# Task definitions
start_monitoring = DummyOperator(
    task_id='start_monitoring',
    dag=dag,
)

# Data Quality Monitoring Task Group
with TaskGroup("data_quality_checks", dag=dag) as data_quality_group:
    check_data_quality_task = PythonOperator(
        task_id='check_data_quality',
        python_callable=check_data_quality,
        dag=dag,
    )

# Model Performance Monitoring Task Group  
with TaskGroup("model_performance_monitoring", dag=dag) as performance_group:
    monitor_performance_task = PythonOperator(
        task_id='monitor_performance',
        python_callable=monitor_model_performance,
        dag=dag,
    )

# Model Drift Detection
detect_drift_task = BranchPythonOperator(
    task_id='detect_model_drift',
    python_callable=detect_model_drift,
    dag=dag,
)

# Conditional tasks based on drift detection
trigger_retraining_task = PythonOperator(
    task_id='trigger_retraining',
    python_callable=trigger_retraining_pipeline,
    dag=dag,
)

no_action_task = DummyOperator(
    task_id='no_action_needed',
    dag=dag,
)

# Dashboard and Alerting Task Group
with TaskGroup("dashboard_and_alerts", dag=dag) as dashboard_group:
    update_dashboard_task = PythonOperator(
        task_id='update_dashboard',
        python_callable=update_monitoring_dashboard,
        dag=dag,
        trigger_rule='none_failed_or_skipped',
    )
    
    send_alerts_task = PythonOperator(
        task_id='send_alerts',
        python_callable=send_alert_if_critical,
        dag=dag,
        trigger_rule='none_failed_or_skipped',
    )

end_monitoring = DummyOperator(
    task_id='end_monitoring',
    dag=dag,
    trigger_rule='none_failed_or_skipped',
)

# Define task dependencies
start_monitoring >> [data_quality_group, performance_group] >> detect_drift_task

detect_drift_task >> [trigger_retraining_task, no_action_task]

[trigger_retraining_task, no_action_task] >> dashboard_group >> end_monitoring

# Set internal task dependencies
data_quality_group >> check_data_quality_task
performance_group >> monitor_performance_task
dashboard_group >> update_dashboard_task >> send_alerts_task