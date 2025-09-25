# 🚀 Quick Setup Guide

## Prerequisites
1. Your main Noblestride app must be running (with database on `noblestride-network`)
2. Docker and Docker Compose installed

## Setup Steps

### 1. Make sure your main app is running
Your main app should have:
- Database container named `noblestride-service-db`
- Connected to `noblestride-network`
- Database credentials: `postgres/password/noblestride`

### 2. Start the ML services
```bash
./start.sh start
```

### 3. Wait and check
```bash
# Wait 2-3 minutes for services to initialize
./start.sh status
```

## What this does:

✅ **Connects to your existing database** - No duplicate databases  
✅ **Creates internal Airflow database** - For workflow metadata  
✅ **Creates internal MLflow database** - For ML experiment tracking  
✅ **Starts Redis cache** - On port 6380 (avoids port 6379 conflict)  
✅ **Joins noblestride-network** - Can communicate with your main app  

## Access URLs:
- **API**: http://localhost:8010/docs
- **Airflow**: http://localhost:8090 (admin/admin123)  
- **MLflow**: http://localhost:5000

## Troubleshooting:

**Connection issues?**
```bash
# Check if main app network exists
docker network ls | grep noblestride-network

# Check if main database is running
docker ps | grep noblestride-service-db
```

**Still having issues?**
```bash
./start.sh logs api
```