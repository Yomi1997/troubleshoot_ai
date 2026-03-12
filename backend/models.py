from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Boolean,
    DateTime,
    Float,
    ForeignKey,
)
from sqlalchemy.sql import func
from db import Base


class Module(Base):
    __tablename__ = "modules"

    id = Column(Integer, primary_key=True, index=True)
    module_id = Column(String(100), unique=True, index=True, nullable=False)
    title = Column(String(255), nullable=False)

    category_id = Column(String(100), nullable=False)
    category_title = Column(String(255), nullable=False)


class Node(Base):
    __tablename__ = "nodes"

    id = Column(Integer, primary_key=True, index=True)
    module_id = Column(String(100), index=True, nullable=False)
    node_id = Column(String(100), index=True, nullable=False)

    message = Column(Text, nullable=False)
    is_final = Column(Boolean, default=False)


class Option(Base):
    __tablename__ = "options"

    id = Column(Integer, primary_key=True, index=True)
    module_id = Column(String(100), index=True, nullable=False)
    node_id = Column(String(100), index=True, nullable=False)

    option_id = Column(String(100), nullable=False)
    label = Column(String(255), nullable=False)
    next_node_id = Column(String(100), nullable=False)


class Result(Base):
    __tablename__ = "results"

    id = Column(Integer, primary_key=True, index=True)
    module_id = Column(String(100), index=True, nullable=False)
    node_id = Column(String(100), index=True, nullable=False)

    type = Column(String(50), nullable=False)  # free_fix | refer_technician | premium_fix
    title = Column(String(255), nullable=False)
    summary = Column(Text, nullable=False)
    next_action = Column(Text, nullable=True)


class Session(Base):
    __tablename__ = "sessions"

    id = Column(Integer, primary_key=True, index=True)
    session_id = Column(String(100), unique=True, index=True, nullable=False)
    module_id = Column(String(100), index=True, nullable=False)
    node_id = Column(String(100), index=True, nullable=False)

    status = Column(String(50), default="active")  # active | done
    created_at = Column(DateTime(timezone=True), server_default=func.now())


class AnswerLog(Base):
    __tablename__ = "answer_logs"

    id = Column(Integer, primary_key=True, index=True)
    session_id = Column(String(100), index=True, nullable=False)
    module_id = Column(String(100), index=True, nullable=False)
    node_id = Column(String(100), index=True, nullable=False)

    answer_id = Column(String(100), nullable=False)
    answer_label = Column(String(255), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, index=True, nullable=False)
    phone = Column(String(50), nullable=True)
    password_hash = Column(String(255), nullable=False)

    role = Column(String(50), default="user")  # user | admin | technician
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    is_premium = Column(Boolean, default=False)
    premium_plan = Column(String(50), nullable=True)
    premium_expires_at = Column(DateTime(timezone=True), nullable=True)

# ✅ FIXED: matches DB exactly (PRIMARY KEY is user_id)
class TechnicianProfile(Base):
    __tablename__ = "technician_profiles"

    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)

    city = Column(String(100), index=True, nullable=False)
    rating = Column(Float, default=5.0)
    is_available = Column(Boolean, default=True)

    skills_json = Column(Text, nullable=True)


class Ticket(Base):
    __tablename__ = "tickets"

    id = Column(Integer, primary_key=True, index=True)

    created_by_user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    session_id = Column(String(100), nullable=True)

    module_id = Column(String(100), nullable=False)
    issue_summary = Column(Text, nullable=False)

    user_city = Column(String(100), index=True, nullable=False)
    preferred_contact = Column(String(50), default="whatsapp")

    assigned_tech_user_id = Column(Integer, ForeignKey("users.id"), nullable=True)

    # pending -> approved -> assigned -> accepted -> working -> done -> rejected
    status = Column(String(50), default="pending")

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(
        DateTime(timezone=True),
        onupdate=func.now(),
        server_default=func.now(),
    )


# ✅ NEW: Password reset tokens (for "Forgot password")
class PasswordResetToken(Base):
    __tablename__ = "password_reset_tokens"

    id = Column(Integer, primary_key=True, index=True)

    user_id = Column(Integer, ForeignKey("users.id"), index=True, nullable=False)

    token = Column(String(200), unique=True, index=True, nullable=False)

    # we store expiry date/time
    expires_at = Column(DateTime(timezone=True), nullable=False)

    used = Column(Boolean, default=False)

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    
class TicketAttachment(Base):
    __tablename__ = "ticket_attachments"

    id = Column(Integer, primary_key=True, index=True)
    ticket_id = Column(Integer, ForeignKey("tickets.id"), nullable=False)

    file_name = Column(String(255), nullable=False)
    file_path = Column(String(500), nullable=False)
    mime_type = Column(String(100), nullable=False)
    file_size = Column(Integer, nullable=False)

    created_at = Column(DateTime(timezone=True), server_default=func.now())
