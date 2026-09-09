#!/bin/bash

echo "Enabling Helper..."

python enable_helper.py

echo "Starting Helper Bot..."

python helper_bot.py > helper.log 2>&1 &

sleep 10

echo "========== HELPER LOG =========="
cat helper.log || true
echo "================================"

echo "Starting Main Bot..."

python main_bot.py
