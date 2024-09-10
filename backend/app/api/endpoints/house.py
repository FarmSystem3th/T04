from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.models import House, HouseType
from app.api.deps import get_db
from app.schemas.house import HouseResponse, HouseUpdate
from typing import List

router = APIRouter()

# 주택 정보를 가져오는 함수 (house_type_id를 house_type_name으로 변환)
def get_house_with_type_name(db: Session, house_id: str) -> HouseResponse:
    house = db.query(House).filter(House.house_id == house_id).first()
    if not house:
        raise HTTPException(status_code=404, detail="House not found")

    house_type = db.query(HouseType).filter(HouseType.house_type_id == house.house_type_id).first()
    house_type_name = house_type.house_type_name if house_type else "Unknown"

    return HouseResponse(
        house_id=house.house_id,
        user_id=house.user_id,
        house_duration=house.house_duration,
        house_type_name=house_type_name,
        house_room=house.house_room,
        house_bathroom=house.house_bathroom,
        house_elevator=house.house_elevator,
        house_area=house.house_area,
        register_date=house.register_date.strftime('%Y-%m-%d'),
        is_matched=house.is_matched,
        house_eupmyeondong=house.house_eupmyeondong,
        house_sido=house.house_sido,
        house_sigungu=house.house_sigungu
    )



@router.get("/{house_id}", response_model=HouseResponse, summary="주택 정보 조회")
def get_house_info(user_id: str, db: Session = Depends(get_db)):
    house = db.query(House).filter(House.user_id == user_id).first()
    if not house:
        raise HTTPException(status_code=404, detail="House not found")

    # Fetch house type name
    house_type = db.query(HouseType).filter(HouseType.house_type_id == house.house_type_id).first()
    house_type_name = house_type.house_type_name if house_type else "Unknown"

    return HouseResponse(
        house_id=house.house_id,
        user_id=house.user_id,
        house_duration=house.house_duration,
        house_type_name=house_type_name,
        house_room=house.house_room,
        house_bathroom=house.house_bathroom,
        house_elevator=house.house_elevator,
        house_area=house.house_area,
        register_date=house.register_date.strftime('%Y-%m-%d'),
        is_matched=house.is_matched,
        house_eupmyeondong=house.house_eupmyeondong,
        house_sido=house.house_sido,
        house_sigungu=house.house_sigungu
    )

# 사용자 ID로 주택 정보 가져오기
@router.get("/user/{user_id}", response_model=List[HouseResponse], summary="사용자 ID로 주택 정보 조회")
def get_houses_by_user(user_id: int, db: Session = Depends(get_db)):
    houses = db.query(House).filter(House.user_id == user_id).all()
    if not houses:
        raise HTTPException(status_code=404, detail="No houses found for this user")

    # 모든 주택 정보를 house_type_name으로 변환
    result = []
    for house in houses:
        house_type = db.query(HouseType).filter(HouseType.house_type_id == house.house_type_id).first()
        house_type_name = house_type.house_type_name if house_type else "Unknown"

        result.append(HouseResponse(
            house_id=house.house_id,
            user_id=house.user_id,
            house_duration=house.house_duration,
            house_type_name=house_type_name,
            house_room=house.house_room,
            house_bathroom=house.house_bathroom,
            house_elevator=house.house_elevator,
            house_area=house.house_area,
            register_date=house.register_date.strftime('%Y-%m-%d'),
            is_matched=house.is_matched,
            house_eupmyeondong=house.house_eupmyeondong,
            house_sido=house.house_sido,
            house_sigungu=house.house_sigungu
        ))

    return result

# 주택 정보 수정
@router.put("/{house_id}", response_model=HouseResponse, summary="주택 정보 수정")
def update_house(house_id: str, house_update: HouseUpdate, db: Session = Depends(get_db)):
    house = db.query(House).filter(House.house_id == house_id).first()
    if not house:
        raise HTTPException(status_code=404, detail="House not found")

    # 주택 정보 업데이트
    for key, value in house_update.dict(exclude_unset=True).items():
        setattr(house, key, value)

    # house_type_name 업데이트
    house_type = db.query(HouseType).filter(HouseType.house_type_name == house_update.house_type).first()
    if house_type:
        house.house_type_id = house_type.house_type_id

    db.commit()
    db.refresh(house)

    return get_house_with_type_name(db, house_id)

# 주택 정보 삭제
@router.delete("/{house_id}", summary="주택 정보 삭제")
def delete_house(house_id: str, db: Session = Depends(get_db)):
    house = db.query(House).filter(House.house_id == house_id).first()
    if not house:
        raise HTTPException(status_code=404, detail="House not found")

    db.delete(house)
    db.commit()

    return {"detail": "House deleted successfully"}