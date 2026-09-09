from control_store import ensure_app_settings, set_app_settings

DB = "/app/data/users.db"

print("Using DB:", DB)

ensure_app_settings(DB)

set_app_settings(
    DB,
    {
        "helper_enabled": "1",
    }
)

print("✅ Helper enabled successfully")
