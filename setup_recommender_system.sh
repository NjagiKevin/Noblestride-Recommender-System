#!/bin/bash

# NobleStride Recommender System Setup Script
# ==========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${PURPLE}╔══════════════════════════════════════════════╗"
echo -e "║     NobleStride Recommender System Setup    ║"
echo -e "╚══════════════════════════════════════════════╝${NC}"
echo ""

# Function to print status
print_status() {
    echo -e "${BLUE}► $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to check if Docker is running
check_docker() {
    print_status "Checking Docker installation..."
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        print_error "Docker is not running. Please start Docker first."
        exit 1
    fi
    
    print_success "Docker is running"
}

# Function to check if docker-compose is available
check_docker_compose() {
    print_status "Checking Docker Compose..."
    if command -v docker-compose &> /dev/null; then
        COMPOSE_CMD="docker-compose"
    elif docker compose version &> /dev/null; then
        COMPOSE_CMD="docker compose"
    else
        print_error "Docker Compose is not available. Please install Docker Compose."
        exit 1
    fi
    print_success "Docker Compose found: $COMPOSE_CMD"
}

# Function to create required directories
create_directories() {
    print_status "Creating required directories..."
    
    directories=(
        "mlflow/artifacts"
        "airflow-orchestrator/logs"
        "airflow-orchestrator/plugins"
        "data/raw"
        "data/processed"
        "data/models"
        "logs"
    )
    
    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
        echo "  Created: $dir"
    done
    
    print_success "All directories created"
}

# Function to set proper permissions
set_permissions() {
    print_status "Setting proper permissions..."
    
    # Set permissions for Airflow directories
    chmod -R 755 airflow-orchestrator/
    chmod +x airflow-orchestrator/entrypoint.sh
    
    # Set permissions for MLflow artifacts
    chmod -R 755 mlflow/
    
    print_success "Permissions set correctly"
}

# Function to validate environment files
validate_env_files() {
    print_status "Validating environment files..."
    
    if [ ! -f ".env" ]; then
        print_error ".env file is missing!"
        exit 1
    fi
    
    if [ ! -f ".env.prod" ]; then
        print_error ".env.prod file is missing!"
        exit 1
    fi
    
    # Check for required variables in .env.prod
    required_vars=(
        "DB_USER" "DB_PASSWORD" "DB_NAME"
        "AIRFLOW_DB_USER" "AIRFLOW_DB_PASSWORD" "AIRFLOW_DB_NAME"
        "MLFLOW_DB_USER" "MLFLOW_DB_PASSWORD" "MLFLOW_DB_NAME"
        "FERNET_KEY" "SECRET_KEY"
        "_AIRFLOW_WWW_USER_USERNAME" "_AIRFLOW_WWW_USER_PASSWORD"
    )
    
    for var in "${required_vars[@]}"; do
        if ! grep -q "^${var}=" .env.prod; then
            print_error "Missing required variable: $var in .env.prod"
            exit 1
        fi
    done
    
    print_success "Environment files are valid"
}

# Function to stop existing containers
cleanup_existing() {
    print_status "Cleaning up existing containers..."
    
    # Stop containers if they exist
    $COMPOSE_CMD -f docker-compose.yml down || true
    $COMPOSE_CMD -f docker-compose.prod.yml down || true
    
    # Remove orphaned containers
    docker container prune -f || true
    
    print_success "Cleanup completed"
}

# Function to build images
build_images() {
    print_status "Building Docker images..."
    
    echo -e "${YELLOW}This may take a few minutes...${NC}"
    $COMPOSE_CMD -f docker-compose.prod.yml build --no-cache
    
    print_success "All images built successfully"
}

# Function to start databases first
start_databases() {
    print_status "Starting database services..."
    
    $COMPOSE_CMD -f docker-compose.prod.yml up -d \
        noblestride-service-db \
        airflow-postgres \
        mlflow-postgres \
        redis
    
    # Wait for databases to be ready
    echo -e "${YELLOW}Waiting for databases to be ready...${NC}"
    sleep 30
    
    print_success "Database services are running"
}

# Function to start MLflow
start_mlflow() {
    print_status "Starting MLflow tracking server..."
    
    $COMPOSE_CMD -f docker-compose.prod.yml up -d mlflow
    
    # Wait for MLflow to be ready
    sleep 15
    
    print_success "MLflow tracking server is running"
}

# Function to start Airflow services
start_airflow() {
    print_status "Starting Airflow services..."
    
    # Start scheduler first
    $COMPOSE_CMD -f docker-compose.prod.yml up -d airflow-scheduler
    
    # Wait for scheduler to initialize
    echo -e "${YELLOW}Waiting for Airflow scheduler to initialize...${NC}"
    sleep 45
    
    # Start webserver
    $COMPOSE_CMD -f docker-compose.prod.yml up -d airflow-webserver
    
    # Start flower (optional)
    $COMPOSE_CMD -f docker-compose.prod.yml up -d flower
    
    print_success "Airflow services are running"
}

# Function to start API
start_api() {
    print_status "Starting FastAPI application..."
    
    $COMPOSE_CMD -f docker-compose.prod.yml up -d api
    
    print_success "FastAPI application is running"
}

# Function to verify services
verify_services() {
    print_status "Verifying services health..."
    
    # Wait a bit for services to fully start
    sleep 30
    
    # Check service ports
    services_to_check=(
        "FastAPI:8010"
        "Airflow Web:8090"
        "MLflow:5000"
        "Flower:5555"
    )
    
    for service_port in "${services_to_check[@]}"; do
        service=$(echo $service_port | cut -d: -f1)
        port=$(echo $service_port | cut -d: -f2)
        
        if curl -s http://localhost:$port > /dev/null 2>&1; then
            print_success "$service is accessible on port $port"
        else
            print_warning "$service on port $port is not yet accessible (may need more time)"
        fi
    done
}

# Function to show service URLs
show_service_urls() {
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════╗"
    echo -e "║              Service URLs                    ║"
    echo -e "╚══════════════════════════════════════════════╝${NC}"
    echo -e "${GREEN}FastAPI Application:${NC}     http://localhost:8010"
    echo -e "${GREEN}FastAPI Docs:${NC}            http://localhost:8010/docs"
    echo -e "${GREEN}Airflow Web UI:${NC}          http://localhost:8090"
    echo -e "${GREEN}MLflow Tracking:${NC}         http://localhost:5000"
    echo -e "${GREEN}Flower (Celery):${NC}         http://localhost:5555"
    echo ""
    echo -e "${BLUE}Database Connections:${NC}"
    echo -e "${YELLOW}Main DB:${NC}                 localhost:5432"
    echo -e "${YELLOW}Airflow DB:${NC}              localhost:5433"
    echo -e "${YELLOW}MLflow DB:${NC}               localhost:5434"
    echo -e "${YELLOW}Redis:${NC}                   localhost:6379"
    echo ""
    echo -e "${BLUE}Credentials:${NC}"
    echo -e "${YELLOW}Airflow:${NC}                 admin / admin_secure_password_2024"
}

# Function to show status
show_status() {
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════╗"
    echo -e "║              Container Status                ║"
    echo -e "╚══════════════════════════════════════════════╝${NC}"
    $COMPOSE_CMD -f docker-compose.prod.yml ps
}

# Main execution
main() {
    echo -e "${BLUE}Starting setup process...${NC}\n"
    
    check_docker
    check_docker_compose
    create_directories
    set_permissions
    validate_env_files
    cleanup_existing
    
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════╗"
    echo -e "║              Building & Starting             ║"
    echo -e "╚══════════════════════════════════════════════╝${NC}"
    
    build_images
    start_databases
    start_mlflow
    start_airflow
    start_api
    verify_services
    
    echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
    echo -e "║              Setup Complete!                 ║"
    echo -e "╚══════════════════════════════════════════════╝${NC}"
    
    show_service_urls
    show_status
    
    echo -e "\n${YELLOW}💡 Tips:${NC}"
    echo -e "  • Use 'docker-compose -f docker-compose.prod.yml logs -f' to view all logs"
    echo -e "  • Use 'docker-compose -f docker-compose.prod.yml logs -f <service>' for specific service logs"
    echo -e "  • Use 'docker-compose -f docker-compose.prod.yml down' to stop all services"
    echo -e "  • Check service health with 'docker-compose -f docker-compose.prod.yml ps'"
    echo ""
}

# Handle script arguments
case "${1:-setup}" in
    setup)
        main
        ;;
    stop)
        print_status "Stopping all services..."
        $COMPOSE_CMD -f docker-compose.prod.yml down
        print_success "All services stopped"
        ;;
    restart)
        print_status "Restarting all services..."
        $COMPOSE_CMD -f docker-compose.prod.yml restart
        print_success "All services restarted"
        ;;
    status)
        show_status
        ;;
    logs)
        $COMPOSE_CMD -f docker-compose.prod.yml logs -f
        ;;
    *)
        echo "Usage: $0 [setup|stop|restart|status|logs]"
        echo "  setup   - Full setup and start (default)"
        echo "  stop    - Stop all services"
        echo "  restart - Restart all services"
        echo "  status  - Show service status"
        echo "  logs    - Show logs for all services"
        ;;
esac
