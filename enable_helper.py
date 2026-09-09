import os
from control_store import ensure_app_settings, set_app_settings

DB = "/app/data/users.db"

token = os.getenv("HELPER_BOT_TOKEN", "").strip()
username = os.getenv("HELPER_BOT_USERNAME", "").strip().lstrip("@")

print("Token exists:", bool(token))
print("Username:", username)

ensure_app_settings(DB)

set_app_settings(
    DB,
    {
        "helper_enabled": "1",
        "helper_token": token,
        "helper_username": username,
    }
)

print("✅ Helper settings saved")
