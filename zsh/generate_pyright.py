import json
import sys
import os
import subprocess


def detect_python():
    return subprocess.check_output(["which", "python"]).decode().strip()


def detect_conda_env():
    python = detect_python()
    env_path = os.path.dirname(os.path.dirname(python))
    env_name = env_path.split("/")[-1]
    return env_path, env_name, python


env_path, env_name, python_path = detect_conda_env()

config = {
    "pythonVersion": "3.13",
    "pythonPath": python_path,
    "venvPath": os.path.dirname(env_path),
    "venv": env_name,
    "reportMissingImports": True,
    "reportMissingTypeStubs": False,
}

with open("./pyrightconfig.json", "w") as f:
    json.dump(config, f, indent=2)

print("Generated pyrightconfig.json")
