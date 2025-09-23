#!/bin/bash

# Build Services Script
# =====================

set -e

echo "🔨 Building NobleStride ML Pipeline Services..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
COMPOSE_FILE=${1:-docker-compose.prod.yml}

echo -e "${YELLOW}Using compose file: $COMPOSE_FILE${NC}"

# Create network if it doesn't exist
if ! docker network ls | grep -q noblestride-network; then
    echo -e "${YELLOW}📡 Creating Docker network...${NC}"
    docker network create noblestride-network
fi

# Build only the API service first (lightest)
echo -e "${YELLOW}🏗️ Building API service...${NC}"
docker-compose -f "$COMPOSE_FILE" build api

# Build Airflow services
echo -e "${YELLOW}🏗️ Building Airflow services...${NC}"
docker-compose -f "$COMPOSE_FILE" build airflow-webserver airflow-scheduler airflow-worker airflow-triggerer airflow-init

echo -e "${GREEN}✅ Build completed successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Run: ./scripts/init_services.sh"
echo "2. Test: ./scripts/test_endpoints.sh"