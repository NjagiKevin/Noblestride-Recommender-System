#!/bin/bash

# NobleStride Recommender System - Development Setup
# ==================================================

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${PURPLE}╔══════════════════════════════════════════════╗"
echo -e "║    NobleStride Recommender - Dev Setup      ║"
echo -e "╚══════════════════════════════════════════════╝${NC}"
echo ""

# Check if docker-compose is available
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
elif docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
else
    echo "❌ Docker Compose is not available."
    exit 1
fi

case "${1:-dev}" in
    dev)
        echo -e "${BLUE}Starting development environment...${NC}"
        
        # Create necessary directories
        mkdir -p data/{raw,processed,models} logs
        
        # Start with development compose file
        $COMPOSE_CMD up -d
        
        echo -e "\n${GREEN}Development environment started!${NC}"
        echo -e "${YELLOW}Services:${NC}"
        echo -e "  • API: http://localhost:8010"
        echo -e "  • API Docs: http://localhost:8010/docs"
        echo -e "  • Airflow: http://localhost:8090"
        echo ""
        ;;
    
    prod)
        echo -e "${BLUE}Starting production environment...${NC}"
        
        # Use full production setup
        ./setup_recommender_system.sh setup
        ;;
    
    stop)
        echo -e "${BLUE}Stopping all services...${NC}"
        $COMPOSE_CMD down
        $COMPOSE_CMD -f docker-compose.prod.yml down || true
        echo -e "${GREEN}All services stopped${NC}"
        ;;
    
    clean)
        echo -e "${BLUE}Cleaning up all containers and volumes...${NC}"
        $COMPOSE_CMD down -v
        $COMPOSE_CMD -f docker-compose.prod.yml down -v || true
        docker system prune -f
        echo -e "${GREEN}Cleanup complete${NC}"
        ;;
    
    logs)
        echo -e "${BLUE}Showing logs...${NC}"
        $COMPOSE_CMD logs -f
        ;;
    
    status)
        echo -e "${BLUE}Service Status:${NC}"
        $COMPOSE_CMD ps
        ;;
    
    test-dag)
        echo -e "${BLUE}Testing DAG syntax...${NC}"
        python -m py_compile airflow-orchestrator/dags/*.py
        echo -e "${GREEN}All DAGs have valid syntax${NC}"
        ;;
    
    *)
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  dev       - Start development environment (default)"
        echo "  prod      - Start full production environment"
        echo "  stop      - Stop all services"
        echo "  clean     - Clean up containers and volumes"
        echo "  logs      - Show service logs"
        echo "  status    - Show service status"
        echo "  test-dag  - Test DAG syntax"
        echo ""
        ;;
esac
