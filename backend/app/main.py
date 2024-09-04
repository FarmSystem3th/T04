from fastapi import FastAPI
from app.api.endpoints import user, category

app = FastAPI()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

# 라우터 등록
app.include_router(user.router, prefix="/users", tags=["users"])
app.include_router(category.router, prefix="/categories", tags=["categories"])
