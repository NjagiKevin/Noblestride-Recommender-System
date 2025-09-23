FROM apache/airflow:2.7.3-python3.11
COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER airflow
