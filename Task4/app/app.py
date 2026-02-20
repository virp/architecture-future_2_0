from fastapi import FastAPI
from pydantic import BaseModel
import os

APP_PORT = int(os.environ.get("APP_PORT", "8080"))
PROJECT_NAME = os.environ.get("PROJECT_NAME", "docker-app")
ENVIRONMENT = os.environ.get("ENVIRONMENT", "dev")
DB_HOST = os.environ.get("DB_HOST", "db")
DB_PORT = int(os.environ.get("DB_PORT", "5432"))
DB_NAME = os.environ.get("DB_NAME", "appdb")
DB_USER = os.environ.get("DB_USER", "app_user")


class HealthResponse(BaseModel):
    status: str


class DatabaseInfo(BaseModel):
    host: str
    port: int
    name: str
    user: str


class InfoResponse(BaseModel):
    project: str
    environment: str
    database: DatabaseInfo


app = FastAPI(title="Future2.0 App", version="1.0.0")


@app.get("/health", response_model=HealthResponse)
def health():
    return HealthResponse(status="ok")


@app.get("/info", response_model=InfoResponse)
def info():
    return InfoResponse(
        project=PROJECT_NAME,
        environment=ENVIRONMENT,
        database=DatabaseInfo(
            host=DB_HOST,
            port=DB_PORT,
            name=DB_NAME,
            user=DB_USER,
        ),
    )