from typing import List, Optional
from pydantic import BaseModel

class UserProfileResponse(BaseModel):
    user_type: int
    user_nickname: Optional[str]
    user_sido: Optional[str]
    user_sigungu: Optional[str]
    age: Optional[int]
    k_age: Optional[int]
    user_lifeservice: str
    bedtime: Optional[str]
    wakeup_time: Optional[str]
    user_adjective: List[str]
    user_interest: List[str]
    user_want_adjective: List[str]
    user_biography: Optional[str]
    has_disease: str
    has_pet: str
