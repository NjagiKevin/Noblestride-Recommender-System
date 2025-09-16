# app/api/api_router.py

from fastapi import APIRouter
from .ranking import router as ranking_router
from .feedback import router as feedback_router
from .users import router as users_router
from .deals import router as deals_router
from .debug import router as debug_router
from .businesses import router as businesses_router
from .investors import router as investors_router
from .sectors import router as sectors_router


# Create a single APIRouter instance
api_router = APIRouter()

# Include all routers here
api_router.include_router(ranking_router)
api_router.include_router(feedback_router)
api_router.include_router(users_router)
api_router.include_router(deals_router)
api_router.include_router(debug_router)
api_router.include_router(businesses_router)
api_router.include_router(investors_router)
api_router.include_router(sectors_router)

