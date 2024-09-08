import os
from pydantic_settings import BaseSettings
from dotenv import load_dotenv

# .env 파일의 환경변수 로드
load_dotenv()

class Settings(BaseSettings):
    DATABASE_URL: str = os.getenv("DATABASE_URL")
    SECRET_KEY: str = os.getenv("SECRET_KEY")
    ALGORITHM: ClassVar[str] = 'HS256'
    ACCESS_TOKEN_EXPIRE_MINUTES : int = 120

    class Config:
        env_file = ".env"

settings = Settings()
