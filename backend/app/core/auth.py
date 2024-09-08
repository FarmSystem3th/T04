from datetime import datetime, timedelta, timezone
from typing import Optional
from jose import JWTError, jwt
import pytz
from fastapi import HTTPException, Depends, Request
from pydantic import BaseModel
from app.api.deps import get_db
from app.db.crud.user_session import create_session, get_session_by_token
from app.db.session import SessionLocal
from app.settings import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES
from fastapi.security import OAuth2PasswordBearer
from app.db.models import User
from sqlalchemy.orm import Session

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="users/login")

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    user_id: int


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(pytz.timezone('Asia/Seoul')) + expires_delta
    else:
        expire = datetime.now(pytz.timezone('Asia/Seoul')) + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

    # DB에 JWT 저장
    db = SessionLocal()
    create_session(db, data["user_id"], encoded_jwt)
    return encoded_jwt


def verify_token(token: str, credentials_exception):
    db = SessionLocal()
    session = get_session_by_token(db, token)
    if not session:
        raise credentials_exception

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: int = int(payload.get("user_id"))
        if user_id is None:
            raise credentials_exception
        return TokenData(user_id=user_id)
    except JWTError:
        raise credentials_exception


def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> User:
    credentials_exception = HTTPException(
        status_code=401,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    # JWT 토큰을 검증하고 user_id를 추출
    token_data = verify_token(token, credentials_exception)
    if token_data is None or token_data.user_id is None:
        raise credentials_exception

    # 추출한 user_id로 사용자를 데이터베이스에서 조회
    user = db.query(User).filter(User.user_id == token_data.user_id).first()
    if user is None:
        raise credentials_exception
    return user


