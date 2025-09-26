# 🚀 NobleStride Recommender System

A complete ML-powered recommendation system with FastAPI, Airflow, and MLflow.

## Quick Start

**Start everything:**
```bash
./start.sh start
```

**That's it!** All services will start automatically.

## 📋 Access Your Services

After starting, access your services at:

| Service | URL | Login |
|---------|-----|-------|
| **API Documentation** | http://localhost:8010/docs | - |
| **Airflow Web UI** | http://localhost:8090 | admin/admin123 |
| **MLflow Tracking** | http://localhost:5000 | - |
| **Main Database** | Uses your existing Noblestride DB | - |
| **Redis Cache** | localhost:6380 | redis_pass |

## 🛠️ Management Commands

```bash
./start.sh start      # Start all services
./start.sh stop       # Stop all services
./start.sh restart    # Restart all services
./start.sh status     # Check service status
./start.sh logs       # View all logs
./start.sh logs api   # View specific service logs
./start.sh build      # Rebuild images
./start.sh clean      # Clean up everything
```

## 🏗️ What's Included

- **FastAPI App** (port 8010) - ML recommendation API (connects to your existing DB)
- **PostgreSQL Databases** (ports 5433, 5434) - Internal Airflow & MLflow data storage
- **Redis Cache** (port 6380) - Fast caching
- **MLflow Server** (port 5000) - ML model tracking
- **Airflow** (port 8090) - Workflow orchestration

## 📊 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Docker Compose                           │
├─────────────────┬─────────────────┬─────────────────────────┤
│   FastAPI App   │  Airflow Web    │      MLflow Server      │
│   (port 8010)   │  (port 8090)    │      (port 5000)        │
├─────────────────┼─────────────────┼─────────────────────────┤
│               PostgreSQL Databases                          │
│  Main DB │ Airflow DB │ MLflow DB │      Redis Cache       │
│ (5432)   │   (5433)   │  (5434)   │      (6380)            │
└─────────────────────────────────────────────────────────────┘
```

## 🚨 First Time Setup

1. **Clone and navigate:**
   ```bash
   cd /path/to/Noblestride-Recommender-System
   ```

2. **Start everything:**
   ```bash
   ./start.sh start
   ```

3. **Wait 2-3 minutes** for all services to initialize

4. **Check status:**
   ```bash
   ./start.sh status
   ```

## 🔧 Development

- **View logs:** `./start.sh logs api`
- **Restart service:** `./start.sh restart`
- **Rebuild after code changes:** `./start.sh build && ./start.sh restart`

## 💾 Data Persistence

All data is automatically saved in Docker volumes:
- Database data persists across restarts
- MLflow experiments and models are saved
- Redis cache data is persistent
- Airflow logs and metadata are saved

## 🆘 Troubleshooting

**Services not starting?**
```bash
./start.sh logs
```

**Port conflicts?**
Edit `docker-compose.yml` and change the port mappings.

**Clean slate restart?**
```bash
./start.sh clean
./start.sh start
```

**Need help?**
```bash
./start.sh help
```