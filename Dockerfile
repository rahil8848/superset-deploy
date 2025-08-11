FROM apache/superset:latest
USER root
RUN pip install --no-cache-dir psycopg2-binary
COPY superset_config.py /app/superset_config.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENV SUPERSET_CONFIG_PATH=/app/superset_config.py
EXPOSE 8088
CMD ["/entrypoint.sh"]
