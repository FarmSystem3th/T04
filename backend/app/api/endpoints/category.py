from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from app.api.deps import get_db
from app.db.models import Adjective, InterestCategory, HouseType, ReportCategory
from pydantic import BaseModel

router = APIRouter()

class CategoryResponse(BaseModel):
    id: int
    name: str


@router.get("/adjectives", response_model=List[CategoryResponse], summary="형용사 목록 가져오기")
def get_adjectives(db: Session = Depends(get_db)):
    adjectives = db.query(Adjective.adj_id, Adjective.adj_name).all()
    return [{"id": adj[0], "name": adj[1]} for adj in adjectives]


@router.get("/interests", response_model=List[CategoryResponse], summary="관심사 목록 가져오기")
def get_interest_categories(db: Session = Depends(get_db)):
    interest_categories = db.query(InterestCategory.interest_category_id, InterestCategory.interest_category_name).all()
    return [{"id": category[0], "name": category[1]} for category in interest_categories]


@router.get("/house-types", response_model=List[CategoryResponse], summary="주택유형 목록 가져오기")
def get_house_types(db: Session = Depends(get_db)):
    house_types = db.query(HouseType.house_type_id, HouseType.house_type_name).all()
    return [{"id": category[0], "name": category[1]} for category in house_types]


@router.get("/report-types", response_model=List[CategoryResponse], summary="신고유형 목록 가져오기")
def get_report_types(db: Session = Depends(get_db)):
    report_types = db.query(ReportCategory.report_category_id, ReportCategory.report_category_name).all()
    return [{"id": category[0], "name": category[1]} for category in report_types]
