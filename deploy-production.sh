#!/bin/bash

# NobleStride Recommender System - Production Deployment Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if required environment variables are set
check_env_vars() {
    print_status "Checking required environment variables..."
    
    required_vars=(
        "DB_HOST" "DB_USER" "DB_PASSWORD" "DB_NAME"
        "AIRFLOW_DB_HOST" "AIRFLOW_DB_USER" "AIRFLOW_DB_PASSWORD"
        "MLFLOW_DB_HOST" "MLFLOW_DB_USER" "MLFLOW_DB_PASSWORD"
        "AIRFLOW_WEB_PASSWORD" "REDIS_PASSWORD"
        "FERNET_KEY" "SECRET_KEY"
    )
    
    missing_vars=()
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            missing_vars+=("$var")
        fi
    done
    
    if [ ${#missing_vars[@]} -ne 0 ]; then
        print_error "Missing required environment variables:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        print_error "Please set these variables in .env.production or your environment"
        exit 1
    fi
    
    print_success "All required environment variables are set"
}

# Function to generate Fernet key if needed
generate_fernet_key() {
    if command -v python3 &> /dev/null; then
        python3 -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
    else
        print_warning "Python3 not found. Please generate a Fernet key manually:"
        print_warning "python -c \"from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())\""
        echo "generated-fernet-key-placeholder"
    fi
}

# Function to setup production environment
setup_production() {
    print_status "Setting up production environment..."
    
    # Create network if it doesn't exist
    if ! docker network ls | grep -q "noblestride-network"; then
        print_status "Creating Docker network..."
        docker network create noblestride-network
        print_success "Docker network created"
    else
        print_status "Docker network already exists"
    fi
    
    # Check if .env.production exists
    if [ ! -f ".env.production" ]; then
        print_error ".env.production file not found!"
        print_error "Please create .env.production with your database connection details"
        exit 1
    fi
    
    # Load environment variables
    set -a
    source .env.production
    set +a
    
    # Validate environment variables
    check_env_vars
    
    print_success "Production environment setup complete"
}

# Function to build images
build_images() {
    print_status "Building Docker images..."
    
    docker-compose -f docker-compose.production.yml build --no-cache
    
    print_success "Docker images built successfully"
}

# Function to start services
start_services() {
    print_status "Starting production services..."
    
    # Start services
    docker-compose -f docker-compose.production.yml up -d
    
    # Wait for services to be healthy
    print_status "Waiting for services to be healthy..."
    sleep 30
    
    # Check service status
    docker-compose -f docker-compose.production.yml ps
    
    print_success "Production services started"
}

# Function to stop services
stop_services() {
    print_status "Stopping production services..."
    
    docker-compose -f docker-compose.production.yml down
    
    print_success "Production services stopped"
}

# Function to restart services
restart_services() {
    print_status "Restarting production services..."
    
    stop_services
    start_services
    
    print_success "Production services restarted"
}

# Function to show logs
show_logs() {
    local service=${1:-}
    
    if [ -n "$service" ]; then
        print_status "Showing logs for service: $service"
        docker-compose -f docker-compose.production.yml logs -f "$service"
    else
        print_status "Showing logs for all services"
        docker-compose -f docker-compose.production.yml logs -f
    fi
}

# Function to show service status
show_status() {
    print_status "Service Status:"
    docker-compose -f docker-compose.production.yml ps
    
    print_status "Service URLs:"
    echo "  - FastAPI Documentation: http://localhost:${API_PORT:-8010}/docs"
    echo "  - Airflow Web UI: http://localhost:${AIRFLOW_PORT:-8090}"
    echo "  - MLflow Tracking: http://localhost:${MLFLOW_PORT:-5000}"
    echo "  - Redis: localhost:6380"
}

# Function to run database migrations
run_migrations() {
    print_status "Running database migrations..."
    
    # This assumes your FastAPI app has database initialization
    docker-compose -f docker-compose.production.yml exec api python -c "
from app.db.session import init_db
init_db()
print('Database initialized successfully')
"
    
    print_success "Database migrations completed"
}

# Function to backup data
backup_data() {
    local backup_dir="backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    print_status "Creating backup in $backup_dir..."
    
    # Backup volumes
    docker run --rm -v noblestride-recommender-system_mlflow-artifacts:/source -v "$(pwd)/$backup_dir":/backup alpine tar czf /backup/mlflow-artifacts.tar.gz -C /source .
    docker run --rm -v noblestride-recommender-system_redis-data:/source -v "$(pwd)/$backup_dir":/backup alpine tar czf /backup/redis-data.tar.gz -C /source .
    
    print_success "Backup created in $backup_dir"
}

# Function to show help
show_help() {
    echo "NobleStride Recommender System - Production Deployment"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  setup        Setup production environment and build images"
    echo "  start        Start production services"
    echo "  stop         Stop production services"
    echo "  restart      Restart production services"
    echo "  status       Show service status and URLs"
    echo "  logs [svc]   Show logs for all services or specific service"
    echo "  migrate      Run database migrations"
    echo "  backup       Backup persistent data"
    echo "  build        Build Docker images"
    echo "  help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 setup              # Initial production setup"
    echo "  $0 start              # Start all services"
    echo "  $0 logs api           # Show API service logs"
    echo "  $0 status             # Check service status"
}

# Main script logic
case "${1:-help}" in
    setup)
        setup_production
        build_images
        ;;
    start)
        setup_production
        start_services
        show_status
        ;;
    stop)
        stop_services
        ;;
    restart)
        restart_services
        show_status
        ;;
    status)
        show_status
        ;;
    logs)
        show_logs "$2"
        ;;
    migrate)
        run_migrations
        ;;
    backup)
        backup_data
        ;;
    build)
        build_images
        ;;
    help)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac