import logging
from logging.handlers import RotatingFileHandler
import os
from app.core.config import settings

def configure_logging():
    level = getattr(logging, settings.LOG_LEVEL.upper(), logging.INFO)
    fmt = "%(asctime)s | %(levelname)s | %(name)s | %(message)s"

    # Console handler
    logging.basicConfig(level=level, format=fmt)

    # Optional rotating file handler (writes only if LOG_DIR is set)
    log_dir = os.getenv("LOG_DIR")
    if log_dir:
        os.makedirs(log_dir, exist_ok=True)
        file_handler = RotatingFileHandler(
            os.path.join(log_dir, "recommender.log"),
            maxBytes=5_000_000,
            backupCount=3
        )
        file_handler.setLevel(level)
        file_handler.setFormatter(logging.Formatter(fmt))
        logging.getLogger().addHandler(file_handler)
    logging.info("Logging configured with level: %s", settings.LOG_LEVEL)