# backend/routes_tech.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db import get_db
from deps import get_current_user, require_roles
from models import Ticket, User

router = APIRouter()


def ok(data):
    return {"ok": True, "data": data, "error": None}


@router.get(
    "/tickets",
    dependencies=[Depends(require_roles(["technician", "admin"]))],
)
def tech_tickets(
    db: Session = Depends(get_db),
    me: User = Depends(get_current_user),
):
    """
    Technician sees ONLY tickets assigned to them.
    """
    rows = (
        db.query(Ticket)
        .filter(Ticket.assigned_tech_user_id == me.id)
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
                "updated_at": r.updated_at.isoformat() if r.updated_at else None,
            }
        )

    return ok(data)


@router.post(
    "/tickets/{ticket_id}/update-status",
    dependencies=[Depends(require_roles(["technician", "admin"]))],
)
def tech_update_ticket_status(
    ticket_id: int,
    payload: dict,
    db: Session = Depends(get_db),
    me: User = Depends(get_current_user),
):
    """
    Body: { "status": "accepted" | "working" | "done" | "rejected" }
    """
    new_status = (payload.get("status") or "").strip().lower()
    allowed = {"accepted", "working", "done", "rejected"}

    if new_status not in allowed:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid status. Allowed: {', '.join(sorted(allowed))}",
        )

    t = db.query(Ticket).filter(Ticket.id == ticket_id).first()
    if not t:
        raise HTTPException(status_code=404, detail="Ticket not found")

    # Tech can only update tickets assigned to them (admin can update any)
    if me.role != "admin" and t.assigned_tech_user_id != me.id:
        raise HTTPException(status_code=403, detail="Not allowed for this ticket")

    # Optional: prevent updating unassigned tickets
    if not t.assigned_tech_user_id:
        raise HTTPException(status_code=400, detail="Ticket is not assigned yet")

    t.status = new_status
    db.commit()
    db.refresh(t)

    return ok({"ticket_id": t.id, "status": t.status})
