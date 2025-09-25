# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Prevent Python from writing .pyc files and buffer logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Force CPU-only execution for torch
ENV CUDA_VISIBLE_DEVICES=-1

# Copy and install Python dependencies first (for Docker layer caching)
COPY requirements.txt .
RUN pip install --upgrade pip --no-cache-dir && \
    pip install --no-cache-dir --timeout=1000 -r requirements.txt

# Copy app code
COPY . .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app
RUN chown -R app:app /app
USER app

# Expose FastAPI port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run FastAPI with Uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
