import uuid
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.models import User, Matching
from app.core.auth import get_current_user
from app.api.deps import get_db

router = APIRouter()

# 매칭 신청
@router.post("/match", summary="매칭 신청하기")
def create_matching(receiver_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    # 현재 사용자의 user_type 가져오기
    sender_user_type = current_user.user_type

    # 수신자의 user_type 가져오기
    receiver = db.query(User).filter(User.user_id == receiver_id).first()
    if not receiver:
        raise HTTPException(status_code=404, detail="Receiver not found")

    receiver_user_type = receiver.user_type

    # user_type이 다른 경우만 매칭 신청 허용
    if sender_user_type == receiver_user_type:
        raise HTTPException(status_code=400, detail="Cannot match with the same user type")

    # 수신자 확인 (존재하는 유저인지 확인)
    receiver = db.query(User).filter(User.user_id == receiver_id).first()
    if not receiver:
        raise HTTPException(status_code=404, detail="Receiver not found")

    # 이미 매칭이 존재하는지 확인
    existing_matching = db.query(Matching).filter(
        Matching.matching_sender_id == current_user.user_id,
        Matching.matching_receiver_id == receiver_id
    ).first()

    if existing_matching:
        raise HTTPException(status_code=400, detail="Matching already exists")

    # 새로운 매칭 생성
    matching = Matching(
        matching_id=str(uuid.uuid4()),  # UUID 생성
        matching_sender_id=current_user.user_id,
        matching_receiver_id=receiver_id,
        matching_status=0
    )

    db.add(matching)
    db.commit()
    db.refresh(matching)

    return {"matching_id": matching.matching_id, "message": "Matching request created successfully"}

# 자신이 매칭 신청한 사람 조회
@router.get("/requests", summary="내가 매칭 신청한 사람 조회")
def get_my_matchings(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    # 내가 매칭 신청한 사람들 조회
    matchings = db.query(Matching).filter(Matching.matching_sender_id == current_user.user_id).all()

    # 매칭이 존재하지 않으면 에러 반환
    if not matchings:
        raise HTTPException(status_code=404, detail="Matching not found")

    # 매칭 상대의 id, 닉네임, user_sido, user_sigungu, age, k_age 정보 추출
    result = []
    for matching in matchings:
        receiver = db.query(User).filter(User.user_id == matching.matching_receiver_id).first()
        result.append({
            "user_id" : receiver.user_id,
            "nickname": receiver.user_nickname,
            "user_sido": receiver.user_sido,
            "user_sigungu": receiver.user_sigungu,
            "age": receiver.user_age,
            "k_age": receiver.user_k_age
        })

    return result

# 매칭 신청 취소
@router.delete("/cancel", summary="매칭 신청 취소")
def cancel_matching(receiver_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    # 현재 유저가 보낸 매칭 중에서 취소하고자 하는 매칭을 찾음
    matching = db.query(Matching).filter(
        Matching.matching_sender_id == current_user.user_id,
        Matching.matching_receiver_id == receiver_id
    ).first()

    # 매칭이 존재하지 않으면 에러 반환
    if not matching:
        raise HTTPException(status_code=404, detail="Matching not found")

    # 매칭을 삭제
    db.delete(matching)
    db.commit()

    return {"detail": "Matching request has been cancelled successfully"}
