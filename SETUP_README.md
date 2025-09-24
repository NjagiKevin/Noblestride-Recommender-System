# NobleStride Recommender System - Setup Guide

## 🏗️ Architecture Overview

Your recommender system includes:

- **FastAPI Application** (port 8010) - Main recommendation service
- **Apache Airflow** (port 8090) - Workflow orchestration
- **MLflow Tracking Server** (port 5000) - ML experiment tracking
- **PostgreSQL Databases**:
  - Main application DB (port 5432)
  - Airflow metadata DB (port 5433)
  - MLflow tracking DB (port 5434)
- **Redis Cache** (port 6379) - Caching and session storage
- **Flower** (port 5555) - Celery monitoring

## ✅ Prerequisites

- Docker & Docker Compose installed
- At least 8GB RAM available
- Ports 5000, 5432-5434, 6379, 8010, 8090, 5555 available

## 🚀 Quick Start

### Option 1: Full Production Setup
```bash
# Run the complete setup script
./setup_recommender_system.sh

# Or step by step:
./setup_recommender_system.sh setup
```

### Option 2: Development Mode
```bash
# Quick development start
./dev-setup.sh dev

# Or using docker-compose directly
docker-compose up -d
```

## 📋 Setup Script Options

The main setup script supports several commands:

```bash
# Complete setup and start all services
./setup_recommender_system.sh setup

# Stop all services
./setup_recommender_system.sh stop

# Restart all services
./setup_recommender_system.sh restart

# Show service status
./setup_recommender_system.sh status

# View all logs
./setup_recommender_system.sh logs
```

## 🔧 Development Commands

```bash
# Development environment
./dev-setup.sh dev          # Start dev environment
./dev-setup.sh stop         # Stop all services
./dev-setup.sh clean        # Clean containers and volumes
./dev-setup.sh logs         # Show logs
./dev-setup.sh status       # Show status
./dev-setup.sh test-dag     # Test Airflow DAGs

# Production environment
./dev-setup.sh prod         # Start full production setup
```

## 🌐 Service URLs

After setup, access your services at:

| Service | URL | Credentials |
|---------|-----|-------------|
| FastAPI Application | http://localhost:8010 | - |
| FastAPI Documentation | http://localhost:8010/docs | - |
| Airflow Web UI | http://localhost:8090 | admin / admin_secure_password_2024 |
| MLflow Tracking | http://localhost:5000 | - |
| Flower (Celery Monitor) | http://localhost:5555 | - |

## 🗄️ Database Connections

| Database | Connection | Port |
|----------|------------|------|
| Main Application | localhost:5432 | 5432 |
| Airflow Metadata | localhost:5433 | 5433 |
| MLflow Tracking | localhost:5434 | 5434 |
| Redis Cache | localhost:6379 | 6379 |

## 🔍 Monitoring & Debugging

### View Service Logs
```bash
# All services
docker-compose -f docker-compose.prod.yml logs -f

# Specific service
docker-compose -f docker-compose.prod.yml logs -f api
docker-compose -f docker-compose.prod.yml logs -f airflow-scheduler
docker-compose -f docker-compose.prod.yml logs -f mlflow
```

### Check Service Health
```bash
# Service status
docker-compose -f docker-compose.prod.yml ps

# Container health
docker ps
```

### Access Service Containers
```bash
# API container
docker exec -it recommender_api bash

# Airflow scheduler
docker exec -it airflow_scheduler bash

# Database
docker exec -it noblestride_main_db psql -U postgres -d noblestride
```

## 🧪 Testing DAGs

```bash
# Test DAG syntax
python -m py_compile airflow-orchestrator/dags/*.py

# Test specific DAG
docker exec -it airflow_scheduler airflow dags test noblestride_integration_pipeline 2024-01-01
```

## 🔧 Configuration Files

### Environment Configuration
- `.env` - Development environment variables
- `.env.prod` - Production environment variables

### Docker Configuration
- `docker-compose.yml` - Development setup
- `docker-compose.prod.yml` - Production setup with all services

### Airflow Configuration
- `airflow-orchestrator/dags/` - DAG definitions
- `airflow-orchestrator/requirements.prod.txt` - Python dependencies
- `airflow-orchestrator/Dockerfile.prod` - Production Airflow image

## 🚨 Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Check what's using the port
   netstat -tulpn | grep :8010
   
   # Kill the process or change port in docker-compose
   ```

2. **Database Connection Issues**
   ```bash
   # Check database logs
   docker-compose -f docker-compose.prod.yml logs -f noblestride-service-db
   
   # Restart database services
   docker-compose -f docker-compose.prod.yml restart noblestride-service-db
   ```

3. **Airflow Database Initialization Failed**
   ```bash
   # Reset Airflow database
   docker-compose -f docker-compose.prod.yml down
   docker volume rm $(docker volume ls -q | grep airflow)
   ./setup_recommender_system.sh setup
   ```

4. **MLflow Not Starting**
   ```bash
   # Check MLflow logs
   docker-compose -f docker-compose.prod.yml logs -f mlflow
   
   # Recreate MLflow artifacts directory
   mkdir -p mlflow/artifacts
   chmod 755 mlflow/artifacts
   ```

### Performance Tuning

1. **Memory Issues**
   - Increase Docker memory limit to 8GB+
   - Monitor memory usage: `docker stats`

2. **Slow Startup**
   - Services start sequentially for stability
   - Full startup takes 5-10 minutes
   - Monitor with `docker-compose -f docker-compose.prod.yml ps`

3. **Database Performance**
   - Monitor database connections
   - Check PostgreSQL logs for slow queries

## 📈 Production Deployment

### Security Considerations
1. Change default passwords in `.env.prod`
2. Use proper SSL certificates
3. Set up firewall rules
4. Enable database encryption

### Scaling Considerations
1. Use external databases for production
2. Set up load balancing for API
3. Configure proper logging and monitoring
4. Implement backup strategies

## 📝 Maintenance

### Regular Tasks
```bash
# Update containers
docker-compose -f docker-compose.prod.yml pull
docker-compose -f docker-compose.prod.yml up -d

# Clean up unused resources
docker system prune

# Backup databases
docker exec noblestride_main_db pg_dump -U postgres noblestride > backup.sql
```

### Logs Rotation
```bash
# Clean up old logs
docker system prune --volumes
```

## 🆘 Support

If you encounter issues:

1. Check service logs for error messages
2. Verify all ports are available
3. Ensure Docker has sufficient resources
4. Check environment variable configuration
5. Review DAG syntax if Airflow fails

For additional help, check the individual service documentation:
- [FastAPI](https://fastapi.tiangolo.com/)
- [Apache Airflow](https://airflow.apache.org/)
- [MLflow](https://mlflow.org/)
- [PostgreSQL](https://www.postgresql.org/)
