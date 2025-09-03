from fastapi import FastAPI
from app.api.api_router import api_router
from app.core.config import settings
from app.core.logging_config import configure_logging
from app.db.session import init_db
from app.db.base import Base
from app.db.session import engine

# Configure logging
configure_logging()

# FastAPI app
app = FastAPI(
    title="Investor–Business Recommender Service",
    version="0.1.0",
    description="Microservice for recommending businesses to investors and vice versa."
)

# Startup event to initialize database
@app.on_event("startup")
def on_startup():
    init_db()  # this will call Base.metadata.create_all(bind=engine)

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

# create tables if they don’t exist
Base.metadata.create_all(bind=engine)# create tables if they don’t exist
