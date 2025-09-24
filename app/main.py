from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from app.api.api_router import api_router
from app.core.config import settings
from app.core.logging_config import configure_logging
from app.db.session import init_db
from app.db.base import Base
from app.db.session import engine
from app.core.responses import NoneExcludingJSONResponse
import logging

# Configure logging
configure_logging()
logger = logging.getLogger(__name__)

# FastAPI app
app = FastAPI(
    title="Investor–Business Recommender Service",
    version=getattr(settings, "APP_VERSION", "0.1.0"),
    description="Microservice for recommending businesses to investors and vice versa.",
    default_response_class=NoneExcludingJSONResponse
)

# Startup event to initialize database
@app.on_event("startup")
def on_startup():
    init_db()  # this will call Base.metadata.create_all(bind=engine)

# Global exception handlers for robustness
@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception):
    logger.exception("Unhandled application error: %s", exc)
    return JSONResponse(status_code=500, content={"success": False, "message": "Internal server error"})

# Register routers
app.include_router(api_router)

@app.get("/")
def root():
    return {"message": "Welcome to the Investor–Business Recommender Service!"}

@app.get("/health")
def health():
    return {
        "status": "ok",
        "service": getattr(settings, "APP_NAME", "recommender"),
        "version": getattr(settings, "APP_VERSION", "0.1.0"),
    }

@app.get("/ready")
def ready():
    # Simple readiness: DB metadata can be accessed
    try:
        Base.metadata.create_all(bind=engine)
        return {"status": "ready"}
    except Exception:
        return JSONResponse(status_code=503, content={"status": "not_ready"})

# create tables if they don’t exist
Base.metadata.create_all(bind=engine)
