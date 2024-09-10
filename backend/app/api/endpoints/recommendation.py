from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime
from app.db.models import User, UserAdjective, UserInterest, LivingTime
from app.api.deps import get_db
from app.db.crud.user import get_user_profile
from app.schemas.user import ExtendedUserProfileResponse

router = APIRouter()


# 시간 차이를 초 단위로 계산하는 함수
def time_difference_in_seconds(time1: str, time2: str) -> int:
    today = datetime.today()
    time1_obj = datetime.strptime(time1, '%H:%M').time()
    time2_obj = datetime.strptime(time2, '%H:%M').time()

    dt1 = datetime.combine(today, time1_obj)
    dt2 = datetime.combine(today, time2_obj)

    return abs((dt1 - dt2).total_seconds())


@router.get("/{user_id}", response_model=List[ExtendedUserProfileResponse], summary="추천 사용자 조회")
def get_recommendations(user_id: int, db: Session = Depends(get_db)):
    user_profile = get_user_profile(db, user_id)
    if not user_profile:
        raise HTTPException(status_code=404, detail="User not found")

    # 반대 user_type (노인-청년) 필터링
    opposite_user_type = 1 if user_profile.user_type == 0 else 0
    potential_matches = db.query(User).filter(User.user_type == opposite_user_type).all()

    recommendations = []
    for match in potential_matches:
        match_profile = get_user_profile(db, match.user_id)

        # 공통 관심사 확인
        common_interests = list(set(user_profile.user_interest) & set(match_profile.user_interest))

        # 공통 형용사 확인
        common_adjectives = list(set(user_profile.user_adjective) & set(match_profile.user_adjective))

        # 공통된 형용사와 관심사의 총합이 2개 이상인지 확인
        total_common = len(common_interests) + len(common_adjectives)
        if total_common < 2:
            continue  # 2개 미만이면 제외

        # 상대방이 원하는 형용사와 내 형용사 간 공통 형용사 확인
        match_wanted_adjectives = list(set(user_profile.user_adjective) & set(match_profile.user_want_adjective))

        # 내가 원하는 형용사와 상대방 형용사 간 공통 형용사 확인
        user_wanted_adjectives = list(set(user_profile.user_want_adjective) & set(match_profile.user_adjective))

        # 공통된 상대방이 원하는 형용사와 내가 원하는 형용사의 총합이 1개 이상인지 확인
        total_wanted = len(match_wanted_adjectives) + len(user_wanted_adjectives)
        if total_wanted < 1:
            continue  # 1개 미만이면 제외

        # 생활 시간 호환성 (비슷한 취침 및 기상 시간)
        if user_profile.bedtime and match_profile.bedtime:
            bedtime_diff = time_difference_in_seconds(user_profile.bedtime, match_profile.bedtime)
            wakeup_diff = time_difference_in_seconds(user_profile.wakeup_time, match_profile.wakeup_time)

            if bedtime_diff < 5400 and wakeup_diff < 5400:  # 1시간 반 이내 호환성 체크
                match_profile = ExtendedUserProfileResponse(
                    **match_profile.dict(),  # Copy the basic profile data
                    common_interests=common_interests,
                    common_adjectives=common_adjectives,
                    match_wanted_adjectives=match_wanted_adjectives,
                    user_wanted_adjectives=user_wanted_adjectives
                )
                recommendations.append(match_profile)

    # 결과 반환
    if not recommendations:
        raise HTTPException(status_code=404, detail="No recommendations found")

    return recommendations


