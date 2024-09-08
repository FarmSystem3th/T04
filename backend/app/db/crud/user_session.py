from sqlalchemy.orm import Session
from app.db.models import User, UserSession
from fastapi import HTTPException

def create_session(db: Session, user_id: int, token: str):
    db_session = UserSession(user_id=user_id, token=token)
    db.add(db_session)
    db.commit()
    db.refresh(db_session)
    return db_session

def get_session_by_token(db: Session, token: str):
    session = db.query(UserSession).filter(UserSession.token == token).first()
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
    return session

def delete_session(db: Session, session_id: int):
    session = db.query(UserSession).filter(UserSession.session_id == session_id).first()
    if session:
        db.delete(session)
        db.commit()
    else:
        raise HTTPException(status_code=404, detail="Session not found")

def get_user_by_username(db: Session, username: str):
    return db.query(User).filter(User.user_name == username).first()