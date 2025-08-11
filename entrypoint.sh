#!/usr/bin/env bash
set -euo pipefail

echo "Waiting for DB..."
python - <<'PY'
import os, time
from sqlalchemy import create_engine
uri = os.environ.get("SQLALCHEMY_DATABASE_URI")
if uri:
    engine = create_engine(uri)
    for _ in range(60):
        try:
            conn = engine.connect()
            conn.close()
            break
        except:
            time.sleep(2)
PY

export FLASK_APP=superset
superset db upgrade
superset fab create-admin \
    --username "${SUPERSET_ADMIN_USERNAME:-admin}" \
    --firstname "${SUPERSET_ADMIN_FIRSTNAME:-Admin}" \
    --lastname "${SUPERSET_ADMIN_LASTNAME:-User}" \
    --email "${SUPERSET_ADMIN_EMAIL:-admin@example.com}" \
    --password "${SUPERSET_ADMIN_PASSWORD:-admin}" || true
superset init
exec gunicorn -w "${SUPERSET_WORKERS:-2}" -k gevent --timeout 120 -b 0.0.0.0:${PORT:-8088} "superset.app:create_app()"
