# backend/routes_auth.py

from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from db import get_db
from models import User
from auth import hash_password, verify_password, create_access_token
from deps import get_current_user

router = APIRouter()


def ok(data):
    return {"ok": True, "data": data, "error": None}


def fail(code: str, message: str, http_status: int = 400):
    raise HTTPException(
        status_code=http_status,
        detail=message,
    )


@router.post("/register")
def register(payload: dict, db: Session = Depends(get_db)):
    """
    JSON:
    {
      "full_name": "John link",
      "email": "john@gmail.com",
      "phone": "090...",
      "password": "secret123"
    }
    """
    full_name = (payload.get("full_name") or "").strip()
    email = (payload.get("email") or "").strip().lower()
    phone = (payload.get("phone") or "").strip() or None
    password = payload.get("password") or ""

    if not full_name or not email or not password:
        fail("VALIDATION_ERROR", "full_name, email, and password are required", 400)

    # basic policy (your auth.py may also validate)
    if len(password) < 6:
        fail("PASSWORD_TOO_SHORT", "Password too short (min 6 characters)", 400)
    if len(password) > 256:
        fail("PASSWORD_TOO_LONG", "Password too long (max 256 characters)", 400)

    exists = db.query(User).filter(User.email == email).first()
    if exists:
        fail("EMAIL_EXISTS", "Email already registered", 400)

    user = User(
        full_name=full_name,
        email=email,
        phone=phone,
        password_hash=hash_password(password),
        role="user",
        is_active=True,
    )

    db.add(user)
    db.commit()
    db.refresh(user)

    return ok(
        {
            "id": user.id,
            "full_name": user.full_name,
            "email": user.email,
            "phone": user.phone,
            "role": user.role,
            "is_active": user.is_active,
        }
    )


@router.post("/login")
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    """
    Form-Data:
    username = email
    password = password
    """
    email = (form_data.username or "").strip().lower()
    password = form_data.password or ""

    if not email or not password:
        fail("VALIDATION_ERROR", "Email and password are required", 400)

    user = db.query(User).filter(User.email == email).first()
    if not user:
        fail("NO_ACCOUNT", "You don’t have an account yet. Please create one.", 404)

    if not user.is_active:
        fail("ACCOUNT_DISABLED", "Your account is disabled. Please contact support.", 403)

    if not verify_password(password, user.password_hash):
        fail("INCORRECT_PASSWORD", "Incorrect password. Please try again.", 401)

    token = create_access_token({"sub": str(user.id), "role": user.role})

    return ok(
        {
            "access_token": token,
            "token_type": "bearer",
            "user": {
                "id": user.id,
                "full_name": user.full_name,
                "email": user.email,
                "phone": user.phone,
                "role": user.role,
            },
        }
    )

@router.get("/me")
def me(user: User = Depends(get_current_user)):

    now = datetime.utcnow()

    has_active_premium = (
        user.is_premium
        and user.premium_expires_at
        and user.premium_expires_at > now
    )

    return ok(
        {
            "id": user.id,
            "full_name": user.full_name,
            "email": user.email,
            "phone": user.phone,
            "role": user.role,
            "is_active": user.is_active,

            # 🔥 AUTO-EXPIRE LOGIC
            "is_premium": has_active_premium,
            "premium_plan": user.premium_plan if has_active_premium else None,
            "premium_expires_at": (
                user.premium_expires_at.isoformat()
                if has_active_premium and user.premium_expires_at
                else None
            ),
        }
    )
