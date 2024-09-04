from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from app.api.deps import get_db
from app.db.models import Adjective, InterestCategory, HouseType, ReportCategory

router = APIRouter()


@router.get("/adjectives", response_model=List[str], summary="형용사 목록 가져오기")
def get_adjectives(db: Session = Depends(get_db)):
    adjectives = db.query(Adjective.adj_name).all()
    return [adj[0] for adj in adjectives]


@router.get("/interests", response_model=List[str], summary="관심사 목록 가져오기")
def get_interest_categories(db: Session = Depends(get_db)):
    interest_categories = db.query(InterestCategory.interest_category_name).all()
    return [category[0] for category in interest_categories]

@router.get("/house-types", response_model=List[str], summary="주택유형 목록 가져오기")
def get_house_types(db: Session = Depends(get_db)):
    get_house_types = db.query(HouseType.house_type_name).all()
    return [category[0] for category in get_house_types]

@router.get("/report-types", response_model=List[str], summary="신고유형 목록 가져오기")
def get_report_types(db: Session = Depends(get_db)):
    get_report_types = db.query(ReportCategory.report_category_name).all()
    return [category[0] for category in get_report_types]