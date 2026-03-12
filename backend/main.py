# backend/main.py
import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from dotenv import load_dotenv

from db import Base, engine

# IMPORTANT: import ALL models BEFORE create_all()
from models import (  # noqa: F401
    Module,
    Node,
    Option,
    Result,
    Session,
    AnswerLog,
    User,
    TechnicianProfile,
    Ticket,
)

# Routers
from routes_auth import router as auth_router
from routes_tickets import router as tickets_router
from routes_admin import router as admin_router
from routes_assign import router as assign_router
from routes_tech import router as tech_router
from routes_modules import router as modules_router
from routes_sessions import router as sessions_router
from routes_password_reset import router as reset_router
from routes_billing import router as billing_router
from routes_attachments import router as attachments_router

load_dotenv()

app = FastAPI(title="Troubleshoot AI API")

os.makedirs("uploads", exist_ok=True)
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")

Base.metadata.create_all(bind=engine)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
        "http://localhost:5174",
        "http://127.0.0.1:5174",
    ],
    allow_origin_regex=r"^http://(localhost|127\.0\.0\.1|192\.168\.\d+\.\d+|10\.\d+\.\d+\.\d+)(:\d+)?$",
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
app.include_router(auth_router, prefix="/auth", tags=["auth"])
app.include_router(tickets_router, prefix="/tickets", tags=["tickets"])
app.include_router(admin_router, prefix="/admin", tags=["admin"])
app.include_router(assign_router, tags=["assign"])
app.include_router(tech_router, prefix="/tech", tags=["tech"])
app.include_router(modules_router, tags=["modules"])
app.include_router(reset_router, tags=["password_reset"])
app.include_router(attachments_router, tags=["attachments"])
app.include_router(billing_router)
app.include_router(sessions_router, tags=["sessions"])  # routes_sessions already has prefix="/sessions"

@app.get("/health")
def health():
    return {"ok": True, "data": {"status": "up"}, "error": None}
