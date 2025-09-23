# NobleStride ML Pipeline - Production Setup

## 🚀 Overview

This setup provides a production-grade ML pipeline with separate Airflow and MLflow instances, each with their own PostgreSQL databases and non-conflicting ports.

## 📋 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    NobleStride ML Pipeline                   │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   FastAPI   │  │   Airflow   │  │      MLflow         │  │
│  │  Port: 8010 │  │  Port: 8090 │  │    Port: 5000       │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  Main App   │  │  Airflow    │  │     MLflow          │  │
│  │ PostgreSQL  │  │ PostgreSQL  │  │   PostgreSQL        │  │
│  │ Port: 5432  │  │ Port: 5433  │  │   Port: 5434        │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐                          │
│  │    Redis    │  │   Flower    │                          │
│  │ Port: 6379  │  │ Port: 5555  │                          │
│  └─────────────┘  └─────────────┘                          │
└─────────────────────────────────────────────────────────────┘
```

## 🔧 Services & Ports

### Core Services
- **FastAPI Application**: `localhost:8010`
  - Main API with ML integration endpoints
  - Interactive docs: `http://localhost:8010/docs`
  - MLOps endpoints: `http://localhost:8010/mlops/`

- **Airflow Web UI**: `localhost:8090`
  - Username: `admin`
  - Password: `admin_secure_password_2024`
  - Manages ML training pipelines and workflows

- **MLflow Tracking UI**: `localhost:5000`
  - Experiment tracking and model registry
  - Artifact storage and model versioning

- **Flower (Celery Monitor)**: `localhost:5555` (optional)
  - Monitor Celery workers and tasks

### Databases
- **Main Application DB**: `localhost:5432` (Your existing database)
- **Airflow Database**: `localhost:5433`
  - Separate PostgreSQL instance for Airflow metadata
- **MLflow Database**: `localhost:5434`
  - Separate PostgreSQL instance for MLflow tracking
- **Redis**: `localhost:6379`
  - Message broker for Celery workers

## 🚀 Quick Start

### 1. Prerequisites
```bash
# Ensure Docker and Docker Compose are installed
docker --version
docker-compose --version

# Ensure network exists (script will create if needed)
docker network create noblestride-network
```

### 2. Initialize Services
```bash
# Make scripts executable
chmod +x scripts/init_services.sh
chmod +x scripts/test_endpoints.sh

# Start all services
./scripts/init_services.sh
```

### 3. Verify Setup
```bash
# Test all endpoints
./scripts/test_endpoints.sh
```

## 📊 Available DAGs

### 1. Recommendation Training Pipeline
- **DAG ID**: `recommendation_training_pipeline`
- **Schedule**: Daily
- **Purpose**: Complete ML model training workflow
- **Stages**:
  - Data Quality Validation
  - Feature Engineering
  - Model Training
  - Model Evaluation
  - Model Deployment
  - Notification

### 2. Recommendation Monitoring
- **DAG ID**: `recommendation_monitoring`  
- **Schedule**: Hourly
- **Purpose**: Monitor model performance and trigger retraining
- **Features**:
  - Data quality monitoring
  - Model drift detection
  - Performance metrics tracking
  - Automated alerting

## 🧪 API Endpoints

### Health Checks
```bash
# Check Airflow health
curl http://localhost:8010/mlops/airflow/health

# Check MLflow health  
curl http://localhost:8010/mlops/mlflow/health

# Overall pipeline status
curl http://localhost:8010/mlops/pipeline/status
```

### Airflow Management
```bash
# List all DAGs
curl http://localhost:8010/mlops/airflow/dags

# Trigger a DAG run
curl -X POST http://localhost:8010/mlops/airflow/dags/recommendation_training_pipeline/dagRuns \
  -H "Content-Type: application/json" \
  -d '{"dag_id": "recommendation_training_pipeline", "conf": {"triggered_by": "api"}}'

# Check DAG run status
curl http://localhost:8010/mlops/airflow/dags/recommendation_training_pipeline/dagRuns/DAGRUN_ID
```

### MLflow Management
```bash
# List experiments
curl http://localhost:8010/mlops/mlflow/experiments

# Create experiment
curl -X POST http://localhost:8010/mlops/mlflow/experiments \
  -H "Content-Type: application/json" \
  -d '{"experiment_name": "my_experiment", "tags": {"env": "production"}}'

# List registered models
curl http://localhost:8010/mlops/mlflow/models

# Transition model stage
curl -X POST http://localhost:8010/mlops/mlflow/models/my_model/versions/1/stage \
  -H "Content-Type: application/json" \
  -d '{"stage": "Production"}'
```

### Pipeline Operations
```bash
# Trigger complete training pipeline
curl -X POST http://localhost:8010/mlops/pipeline/training/trigger
```

## 🔐 Security Configuration

### Environment Variables
All sensitive configurations are in `.env.prod`:
- Airflow admin credentials
- Database passwords
- API keys
- Fernet encryption keys

### Default Credentials
- **Airflow Admin**: 
  - Username: `admin`
  - Password: `admin_secure_password_2024`

⚠️ **Change these credentials in production!**

## 📁 Project Structure

```
recommendation-service/
├── docker-compose.prod.yml          # Production Docker Compose
├── .env.prod                        # Production environment variables
├── scripts/
│   ├── init_services.sh            # Service initialization script
│   └── test_endpoints.sh           # API testing script
├── airflow-orchestrator/
│   ├── Dockerfile.prod             # Production Airflow image
│   ├── entrypoint.prod.sh          # Airflow startup script
│   ├── requirements.prod.txt       # Airflow dependencies
│   ├── config/
│   │   └── airflow.cfg             # Airflow configuration
│   └── dags/
│       ├── recommendation_training_pipeline.py
│       └── recommendation_monitoring_dag.py
├── mlflow_config/
│   └── mlflow.ini                  # MLflow configuration
├── app/
│   └── api/
│       └── ml_ops.py               # MLOps API endpoints
└── data/                           # Data directories
    ├── raw/
    ├── processed/
    └── models/
```

## 🛠️ Management Commands

### Start Services
```bash
# Start all services
docker-compose -f docker-compose.prod.yml up -d

# Start with Flower monitoring
docker-compose -f docker-compose.prod.yml --profile flower up -d

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

### Stop Services
```bash
# Stop all services
docker-compose -f docker-compose.prod.yml down

# Stop and remove volumes (⚠️ DELETES DATA)
docker-compose -f docker-compose.prod.yml down -v
```

### Service Management
```bash
# Restart specific service
docker-compose -f docker-compose.prod.yml restart airflow-webserver

# View service logs
docker-compose -f docker-compose.prod.yml logs -f mlflow

# Execute commands in containers
docker-compose -f docker-compose.prod.yml exec airflow-webserver bash
docker-compose -f docker-compose.prod.yml exec mlflow bash
```

## 🔍 Monitoring & Debugging

### Check Service Status
```bash
# Check all containers
docker-compose -f docker-compose.prod.yml ps

# Check resource usage
docker stats
```

### Access Logs
```bash
# Airflow scheduler logs
docker-compose -f docker-compose.prod.yml logs -f airflow-scheduler

# MLflow logs
docker-compose -f docker-compose.prod.yml logs -f mlflow

# API logs
docker-compose -f docker-compose.prod.yml logs -f api
```

### Database Access
```bash
# Connect to Airflow database
docker exec -it airflow_postgres psql -U airflow -d airflow

# Connect to MLflow database  
docker exec -it mlflow_postgres psql -U mlflow -d mlflow
```

## 🚨 Troubleshooting

### Common Issues

1. **Port Conflicts**
   - Check if ports 8010, 8090, 5000, 5433, 5434, 6379 are available
   - Modify ports in `docker-compose.prod.yml` if needed

2. **Airflow Not Starting**
   - Check Fernet key is generated: `grep FERNET_KEY .env.prod`
   - Ensure database initialization completed: `docker-compose logs airflow-init`

3. **MLflow Connection Issues**
   - Verify MLflow database is running: `docker-compose ps mlflow-postgres`
   - Check MLflow logs: `docker-compose logs mlflow`

4. **Permission Issues**
   - Ensure scripts are executable: `chmod +x scripts/*.sh`
   - Check Docker daemon is running with proper permissions

### Reset Everything
```bash
# Complete reset (⚠️ DELETES ALL DATA)
docker-compose -f docker-compose.prod.yml down -v --remove-orphans
docker system prune -f
./scripts/init_services.sh
```

## 📝 Development Notes

### Adding New DAGs
1. Place DAG files in `airflow-orchestrator/dags/`
2. Restart Airflow: `docker-compose restart airflow-webserver airflow-scheduler`
3. DAGs will auto-discover and appear in UI

### Adding New API Endpoints
1. Add endpoints to `app/api/ml_ops.py`
2. Rebuild API container: `docker-compose build api`
3. Restart API: `docker-compose restart api`

### Environment Updates
1. Modify `.env.prod`
2. Restart affected services
3. Some changes require complete restart

## 📚 Additional Resources

- [Airflow Documentation](https://airflow.apache.org/docs/)
- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## 🎯 Production Considerations

1. **Security**: Change all default passwords and keys
2. **Backup**: Set up regular database backups
3. **Monitoring**: Configure external monitoring (Prometheus/Grafana)
4. **SSL/TLS**: Configure HTTPS for production deployment
5. **Resources**: Adjust CPU/memory limits based on workload
6. **Storage**: Configure persistent volumes for production data
7. **Logging**: Set up centralized logging (ELK Stack)

---

**Happy ML Engineering!** 🚀