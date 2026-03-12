from fastapi import APIRouter, HTTPException, Depends
import os
import requests
from datetime import datetime, timedelta
from sqlalchemy import text

from db import get_db
from routes_auth import get_current_user


router = APIRouter(prefix="/billing", tags=["Billing"])

FRONTEND_URL = os.getenv("FRONTEND_URL", "http://localhost:5173")


PLANS = {
    "weekly": {"amount_kobo": 150000, "days": 7},
    "monthly": {"amount_kobo": 600000, "days": 30},
    "yearly": {"amount_kobo": 6000000, "days": 365},
}


def require_paystack_secret():
    key = os.getenv("PAYSTACK_SECRET_KEY")
    if not key:
        raise HTTPException(500, "PAYSTACK_SECRET_KEY not set")
    return key.strip()


# Initialize payment
@router.post("/paystack/init")
def paystack_init(payload: dict, db=Depends(get_db), user=Depends(get_current_user)):

    paystack_secret = require_paystack_secret()

    plan = payload.get("plan")

    if plan not in PLANS:
        raise HTTPException(400, "Invalid plan")

    user_id = user.id
    email = user.email

    if not email:
        raise HTTPException(400, "User email missing")

    amount_kobo = PLANS[plan]["amount_kobo"]

    headers = {
        "Authorization": f"Bearer {paystack_secret}",
        "Content-Type": "application/json",
    }

    body = {
        "email": email,
        "amount": amount_kobo,
        "callback_url": f"{FRONTEND_URL}/payment-success",
        "metadata": {
            "user_id": user_id,
            "plan": plan
        }
    }

    response = requests.post(
        "https://api.paystack.co/transaction/initialize",
        headers=headers,
        json=body
    )

    data = response.json()

    if not data["status"]:
        raise HTTPException(400, data["message"])

    reference = data["data"]["reference"]
    url = data["data"]["authorization_url"]

    db.execute(
        text("""
        INSERT INTO payments 
        (user_id, provider, reference, amount_kobo, status, plan, created_at)
        VALUES
        (:user_id, 'paystack', :reference, :amount, 'pending', :plan, NOW())
        """),
        {
            "user_id": user_id,
            "reference": reference,
            "amount": amount_kobo,
            "plan": plan
        }
    )

    db.commit()

    return {
        "authorization_url": url,
        "reference": reference
    }


# Verify payment
@router.get("/paystack/verify")
def verify(reference: str, db=Depends(get_db)):

    paystack_secret = require_paystack_secret()

    headers = {
        "Authorization": f"Bearer {paystack_secret}"
    }

    response = requests.get(
        f"https://api.paystack.co/transaction/verify/{reference}",
        headers=headers
    )

    data = response.json()

    if not data["status"]:
        raise HTTPException(400, data["message"])

    pay_status = data["data"]["status"]

    payment = db.execute(
        text("SELECT user_id, plan FROM payments WHERE reference=:ref"),
        {"ref": reference}
    ).fetchone()

    if not payment:
        raise HTTPException(400, "Payment not found")

    user_id, plan = payment

    db.execute(
        text("""
        UPDATE payments
        SET status=:status,
            paid_at=NOW()
        WHERE reference=:reference
        """),
        {
            "status": pay_status,
            "reference": reference
        }
    )

    db.commit()

    if pay_status != "success":
        raise HTTPException(400, "Payment not successful")

    expires = datetime.utcnow() + timedelta(days=PLANS[plan]["days"])

    db.execute(
        text("""
        UPDATE users
        SET is_premium=TRUE,
            premium_plan=:plan,
            premium_expires_at=:exp
        WHERE id=:user_id
        """),
        {
            "plan": plan,
            "exp": expires,
            "user_id": user_id
        }
    )

    db.commit()

    return {
        "status": "success",
        "expires": expires
    }
