"""
ML Operations API Endpoints
============================

API endpoints for testing and managing Airflow workflows and MLflow experiments.
Provides production-grade endpoints for ML pipeline orchestration.

Author: NobleStride AI Team
"""

import os
import logging
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
import json

from fastapi import APIRouter, HTTPException, Depends, BackgroundTasks, status
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field
import requests
try:
    import mlflow
    from mlflow.tracking import MlflowClient
except ImportError:
    # Fallback for environments without MLflow
    mlflow = None
    MlflowClient = None

from app.core.config import get_settings
from app.core.responses import create_response

# Setup logging
logger = logging.getLogger(__name__)

# Get configuration
settings = get_settings()

# Router setup
router = APIRouter(
    prefix="/mlops",
    tags=["MLOps"],
    responses={404: {"description": "Not found"}},
)

# Configuration
AIRFLOW_API_URL = os.getenv('AIRFLOW_API_URL', 'http://airflow-webserver:8080')
AIRFLOW_USERNAME = os.getenv('AIRFLOW_API_USERNAME', 'admin')
AIRFLOW_PASSWORD = os.getenv('AIRFLOW_API_PASSWORD', 'admin')
MLFLOW_TRACKING_URI = os.getenv('MLFLOW_TRACKING_URI', 'http://mlflow:5000')

# Pydantic models
class DAGRunRequest(BaseModel):
    dag_id: str = Field(..., description="The DAG ID to trigger")
    conf: Optional[Dict[str, Any]] = Field(default_factory=dict, description="Configuration for the DAG run")
    
class DAGRunResponse(BaseModel):
    dag_run_id: str
    dag_id: str
    state: str
    execution_date: str
    start_date: Optional[str]
    end_date: Optional[str]

class MLExperimentRequest(BaseModel):
    experiment_name: str = Field(..., description="Name of the experiment")
    tags: Optional[Dict[str, str]] = Field(default_factory=dict, description="Tags for the experiment")

class ModelRegistrationRequest(BaseModel):
    model_name: str = Field(..., description="Name of the model")
    model_version: str = Field(..., description="Version of the model")
    stage: str = Field(default="Staging", description="Stage for the model (Staging/Production)")

class HealthResponse(BaseModel):
    service: str
    status: str
    version: Optional[str]
    uptime: Optional[str]
    last_check: str

# Helper functions
def get_airflow_auth():
    """Get Airflow authentication tuple"""
    return (AIRFLOW_USERNAME, AIRFLOW_PASSWORD)

def setup_mlflow():
    """Setup MLflow client"""
    if mlflow is None:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="MLflow not available"
        )
    mlflow.set_tracking_uri(MLFLOW_TRACKING_URI)
    return MlflowClient()

# Airflow Integration Endpoints

@router.get("/airflow/health", response_model=HealthResponse)
async def check_airflow_health():
    """
    Check Airflow webserver health
    """
    try:
        response = requests.get(
            f"{AIRFLOW_API_URL}/health",
            auth=get_airflow_auth(),
            timeout=10
        )
        
        if response.status_code == 200:
            health_data = response.json()
            return HealthResponse(
                service="Airflow",
                status="healthy" if health_data.get("status") == "healthy" else "unhealthy",
                version=health_data.get("version"),
                uptime=health_data.get("uptime"),
                last_check=datetime.now().isoformat()
            )
        else:
            return HealthResponse(
                service="Airflow",
                status="unhealthy",
                last_check=datetime.now().isoformat()
            )
            
    except Exception as e:
        logger.error(f"Failed to check Airflow health: {str(e)}")
        return HealthResponse(
            service="Airflow",
            status="unreachable",
            last_check=datetime.now().isoformat()
        )

@router.get("/airflow/dags")
async def list_airflow_dags():
    """
    List all available DAGs in Airflow
    """
    try:
        response = requests.get(
            f"{AIRFLOW_API_URL}/api/v1/dags",
            auth=get_airflow_auth(),
            timeout=10
        )
        
        if response.status_code == 200:
            dags_data = response.json()
            return create_response(
                data={
                    "dags": dags_data.get("dags", []),
                    "total_entries": dags_data.get("total_entries", 0)
                },
                message="DAGs retrieved successfully"
            )
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail=f"Failed to retrieve DAGs: {response.text}"
            )
            
    except requests.RequestException as e:
        logger.error(f"Failed to connect to Airflow: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Airflow service unavailable"
        )

@router.post("/airflow/dags/{dag_id}/dagRuns")
async def trigger_dag_run(dag_id: str, request: DAGRunRequest):
    """
    Trigger a DAG run in Airflow
    """
    try:
        payload = {
            "conf": request.conf or {},
            "dag_run_id": f"manual__{datetime.now().strftime('%Y-%m-%dT%H:%M:%S')}"
        }
        
        response = requests.post(
            f"{AIRFLOW_API_URL}/api/v1/dags/{dag_id}/dagRuns",
            auth=get_airflow_auth(),
            json=payload,
            headers={"Content-Type": "application/json"},
            timeout=10
        )
        
        if response.status_code == 200:
            dag_run_data = response.json()
            return create_response(
                data=DAGRunResponse(
                    dag_run_id=dag_run_data["dag_run_id"],
                    dag_id=dag_run_data["dag_id"],
                    state=dag_run_data["state"],
                    execution_date=dag_run_data["execution_date"],
                    start_date=dag_run_data.get("start_date"),
                    end_date=dag_run_data.get("end_date")
                ),
                message=f"DAG run triggered successfully for {dag_id}"
            )
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail=f"Failed to trigger DAG run: {response.text}"
            )
            
    except requests.RequestException as e:
        logger.error(f"Failed to trigger DAG run: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Airflow service unavailable"
        )

@router.get("/airflow/dags/{dag_id}/dagRuns/{dag_run_id}")
async def get_dag_run_status(dag_id: str, dag_run_id: str):
    """
    Get the status of a specific DAG run
    """
    try:
        response = requests.get(
            f"{AIRFLOW_API_URL}/api/v1/dags/{dag_id}/dagRuns/{dag_run_id}",
            auth=get_airflow_auth(),
            timeout=10
        )
        
        if response.status_code == 200:
            dag_run_data = response.json()
            return create_response(
                data=dag_run_data,
                message="DAG run status retrieved successfully"
            )
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail=f"Failed to get DAG run status: {response.text}"
            )
            
    except requests.RequestException as e:
        logger.error(f"Failed to get DAG run status: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Airflow service unavailable"
        )

# MLflow Integration Endpoints

@router.get("/mlflow/health", response_model=HealthResponse)
async def check_mlflow_health():
    """
    Check MLflow server health
    """
    try:
        response = requests.get(
            f"{MLFLOW_TRACKING_URI}/health",
            timeout=10
        )
        
        return HealthResponse(
            service="MLflow",
            status="healthy" if response.status_code == 200 else "unhealthy",
            last_check=datetime.now().isoformat()
        )
        
    except Exception as e:
        logger.error(f"Failed to check MLflow health: {str(e)}")
        return HealthResponse(
            service="MLflow",
            status="unreachable",
            last_check=datetime.now().isoformat()
        )

@router.get("/mlflow/experiments")
async def list_mlflow_experiments():
    """
    List all MLflow experiments
    """
    try:
        client = setup_mlflow()
        experiments = client.search_experiments()
        
        experiments_data = [
            {
                "experiment_id": exp.experiment_id,
                "name": exp.name,
                "lifecycle_stage": exp.lifecycle_stage,
                "artifact_location": exp.artifact_location,
                "tags": dict(exp.tags) if exp.tags else {}
            }
            for exp in experiments
        ]
        
        return create_response(
            data={"experiments": experiments_data},
            message="Experiments retrieved successfully"
        )
        
    except Exception as e:
        logger.error(f"Failed to list MLflow experiments: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to retrieve experiments: {str(e)}"
        )

@router.post("/mlflow/experiments")
async def create_mlflow_experiment(request: MLExperimentRequest):
    """
    Create a new MLflow experiment
    """
    try:
        client = setup_mlflow()
        experiment_id = client.create_experiment(
            name=request.experiment_name,
            tags=request.tags
        )
        
        return create_response(
            data={
                "experiment_id": experiment_id,
                "experiment_name": request.experiment_name
            },
            message="Experiment created successfully"
        )
        
    except Exception as e:
        logger.error(f"Failed to create MLflow experiment: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to create experiment: {str(e)}"
        )

@router.get("/mlflow/experiments/{experiment_id}/runs")
async def list_experiment_runs(experiment_id: str, limit: int = 100):
    """
    List runs for a specific experiment
    """
    try:
        client = setup_mlflow()
        runs = client.search_runs(
            experiment_ids=[experiment_id],
            max_results=limit
        )
        
        runs_data = [
            {
                "run_id": run.info.run_id,
                "experiment_id": run.info.experiment_id,
                "status": run.info.status,
                "start_time": run.info.start_time,
                "end_time": run.info.end_time,
                "metrics": dict(run.data.metrics),
                "params": dict(run.data.params),
                "tags": dict(run.data.tags)
            }
            for run in runs
        ]
        
        return create_response(
            data={"runs": runs_data},
            message="Experiment runs retrieved successfully"
        )
        
    except Exception as e:
        logger.error(f"Failed to list experiment runs: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to retrieve runs: {str(e)}"
        )

@router.get("/mlflow/models")
async def list_registered_models():
    """
    List all registered models in MLflow
    """
    try:
        client = setup_mlflow()
        models = client.search_registered_models()
        
        models_data = [
            {
                "name": model.name,
                "creation_timestamp": model.creation_timestamp,
                "last_updated_timestamp": model.last_updated_timestamp,
                "description": model.description,
                "latest_versions": [
                    {
                        "version": version.version,
                        "stage": version.current_stage,
                        "status": version.status,
                        "creation_timestamp": version.creation_timestamp
                    }
                    for version in model.latest_versions
                ]
            }
            for model in models
        ]
        
        return create_response(
            data={"models": models_data},
            message="Registered models retrieved successfully"
        )
        
    except Exception as e:
        logger.error(f"Failed to list registered models: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to retrieve models: {str(e)}"
        )

@router.post("/mlflow/models/{model_name}/versions/{version}/stage")
async def transition_model_stage(model_name: str, version: str, request: ModelRegistrationRequest):
    """
    Transition model version to a different stage
    """
    try:
        client = setup_mlflow()
        
        client.transition_model_version_stage(
            name=model_name,
            version=version,
            stage=request.stage
        )
        
        return create_response(
            data={
                "model_name": model_name,
                "version": version,
                "new_stage": request.stage
            },
            message=f"Model {model_name} version {version} transitioned to {request.stage}"
        )
        
    except Exception as e:
        logger.error(f"Failed to transition model stage: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to transition model stage: {str(e)}"
        )

# Combined MLOps Endpoints

@router.get("/pipeline/status")
async def get_pipeline_status():
    """
    Get overall ML pipeline status combining Airflow and MLflow information
    """
    try:
        # Check Airflow status
        airflow_health = await check_airflow_health()
        
        # Check MLflow status  
        mlflow_health = await check_mlflow_health()
        
        # Get recent DAG runs (simplified)
        try:
            dag_response = requests.get(
                f"{AIRFLOW_API_URL}/api/v1/dags/recommendation_training_pipeline/dagRuns?limit=5",
                auth=get_airflow_auth(),
                timeout=5
            )
            recent_runs = dag_response.json().get("dag_runs", []) if dag_response.status_code == 200 else []
        except:
            recent_runs = []
        
        # Get recent experiments
        try:
            client = setup_mlflow()
            experiments = client.search_experiments(max_results=5)
            recent_experiments = [exp.name for exp in experiments]
        except:
            recent_experiments = []
        
        pipeline_status = {
            "overall_health": "healthy" if airflow_health.status == "healthy" and mlflow_health.status == "healthy" else "degraded",
            "services": {
                "airflow": {
                    "status": airflow_health.status,
                    "last_check": airflow_health.last_check
                },
                "mlflow": {
                    "status": mlflow_health.status,
                    "last_check": mlflow_health.last_check
                }
            },
            "recent_pipeline_runs": len(recent_runs),
            "recent_experiments": recent_experiments,
            "timestamp": datetime.now().isoformat()
        }
        
        return create_response(
            data=pipeline_status,
            message="Pipeline status retrieved successfully"
        )
        
    except Exception as e:
        logger.error(f"Failed to get pipeline status: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to get pipeline status: {str(e)}"
        )

@router.post("/pipeline/training/trigger")
async def trigger_training_pipeline(background_tasks: BackgroundTasks):
    """
    Trigger the complete training pipeline
    """
    try:
        # Trigger the training DAG
        dag_payload = {
            "conf": {
                "triggered_by": "api",
                "trigger_time": datetime.now().isoformat()
            }
        }
        
        response = requests.post(
            f"{AIRFLOW_API_URL}/api/v1/dags/recommendation_training_pipeline/dagRuns",
            auth=get_airflow_auth(),
            json={
                "conf": dag_payload["conf"],
                "dag_run_id": f"api_trigger__{datetime.now().strftime('%Y-%m-%dT%H:%M:%S')}"
            },
            headers={"Content-Type": "application/json"},
            timeout=10
        )
        
        if response.status_code == 200:
            dag_run_data = response.json()
            return create_response(
                data={
                    "dag_run_id": dag_run_data["dag_run_id"],
                    "status": "triggered",
                    "trigger_time": datetime.now().isoformat(),
                    "monitor_url": f"{AIRFLOW_API_URL}/tree?dag_id=recommendation_training_pipeline"
                },
                message="Training pipeline triggered successfully"
            )
        else:
            raise HTTPException(
                status_code=response.status_code,
                detail=f"Failed to trigger training pipeline: {response.text}"
            )
            
    except Exception as e:
        logger.error(f"Failed to trigger training pipeline: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to trigger training pipeline: {str(e)}"
        )