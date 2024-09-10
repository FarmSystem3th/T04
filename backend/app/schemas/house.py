from pydantic import BaseModel, Field
from typing import Optional

class HouseResponse(BaseModel):
    house_id: str
    user_id: int
    house_duration: int
    house_type_name: str
    house_room: int
    house_bathroom: int
    house_elevator: Optional[bool] = None
    house_area: int
    register_date: str
    is_matched: bool
    house_eupmyeondong: Optional[str] = None
    house_sido: Optional[str] = None
    house_sigungu: Optional[str] = None

    class Config:
        orm_mode = True

class HouseUpdate(BaseModel):
    house_duration: Optional[int] = Field(None, description="주택 임대 기간 (개월)")
    house_type_id: Optional[int] = Field(None, description="주택 유형 ID")
    house_room: Optional[int] = Field(None, description="방 개수")
    house_bathroom: Optional[int] = Field(None, description="욕실 개수")
    house_elevator: Optional[bool] = Field(None, description="엘리베이터 유무")
    house_area: Optional[int] = Field(None, description="주택 면적 (제곱미터)")
    house_eupmyeondong: Optional[str] = Field(None, description="읍면동")
    house_sido: Optional[str] = Field(None, description="시도")
    house_sigungu: Optional[str] = Field(None, description="시군구")

    class Config:
        orm_mode = True