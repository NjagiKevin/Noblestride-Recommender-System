# app/api/api_router.py

from fastapi import APIRouter
from .businesses import router as businesses_router
from .investors import router as investors_router
from .ranking import router as ranking_router
from .feedback import router as feedback_router
from .recommend import router as recommend_router

# Create a single APIRouter instance
api_router = APIRouter()

# Include all routers here
api_router.include_router(businesses_router)
api_router.include_router(investors_router)
api_router.include_router(ranking_router)
api_router.include_router(feedback_router)
api_router.include_router(recommend_router)