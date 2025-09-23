#!/bin/bash

# NobleStride Recommendation Service - Service Initialization Script
# =================================================================

set -e

echo "🚀 Starting NobleStride ML Pipeline Services Initialization..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
COMPOSE_FILE=${1:-docker-compose.prod.yml}
ENV_FILE=${2:-.env.prod}

echo -e "${YELLOW}Using compose file: $COMPOSE_FILE${NC}"
echo -e "${YELLOW}Using environment file: $ENV_FILE${NC}"

# Function to wait for service
wait_for_service() {
    local service_name=$1
    local port=$2
    local max_attempts=30
    local attempt=1
    
    echo -e "${YELLOW}⏳ Waiting for $service_name to be ready on port $port...${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        if curl -s http://localhost:$port/health >/dev/null 2>&1 || \
           nc -z localhost $port >/dev/null 2>&1; then
            echo -e "${GREEN}✅ $service_name is ready!${NC}"
            return 0
        fi
        
        echo "⏳ Attempt $attempt/$max_attempts: $service_name not ready yet..."
        sleep 10
        attempt=$((attempt + 1))
    done
    
    echo -e "${RED}❌ $service_name failed to start within expected time${NC}"
    return 1
}

# Function to check if network exists
check_network() {
    if ! docker network ls | grep -q noblestride-network; then
        echo -e "${YELLOW}📡 Creating Docker network...${NC}"
        docker network create noblestride-network
        echo -e "${GREEN}✅ Network created successfully${NC}"
    else
        echo -e "${GREEN}✅ Docker network already exists${NC}"
    fi
}

# Function to generate Fernet key
generate_fernet_key() {
    echo -e "${YELLOW}🔐 Generating Fernet key for Airflow...${NC}"
    python3 -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
}

# Step 1: Check prerequisites
echo -e "${YELLOW}📋 Checking prerequisites...${NC}"

if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ docker-compose not found${NC}"
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo -e "${RED}❌ curl not found${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Prerequisites check passed${NC}"

# Step 2: Setup environment
echo -e "${YELLOW}🔧 Setting up environment...${NC}"

if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}❌ Environment file $ENV_FILE not found${NC}"
    exit 1
fi

# Generate Fernet key if not exists
if ! grep -q "FERNET_KEY=" "$ENV_FILE" || grep -q "your_32_character_fernet_key_here" "$ENV_FILE"; then
    FERNET_KEY=$(generate_fernet_key)
    sed -i.bak "s/your_32_character_fernet_key_here/$FERNET_KEY/g" "$ENV_FILE"
    echo -e "${GREEN}✅ Fernet key generated and added to environment${NC}"
fi

# Step 3: Check Docker network
check_network

# Step 4: Build and start services
echo -e "${YELLOW}🏗️ Building and starting services...${NC}"

# Stop any existing services
docker-compose -f "$COMPOSE_FILE" down --remove-orphans

# Start databases first
echo -e "${YELLOW}🗄️ Starting databases...${NC}"
docker-compose -f "$COMPOSE_FILE" up -d airflow-postgres mlflow-postgres redis

# Wait for databases
echo -e "${YELLOW}⏳ Waiting for databases to be ready...${NC}"
sleep 15

# Initialize Airflow database
echo -e "${YELLOW}🔧 Initializing Airflow database...${NC}"
docker-compose -f "$COMPOSE_FILE" run --rm airflow-init

# Start all services
echo -e "${YELLOW}🚀 Starting all services...${NC}"
docker-compose -f "$COMPOSE_FILE" up -d

# Step 5: Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to be ready...${NC}"

wait_for_service "Airflow" 8090 &
wait_for_service "MLflow" 5000 &
wait_for_service "API" 8010 &

wait # Wait for all background processes

# Step 6: Create sample data directories
echo -e "${YELLOW}📁 Creating data directories...${NC}"
mkdir -p data/raw data/processed data/models
echo "user_id,product_id,rating,timestamp" > data/user_interactions.csv
echo "product_id,name,category,price" > data/product_data.csv
echo "user_id,age,gender,preferences" > data/user_profiles.csv
echo -e "${GREEN}✅ Sample data files created${NC}"

# Step 7: Validation
echo -e "${YELLOW}🔍 Validating service health...${NC}"

# Check Airflow
if curl -s -u admin:admin_secure_password_2024 http://localhost:8090/health >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Airflow is healthy${NC}"
else
    echo -e "${YELLOW}⚠️ Airflow health check inconclusive${NC}"
fi

# Check MLflow
if curl -s http://localhost:5000/health >/dev/null 2>&1; then
    echo -e "${GREEN}✅ MLflow is healthy${NC}"
else
    echo -e "${YELLOW}⚠️ MLflow health check inconclusive${NC}"
fi

# Check API
if curl -s http://localhost:8010/health >/dev/null 2>&1; then
    echo -e "${GREEN}✅ API is healthy${NC}"
else
    echo -e "${YELLOW}⚠️ API health check inconclusive${NC}"
fi

# Step 8: Display summary
echo -e "${GREEN}"
echo "🎉 =================================================="
echo "   NobleStride ML Pipeline Services Started!"
echo "==================================================="
echo ""
echo "📊 Services Status:"
echo "  • Airflow Web UI: http://localhost:8090"
echo "    Username: admin"
echo "    Password: admin_secure_password_2024"
echo ""
echo "  • MLflow UI: http://localhost:5000"
echo ""
echo "  • API Endpoints: http://localhost:8010"
echo "    Docs: http://localhost:8010/docs"
echo "    MLOps: http://localhost:8010/mlops/"
echo ""
echo "  • Flower (Celery): http://localhost:5555"
echo "    (Start with: docker-compose --profile flower up -d)"
echo ""
echo "🗄️ Database Ports:"
echo "  • Main App DB: localhost:5432 (existing)"
echo "  • Airflow DB: localhost:5433"
echo "  • MLflow DB: localhost:5434"
echo "  • Redis: localhost:6379"
echo ""
echo "🧪 Test Commands:"
echo "  curl http://localhost:8010/mlops/pipeline/status"
echo "  curl http://localhost:8010/mlops/airflow/health"
echo "  curl http://localhost:8010/mlops/mlflow/health"
echo ""
echo "Happy Noble striding! 🚀"
echo -e "${NC}"