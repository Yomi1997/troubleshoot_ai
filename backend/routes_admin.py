# backend/routes_admin.py

import json
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db import get_db
from deps import require_roles, get_current_user
from models import Ticket, TechnicianProfile, User

router = APIRouter()


def ok(data):
    return {"ok": True, "data": data, "error": None}


# =========================
# ADMIN: LIST ALL TICKETS
# =========================
@router.get("/tickets", dependencies=[Depends(require_roles(["admin"]))])
def admin_list_tickets(db: Session = Depends(get_db)):
    rows = db.query(Ticket).order_by(Ticket.id.desc()).all()

    data = []
    for t in rows:
        data.append(
            {
                "id": t.id,
                "created_by_user_id": t.created_by_user_id,
                "session_id": t.session_id,
                "module_id": t.module_id,
                "issue_summary": t.issue_summary,
                "user_city": t.user_city,
                "preferred_contact": t.preferred_contact,
                "assigned_tech_user_id": t.assigned_tech_user_id,
                "status": t.status,
                "created_at": t.created_at.isoformat() if t.created_at else None,
                "updated_at": t.updated_at.isoformat() if t.updated_at else None,
            }
        )

    return ok(data)


# =========================
# ADMIN: LIST TECHNICIANS
# =========================
@router.get("/technicians", dependencies=[Depends(require_roles(["admin"]))])
def admin_list_techs(db: Session = Depends(get_db)):
    # ✅ NO .id anymore — use user_id (PK)
    rows = db.query(TechnicianProfile).order_by(TechnicianProfile.user_id.desc()).all()

    data = []
    for p in rows:
        skills = None
        if p.skills_json:
            try:
                skills = json.loads(p.skills_json)
            except Exception:
                skills = p.skills_json

        data.append(
            {
                "user_id": p.user_id,
                "city": p.city,
                "rating": float(p.rating) if p.rating is not None else 0.0,
                "is_available": bool(p.is_available),
                "skills": skills,
            }
        )

    return ok(data)


# =========================
# ADMIN: CREATE / UPDATE TECHNICIAN PROFILE
# =========================
@router.post("/technicians", dependencies=[Depends(require_roles(["admin"]))])
def admin_create_technician(payload: dict, db: Session = Depends(get_db)):
    """
    Body example:
    {
      "user_id": 5,
      "city": "Mowe",
      "rating": 5.0,
      "is_available": true,
      "skills": ["laptop", "networking"]   OR  {"laptop": true, "router": true}
    }
    """

    user_id = payload.get("user_id")
    city = (payload.get("city") or "").strip()
    rating = payload.get("rating", 5.0)
    is_available = payload.get("is_available", True)
    skills = payload.get("skills", None)

    if not user_id:
        raise HTTPException(status_code=400, detail="user_id is required")
    if not city:
        raise HTTPException(status_code=400, detail="city is required")

    # Ensure user exists
    u = db.query(User).filter(User.id == int(user_id)).first()
    if not u:
        raise HTTPException(status_code=404, detail="User not found")

    # ✅ FIX: MySQL can't store dict/list directly. Convert to JSON string.
    skills_json = None
    if skills is not None:
        skills_json = json.dumps(skills)

    # Upsert profile (since PK is user_id)
    prof = db.query(TechnicianProfile).filter(TechnicianProfile.user_id == int(user_id)).first()

    if prof is None:
        prof = TechnicianProfile(
            user_id=int(user_id),
            city=city,
            rating=float(rating) if rating is not None else 5.0,
            is_available=bool(is_available),
            skills_json=skills_json,
        )
        db.add(prof)
    else:
        prof.city = city
        prof.rating = float(rating) if rating is not None else prof.rating
        prof.is_available = bool(is_available)
        prof.skills_json = skills_json

    # Optional but helpful: upgrade the user's role to technician
    u.role = "technician"

    db.commit()

    return ok(
        {
            "user_id": prof.user_id,
            "city": prof.city,
            "rating": float(prof.rating) if prof.rating is not None else 0.0,
            "is_available": bool(prof.is_available),
            "skills_json": prof.skills_json,
        }
    )
