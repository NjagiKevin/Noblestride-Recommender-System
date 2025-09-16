from fastapi import APIRouter
from .deals import router as deals_router
from .ranking import router as ranking_router
from .feedback import router as feedback_router
from .users import router as users_router

api_router = APIRouter()

api_router.include_router(deals_router)
api_router.include_router(ranking_router)
api_router.include_router(feedback_router)
api_router.include_router(users_router)
