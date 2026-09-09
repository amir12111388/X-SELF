import os
from pathlib import Path

from control_store import ensure_app_settings, set_app_settings

db = Path("data/users.db")
db.parent.mkdir(exist_ok=True)

ensure_app_settings(db)

set_app_settings(
    db,
    {
        "helper_enabled": "1",
        "helper_token": os.environ["HELPER_BOT_TOKEN"],
        "helper_username": os.environ["HELPER_BOT_USERNAME"],
    },
)

print("Helper enabled successfully")
