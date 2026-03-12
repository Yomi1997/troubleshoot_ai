# backend/routes_modules.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from db import get_db
from models import Module

router = APIRouter()


@router.get("/modules")
def list_modules(db: Session = Depends(get_db)):
    rows = db.query(Module).all()

    cat_map = {}
    for r in rows:
        # Defensive: avoid crashing if any field is None
        cat_id = r.category_id or "laptops_desktops"
        cat_title = r.category_title or "Laptops / Desktops"

        if cat_id not in cat_map:
            cat_map[cat_id] = {
                "category_id": cat_id,
                "title": cat_title,
                "modules": [],
            }

        cat_map[cat_id]["modules"].append(
            {"module_id": r.module_id, "title": r.title}
        )

    return {"ok": True, "data": {"categories": list(cat_map.values())}, "error": None}
