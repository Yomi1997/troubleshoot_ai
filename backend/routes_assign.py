# backend/routes_assign.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db import get_db
from deps import require_roles
from models import Ticket, TechnicianProfile

router = APIRouter()


def ok(data):
    return {"ok": True, "data": data, "error": None}


@router.post(
    "/tickets/{ticket_id}/auto-assign",
    dependencies=[Depends(require_roles(["admin"]))],
)
def auto_assign(ticket_id: int, db: Session = Depends(get_db)):
    t = db.query(Ticket).filter(Ticket.id == ticket_id).first()
    if not t:
        raise HTTPException(status_code=404, detail="Ticket not found")

    if t.assigned_tech_user_id:
        raise HTTPException(status_code=400, detail="Ticket already assigned")

    city = (t.user_city or "").strip()
    if not city:
        raise HTTPException(status_code=400, detail="Ticket city is missing")

    prof = (
        db.query(TechnicianProfile)
        .filter(
            TechnicianProfile.city == city,
            TechnicianProfile.is_available == True,  # noqa: E712
        )
        .order_by(TechnicianProfile.rating.desc())
        .first()
    )

    if not prof:
        raise HTTPException(status_code=404, detail=f"No available technician in '{city}'")

    t.assigned_tech_user_id = prof.user_id
    t.status = "assigned"
    db.commit()
    db.refresh(t)

    return ok(
        {
            "ticket_id": t.id,
            "assigned_tech_user_id": t.assigned_tech_user_id,
            "status": t.status,
            "city": city,
        }
    )
