# backend/routes_attachments.py
import os
import uuid
from typing import List

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile
from sqlalchemy.orm import Session

from db import get_db
from deps import require_roles, get_current_user
from models import Ticket, TicketAttachment

router = APIRouter()


def ok(data):
    return {"ok": True, "data": data, "error": None}


# ✅ Make sure uploads folder exists
UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


def _can_access_ticket(user, ticket: Ticket) -> bool:
    # admin can access all
    if user.role == "admin":
        return True

    # ticket owner (normal user)
    if ticket.created_by_user_id == user.id:
        return True

    # assigned technician
    if user.role == "technician" and ticket.assigned_tech_user_id == user.id:
        return True

    return False


@router.get("/tickets/{ticket_id}/attachments", dependencies=[Depends(require_roles(["admin", "user", "technician"]))])
def list_attachments(ticket_id: int, db: Session = Depends(get_db), me=Depends(get_current_user)):
    t = db.query(Ticket).filter(Ticket.id == ticket_id).first()
    if not t:
        raise HTTPException(status_code=404, detail="Ticket not found")

    if not _can_access_ticket(me, t):
        raise HTTPException(status_code=403, detail="Not allowed")

    items = (
        db.query(TicketAttachment)
        .filter(TicketAttachment.ticket_id == ticket_id)
        .order_by(TicketAttachment.id.desc())
        .all()
    )

    data = []
    for a in items:
        data.append(
            {
                "id": a.id,
                "ticket_id": a.ticket_id,
                "file_name": a.file_name,
                "file_path": a.file_path,
                "mime_type": a.mime_type,
                "file_size": a.file_size,
                "url": f"http://127.0.0.1:8000/{a.file_path}",  # ✅ frontend uses this
                "created_at": a.created_at,
            }
        )

    return ok(data)


@router.post("/tickets/{ticket_id}/attachments", dependencies=[Depends(require_roles(["admin", "user"]))])
def upload_attachment(
    ticket_id: int,
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
    me=Depends(get_current_user),
):
    t = db.query(Ticket).filter(Ticket.id == ticket_id).first()
    if not t:
        raise HTTPException(status_code=404, detail="Ticket not found")

    # only ticket owner or admin can upload
    if not (me.role == "admin" or t.created_by_user_id == me.id):
        raise HTTPException(status_code=403, detail="Only ticket owner/admin can upload")

    if not file.content_type or not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="Only image files are allowed")

    ext = os.path.splitext(file.filename or "")[1].lower() or ".png"
    safe_name = f"{uuid.uuid4().hex}{ext}"
    disk_path = os.path.join(UPLOAD_DIR, safe_name)

    contents = file.file.read()
    with open(disk_path, "wb") as f:
        f.write(contents)

    rel_path = f"{UPLOAD_DIR}/{safe_name}"

    att = TicketAttachment(
        ticket_id=ticket_id,
        file_name=file.filename or safe_name,
        file_path=rel_path,
        mime_type=file.content_type,
        file_size=len(contents),
    )
    db.add(att)
    db.commit()
    db.refresh(att)

    return ok(
        {
            "id": att.id,
            "ticket_id": att.ticket_id,
            "file_name": att.file_name,
            "file_path": att.file_path,
            "mime_type": att.mime_type,
            "file_size": att.file_size,
            "url": f"http://127.0.0.1:8000/{att.file_path}",
            "created_at": att.created_at,
        }
    )
