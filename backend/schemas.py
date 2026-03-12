# backend/schemas.py
from typing import Any, Dict, List, Optional
from pydantic import BaseModel


class ApiResponse(BaseModel):
    ok: bool = True
    data: Optional[Any] = None
    error: Optional[Dict[str, Any]] = None


# -------------------------
# Sessions
# -------------------------
class StartSessionRequest(BaseModel):
    module_id: str
    user_context: Optional[Dict[str, Any]] = None


class AnswerRequest(BaseModel):
    session_id: str
    answer_id: str


# -------------------------
# Auth
# -------------------------
class RegisterRequest(BaseModel):
    full_name: str
    email: str
    phone: Optional[str] = None
    password: str


# -------------------------
# Tickets
# -------------------------
class TicketCreate(BaseModel):
    session_id: Optional[str] = None
    module_id: str
    issue_summary: str
    user_city: str
    preferred_contact: str = "whatsapp"


class TicketOut(BaseModel):
    id: int
    module_id: str
    issue_summary: str
    user_city: str
    preferred_contact: str
    status: str
    assigned_tech_user_id: Optional[int] = None
    created_at: Optional[str] = None

    class Config:
        orm_mode = True


# -------------------------
# Assign / Tech actions
# -------------------------
class AssignRequest(BaseModel):
    ticket_id: int


class TechAcceptRequest(BaseModel):
    ticket_id: int
