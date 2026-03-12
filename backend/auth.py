from datetime import datetime, timedelta
from typing import Dict, Any, Optional

from jose import jwt, JWTError
from passlib.context import CryptContext
from fastapi import HTTPException, status

SECRET_KEY = "CHANGE_ME_TO_A_RANDOM_SECRET_64_CHARS"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24

pwd_context = CryptContext(
    schemes=["argon2", "bcrypt"],
    deprecated="auto",
)


def validate_password_policy(pw: str):
    if pw is None:
        raise HTTPException(status_code=400, detail="Password is required")
    if len(pw) < 6:
        raise HTTPException(status_code=400, detail="Password too short (min 6)")
    if len(pw) > 256:
        raise HTTPException(status_code=400, detail="Password too long (max 256)")


def hash_password(password: str) -> str:
    validate_password_policy(password)
    return pwd_context.hash(password)


def verify_password(plain_password: str, password_hash: str) -> bool:
    validate_password_policy(plain_password)
    return pwd_context.verify(plain_password, password_hash)


def create_access_token(data: Dict[str, Any], expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def decode_token(token: str) -> Dict[str, Any]:
    try:
        return jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")
