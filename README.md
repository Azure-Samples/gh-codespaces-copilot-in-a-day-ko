# GitHub Codespaces와 Copilot으로 앱 만들어 보기

Java 기반의 Spring 백엔드와 React 기반의 프론트엔드 앱을 GitHub Codespaces 안에서 GitHub Copilot을 이용해서 빌드하고 애저 및 파워 앱에 배포하는 핸즈온랩입니다.


## 목표

이 핸즈온랩을 끝마치면 여러분은 아래와 같은 내용을 학습할 수 있습니다.

- 인프라스트럭처
  - GitHub Codespaces
  - GitHub Copilot
  - 애저 Bicep
  - 애저 Terraform
- 프론트엔드 애플리케이션
  - 애저 정적 웹 앱 &ndash; React 기반
  - 파워 앱 &ndash; 파워 플랫폼 기반
- 백엔드 애플리케이션
  - 애저 앱서비스 &ndash; Spring 기반
  - 애저 Kubernetes 서비스 (AKS) &ndash; Spring 기반


## 기본 아키텍처

TBD


## 시작하기

### 스프링 앱 로컬 테스트

1. 프론트엔드(리액트) 빌드

   ```bash
   cd web
   npm install
   npm start
   ```

2. 백엔드(Java) 빌드
    - Terminal

   ```bash
   cd api
   mvn spring-boot:run
   ```

    - VSCode에서 Run Java를 이용
    ![java_run](/images/java_run.png)

3. 브라우저에서 http://localhost:3000/ 접속


### 사전 준비사항

TBD


### 설치 및 배포

TBD


### 퀵스타트 1 &ndash; 애저 Bicep 이용

1. 이 리포지토리를 자신의 계정으로 포크합니다.
2. 아래 명령어를 차례대로 실행시켜 애저에 리소스를 프로비저닝합니다.

    ```bash
    azd login
    azd init
    azd pipeline config
    azd up
    ```

   > GitHub Codespaces를 사용할 경우에는 `azd login` 대신 `azd login --use-device-code=false` 명령어를 사용해야 합니다.

3. 아래 명령어를 차례로 실행시켜 애플리케이션을 배포합니다. 아래 `{{GitHub ID}}`는 자신의 GitHub ID를 가리킵니다.

    ```bash
    gh auth login

    GITHUB_USERNAME="{{GitHub ID}}"
    gh workflow run "Azure Dev" --repo $GITHUB_USERNAME/gh-codespaces-copilot-in-a-day-ko
    ```

   > 만약 `gh auth login` 명령어를 실행시키는 도중 에러가 발생하면 `GITHUB_TOKEN=` 명령어를 실행히켜 토큰을 초기화한 후 다시 실행시킵니다.


### 퀵스타트 2 &ndash; 애저 Terraform 이용

TBD


### 퀵스타트 3 &ndash; 파워 앱 이용

TBD


## 참고 자료 및 추가 학습 자료

TBD
