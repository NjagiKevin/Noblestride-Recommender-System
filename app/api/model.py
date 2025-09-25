# app/api/model.py

from fastapi import APIRouter, HTTPException, BackgroundTasks
from pydantic import BaseModel
from pydantic import ConfigDict
from datetime import datetime
from typing import Dict, Any, Optional
import logging

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/model", tags=["model"])

class ModelTrainingComplete(BaseModel):
    model_config = ConfigDict(protected_namespaces=())
    model_type: str
    training_samples: int
    training_timestamp: str
    model_version: str

class ModelStatus(BaseModel):
    model_config = ConfigDict(protected_namespaces=())
    status: str
    current_model_version: Optional[str] = None
    last_training: Optional[str] = None
    message: Optional[str] = None

# In-memory storage for demo (in production, use database)
model_status = {
    "current_model_version": None,
    "last_training": None,
    "training_in_progress": False
}

@router.post("/training-complete")
async def model_training_complete(training_data: ModelTrainingComplete):
    """
    Endpoint called by Airflow when model training is complete
    """
    try:
        logger.info(f"🎯 Received model training completion notification: {training_data.dict()}")
        
        # Update model status
        model_status["current_model_version"] = training_data.model_version
        model_status["last_training"] = training_data.training_timestamp
        model_status["training_in_progress"] = False
        
        # Here you could:
        # 1. Load the new model into memory
        # 2. Update database with new model metadata
        # 3. Invalidate caches
        # 4. Send notifications
        
        return {
            "status": "success",
            "message": f"Model {training_data.model_version} registered successfully",
            "received_at": datetime.now().isoformat()
        }
    
    except Exception as e:
        logger.error(f"❌ Failed to process model training completion: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to process training completion: {str(e)}")

@router.get("/status")
async def get_model_status() -> ModelStatus:
    """
    Get current model status
    """
    try:
        return ModelStatus(
            status="training" if model_status.get("training_in_progress") else "ready",
            current_model_version=model_status.get("current_model_version"),
            last_training=model_status.get("last_training"),
            message="Model is ready for predictions" if not model_status.get("training_in_progress") else "Training in progress"
        )
    
    except Exception as e:
        logger.error(f"❌ Failed to get model status: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to get model status: {str(e)}")

@router.post("/trigger-training")
async def trigger_training(background_tasks: BackgroundTasks):
    """
    Trigger model training (this could call Airflow DAG via API)
    """
    try:
        if model_status.get("training_in_progress"):
            raise HTTPException(status_code=409, detail="Training already in progress")
        
        model_status["training_in_progress"] = True
        
        # Here you could trigger the Airflow DAG
        # For now, just return success
        logger.info("🚀 Model training triggered")
        
        return {
            "status": "success",
            "message": "Model training triggered successfully",
            "timestamp": datetime.now().isoformat()
        }
    
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"❌ Failed to trigger training: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to trigger training: {str(e)}")

@router.get("/health")
async def model_health_check():
    """
    Health check endpoint specifically for model service
    """
    return {
        "status": "healthy",
        "service": "model-service",
        "timestamp": datetime.now().isoformat(),
        "model_ready": model_status.get("current_model_version") is not None
    }
