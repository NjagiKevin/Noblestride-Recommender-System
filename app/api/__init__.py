from .businesses import router as businesses_router
from .investors import router as investors_router
from .ranking import router as ranking_router
from .feedback import router as feedback_router
from fastapi import APIRouter
from app.api import businesses, investors, ranking, feedback

api_router = APIRouter()

__all__ = [
    "businesses_router",
    "investors_router",
    "ranking_router",
    "feedback_router"
]