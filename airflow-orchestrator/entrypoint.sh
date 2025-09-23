#!/usr/bin/env bash

# Wait for the database to be ready (optional, but good practice)
sleep 10

# Initialize the Airflow database
airflow db init

# Create Admin role
airflow roles create Admin

# Create Admin user
airflow users create -u admin -f admin -l user -r Admin -e admin@example.com -p admin

# Execute the original command (e.g., airflow webserver)
exec "$@"