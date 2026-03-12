from datetime import datetime, timedelta, timezone
import secrets

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db import get_db
from models import User, PasswordResetToken
from passlib.context import CryptContext

router = APIRouter()

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def ok(data):
    return {"ok": True, "data": data, "error": None}


@router.post("/auth/forgot-password")
def forgot_password(payload: dict, db: Session = Depends(get_db)):
    """
    Body: { "email": "user@gmail.com" }
    DEV MODE: returns token so you can test.
    In production: you send it via email instead.
    """
    email = (payload.get("email") or "").strip().lower()
    if not email:
        raise HTTPException(status_code=400, detail="email is required")

    user = db.query(User).filter(User.email == email).first()

    # Security best practice: don't reveal if email exists
    # We'll still create token only if user exists.
    if not user:
        return ok({"message": "If that email exists, a reset token has been sent."})

    # expire in 30 minutes
    expires_at = datetime.now(timezone.utc) + timedelta(minutes=30)

    token = secrets.token_urlsafe(32)

    # optional: invalidate old unused tokens
    db.query(PasswordResetToken).filter(
        PasswordResetToken.user_id == user.id,
        PasswordResetToken.used == False,  # noqa: E712
    ).update({"used": True})

    rec = PasswordResetToken(
        user_id=user.id,
        token=token,
        expires_at=expires_at,
        used=False,
    )
    db.add(rec)
    db.commit()

    # DEV MODE: return token in response
    return ok(
        {
            "message": "Reset token generated (DEV MODE). Use it to reset password.",
            "token": token,
            "expires_at": expires_at.isoformat(),
        }
    )


@router.post("/auth/reset-password")
def reset_password(payload: dict, db: Session = Depends(get_db)):
    """
    Body: { "token": "...", "new_password": "NewPass123" }
    """
    token = (payload.get("token") or "").strip()
    new_password = payload.get("new_password") or ""

    if not token or not new_password:
        raise HTTPException(status_code=400, detail="token and new_password are required")

    if len(new_password) < 6:
        raise HTTPException(status_code=400, detail="Password must be at least 6 characters")

    rec = db.query(PasswordResetToken).filter(
        PasswordResetToken.token == token
    ).first()

    if not rec:
        raise HTTPException(status_code=400, detail="Invalid reset token")

    if rec.used:
        raise HTTPException(status_code=400, detail="Reset token already used")

    now = datetime.now(timezone.utc)

    # rec.expires_at may be naive depending on DB, handle safely
    exp = rec.expires_at
    if exp.tzinfo is None:
        exp = exp.replace(tzinfo=timezone.utc)

    if now > exp:
        raise HTTPException(status_code=400, detail="Reset token expired")

    user = db.query(User).filter(User.id == rec.user_id).first()
    if not user:
        raise HTTPException(status_code=400, detail="User not found")

    user.password_hash = pwd_context.hash(new_password)
    rec.used = True

    db.commit()

    return ok({"message": "Password reset successful. Please login."})
