# app/db/session.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from app.core.config import settings

# Base class for models
Base = declarative_base()

# Database engine
engine = create_engine(settings.DATABASE_URL)

# Session factory
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency for FastAPI routes
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Initialize DB (called in main.py startup)
def init_db():
    import app.models.db_models  # <-- ensure models are imported so Base.metadata has them
    Base.metadata.create_all(bind=engine)
