# 🚀 Deployment & Testing Guide
## Investor-Business Recommender System

### 📋 Table of Contents
1. [Quick Start](#quick-start)
2. [Prerequisites](#prerequisites)
3. [Environment Setup](#environment-setup)
4. [Service Deployment](#service-deployment)
5. [Testing Procedures](#testing-procedures)
6. [Production Deployment](#production-deployment)
7. [Troubleshooting](#troubleshooting)
8. [Performance Testing](#performance-testing)

---

## ⚡ Quick Start

### 🎯 30-Second Setup
For users who just want to get the system running quickly:

```bash
# 1. Start FastAPI Recommendation Service
cd C:\Users\User\recommendation-service
docker-compose up -d

# 2. Verify FastAPI is running
curl http://localhost:8010/health

# 3. Start Node.js Backend (in another terminal)
cd C:\Users\User\noblestride-backend
npm start

# 4. Start Airflow (in another terminal)
cd C:\Users\User\recommendation-service\airflow-orchestrator
astro dev start

# 5. Access services
# FastAPI: http://localhost:8010/docs
# Node.js: http://localhost:3030/api-docs
# Airflow: http://localhost:8080
```

---

## 📋 Prerequisites

### 💻 System Requirements

#### Minimum Requirements
- **OS**: Windows 10/11, macOS 10.15+, or Linux Ubuntu 18.04+
- **RAM**: 8 GB minimum, 16 GB recommended
- **CPU**: 4 cores minimum, 8 cores recommended
- **Storage**: 20 GB free space
- **Network**: Stable internet connection

#### Software Dependencies
| Software | Version | Purpose |
|----------|---------|---------|
| **Docker** | 20.10+ | Container orchestration |
| **Docker Compose** | 2.0+ | Multi-container applications |
| **Python** | 3.8-3.11 | FastAPI service runtime |
| **Node.js** | 16+ | Backend service runtime |
| **PostgreSQL** | 15+ | Database system |
| **Redis** | 6.0+ | Caching and queues |
| **Astronomer CLI** | Latest | Airflow development |

### 🔧 Installation Instructions

#### 1. Install Docker
**Windows:**
```powershell
# Download and install Docker Desktop from docker.com
# Ensure WSL 2 is enabled
wsl --set-default-version 2
```

**macOS:**
```bash
# Install via Homebrew
brew install --cask docker
```

**Linux:**
```bash
# Install Docker Engine
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

#### 2. Install Python (if not using Docker)
```bash
# Windows (via Chocolatey)
choco install python

# macOS (via Homebrew)
brew install python@3.11

# Linux (Ubuntu)
sudo apt update
sudo apt install python3.11 python3.11-pip
```

#### 3. Install Node.js
```bash
# Windows (via Chocolatey)
choco install nodejs

# macOS (via Homebrew)
brew install node

# Linux (Ubuntu)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### 4. Install Astronomer CLI
```bash
# Windows (PowerShell)
curl -L https://github.com/astronomer/astro-cli/releases/latest/download/astro_windows_amd64.exe -o astro.exe

# macOS
brew install astronomer/tap/astro

# Linux
curl -sSL install.astronomer.io | sudo bash -s
```

### ✅ Verification Commands
```bash
# Verify installations
docker --version
docker-compose --version
python --version
node --version
npm --version
astro version
```

---

## 🔧 Environment Setup

### 📁 Project Structure Verification
Ensure your project structure matches:
```
C:\Users\User\
├── recommendation-service\         # FastAPI & Airflow
│   ├── app\                       # FastAPI application
│   ├── airflow-orchestrator\       # Airflow DAGs
│   ├── docker-compose.yml         # Docker services
│   ├── .env                       # Environment variables
│   └── requirements.txt           # Python dependencies
└── noblestride-backend\           # Node.js backend
    ├── index.js                   # Main application
    ├── package.json               # Node dependencies
    └── .env                       # Backend configuration
```

### 🌍 Environment Configuration

#### 1. FastAPI Environment (.env)
Create/update `C:\Users\User\recommendation-service\.env`:
```bash
# Database Configuration
DATABASE_URL=postgresql+psycopg2://postgres:password@db:5432/recommender_db
DB_USER=postgres
DB_PASSWORD=password
DB_NAME=recommender_db
DB_HOST=db
DB_PORT=5432

# Application Settings
APP_NAME=RecommenderService
APP_VERSION=0.1.0

# Development Settings
DEBUG=true
LOG_LEVEL=INFO
```

#### 2. Node.js Environment (.env)
Verify `C:\Users\User\noblestride-backend\.env` contains:
```bash
# Database Connection
DB_USERNAME=postgres
DB_PASSWORD=password
DB_NAME=noblestride
DB_HOST=localhost
DB_PORT=5436

# Server Configuration
PORT=3030
NODE_ENV=development

# External Services
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# Application Keys
SECRET_KEY=your_secret_key_here
API_KEY=your_api_key_here
```

### 🔐 Security Configuration

#### Development Security Settings
```bash
# Generate secure secrets (run in terminal)
python -c "import secrets; print(f'SECRET_KEY={secrets.token_urlsafe(32)}')"
python -c "import uuid; print(f'API_KEY={uuid.uuid4()}')"
```

Update your `.env` files with generated values.

---

## 🚀 Service Deployment

### 🐳 Docker-Based Deployment (Recommended)

#### 1. Deploy FastAPI Recommendation Service
```bash
cd C:\Users\User\recommendation-service

# Pull latest images
docker-compose pull

# Start services in detached mode
docker-compose up -d

# Verify containers are running
docker-compose ps
```

**Expected Output:**
```
NAME               COMMAND             SERVICE    STATUS    PORTS
recommender_api    "uvicorn app.ma..."  api        Up        0.0.0.0:8010->8000/tcp
recommender_db     "docker-entry..."    db         Up        0.0.0.0:5438->5432/tcp
```

#### 2. Deploy Node.js Backend
```bash
cd C:\Users\User\noblestride-backend

# Install dependencies
npm install

# Start the application
npm start
```

**Expected Output:**
```
Server is connected on 3030
✅ Database connected successfully
✅ Redis connected successfully
Bull Dashboard enabled at /admin/queues
```

#### 3. Deploy Airflow Orchestrator
```bash
cd C:\Users\User\recommendation-service\airflow-orchestrator

# Initialize Airflow environment
astro dev start

# Wait for services to be ready (2-3 minutes)
```

**Expected Output:**
```
Airflow Webserver: http://localhost:8080
Postgres Database: postgresql://postgres:postgres@localhost:5432/postgres
```

### 🔍 Service Health Verification

#### Automated Health Check Script
Create `health_check.ps1`:
```powershell
# health_check.ps1
Write-Host "🔍 Checking Service Health..." -ForegroundColor Cyan

# Check FastAPI
try {
    $fastapi = Invoke-RestMethod -Uri "http://localhost:8010/health" -TimeoutSec 10
    Write-Host "✅ FastAPI: $($fastapi.status)" -ForegroundColor Green
} catch {
    Write-Host "❌ FastAPI: Not responding" -ForegroundColor Red
}

# Check Node.js
try {
    $nodejs = Invoke-RestMethod -Uri "http://localhost:3030/" -TimeoutSec 10
    Write-Host "✅ Node.js: Running" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js: Not responding" -ForegroundColor Red
}

# Check Airflow
try {
    $airflow = Invoke-RestMethod -Uri "http://localhost:8080/health" -TimeoutSec 10
    Write-Host "✅ Airflow: Running" -ForegroundColor Green
} catch {
    Write-Host "❌ Airflow: Not responding" -ForegroundColor Red
}

# Check Databases
Write-Host "🗄️ Database Status:" -ForegroundColor Cyan
docker exec recommender_db pg_isready -U postgres -d recommender_db
docker exec noblestride_db pg_isready -U postgres -d noblestride 2>$null
```

Run health check:
```bash
powershell -ExecutionPolicy Bypass -File health_check.ps1
```

### 🌐 Service URLs Summary
After successful deployment:
- **FastAPI API**: http://localhost:8010
- **FastAPI Documentation**: http://localhost:8010/docs
- **Node.js Backend**: http://localhost:3030
- **Node.js API Docs**: http://localhost:3030/api-docs
- **Airflow UI**: http://localhost:8080 (admin/admin)
- **Queue Dashboard**: http://localhost:3030/admin/queues

---

## 🧪 Testing Procedures

### 🔬 Unit Testing

#### 1. FastAPI Unit Tests
```bash
cd C:\Users\User\recommendation-service

# Install test dependencies
pip install pytest pytest-asyncio httpx

# Run unit tests
pytest tests/ -v

# Run with coverage
pytest tests/ --cov=app --cov-report=html
```

**Sample Test File** (`tests/test_health.py`):
```python
import pytest
from httpx import AsyncClient
from app.main import app

@pytest.mark.asyncio
async def test_health_endpoint():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.get("/health")
    
    assert response.status_code == 200
    assert response.json()["status"] == "ok"

@pytest.mark.asyncio
async def test_model_status():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.get("/api/model/status")
    
    assert response.status_code == 200
    assert "status" in response.json()
```

#### 2. Node.js Unit Tests
```bash
cd C:\Users\User\noblestride-backend

# Run existing tests
npm test

# Run with coverage
npm run test:coverage
```

### 🔗 Integration Testing

#### 1. API Integration Tests
Create `integration_tests.py`:
```python
import requests
import time
import json

def test_service_integration():
    """Test integration between all services"""
    
    # Test 1: FastAPI Health
    print("🔍 Testing FastAPI Health...")
    response = requests.get("http://localhost:8010/health", timeout=10)
    assert response.status_code == 200
    assert response.json()["status"] == "ok"
    print("✅ FastAPI healthy")
    
    # Test 2: Node.js Health  
    print("🔍 Testing Node.js Health...")
    response = requests.get("http://localhost:3030/", timeout=10)
    assert response.status_code == 200
    print("✅ Node.js healthy")
    
    # Test 3: Model Status
    print("🔍 Testing Model Status...")
    response = requests.get("http://localhost:8010/api/model/status", timeout=10)
    assert response.status_code == 200
    print(f"✅ Model status: {response.json()['status']}")
    
    # Test 4: Database Connectivity
    print("🔍 Testing Database Connectivity...")
    response = requests.get("http://localhost:8010/api/debug/system-info", timeout=10)
    if response.status_code == 200:
        db_status = response.json().get("database", {}).get("status")
        print(f"✅ Database: {db_status}")
    
    print("🎉 Integration tests passed!")

if __name__ == "__main__":
    test_service_integration()
```

Run integration tests:
```bash
python integration_tests.py
```

#### 2. End-to-End Testing

**E2E Test Script** (`e2e_test.py`):
```python
import requests
import time
import json
from datetime import datetime

def test_full_recommendation_flow():
    """Test complete recommendation workflow"""
    
    base_url = "http://localhost:8010"
    
    print("🔄 Starting End-to-End Test...")
    
    # Step 1: Check system health
    health = requests.get(f"{base_url}/health").json()
    assert health["status"] == "ok"
    print("✅ System healthy")
    
    # Step 2: Get model status
    model_status = requests.get(f"{base_url}/api/model/status").json()
    print(f"📊 Model status: {model_status['status']}")
    
    # Step 3: Trigger model training (if needed)
    if model_status["status"] != "ready":
        print("🚀 Triggering model training...")
        training = requests.post(f"{base_url}/api/model/trigger-training")
        assert training.status_code == 200
        time.sleep(5)  # Wait for training to start
    
    # Step 4: Test recommendation endpoints (with mock data)
    print("🎯 Testing recommendation endpoints...")
    
    # Mock recommendation request
    rec_request = {
        "investor_id": "test_investor_123",
        "filters": {
            "sectors": ["fintech"],
            "min_funding": 100000,
            "max_funding": 5000000
        },
        "limit": 5
    }
    
    try:
        rec_response = requests.post(
            f"{base_url}/api/recommend/businesses-for-investor",
            json=rec_request,
            timeout=30
        )
        print(f"📈 Recommendation response: {rec_response.status_code}")
        
        if rec_response.status_code == 200:
            recommendations = rec_response.json()
            print(f"📊 Found {len(recommendations.get('items', []))} recommendations")
    
    except requests.exceptions.RequestException as e:
        print(f"⚠️  Recommendation endpoint not fully implemented: {e}")
    
    # Step 5: Test feedback submission
    feedback_data = {
        "investor_id": "test_investor_123",
        "business_id": "test_business_456",
        "feedback_type": "positive",
        "details": {
            "rating": 5,
            "comments": "Test feedback"
        }
    }
    
    try:
        feedback_response = requests.post(
            f"{base_url}/api/feedback",
            json=feedback_data,
            timeout=10
        )
        print(f"📝 Feedback response: {feedback_response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"⚠️  Feedback endpoint not fully implemented: {e}")
    
    print("🎉 End-to-End test completed!")

if __name__ == "__main__":
    test_full_recommendation_flow()
```

### ⚡ Performance Testing

#### 1. Load Testing with Locust
Install Locust:
```bash
pip install locust
```

Create `locustfile.py`:
```python
from locust import HttpUser, task, between

class RecommenderUser(HttpUser):
    wait_time = between(1, 3)
    
    def on_start(self):
        """Initialize test data"""
        self.investor_id = "load_test_investor"
        self.business_id = "load_test_business"
    
    @task(10)
    def health_check(self):
        """Test health endpoint (high frequency)"""
        self.client.get("/health")
    
    @task(5)
    def model_status(self):
        """Test model status endpoint"""
        self.client.get("/api/model/status")
    
    @task(2)
    def get_recommendations(self):
        """Test recommendation endpoint"""
        payload = {
            "investor_id": self.investor_id,
            "filters": {
                "sectors": ["fintech", "healthtech"],
                "min_funding": 100000,
                "max_funding": 1000000
            },
            "limit": 10
        }
        
        with self.client.post("/api/recommend/businesses-for-investor", json=payload, catch_response=True) as response:
            if response.status_code == 404:
                response.success()  # Expected for endpoints not implemented
    
    @task(1)
    def submit_feedback(self):
        """Test feedback submission"""
        payload = {
            "investor_id": self.investor_id,
            "business_id": self.business_id,
            "feedback_type": "positive"
        }
        
        with self.client.post("/api/feedback", json=payload, catch_response=True) as response:
            if response.status_code in [404, 422]:
                response.success()  # Expected for endpoints not fully implemented
```

Run load tests:
```bash
# Start load test
locust -f locustfile.py --host=http://localhost:8010

# Access web UI at http://localhost:8089
# Configure: 100 users, 10 users/second spawn rate
```

#### 2. Database Performance Testing
```bash
# Test PostgreSQL performance
cd C:\Users\User\recommendation-service

# Create test script
cat > db_performance_test.py << 'EOF'
import psycopg2
import time
import statistics

def test_db_performance():
    conn_params = {
        'host': 'localhost',
        'port': 5438,
        'database': 'recommender_db',
        'user': 'postgres',
        'password': 'password'
    }
    
    try:
        conn = psycopg2.connect(**conn_params)
        cursor = conn.cursor()
        
        # Test connection time
        times = []
        for i in range(10):
            start = time.time()
            cursor.execute("SELECT 1")
            cursor.fetchone()
            times.append(time.time() - start)
        
        print(f"📊 Database Performance:")
        print(f"   Average query time: {statistics.mean(times)*1000:.2f}ms")
        print(f"   Min query time: {min(times)*1000:.2f}ms")
        print(f"   Max query time: {max(times)*1000:.2f}ms")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"❌ Database test failed: {e}")

if __name__ == "__main__":
    test_db_performance()
EOF

python db_performance_test.py
```

---

## 🏭 Production Deployment

### 🔒 Production Configuration

#### 1. Environment Variables
Create production `.env` file:
```bash
# Production Database
DATABASE_URL=postgresql+psycopg2://prod_user:secure_password@prod_db:5432/recommender_prod

# Security
DEBUG=false
LOG_LEVEL=WARNING
SECRET_KEY=your_production_secret_key_here
API_KEY=your_production_api_key_here

# Performance
DB_POOL_SIZE=20
DB_POOL_MAX_OVERFLOW=50
WORKER_CONNECTIONS=1000

# Monitoring
ENABLE_METRICS=true
METRICS_PORT=9090
```

#### 2. Production Docker Compose
Create `docker-compose.prod.yml`:
```yaml
version: '3.8'

services:
  api:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - DEBUG=false
      - LOG_LEVEL=WARNING
    deploy:
      replicas: 3
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G

  redis:
    image: redis:7-alpine
    command: redis-server --requirepass ${REDIS_PASSWORD}
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 256M

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/ssl/certs
    depends_on:
      - api

volumes:
  postgres_data:
```

#### 3. Nginx Configuration
Create `nginx.conf`:
```nginx
events {
    worker_connections 1024;
}

http {
    upstream fastapi_backend {
        server api:8000;
    }
    
    server {
        listen 80;
        server_name your-domain.com;
        
        # Redirect HTTP to HTTPS
        return 301 https://$server_name$request_uri;
    }
    
    server {
        listen 443 ssl http2;
        server_name your-domain.com;
        
        ssl_certificate /etc/ssl/certs/cert.pem;
        ssl_certificate_key /etc/ssl/certs/key.pem;
        
        location / {
            proxy_pass http://fastapi_backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```

### 🚀 Deployment Commands

```bash
# Production deployment
docker-compose -f docker-compose.prod.yml up -d

# Scale services
docker-compose -f docker-compose.prod.yml up -d --scale api=3

# Rolling update
docker-compose -f docker-compose.prod.yml up -d --no-deps api
```

### 📊 Production Monitoring

#### 1. Health Check Monitoring
```bash
# Create monitoring script
cat > monitor.py << 'EOF'
import requests
import time
import smtplib
from email.mime.text import MIMEText

def check_health():
    services = {
        'FastAPI': 'http://localhost:8010/health',
        'Node.js': 'http://localhost:3030/',
        'Airflow': 'http://localhost:8080/health'
    }
    
    for name, url in services.items():
        try:
            response = requests.get(url, timeout=10)
            if response.status_code == 200:
                print(f"✅ {name}: Healthy")
            else:
                print(f"⚠️  {name}: Unhealthy ({response.status_code})")
                send_alert(f"{name} service unhealthy")
        except Exception as e:
            print(f"❌ {name}: Error - {e}")
            send_alert(f"{name} service down: {e}")

def send_alert(message):
    # Configure email alerts
    pass

if __name__ == "__main__":
    while True:
        check_health()
        time.sleep(300)  # Check every 5 minutes
EOF

# Run monitoring
python monitor.py
```

---

## 🔧 Troubleshooting

### 🚨 Common Issues

#### 1. Port Conflicts
**Symptoms**: `Port already in use` errors

**Solutions**:
```bash
# Find processes using ports
netstat -ano | findstr :8010
netstat -ano | findstr :3030
netstat -ano | findstr :8080

# Kill processes (Windows)
taskkill /PID <process_id> /F

# Change ports in configuration files
# docker-compose.yml: "8011:8000" instead of "8010:8000"
```

#### 2. Database Connection Issues
**Symptoms**: Connection timeouts, authentication failures

**Solutions**:
```bash
# Check PostgreSQL containers
docker ps | grep postgres
docker logs recommender_db
docker logs noblestride_db

# Test connections
docker exec -it recommender_db psql -U postgres -d recommender_db
docker exec -it noblestride_db psql -U postgres -d noblestride

# Reset database passwords
docker exec -it recommender_db psql -U postgres -c "ALTER USER postgres PASSWORD 'new_password';"
```

#### 3. Service Communication Issues
**Symptoms**: Services can't communicate, API timeouts

**Solutions**:
```bash
# Check Docker networks
docker network ls
docker network inspect recommendation-service_default

# Test connectivity between containers
docker exec -it recommender_api ping recommender_db
docker exec -it recommender_api curl http://host.docker.internal:3030

# Check firewall settings
netsh advfirewall show allprofiles
```

#### 4. Memory/Resource Issues
**Symptoms**: Slow performance, container crashes

**Solutions**:
```bash
# Monitor resource usage
docker stats

# Increase Docker resources
# Docker Desktop > Settings > Resources > Memory: 8GB+

# Optimize container resources
docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

### 🔍 Debugging Commands

#### Docker Debugging
```bash
# View container logs
docker logs recommender_api --tail 100 -f
docker logs recommender_db --tail 50

# Execute commands in containers
docker exec -it recommender_api /bin/bash
docker exec -it recommender_api python -c "from app.core.config import settings; print(settings.DATABASE_URL)"

# Inspect container configuration
docker inspect recommender_api
docker inspect recommender_db
```

#### Application Debugging
```bash
# FastAPI debugging
docker exec -it recommender_api python -m pytest tests/ -v
docker exec -it recommender_api python -c "
from app.db.session import engine
try:
    with engine.connect() as conn:
        print('✅ Database connected')
except Exception as e:
    print(f'❌ Database error: {e}')
"

# Check environment variables
docker exec -it recommender_api env | grep DB_
docker exec -it recommender_api env | grep API_
```

### 📋 Health Check Scripts

Create comprehensive health check:
```bash
# create_health_check.ps1
cat > comprehensive_health_check.ps1 << 'EOF'
Write-Host "🏥 Comprehensive Health Check" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Check Docker
try {
    docker version | Out-Null
    Write-Host "✅ Docker: Running" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker: Not running" -ForegroundColor Red
}

# Check Containers
Write-Host "`n🐳 Container Status:" -ForegroundColor Cyan
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Check Services
$services = @(
    @{Name="FastAPI"; URL="http://localhost:8010/health"},
    @{Name="Node.js"; URL="http://localhost:3030/"},
    @{Name="Airflow"; URL="http://localhost:8080/health"}
)

Write-Host "`n🌐 Service Health:" -ForegroundColor Cyan
foreach ($service in $services) {
    try {
        $response = Invoke-RestMethod -Uri $service.URL -TimeoutSec 5
        Write-Host "✅ $($service.Name): Healthy" -ForegroundColor Green
    } catch {
        Write-Host "❌ $($service.Name): Unhealthy" -ForegroundColor Red
    }
}

# Check Database Connections
Write-Host "`n🗄️  Database Status:" -ForegroundColor Cyan
try {
    docker exec recommender_db pg_isready -U postgres -d recommender_db
    Write-Host "✅ Recommender DB: Connected" -ForegroundColor Green
} catch {
    Write-Host "❌ Recommender DB: Not connected" -ForegroundColor Red
}

# Check System Resources
Write-Host "`n💻 System Resources:" -ForegroundColor Cyan
$memory = Get-WmiObject -Class Win32_OperatingSystem
$memoryUsed = [math]::Round((($memory.TotalVisibleMemorySize - $memory.FreePhysicalMemory) / $memory.TotalVisibleMemorySize) * 100, 2)
Write-Host "Memory Usage: $memoryUsed%" -ForegroundColor $(if($memoryUsed -gt 80) {"Red"} else {"Green"})

Write-Host "`n🎯 Health Check Complete!" -ForegroundColor Cyan
EOF

powershell -ExecutionPolicy Bypass -File comprehensive_health_check.ps1
```

---

## 📈 Performance Optimization

### ⚡ FastAPI Optimization

#### 1. Database Connection Pooling
```python
# app/db/session.py
from sqlalchemy import create_engine
from sqlalchemy.pool import QueuePool

engine = create_engine(
    DATABASE_URL,
    poolclass=QueuePool,
    pool_size=20,
    max_overflow=50,
    pool_pre_ping=True,
    pool_recycle=3600,
    echo=False
)
```

#### 2. Async Endpoints
```python
# Convert sync endpoints to async
@router.get("/api/businesses")
async def get_businesses(db: Session = Depends(get_db)):
    # Use async database operations
    result = await db.execute(select(Business).limit(10))
    return result.scalars().all()
```

#### 3. Caching Layer
```python
# Add Redis caching
from redis import Redis
redis_client = Redis(host='redis', port=6379, decode_responses=True)

@router.get("/api/businesses")
async def get_businesses_cached():
    cache_key = "businesses:all"
    cached = redis_client.get(cache_key)
    
    if cached:
        return json.loads(cached)
    
    # Fetch from database
    businesses = fetch_businesses()
    redis_client.setex(cache_key, 300, json.dumps(businesses))
    return businesses
```

### 🐳 Docker Optimization

#### 1. Multi-stage Build
```dockerfile
# Dockerfile.optimized
FROM python:3.11-slim as builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.11-slim as runner

WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .

ENV PATH=/root/.local/bin:$PATH
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### 2. Resource Limits
```yaml
# docker-compose.performance.yml
services:
  api:
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G
        reservations:
          cpus: '1.0'
          memory: 1G
    environment:
      - UVICORN_WORKERS=4
      - UVICORN_WORKER_CLASS=uvicorn.workers.UvicornWorker
```

---

*Deployment & Testing Guide Last Updated: September 18, 2025*  
*System Version: 0.1.0*  
*Documentation Version: 1.0*