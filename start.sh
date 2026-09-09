echo "===== ENABLE HELPER TEST ====="
python enable_helper.py

echo "===== CHECK SETTINGS ====="
python - <<'PY'
from control_store import get_helper_config
print(get_helper_config("/app/data/users.db"))
PY

echo "===== START HELPER ====="
python helper_bot.py > helper.log 2>&1 &
