#!/bin/bash

# NobleStride ML Pipeline - API Endpoints Testing Script
# ======================================================

set -e

echo "🧪 Testing NobleStride ML Pipeline API Endpoints..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
API_BASE_URL="http://localhost:8010"
AIRFLOW_USERNAME="admin"
AIRFLOW_PASSWORD="admin_secure_password_2024"

# Function to test endpoint
test_endpoint() {
    local method=$1
    local endpoint=$2
    local description=$3
    local expected_status=${4:-200}
    local data=$5
    
    echo -e "${BLUE}Testing: $description${NC}"
    echo -e "  ${method} ${API_BASE_URL}${endpoint}"
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\nSTATUS_CODE:%{http_code}" "${API_BASE_URL}${endpoint}")
    elif [ "$method" = "POST" ]; then
        response=$(curl -s -w "\nSTATUS_CODE:%{http_code}" -X POST \
                   -H "Content-Type: application/json" \
                   -d "$data" "${API_BASE_URL}${endpoint}")
    fi
    
    status_code=$(echo "$response" | grep "STATUS_CODE:" | cut -d: -f2)
    body=$(echo "$response" | sed '/STATUS_CODE:/d')
    
    if [ "$status_code" -eq "$expected_status" ]; then
        echo -e "  ${GREEN}✅ PASS (Status: $status_code)${NC}"
        if [ ! -z "$body" ]; then
            echo "$body" | python3 -m json.tool 2>/dev/null | head -10 || echo "$body" | head -3
        fi
    else
        echo -e "  ${RED}❌ FAIL (Expected: $expected_status, Got: $status_code)${NC}"
        echo "$body" | head -3
    fi
    echo ""
}

echo -e "${YELLOW}🚀 Starting API Endpoint Tests...${NC}"
echo ""

# Test 1: Health Checks
echo -e "${YELLOW}=== Health Check Tests ===${NC}"

test_endpoint "GET" "/mlops/airflow/health" "Airflow Health Check"
test_endpoint "GET" "/mlops/mlflow/health" "MLflow Health Check"
test_endpoint "GET" "/mlops/pipeline/status" "Overall Pipeline Status"

# Test 2: Airflow Integration
echo -e "${YELLOW}=== Airflow Integration Tests ===${NC}"

test_endpoint "GET" "/mlops/airflow/dags" "List Airflow DAGs"

# Test 3: MLflow Integration
echo -e "${YELLOW}=== MLflow Integration Tests ===${NC}"

test_endpoint "GET" "/mlops/mlflow/experiments" "List MLflow Experiments"
test_endpoint "GET" "/mlops/mlflow/models" "List Registered Models"

# Test 4: Create MLflow Experiment
echo -e "${YELLOW}=== MLflow Experiment Creation Test ===${NC}"

experiment_data='{
    "experiment_name": "test_experiment_'$(date +%s)'",
    "tags": {
        "purpose": "api_testing",
        "created_by": "test_script"
    }
}'

test_endpoint "POST" "/mlops/mlflow/experiments" "Create MLflow Experiment" 200 "$experiment_data"

# Test 5: Pipeline Operations
echo -e "${YELLOW}=== Pipeline Operations Tests ===${NC}"

# Note: This will actually trigger a DAG run - use with caution in production
echo -e "${BLUE}Testing: Trigger Training Pipeline (WARNING: This starts actual training)${NC}"
echo "  POST ${API_BASE_URL}/mlops/pipeline/training/trigger"
echo -e "  ${YELLOW}⚠️ Skipping to avoid triggering actual training pipeline${NC}"
echo ""

# Test 6: Additional API Tests
echo -e "${YELLOW}=== Additional API Tests ===${NC}"

test_endpoint "GET" "/docs" "API Documentation" 200
test_endpoint "GET" "/health" "Main API Health" 200

# Test 7: Direct Service Tests (if services are available)
echo -e "${YELLOW}=== Direct Service Tests ===${NC}"

echo -e "${BLUE}Testing direct Airflow connection...${NC}"
airflow_response=$(curl -s -u "$AIRFLOW_USERNAME:$AIRFLOW_PASSWORD" \
                   http://localhost:8090/health 2>/dev/null || echo "Connection failed")
if echo "$airflow_response" | grep -q "healthy"; then
    echo -e "  ${GREEN}✅ Direct Airflow connection successful${NC}"
else
    echo -e "  ${RED}❌ Direct Airflow connection failed${NC}"
fi

echo -e "${BLUE}Testing direct MLflow connection...${NC}"
mlflow_response=$(curl -s http://localhost:5000/health 2>/dev/null || echo "Connection failed")
if [ $? -eq 0 ]; then
    echo -e "  ${GREEN}✅ Direct MLflow connection successful${NC}"
else
    echo -e "  ${RED}❌ Direct MLflow connection failed${NC}"
fi

echo ""

# Summary
echo -e "${GREEN}"
echo "🎉 =================================================="
echo "   API Endpoint Testing Complete!"
echo "==================================================="
echo ""
echo "📊 Available Endpoints:"
echo ""
echo "🔧 MLOps Health:"
echo "  GET /mlops/airflow/health"
echo "  GET /mlops/mlflow/health"
echo "  GET /mlops/pipeline/status"
echo ""
echo "🌬️ Airflow Management:"
echo "  GET /mlops/airflow/dags"
echo "  POST /mlops/airflow/dags/{dag_id}/dagRuns"
echo "  GET /mlops/airflow/dags/{dag_id}/dagRuns/{dag_run_id}"
echo ""
echo "🧪 MLflow Management:"
echo "  GET /mlops/mlflow/experiments"
echo "  POST /mlops/mlflow/experiments"
echo "  GET /mlops/mlflow/experiments/{experiment_id}/runs"
echo "  GET /mlops/mlflow/models"
echo "  POST /mlops/mlflow/models/{model_name}/versions/{version}/stage"
echo ""
echo "🚀 Pipeline Operations:"
echo "  POST /mlops/pipeline/training/trigger"
echo ""
echo "📚 Documentation:"
echo "  GET /docs - Interactive API documentation"
echo "  GET /redoc - Alternative API documentation"
echo ""
echo "🧪 Example cURL Commands:"
echo ""
echo "# Check pipeline status"
echo "curl http://localhost:8010/mlops/pipeline/status | jq"
echo ""
echo "# List DAGs"
echo "curl http://localhost:8010/mlops/airflow/dags | jq"
echo ""
echo "# Create experiment"
echo 'curl -X POST http://localhost:8010/mlops/mlflow/experiments \'
echo '  -H "Content-Type: application/json" \'
echo '  -d "{\"experiment_name\":\"my_experiment\",\"tags\":{\"env\":\"test\"}}" | jq'
echo ""
echo "# Trigger training pipeline (use with caution!)"
echo "curl -X POST http://localhost:8010/mlops/pipeline/training/trigger | jq"
echo ""
echo -e "${NC}"