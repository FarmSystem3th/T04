from fastapi import FastAPI
from app.api.endpoints import user

app = FastAPI()

# 라우터 등록
app.include_router(user.router, prefix="/api", tags=["user"])
