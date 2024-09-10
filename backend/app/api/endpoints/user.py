from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from app.db import crud
from app.core.config import settings
from jose import JWTError, jwt
from app.db.models import User
from app.schemas.user import UserProfileResponse, UserProfileUpdate, UpdateResponseMessage, SignUp, Login
from app.core.auth import create_access_token, get_current_user, verify_token, Token, TokenData
from app.db.crud.user_session import get_session_by_token, delete_session
from app.api.deps import get_db
from app.core.config import settings

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="users/login")

# 사용자 프로필 조회
@router.get("/profile/{user_id}", response_model=UserProfileResponse, summary="프로필 조회")
def get_user_profile(user_id: int, db: Session = Depends(get_db)):
    user_profile = crud.user.get_user_profile(db, user_id)
    if user_profile is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user_profile

# 사용자 프로필 업데이트
@router.put("/profile/{user_id}", response_model=UpdateResponseMessage, summary="프로필 업데이트")
def update_profile(user_id: int, profile_update: UserProfileUpdate, db: Session = Depends(get_db)):
    updated_user = crud.user.update_user_profile(db, user_id, profile_update)
    return updated_user

# 회원가입
@router.post("/signup", summary="회원가입")
def signup(signup_data: SignUp, db: Session = Depends(get_db)):
    # 기존에 같은 이름의 유저가 있는지 확인
    existing_user = db.query(User).filter(User.user_name == signup_data.user_name).first()

    if existing_user:
        raise HTTPException(status_code=400, detail="이미 존재하는 사용자 아이디입니다.")

    # 새로운 사용자 생성
    new_user = User(
        user_name=signup_data.user_name,
        user_password=signup_data.user_password
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {"user_id": new_user.user_id, "message": "회원가입이 완료되었습니다."}

# 로그인
@router.post("/login", response_model=Token, summary="로그인")
def login(login: Login, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.user_name == login.user_name).first()

    if not user or not user.verify_password(login.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)

    access_token = create_access_token(
        data={"user_id": str(user.user_id)},
        expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "bearer"}


@router.get("/me", summary="현재 로그인된 사용자 ID 가져오기")
def get_logged_in_user_id(current_user: User = Depends(get_current_user)):
    return {"user_id": current_user.user_id}


# 로그아웃
@router.post("/logout", summary="로그아웃")
def logout(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    # 현재 토큰에 해당하는 세션을 찾음
    session = get_session_by_token(db, token)
    if session:
        # 세션 삭제
        delete_session(db, session.session_id)
        return {"message": "Successfully logged out"}
    else:
        raise HTTPException(status_code=404, detail="Session not found")
