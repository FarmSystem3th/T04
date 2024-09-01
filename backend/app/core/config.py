import os
from pydantic_settings import BaseSettings
from dotenv import load_dotenv

# .env 파일의 환경변수 로드
load_dotenv()

class Settings(BaseSettings):
    DATABASE_URL: str = os.getenv("DATABASE_URL")

    class Config:
        env_file = ".env"

settings = Settings()
