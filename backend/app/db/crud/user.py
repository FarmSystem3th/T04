from fastapi import HTTPException
from sqlalchemy.orm import Session
from app.db.models import User, Adjective, UserAdjective, UserInterest, InterestCategory, UserLifeService, UserWantAdjective, LivingTime
from app.schemas.user import UserProfileResponse

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
