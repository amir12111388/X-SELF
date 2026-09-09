#!/bin/bash

set -e

echo "===== ENABLE HELPER ====="
python enable_helper.py

echo "===== CHECK SETTINGS ====="
python - <<'PY'
from control_store import get_helper_config

config = get_helper_config("/app/data/users.db")

print({
    "enabled": config.get("enabled"),
    "username": config.get("username"),
    "token_exists": bool(config.get("token")),
    "pid": config.get("pid"),
})
PY

echo "===== STARTING HELPER ====="

rm -f /app/data/helper.status.json

python helper_bot.py \
  --data-dir "/app/data" \
  --status-file "/app/data/helper.status.json" \
  > helper.log 2>&1 &

HELPER_PID=$!

echo "Helper PID: $HELPER_PID"

echo "===== WAITING FOR HELPER ====="

for i in $(seq 1 30); do
    if [ -f /app/data/helper.status.json ]; then
        cat /app/data/helper.status.json
        echo

        if grep -q '"status": "ready"' /app/data/helper.status.json; then
            echo "✅ Helper is READY"
            break
        fi

        if grep -q '"status": "failed"' /app/data/helper.status.json; then
            echo "❌ Helper FAILED"
            cat helper.log
            exit 1
        fi
    fi

    if ! kill -0 "$HELPER_PID" 2>/dev/null; then
        echo "❌ Helper process stopped"
        cat helper.log || true
        exit 1
    fi

    sleep 1
done

if [ ! -f /app/data/helper.status.json ] || ! grep -q '"status": "ready"' /app/data/helper.status.json; then
    echo "❌ Helper did not become ready"
    echo "===== HELPER LOG ====="
    cat helper.log || true
    exit 1
fi

echo "===== STARTING MAIN BOT ====="

exec python main_bot.py
