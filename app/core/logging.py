import logging
import sys
from pathlib import Path
from app.core.config import settings

# Create logs directory if it doesn't exist
LOG_DIR = Path("logs")
LOG_DIR.mkdir(exist_ok=True)

# Configure the root logger
def setup_logging():
    log_level = getattr(settings, "LOG_LEVEL", "INFO").upper()
    
    logger = logging.getLogger()
    logger.setLevel(log_level)
    
    # Create formatter
    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    
    # Console handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # File handler
    file_handler = logging.FileHandler(LOG_DIR / "app.log")
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    return logger

# Initialize logger
logger = setup_logging()