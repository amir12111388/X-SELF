#!/bin/bash

echo "Starting Helper Bot..."

python helper_bot.py \
  --data-dir "$(pwd)/data" \
  --status-file "$(pwd)/data/helper.status.json" \
  > helper.log 2>&1 &

HELPER_PID=$!

echo "Helper PID: $HELPER_PID"

sleep 10

echo "========== HELPER LOG =========="
cat helper.log || true
echo "================================"

echo "Starting Main Bot..."

python main_bot.py
