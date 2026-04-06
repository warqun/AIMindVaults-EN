# AIMindVaults — 멀티볼트 라우팅 허브

> 이 디렉토리는 여러 Obsidian 볼트를 관리하는 최상위 작업 디렉토리.
> 개별 볼트 작업 시 반드시 볼트 진입 프로토콜을 따른다.
> 공통 강제 규칙은 `.claude/rules/`에 정의되어 자동 적용.

## 볼트 레지스트리

### BasicVaults (작업환경 허브)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | **작업환경 원본(Hub)** — AI 작업환경 설계·개선·배포 허브 | active |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | 범용 콘텐츠 저장소 | active |

### Domains (도메인 지식 볼트)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| Unity | `Vaults/Domains_Game/Unity/` | Unity 엔진 도메인 지식 | active |
| CapCut | `Vaults/Domains_Video/CapCut/` | CapCut 영상편집 도메인 지식 | active |
| Notion | `Vaults/Domains_Infra/Notion/` | Notion 워크스페이스 운영 도메인 지식 | active |
| CICD | `Vaults/Domains_Infra/CICD/` | CI/CD 및 배포 동기화 도메인 지식 | active |
| Search | `Vaults/Domains_Infra/Search/` | 검색 엔진, 인덱싱, 텍스트 매칭 도메인 지식 | active |
| AI | `Vaults/Domains_Infra/AI/` | AI 활용 기술 도메인 지식 (에이전트, 프롬프트, 도구 가이드) | active |
| AppFlowy | `Vaults/Domains_Infra/AppFlowy/` | AppFlowy 셀프호스트 설치·운영·이관 도메인 지식 | active |
| GameArt | `Vaults/Domains_Game/GameArt/` | 게임 아트/비주얼 프로덕션 기법 도메인 지식 | active |

### Labs (도메인+프로젝트 복합 볼트)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| ObsidianDev | `Vaults/Lab_Infra/ObsidianDev/` | Obsidian 플러그인 개발 (지식 축적 + 실제 개발) | active |

### Projects_GameTool (게임 개발 도구)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| CombatToolKit | `Vaults/Projects_GameTool/CombatToolKit/` | 게임 전투 시스템 개발 툴킷 | active |
| TileMapToolKit | `Vaults/Projects_GameTool/TileMapToolKit/` | 타일맵 시스템 개발 툴킷 | active |

### Projects_Game (게임 개발 프로젝트)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| JissouGame | `Vaults/Projects_Game/JissouGame/` | Unity 기반 게임 개발 프로젝트 | active |

### Projects_Infra (인프라 프로젝트)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| Project_AIMindVaults | `Vaults/Projects_Infra/Project_AIMindVaults/` | AIMindVaults 멀티볼트 시스템 프로젝트 | active |

### Personal (개인 기록)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| Diary | `Vaults/Personal/Diary/` | 개인 다이어리, 회고, 성장 로그 | active |

### References (참조 전용)

| 볼트 ID | 경로 | 역할 | 상태 |
|---------|------|------|------|
| Unity_Documentation | `References/Unity_Documentation/` | Unity 6.3 공식 매뉴얼·스크립트 API (조회 전용) | readonly |

### 기타 루트 폴더

| 폴더 | 용도 |
|------|------|
| `Archives/` | 볼트 형태가 아닌 일반 자료 보관 |
| `Backup/` | 백업 |

## 볼트 진입 프로토콜 (강제)

1. **대상 볼트 식별**
   - 명시적 지정: "AIHubVault에서 ~", "BasicContentsVault ~"
   - 키워드 추론:
     - "_Standards", ".forge", "workspace", "동기화 스크립트" → AIHubVault (workspace 전용 Hub)
     - "콘텐츠", "노트 작성", "지식 관리" → BasicContentsVault
     - "Unity", "유니티 엔진" → Vaults/Domains_Game/Unity
     - "CapCut", "영상편집" → Vaults/Domains_Video/CapCut
     - "Notion", "노션 운영" → Vaults/Domains_Infra/Notion
     - "CI/CD", "배포 동기화", "파이프라인" → Vaults/Domains_Infra/CICD
     - "검색", "인덱싱", "인덱서", "텍스트 매칭", "Search" → Vaults/Domains_Infra/Search
     - "AI 활용", "에이전트 활용법", "프롬프트", "AI 도구" → Vaults/Domains_Infra/AI
     - "AppFlowy", "셀프호스트", "Notion 이관" → Vaults/Domains_Infra/AppFlowy
     - "AIMindVaults 프로젝트", "멀티볼트 계획", "배포 계획" → Vaults/Projects_Infra/Project_AIMindVaults
     - "Obsidian 플러그인", "플러그인 개발" → Vaults/Lab_Infra/ObsidianDev
     - "전투 시스템", "CombatToolKit", "스킬 시스템", "이펙트 패키지", "뱀서" → Vaults/Projects_GameTool/CombatToolKit
     - "타일맵", "TileMap", "맵 생성", "청크", "절차적 생성" → Vaults/Projects_GameTool/TileMapToolKit
     - "JissouGame", "지쏘우", "jissou" → Vaults/Projects_Game/JissouGame
     - "게임 아트", "비주얼 기법", "Fake 2D", "렌더링 스타일", "셰이더 스타일" → Vaults/Domains_Game/GameArt
     - "다이어리", "회고", "성장 기록", "개인 메모" → Vaults/Personal/Diary
     - "Unity 매뉴얼", "스크립트 API", "Unity 문서" → References/Unity_Documentation (readonly)
   - 파일 경로 포함 시 → 경로에서 볼트 추출
   - 모호하면 → 사용자에게 확인

2. **볼트 진입 시 필수 읽기** (순서대로)
   - `_SESSION_HANDOFF_CLAUDE.md` (루트) — Claude 이전 세션 맥락, 변경 파일, 미완료 항목 파악
   - `_SESSION_HANDOFF_CODEX.md` (루트) — Codex 이전 세션 맥락 (충돌/연계 확인)
   - `_STATUS.md` (루트) — 전체 볼트 현황 파악 + 다른 볼트 작업과 충돌/연계 확인
   - `{볼트경로}/CLAUDE.md` — 볼트 전용 규칙
   - `{볼트경로}/_STATUS.md` — 현재 진행 상황

3. **작업환경 동기화 검토** (대상 볼트 ≠ AIHubVault인 경우)
   - `{볼트경로}/_WORKSPACE_VERSION.md` 최상단 버전과 AIHubVault의 최상단 버전 비교
   - 차이 있으면 → AIHubVault 기준으로 동기화 수행 후 작업 시작
   - 상세 프로토콜: AIHubVault `Contents/Project/plan/AIMindVaults_plan/20260311_허브_동기화_계획.md`

4. **교차 작업 규칙**
   - 2개 이상 볼트를 수정하는 경우, 볼트별로 분리하여 순차 실행
   - 볼트 전환 시 현재 볼트의 편집을 완결한 후 전환

## 루트 작업 범위

루트에서 직접 수정 가능한 대상:
- `_STATUS.md` (멀티볼트 상태 허브)
- `CLAUDE.md` (이 파일)
- `CODEX.md` (Codex 루트 진입점)
- `.claude/` (루트 Claude 설정)
- `.codex/` (루트 Codex 설정)
- `.cursor/` (루트 Cursor 설정)
- `docs/` (루트 문서)

볼트 내부 파일은 볼트 진입 프로토콜을 거친 후에만 수정한다.

## 공통 강제 규칙 참조

아래 규칙은 `.claude/rules/core/`에 정의되어 모든 볼트에 자동 적용:
- 인코딩 안전 (`encoding-safety.md`)
- 편집 모드 분리 (`edit-mode-separation.md`)
- Post-Edit Review (`post-edit-review.md`)
- 스크립트 관리 (`script-management.md`)
- Juggl 스타일 동기화 (`juggl-style-sync.md`)
- 노트 작성 패턴 (`note-writing.md`)
- 볼트 라우팅 (`vault-routing.md`)
- 세션 종료 (`session-exit.md`)
- 토큰 최적화 (`token-optimization.md`)
- 임시 파일 관리 (`temp-file-management.md`)
- 스크립트 생성 승인 (`script-creation-approval.md`)
- 배포 동기화 (`distribution-sync.md`)
- Obsidian 설정 안전 편집 (`obsidian-config-safety.md`)
- 볼트 개별화 (`vault-individualization.md`)

### 사용자 개인화 규칙

아래 규칙은 `.claude/rules/custom/`에 정의. 배포 동기화 대상 아님:
- 멀티볼트 개인화 (`multivault-personalization.md`) — 에이전트/플러그인/스킬 커스텀 설정

### 에이전트 필수 준수 사항

- **볼트 생성 시**: `vault-individualization.md` 규칙을 따라 이름/분류/CLAUDE.md/태그를 구체화한다.
- **멀티볼트 커스텀 설정 시**: `multivault-personalization.md`를 참조하여 사용자의 에이전트/플러그인 선택을 반영한다.
- **에이전트 진입점 파일** (`CLAUDE.md`, `CODEX.md`, `AGENT_STATUS.md`)은 볼트 개별 파일이므로 배포 동기화에 포함하지 않는다.

### 네임스페이스 구조

```
.claude/rules/core/     ← 배포 규칙 (동기화 대상)
.claude/rules/custom/   ← 사용자 규칙 (동기화 미대상)
.claude/commands/core/   ← 배포 스킬 (동기화 대상)
.claude/commands/custom/ ← 사용자 스킬 (동기화 미대상)
```

각 폴더의 `MANIFEST.md`에 배포 파일 목록이 명시되어 있다.
