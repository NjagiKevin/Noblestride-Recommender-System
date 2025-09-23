#!/usr/bin/env bash

# Delete default connections that might be overriding our settings
airflow connections delete --conn-id postgres_default || true
airflow connections delete --conn-id airflow_db || true

# Upgrade the Airflow database
airflow db upgrade

# Create Admin role
airflow roles create Admin

# Create Admin user
airflow users create -u admin -f admin -l user -r Admin -e admin@example.com -p admin

# Execute the original command (e.g., airflow webserver)
exec "$@"