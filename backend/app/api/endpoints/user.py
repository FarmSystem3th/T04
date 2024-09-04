from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db import crud
from app.schemas.user import UserProfileResponse, UserProfileUpdate, UpdateResponseMessage
from app.api.deps import get_db

router = APIRouter()


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
