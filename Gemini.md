
# Gemini Project Analysis: recommendation-service

## Overview

This project is a recommendation service that provides recommendations for businesses to investors and vice versa. It is built as a microservice using FastAPI and uses Apache Airflow for model training. The entire application is containerized using Docker.

## Architecture

The project consists of the following components:

*   **FastAPI Application**: A Python web service that exposes a RESTful API for recommendations.
*   **PostgreSQL Database**: The primary data store for the application.
*   **Apache Airflow**: A workflow management system used to orchestrate the machine learning model training pipeline.
*   **Docker**: The entire application is containerized using Docker, making it easy to set up and run in different environments.

The application is structured as follows:

*   `app/`: Contains the FastAPI application code.
    *   `app/main.py`: The entry point for the FastAPI application.
    *   `app/api/`: Contains the API router and endpoint definitions.
    *   `app/core/`: Core application settings and configuration.
    *   `app/db/`: Database session management and initialization.
    *   `app/models/`: Pydantic schemas and SQLAlchemy database models.
    *   `app/services/`: Business logic for recommendations and other services.
*   `dags/`: Contains the Airflow DAG definitions.
    *   `dags/recommender_training.py`: The DAG for training the recommendation model.
*   `docker-compose.yml`: Defines the services, networks, and volumes for the Dockerized application.
*   `dockerfile`: The Dockerfile for building the application image.
*   `requirements.txt`: A list of Python dependencies for the project.

## Getting Started

To run this project, you will need to have Docker and Docker Compose installed.

1.  **Create a `.env` file**:
    Based on the `docker-compose.yml` file, you will need to create a `.env` file in the project root with the following variables:
    ```
    DB_USER=your_postgres_user
    DB_PASSWORD=your_postgres_password
    DB_NAME=your_postgres_db
    ```

2.  **Build and run the containers**:
    ```bash
    docker-compose up --build
    ```
    This will start the FastAPI application, the PostgreSQL database, and an Airflow instance.

3.  **Access the application**:
    *   **API**: The FastAPI application will be available at `http://localhost:8000`.
    *   **API Docs**: The OpenAPI documentation can be accessed at `http://localhost:8000/docs`.
    *   **Airflow UI**: The Airflow UI will be available at `http://localhost:8080`.

## Key Components

### FastAPI Application

The FastAPI application provides the following API endpoints:

*   `/health`: A health check endpoint.
*   `/businesses`: Endpoints for managing businesses.
*   `/investors`: Endpoints for managing investors.
*   `/ranking`: Endpoints for retrieving recommendations.
*   `/feedback`: Endpoints for submitting feedback on recommendations.

### Airflow DAG

The `recommender_training` DAG is responsible for training the recommendation model. It is scheduled to run daily and performs the following steps:

1.  **Extract Data**: Extracts user data from the PostgreSQL database.
2.  **Preprocess Data**: Preprocesses the extracted data.
3.  **Train Model**: Trains a recommendation model and saves it as a pickle file.

The DAG uses a Postgres connection with the `conn_id` "my_postgres". You will need to configure this connection in the Airflow UI.
