#!/bin/bash

# 🚀 NobleStride Recommender System - Simple Start Script

echo "🚀 Starting NobleStride Recommender System..."

case "${1:-start}" in
    start)
        echo "Starting all services..."
        docker-compose up -d
        echo ""
        echo "✅ Services starting! Check status with: ./start.sh status"
        echo ""
        echo "📋 Access URLs:"
        echo "  • API Documentation: http://localhost:8010/docs"
        echo "  • Airflow Web UI:    http://localhost:8090 (admin/admin123)"
        echo "  • MLflow Tracking:   http://localhost:5001"
        echo "  • Main Database:     Uses your existing Noblestride DB"
        echo "  • Airflow DB:        Internal Docker (port 5437)"
        echo "  • MLflow DB:         Internal Docker (port 5438)"
        echo "  • Redis Cache:       localhost:6380 (password: redis_pass)"
        ;;
    stop)
        echo "Stopping all services..."
        docker-compose down
        echo "✅ All services stopped"
        ;;
    restart)
        echo "Restarting all services..."
        docker-compose down
        docker-compose up -d
        echo "✅ Services restarted"
        ;;
    status)
        echo "📊 Service Status:"
        docker-compose ps
        ;;
    logs)
        if [ -z "$2" ]; then
            echo "📋 All service logs:"
            docker-compose logs -f
        else
            echo "📋 Logs for $2:"
            docker-compose logs -f "$2"
        fi
        ;;
    build)
        echo "🔨 Building images..."
        docker-compose build --no-cache
        echo "✅ Images built"
        ;;
    clean)
        echo "🧹 Cleaning up everything..."
        docker-compose down -v
        docker system prune -f
        echo "✅ Cleanup complete"
        ;;
    help|*)
        echo ""
        echo "NobleStride Recommender System Commands:"
        echo ""
        echo "  ./start.sh start    - Start all services"
        echo "  ./start.sh stop     - Stop all services"  
        echo "  ./start.sh restart  - Restart all services"
        echo "  ./start.sh status   - Check service status"
        echo "  ./start.sh logs     - View all logs"
        echo "  ./start.sh logs api - View specific service logs"
        echo "  ./start.sh build    - Rebuild Docker images"
        echo "  ./start.sh clean    - Clean up everything"
        echo ""
        echo "Services included:"
        echo "  • FastAPI (Recommendation API) - connects to your main DB"
        echo "  • PostgreSQL (2 internal DBs: airflow, mlflow)"
        echo "  • Redis (Caching)"
        echo "  • MLflow (ML model tracking)"
        echo "  • Airflow (Workflow orchestration)"
        echo ""
        ;;
esac