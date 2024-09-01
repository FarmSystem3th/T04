import os
from dotenv import load_dotenv

# .env 파일을 로드
load_dotenv()

# 환경 변수에서의 설정 값 가져오기
DATABASE_URL = os.getenv("DATABASE_URL")

