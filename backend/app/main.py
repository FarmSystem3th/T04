from fastapi import FastAPI
from app.api.endpoints import user, category
from app.db.session import engine, SessionLocal
from app.db.models import Base, UserSession



app = FastAPI()


@app.on_event("startup")
async def startup_event():
    # 데이터베이스 테이블 생성
    Base.metadata.create_all(bind=engine)

    # 모든 세션 삭제
    with SessionLocal() as db:
        db.query(UserSession).delete()
        db.commit()

    # OpenAPI 스키마 업데이트
    app.openapi_schema = custom_openapi()

def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema

    openapi_schema = app.openapi()

    # 보안 스키마 추가
    openapi_schema["components"]["securitySchemes"] = {
        "BearerAuth": {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "JWT"
        }
    }

    # 모든 경로에 보안 적용
    for path in openapi_schema["paths"]:
        for method in openapi_schema["paths"][path]:
            openapi_schema["paths"][path][method]["security"] = [{"BearerAuth": []}]

    app.openapi_schema = openapi_schema
    app.openapi_schema["security"] = [{"Bearer": []}]
    return app.openapi_schema



# 라우터 등록
app.include_router(user.router, prefix="/users", tags=["users"])
app.include_router(category.router, prefix="/categories", tags=["categories"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
