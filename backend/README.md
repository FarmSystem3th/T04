### 환경 변수 설정

- 이 프로젝트를 실행하기 위해서는 .env.example과 같은 환경 변수가 필요합니다.
- `.env` 파일을 생성하고, 해당 로컬 컴퓨터에 맞는 값으로 설정해 주세요.


### 종속성 설치

- 프로젝트의 종속성을 설치하려면 다음 명령어를 실행하세요:
    - pip install -r requirements.txt


### FastAPI 서버 실행

- FastAPI 서버를 실행하기 전에 MySQL 서버를 먼저 실행해야 합니다. 다음 명령어를 사용하여 MySQL 서버를 시작하세요:
    - mysql -u USERNAME -p 
    - USERNAME에는 DATABASE_URL에 사용한 USERNAME을 입력하면 됩니다. eg) mysql -u root -p

- backend 디렉토리로 이동한 후, FastAPI 서버를 실행하세요:
    - cd backend
    - uvicorn app.main:app --reload

- 서버는 기본적으로 http://127.0.0.1:8000 에서 실행됩니다.
- 서버가 정상적으로 실행되면, http://127.0.0.1:8000/docs 에서 API 문서를 확인할 수 있습니다. 

