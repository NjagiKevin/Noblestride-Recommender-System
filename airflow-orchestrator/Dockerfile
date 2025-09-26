FROM apache/airflow:2.7.3-python3.11

# Copy entrypoint and requirements
COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt
COPY requirements.prod.txt /requirements.prod.txt

# Use root only for file permissions
USER root
RUN chmod +x /entrypoint.sh

# Switch back to airflow user
USER airflow

# Upgrade pip and install dependencies with higher timeout & retries
RUN pip install --upgrade pip setuptools wheel \
 && pip install --no-cache-dir \
    --default-timeout=200 --retries=20 \
    -i https://pypi.org/simple \
    --trusted-host pypi.org \
    --trusted-host pypi.python.org \
    --trusted-host files.pythonhosted.org \
    -r /requirements.prod.txt -r /requirements.txt
