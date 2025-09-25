# app/core/config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Investor–Business Recommender Service"
    DB_USER: str
    DB_PASSWORD: str
    DB_NAME: str
    DB_HOST: str
    DB_PORT: str = "5432"
    DATABASE_URL: str | None = None
    API_KEY: str = "default_key"
    DEBUG: bool = False
    LOG_LEVEL: str = "INFO"
    PORT: int = 8000

    def __init__(self, **values):
        super().__init__(**values)
        # Respect DATABASE_URL if provided via environment; otherwise build one from individual DB_* parts
        if not self.DATABASE_URL:
            self.DATABASE_URL = (
                f"postgresql+psycopg2://{self.DB_USER}:{self.DB_PASSWORD}@{self.DB_HOST}:{self.DB_PORT}/{self.DB_NAME}"
            )

    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'
        extra = "ignore"  # Ignore extra fields in the environment file    

# Create the settings instance
settings = Settings()
