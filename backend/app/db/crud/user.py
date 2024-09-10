from fastapi import HTTPException
from datetime import time
from typing import List
from sqlalchemy.orm import Session
from app.db.models import User, Adjective, UserAdjective, UserInterest, InterestCategory, UserLifeService, UserWantAdjective, LivingTime
from app.schemas.user import UserProfileResponse, UserProfileUpdate


# 사용자 프로필 조회
def get_user_profile(db: Session, user_id: int) -> UserProfileResponse:
    user = db.query(User).filter(User.user_id == user_id).first()
    life_service = db.query(UserLifeService).filter(UserLifeService.user_id == user_id).first()
    living_time = db.query(LivingTime).filter(LivingTime.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # user_type을 bool에서 0(노인) 또는 1(청년)로 변환
    user_type = 1 if user.user_type else 0

    # Fetch user adjectives
    adjectives = db.query(Adjective).join(UserAdjective).filter(UserAdjective.user_id == user_id).all()
    adjective_names = [adj.adj_name for adj in adjectives]

    # Fetch user interests
    interests = db.query(InterestCategory).join(UserInterest).filter(UserInterest.user_id == user_id).all()
    interest_names = [interest.interest_category_name for interest in interests]

    # Fetch user want adjectives
    want_adjectives = db.query(Adjective).join(UserWantAdjective).filter(UserWantAdjective.user_id == user_id).all()
    want_adjective_names = [adj.adj_name for adj in want_adjectives]

    return UserProfileResponse(
        id = user_id,
        user_type=user_type,
        user_nickname=user.user_nickname,
        user_sido=user.user_sido,
        user_sigungu=user.user_sigungu,
        age=user.user_age,
        k_age=user.user_k_age,
        user_lifeservice= life_service.life_service,
        bedtime=living_time.bedtime.strftime('%H:%M') if living_time and living_time.bedtime else None,
        wakeup_time=living_time.wakeup_time.strftime('%H:%M') if living_time and living_time.wakeup_time else None,
        user_adjective=adjective_names,
        user_interest=interest_names,
        user_want_adjective=want_adjective_names,
        user_biography=user.user_biography,
        has_disease="있음" if user.has_disease else "없음",
        has_pet="있음" if user.has_pet else "없음"
    )



# 사용자 프로필 업데이트
def update_user_profile(db: Session, user_id: int, profile_update: UserProfileUpdate):
    user = db.query(User).filter(User.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # 기본적인 필드 업데이트
    if profile_update.user_nickname:
        user.user_nickname = profile_update.user_nickname
    if profile_update.user_biography:
        user.user_biography = profile_update.user_biography
    if profile_update.has_disease is not None:
        user.has_disease = profile_update.has_disease
    if profile_update.has_pet is not None:
        user.has_pet = profile_update.has_pet

    # 생활 서비스 업데이트
    if profile_update.life_service:
        life_service = db.query(UserLifeService).filter(UserLifeService.user_id == user_id).first()
        if not life_service:
            life_service = UserLifeService(user_id=user_id, life_service=profile_update.life_service)
            db.add(life_service)
        else:
            life_service.life_service = profile_update.life_service

    # bedtime과 wakeup_time 업데이트
    if profile_update.bedtime or profile_update.wakeup_time:
        living_time = db.query(LivingTime).filter(LivingTime.user_id == user_id).first()
        if not living_time:
            living_time = LivingTime(user_id=user_id)
            db.add(living_time)
        if profile_update.bedtime:
            living_time.bedtime = time.fromisoformat(profile_update.bedtime)
        if profile_update.wakeup_time:
            living_time.wakeup_time = time.fromisoformat(profile_update.wakeup_time)

    # 형용사, 관심사, 원하는 형용사 업데이트
    update_user_categories(db, user, profile_update.user_adjective, Adjective, UserAdjective, "adj_id", "adj_name",
                           "adj_id")
    update_user_categories(db, user, profile_update.user_interest, InterestCategory, UserInterest,
                           "interest_category_id", "interest_category_name", "interest_category_id")
    update_user_categories(db, user, profile_update.user_want_adjective, Adjective, UserWantAdjective, "adj_id",
                           "adj_name", "wanted_adj_id")

    db.commit()
    db.refresh(user)
    return {"message": "Profile updated successfully"}



# 형용사, 관심사, 원하는 형용사 테이블 업데이트 함수
def update_user_categories(db: Session, user: User, new_categories: List[str], category_model, user_category_model,
                           category_field: str, name_field: str, user_field: str):
    if new_categories is None:
        return

    # 현재 유저의 매핑된 항목을 제거
    db.query(user_category_model).filter(user_category_model.user_id == user.user_id).delete()

    for category_name in new_categories:
        category = db.query(category_model).filter(getattr(category_model, name_field) == category_name).first()
        if not category:
            raise HTTPException(status_code=404, detail=f"{category_model.__tablename__} '{category_name}' not found")

        # 사용자 카테고리 항목 생성
        user_category_entry = user_category_model(user_id=user.user_id,
                                                  **{user_field: getattr(category, category_field)})
        db.add(user_category_entry)

    db.commit()
