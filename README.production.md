# NobleStride Recommender System - Production Deployment

## 🏗️ Architecture Overview

This production setup connects to your existing Noblestride database while running the ML recommendation services in containerized form:

**External Dependencies (Your Infrastructure):**
- Main Noblestride Database (PostgreSQL)
- Airflow Metadata Database (PostgreSQL)
- MLflow Tracking Database (PostgreSQL)

**Internal Services (This Container Stack):**
- **FastAPI Application** (port 8010) - ML recommendation service
- **Apache Airflow** (port 8090) - Workflow orchestration
- **MLflow Tracking Server** (port 5000) - ML experiment tracking
- **Redis Cache** (port 6380) - Internal caching

## 📋 Prerequisites

- Docker & Docker Compose installed
- At least 4GB RAM available for containers
- Access to your existing Noblestride database
- Separate databases for Airflow and MLflow (recommended)
- Ports 5000, 6380, 8010, 8090 available

## 🚀 Production Setup

### Step 1: Configure Environment Variables

1. Copy the production environment template:
```bash
cp .env.production .env.production.local
```

2. Edit `.env.production.local` with your actual database credentials:

```bash
# Main Application Database (Your existing Noblestride database)
DB_HOST=your-actual-database-host.com
DB_USER=your-database-username
DB_PASSWORD=your-secure-database-password
DB_NAME=noblestride
DB_PORT=5432

# Airflow Database (Separate database recommended)
AIRFLOW_DB_HOST=your-airflow-db-host.com
AIRFLOW_DB_USER=airflow
AIRFLOW_DB_PASSWORD=secure-airflow-password
AIRFLOW_DB_NAME=airflow

# MLflow Database (Separate database recommended)
MLFLOW_DB_HOST=your-mlflow-db-host.com
MLFLOW_DB_USER=mlflow
MLFLOW_DB_PASSWORD=secure-mlflow-password
MLFLOW_DB_NAME=mlflow

# Generate secure keys (see below)
FERNET_KEY=your-generated-fernet-key
SECRET_KEY=your-super-secret-production-key
AIRFLOW_WEB_PASSWORD=secure-admin-password
REDIS_PASSWORD=secure-redis-password
```

### Step 2: Generate Security Keys

Generate a Fernet key for Airflow:
```bash
python3 -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
```

Generate a secret key:
```bash
openssl rand -hex 32
```

### Step 3: Setup Databases

Create the required databases in your PostgreSQL instances:

```sql
-- For Airflow (on your Airflow database server)
CREATE DATABASE airflow;
CREATE USER airflow WITH PASSWORD 'your-airflow-password';
GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;

-- For MLflow (on your MLflow database server)
CREATE DATABASE mlflow;
CREATE USER mlflow WITH PASSWORD 'your-mlflow-password';
GRANT ALL PRIVILEGES ON DATABASE mlflow TO mlflow;
```

### Step 4: Deploy Production Services

Use the production deployment script:

```bash
# Initial setup and build
./deploy-production.sh setup

# Start services
./deploy-production.sh start

# Check status
./deploy-production.sh status
```

## 🔧 Management Commands

The `deploy-production.sh` script provides easy management:

```bash
# Start all services
./deploy-production.sh start

# Stop all services
./deploy-production.sh stop

# Restart services
./deploy-production.sh restart

# View service status and URLs
./deploy-production.sh status

# View logs for all services
./deploy-production.sh logs

# View logs for specific service
./deploy-production.sh logs api
./deploy-production.sh logs airflow-webserver

# Run database migrations
./deploy-production.sh migrate

# Create backup of persistent data
./deploy-production.sh backup

# Rebuild Docker images
./deploy-production.sh build
```

## 🌐 Service Access

After deployment, access your services at:

| Service | URL | Credentials |
|---------|-----|-------------|
| FastAPI Documentation | http://localhost:8010/docs | - |
| Airflow Web UI | http://localhost:8090 | admin / your-airflow-password |
| MLflow Tracking | http://localhost:5000 | - |
| Redis | localhost:6380 | Password protected |

## 📊 Directory Structure and Purpose

```
├── app/                          # FastAPI application code
├── airflow-orchestrator/         # Airflow DAGs and configuration
│   ├── dags/                    # Airflow workflow definitions
│   ├── Dockerfile.prod          # Production Airflow image
│   └── requirements.prod.txt    # Airflow Python dependencies
├── mlflow/artifacts/            # MLflow model artifacts (Docker volume)
├── docker-compose.production.yml # Production container orchestration
├── .env.production              # Production environment template
├── deploy-production.sh         # Production deployment script
├── requirements.txt             # FastAPI Python dependencies
└── README.production.md         # This file
```

### Key Directories Explained:

- **`mlflow/artifacts/`**: Stores trained ML models and experiment artifacts
- **`airflow-orchestrator/dags/`**: Contains workflow definitions for ML pipelines
- **`app/`**: Main recommendation service application

## 🔒 Security Considerations

1. **Environment Variables**: Never commit `.env.production.local` to version control
2. **Database Access**: Use dedicated database users with minimal required permissions
3. **Network Security**: Consider using Docker networks and firewall rules
4. **SSL/TLS**: Configure reverse proxy with SSL in production
5. **Secrets Management**: Use proper secrets management for sensitive data

## 🔍 Monitoring & Debugging

### Health Checks

All services include health checks. Monitor with:
```bash
docker-compose -f docker-compose.production.yml ps
```

### Viewing Logs

```bash
# All services
./deploy-production.sh logs

# Specific services
./deploy-production.sh logs api
./deploy-production.sh logs airflow-scheduler
./deploy-production.sh logs mlflow
./deploy-production.sh logs redis
```

### Service Status

```bash
./deploy-production.sh status
```

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Failed**
   ```bash
   # Check database connectivity from container
   docker-compose -f docker-compose.production.yml exec api python -c "
   from app.db.session import engine
   try:
       engine.connect()
       print('Database connection successful')
   except Exception as e:
       print(f'Database connection failed: {e}')
   "
   ```

2. **Redis Connection Issues**
   ```bash
   # Test Redis connectivity
   docker-compose -f docker-compose.production.yml exec redis redis-cli -a your-redis-password ping
   ```

3. **Airflow Database Initialization**
   ```bash
   # Initialize Airflow database manually
   docker-compose -f docker-compose.production.yml exec airflow-webserver airflow db init
   ```

4. **MLflow Artifacts Permission Issues**
   ```bash
   # Fix MLflow artifacts permissions
   docker-compose -f docker-compose.production.yml exec mlflow chown -R 1000:1000 /mlflow/artifacts
   ```

### Port Conflicts

If you encounter port conflicts:
1. Stop conflicting services
2. Update port mappings in `docker-compose.production.yml`
3. Update corresponding environment variables

## 📈 Production Best Practices

1. **Resource Allocation**: Ensure adequate CPU and memory
2. **Database Connections**: Monitor connection pool usage
3. **Log Rotation**: Implement log rotation for long-running services
4. **Backup Strategy**: Regular backups of MLflow artifacts and Redis data
5. **Update Strategy**: Plan for zero-downtime updates

## 🔄 Updates and Maintenance

### Updating Services

1. Pull latest code
2. Rebuild images: `./deploy-production.sh build`
3. Restart services: `./deploy-production.sh restart`

### Backup Before Updates

```bash
./deploy-production.sh backup
```

### Database Migrations

```bash
./deploy-production.sh migrate
```

## 📞 Support

For issues specific to:
- **Database connectivity**: Check your database server configurations
- **Airflow workflows**: Review DAG syntax and dependencies
- **ML model issues**: Check MLflow tracking server logs
- **API performance**: Monitor FastAPI application logs

Service logs location: Use `./deploy-production.sh logs [service]` to access logs for debugging.