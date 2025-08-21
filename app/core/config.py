# app/core/config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Investor–Business Recommender Service"
    DATABASE_URL: str = "postgresql://user:password@localhost/db"
    API_KEY: str = "default_key"
    DEBUG: bool = False
    LOG_LEVEL: str = "INFO"
    PORT: int = 8000

    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'
        extra = "ignore"  # Ignore extra fields in the environment file    

# Create the settings instance
settings = Settings()
