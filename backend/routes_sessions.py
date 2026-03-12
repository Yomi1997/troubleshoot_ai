# backend/routes_sessions.py

import secrets
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from db import get_db
from models import Module, Node, Option, Result, Session as DbSession, AnswerLog

# ✅ put prefix here
router = APIRouter(prefix="/sessions")


@router.post("/start")
def start_session(payload: dict, db: Session = Depends(get_db)):
    module_id = payload.get("module_id")
    if not module_id:
        raise HTTPException(status_code=400, detail="module_id is required")

    module = db.query(Module).filter(Module.module_id == module_id).first()
    if not module:
        raise HTTPException(status_code=404, detail="Module not found")

    # start node
    node_id = "intro"

    node = (
        db.query(Node)
        .filter(Node.module_id == module.module_id, Node.node_id == node_id)
        .first()
    )
    if not node:
        raise HTTPException(
            status_code=404,
            detail=f"Start node '{node_id}' not found for module '{module.module_id}'",
        )

    session_id = "S_" + secrets.token_hex(4)

    db.add(
        DbSession(
            session_id=session_id,
            module_id=module.module_id,
            node_id=node_id,
            status="active",
        )
    )
    db.commit()

    opts = (
        db.query(Option)
        .filter(Option.module_id == module.module_id, Option.node_id == node_id)
        .all()
    )

    options = [{"id": o.option_id, "label": o.label} for o in opts]

    return {
        "ok": True,
        "data": {
            "session_id": session_id,
            "state": {"module_id": module.module_id, "node_id": node_id},
            "message": node.message,
            "options": options,
            "result": None,
        },
        "error": None,
    }


@router.post("/answer")
def answer(payload: dict, db: Session = Depends(get_db)):
    session_id = payload.get("session_id")
    answer_id = payload.get("answer_id")

    if not session_id or not answer_id:
        raise HTTPException(status_code=400, detail="session_id and answer_id required")

    sess = (
        db.query(DbSession)
        .filter(DbSession.session_id == session_id, DbSession.status == "active")
        .first()
    )
    if not sess:
        raise HTTPException(status_code=404, detail="Invalid session_id")

    opt = (
        db.query(Option)
        .filter(
            Option.module_id == sess.module_id,
            Option.node_id == sess.node_id,
            Option.option_id == answer_id,
        )
        .first()
    )
    if not opt:
        raise HTTPException(status_code=400, detail="Answer not valid for this question")

    # log answer
    db.add(
        AnswerLog(
            session_id=sess.session_id,
            module_id=sess.module_id,
            node_id=sess.node_id,
            answer_id=opt.option_id,
            answer_label=opt.label,
        )
    )

    # move to next node
    sess.node_id = opt.next_node_id
    db.commit()

    node = (
        db.query(Node)
        .filter(Node.module_id == sess.module_id, Node.node_id == sess.node_id)
        .first()
    )
    if not node:
        raise HTTPException(
            status_code=404,
            detail=f"Next node '{sess.node_id}' not found for module '{sess.module_id}'",
        )

    opts = (
        db.query(Option)
        .filter(Option.module_id == sess.module_id, Option.node_id == sess.node_id)
        .all()
    )
    options = [{"id": o.option_id, "label": o.label} for o in opts]

    res = None
    if node.is_final:
        r = (
            db.query(Result)
            .filter(Result.module_id == sess.module_id, Result.node_id == sess.node_id)
            .first()
        )
        if r:
            res = {
                "type": r.type,
                "title": r.title,
                "summary": r.summary,
                "next_action": r.next_action,
            }

        sess.status = "done"
        db.commit()
        options = []  # no more options after final

    return {
        "ok": True,
        "data": {
            "session_id": sess.session_id,
            "state": {"module_id": sess.module_id, "node_id": sess.node_id},
            "message": node.message,
            "options": options,
            "result": res,
        },
        "error": None,
    }
