#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Airflow Entrypoint Script${NC}"

# Function to wait for database
wait_for_db() {
    echo -e "${YELLOW}⏳ Waiting for database to be ready...${NC}"
    while ! nc -z ${AIRFLOW_DB_HOST} ${AIRFLOW_DB_PORT}; do
        echo -e "${YELLOW}⏳ Database not ready yet. Waiting 5 seconds...${NC}"
        sleep 5
    done
    echo -e "${GREEN}✅ Database is ready!${NC}"
}

# Function to initialize Airflow database
init_airflow_db() {
    echo -e "${BLUE}🔄 Initializing Airflow database...${NC}"
    airflow db init
    echo -e "${GREEN}✅ Airflow database initialized!${NC}"
}

# Function to create admin user
create_admin_user() {
    echo -e "${BLUE}👤 Creating Airflow admin user...${NC}"
    airflow users create \
        --username "${_AIRFLOW_WWW_USER_USERNAME}" \
        --firstname "Admin" \
        --lastname "User" \
        --role "Admin" \
        --email "admin@noblestride.com" \
        --password "${_AIRFLOW_WWW_USER_PASSWORD}" || true
    echo -e "${GREEN}✅ Admin user created/updated!${NC}"
}

# Function to upgrade database
upgrade_db() {
    echo -e "${BLUE}⬆️ Upgrading Airflow database...${NC}"
    airflow db upgrade
    echo -e "${GREEN}✅ Database upgrade completed!${NC}"
}

# Set environment variables with defaults
export AIRFLOW_HOME=${AIRFLOW_HOME:-/opt/airflow}
export AIRFLOW__CORE__LOAD_EXAMPLES=${AIRFLOW__CORE__LOAD_EXAMPLES:-False}
export AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION=${AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION:-True}
export AIRFLOW__WEBSERVER__EXPOSE_CONFIG=${AIRFLOW__WEBSERVER__EXPOSE_CONFIG:-True}

# Set database connection if not already set
if [ -z "$AIRFLOW__DATABASE__SQL_ALCHEMY_CONN" ]; then
    export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql://${AIRFLOW_DB_USER}:${AIRFLOW_DB_PASSWORD}@${AIRFLOW_DB_HOST}:${AIRFLOW_DB_PORT}/${AIRFLOW_DB_NAME}"
fi

echo -e "${BLUE}📝 Airflow Configuration:${NC}"
echo -e "  Home: ${AIRFLOW_HOME}"
echo -e "  Database: ${AIRFLOW__DATABASE__SQL_ALCHEMY_CONN}"
echo -e "  Executor: ${AIRFLOW__CORE__EXECUTOR}"

# Wait for database to be ready
wait_for_db

# Initialize or upgrade database based on the command
case "$1" in
    webserver)
        echo -e "${BLUE}🌐 Starting Airflow Webserver${NC}"
        upgrade_db
        create_admin_user
        exec airflow webserver
        ;;
    scheduler)
        echo -e "${BLUE}⏰ Starting Airflow Scheduler${NC}"
        # Only init DB from scheduler to avoid conflicts
        if [ ! -f "/opt/airflow/db_initialized.flag" ]; then
            init_airflow_db
            create_admin_user
            touch /opt/airflow/db_initialized.flag
        else
            upgrade_db
        fi
        exec airflow scheduler
        ;;
    worker)
        echo -e "${BLUE}👷 Starting Airflow Worker${NC}"
        upgrade_db
        exec airflow celery worker
        ;;
    flower)
        echo -e "${BLUE}🌸 Starting Flower${NC}"
        exec airflow celery flower
        ;;
    *)
        echo -e "${GREEN}🔧 Executing custom command: $@${NC}"
        exec "$@"
        ;;
esac
