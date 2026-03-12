# backend/routes_tickets.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db import get_db
from deps import get_current_user, require_roles
from models import Ticket, User

router = APIRouter()


@router.post(
    "",
    dependencies=[Depends(require_roles(["user", "admin"]))],
)
def create_ticket(
    payload: dict,
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """
    Body:
    {
      "session_id": "S_xxxx" (optional),
      "module_id": "power_no_boot_v1",
      "issue_summary": "short summary...",
      "user_city": "Ibadan",
      "preferred_contact": "whatsapp" | "call" | "email"
    }
    """
    module_id = payload.get("module_id")
    issue_summary = payload.get("issue_summary")
    user_city = payload.get("user_city")
    preferred_contact = payload.get("preferred_contact", "whatsapp")
    session_id = payload.get("session_id")

    if not module_id or not issue_summary or not user_city:
        raise HTTPException(
            status_code=400,
            detail="module_id, issue_summary, user_city are required",
        )

    t = Ticket(
        created_by_user_id=user.id,
        session_id=session_id,
        module_id=module_id,
        issue_summary=issue_summary,
        user_city=user_city,
        preferred_contact=preferred_contact,
        status="pending",
    )

    db.add(t)
    db.commit()
    db.refresh(t)

    return {"ok": True, "data": {"ticket_id": t.id, "status": t.status}, "error": None}


@router.get(
    "/my",
    dependencies=[Depends(require_roles(["user", "admin"]))],
)
def my_tickets(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    rows = (
        db.query(Ticket)
        .filter(Ticket.created_by_user_id == user.id)
        .order_by(Ticket.id.desc())
        .all()
    )

    data = []
    for r in rows:
        data.append(
            {
                "id": r.id,
                "module_id": r.module_id,
                "issue_summary": r.issue_summary,
                "user_city": r.user_city,
                "preferred_contact": r.preferred_contact,
                "status": r.status,
                "assigned_tech_user_id": r.assigned_tech_user_id,
                "created_at": r.created_at.isoformat() if r.created_at else None,
            }
        )

    return {"ok": True, "data": data, "error": None}
