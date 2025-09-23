#!/bin/bash
set -e

# Function to wait for service
wait_for_service() {
    local host=$1
    local port=$2
    local service_name=$3
    
    echo "⏳ Waiting for $service_name at $host:$port..."
    
    while ! nc -z "$host" "$port"; do
        echo "⏳ $service_name is unavailable - sleeping"
        sleep 2
    done
    
    echo "✅ $service_name is available"
}

# Wait for dependencies
if [ -n "$POSTGRES_HOST" ]; then
    wait_for_service "${POSTGRES_HOST:-airflow-postgres}" "${POSTGRES_PORT:-5432}" "PostgreSQL"
fi

if [ -n "$REDIS_HOST" ]; then
    wait_for_service "${REDIS_HOST:-redis}" "${REDIS_PORT:-6379}" "Redis"
fi

# Generate Fernet key if not provided
if [ -z "$AIRFLOW__CORE__FERNET_KEY" ]; then
    export AIRFLOW__CORE__FERNET_KEY=$(python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())")
    echo "🔐 Generated Fernet key"
fi

# Initialize database (only for init container)
if [ "$1" = "airflow" ] && [ "$2" = "db" ] && [ "$3" = "init" ]; then
    echo "🚀 Initializing Airflow database..."
    airflow db init
    
    # Create admin user
    echo "👤 Creating admin user..."
    airflow users create \
        --username "${_AIRFLOW_WWW_USER_USERNAME:-admin}" \
        --firstname "Admin" \
        --lastname "User" \
        --role "Admin" \
        --email "admin@noblestride.com" \
        --password "${_AIRFLOW_WWW_USER_PASSWORD:-admin}"
fi

# Execute the command
echo "🚀 Starting Airflow component: $*"
exec airflow "$@"