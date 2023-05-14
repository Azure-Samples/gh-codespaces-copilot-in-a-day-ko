# Session02 Code - Sheet

두 번째 세션에서 GitHub Copilot & Codespaces로 생성해야 할 코드 가이드라인/예시를 소개합니다.
라이브로 따라하지 못해도 해당 sheet 페이지를 통해 본인의 Copilot 결과와 비교하며 앱을 테스트하고 배포할 수 있습니다.

## Terraform 인프라: 프로비저닝

정답지 Sheet는 원 저장소 [session02-infra] 브랜치 내 terraform 폴더에 있습니다.
- https://github.com/Azure-Samples/gh-codespaces-copilot-in-a-day-ko/tree/session02-infra/terraform

### 1. `infra-k8s/main.tf`

* `required_providers` 정의: `azurerm`, `azurecaf`, `azapi` 3개의 provider를 필요로 함

![session02-required_providers 정의](../images/session02-required_providers.png)

> 버전은 `azurerm`은 `3.30.0`, `azurecaf`는 `1.2.16`와 같이 수동으로 맞출 수밖에 없음

* `backend` 정의

![session02-backend 정의](../images/session02-backend.png)

> `storage_account_name` 는 Azure에서 만든 결과를 사용합니다.

* TBD
  
![TBD](../images/session02-.png)


### 2. `infra-k8s/outputs.tf`

* 결과 대상: `resource_group`, `acr_name`, `cluster_name`, `cluster_fqdn`, `client_certificate`, `client_key`, `cluster_ca_certificate`, `kube_config`, `kube_config_raw`, `username`, `password`, `kubelet_identity`, `acr_fqdn`, `acr_admin_username`, `acr_admin_password`

* 중요 정보는 반드시 `sensitive = True` 를 설정해야 함

* 2개 모듈 정의 후 실제 value를 설정하는 것이 좋겠다.

### 3. `infra-k8s/variables.tf`

* 변수: `application_name`, `environment`, `location`, `acr_id`, `dns_prefix`

* `variable "변수명" {` 정도 입력하면 Copilot 제안이 나옴

### 4. 모듈 정의: `modules/acr`

### 5. 모듈 정의: `modules/aks`


## Sprint Boot API: 컨테이너화를 위한 코드

### 1. pom.xml

### 2. Dockerfile

## 그 외 참고를 위한 시트

### Azure API Management 설정 변경 화면

![session02-APIM 설정 변경 화면](../images/session02-azure-apim.png)

* TBD

