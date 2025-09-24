FROM apache/airflow:2.7.3-python3.11

# Copy entrypoint and requirements
COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt
COPY requirements.prod.txt /requirements.prod.txt

# Use root only for file permissions, then install Python packages as 'airflow' user
USER root
RUN chmod +x /entrypoint.sh

USER airflow
RUN pip install --no-cache-dir -r /requirements.prod.txt -r /requirements.txt
