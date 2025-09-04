# app/api/api_router.py

from fastapi import APIRouter
from .ranking import router as ranking_router
from .feedback import router as feedback_router
from .users import router as users_router
from .deals import router as deals_router

# Create a single APIRouter instance
api_router = APIRouter()

# Include all routers here
api_router.include_router(ranking_router)
api_router.include_router(feedback_router)
api_router.include_router(users_router)
api_router.include_router(deals_router)
