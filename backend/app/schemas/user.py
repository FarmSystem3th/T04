from dataclasses import Field
from typing import List, Optional
from pydantic import BaseModel, Field

## 프로필
class UserProfileResponse(BaseModel):
    user_type: int
    user_nickname: Optional[str]
    user_sido: Optional[str]
    user_sigungu: Optional[str]
    age: Optional[int]
    k_age: Optional[int]
    user_lifeservice: Optional[str]
    bedtime: Optional[str]   # 'HH:MM' 형식의 문자열
    wakeup_time: Optional[str]   # 'HH:MM' 형식의 문자열
    user_adjective: Optional[List[str]]
    user_interest: Optional[List[str]]
    user_want_adjective: Optional[List[str]]
    user_biography: Optional[str]
    has_disease: Optional[str]
    has_pet: Optional[str]

class UserProfileUpdate(BaseModel):
    user_nickname: Optional[str] = Field(None, example = "닉네임")
    life_service: Optional[str] = Field(None, example = "생활서비스")
    bedtime: Optional[str] = Field(None, description = "'HH:MM' 형식의 문자열", example="23:00")  # 'HH:MM' 형식의 문자열
    wakeup_time: Optional[str] = Field(None, description = "'HH:MM' 형식의 문자열", example="09:00") # 'HH:MM' 형식의 문자열
    user_adjective: Optional[List[str]] = Field(None, example = ["밝은", "용감한"])
    user_interest: Optional[List[str]] = Field(None, example = ["골프", "요가"])
    user_want_adjective: Optional[List[str]] = Field(None, example = ["겸손한", "신중한"])
    user_biography: Optional[str] = Field(None, example = "자기소개")
    has_disease: Optional[bool] = Field(None, example = False)
    has_pet: Optional[bool] = Field(None, example = False)

    class Config:
        orm_mode = True

class UpdateResponseMessage(BaseModel):
    message: str

# 회원가입
class SignUp(BaseModel):
    user_name: str
    user_password: str

# 로그인
class Login(BaseModel):
    user_name: str = Field(example = "yyun")
    password: str = Field(example = "IoQ5MwmOLB")

class TokenData(BaseModel):
    user_id: Optional[str] = None
