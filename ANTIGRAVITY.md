# ANTIGRAVITY — 멀티볼트 라우팅 허브

> 이 디렉토리는 여러 Obsidian 볼트를 관리하는 최상위 작업 디렉토리 시스템입니다.
> `CLAUDE.md`와 상호 보완적인 글로벌 지침서로 활용됩니다.
> 기본적으로 공통 강제 규칙은 `.claude/rules/`에 정의되어 자동 적용됩니다.

## 볼트 레지스트리 (Vault Registry)

| 볼트 ID | 경로 | 역할 | 로컬 규칙(Local Rules) |
|---------|------|------|------------------------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | **작업환경 원본(Hub)** — AI 작업환경 설계·개선·배포 허브 | `.antigravity/SESSION_RULES.md` |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | 범용 콘텐츠 저장소 | (추후 생성) |

## 글로벌 볼트 진입 프로토콜 (Global Entry Protocol)

다중 환경에서 작업을 수행할 때 반드시 다음 단계를 거칩니다.

1. **대상 볼트 식별**
   - 현재 목표로 하는 작업이 어느 볼트에 속하는지 우선 파악합니다.
   - 명시적인 경로가 주어지지 않았다면 작업 컨텍스트를 보고 볼트를 특정하거나, 전체 범위 검색을 선행합니다.

2. **로컬 환경 격리 (Local Environment Isolation)**
   - 각 볼트는 서로 다른 역할과 모드를 가질 수 있습니다 (예: AIHubVault 작업 vs 일반 노트정리).
   - **볼트 진입 시 필수 우선 읽기:** 해당 볼트에 `.antigravity/SESSION_RULES.md` 또는 `_STATUS.md`가 존재한다면 이 글로벌 가이드보다 **우선**하여 읽고 적용합니다.

3. **작업환경 동기화 검토** (대상 볼트 ≠ AIHubVault인 경우)
   - `{볼트경로}/_WORKSPACE_VERSION.md` 최상단 버전과 AIHubVault의 최상단 버전을 비교합니다.
   - 차이가 있으면 AIHubVault 기준으로 동기화를 수행한 후 작업을 시작합니다.
   - 상세: AIHubVault 내 `Contents/Project/plan/AIMindVaults_plan/20260311_허브_동기화_계획.md`

4. **교차 작업 (Cross-Vault Operations)**
   - 두 개 이상의 볼트를 수정하는 작업의 경우, 각 볼트 단위로 논리적 세션을 분리하여 순차적으로 실행합니다. (A 볼트 작업 완료 후 -> B 볼트 작업 진행)

## 워크플로우 (Workflows) 활용

`.antigravity/workflows/` 디렉토리에는 안티그래비티 기반의 전체 환경 관리, 자동화 처리 등의 글로벌 워크플로우 슬래시(`/`) 명령어 스크립트들이 위치합니다.
반복적이거나 절차가 복잡한 글로벌 프로세싱은 이곳에 정의하여 재사용성을 높입니다.

## 공통 강제 규칙 참조

아래 규칙은 `.claude/rules/`에 정의되어 모든 볼트 및 에이전트(Claude & Antigravity)에 자동 적용됩니다:
- 인코딩 안전 (`encoding-safety.md`)
- 편집 모드 분리 (`edit-mode-separation.md`)
- Post-Edit Review (`post-edit-review.md`)
- 스크립트 관리 (`script-management.md`)
- Juggl 스타일 동기화 (`juggl-style-sync.md`)
- 노트 작성 패턴 (`note-writing.md`)
