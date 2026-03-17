# AIMindVaults

> AI 에이전트와 함께 사용하는 Obsidian 멀티볼트 지식관리 시스템.

---

## 이것은 무엇인가?

여러 개의 Obsidian 볼트를 하나의 작업 디렉토리에서 관리하면서, AI 에이전트(Claude Code, Codex, Cursor 등)가 볼트 간 라우팅·동기화·편집 규칙을 자동으로 따르도록 설계된 시스템입니다.

### 핵심 개념

| 개념 | 설명 |
|------|------|
| **Hub & Spoke** | AIHubVault가 유일한 원본(Hub). 규칙·도구·표준 문서는 Hub에서만 편집하고, 다른 볼트(Spoke)로 자동 전파 |
| **Hub-Sync** | Spoke 볼트를 열 때 자동으로 Hub와 버전을 비교하고, 차이가 있으면 동기화 |
| **편집 모드 분리** | 콘텐츠 작업(`Contents/`)과 환경 작업(`_Standards/`, `_tools/` 등)을 혼합하지 않음 |
| **볼트 라우팅** | AI 에이전트가 사용자의 요청에서 대상 볼트를 자동 판별하고, 해당 볼트의 규칙을 따름 |
| **멀티 에이전트** | 여러 AI 에이전트가 같은 볼트에서 `_STATUS.md`로 상태를 공유하며 교대 작업 |

### 구조

```
AIMindVaults/                        ← 멀티볼트 루트 (AI 에이전트 작업 경로)
├── CLAUDE.md                        ← Claude Code 볼트 라우팅 허브
├── CODEX.md                         ← Codex 볼트 라우팅 허브
├── .claude/rules/                   ← 공통 AI 규칙 (모든 볼트에 자동 적용)
├── Vaults/
│   └── BasicVaults/
│       ├── AIHubVault/              ← 작업환경 원본 (Hub)
│       └── BasicContentsVault/      ← 범용 콘텐츠 저장소
└── References/                      ← 참조 전용 자료
```

---

## 시작하기

**상세 설치·설정 가이드:**  `Vaults/BasicVaults/AIHubVault/README.md`

### 빠른 시작

1. ZIP 다운로드 → 드라이브 루트 가까이에 압축 해제 (예: `C:\AIMindVaults/`)
2. Obsidian에서 `Vaults/BasicVaults/AIHubVault/`를 볼트로 등록
3. Shell Commands 플러그인 확인 (`syncworkspace` 명령 + `on-layout-ready` 이벤트)
4. AI 에이전트의 프로젝트 루트를 `AIMindVaults/`로 설정

---

## AI 에이전트 규칙 체계

이 시스템에서 AI 에이전트의 동작을 제어하는 규칙은 3계층으로 구성됩니다:

| 계층 | 위치 | 역할 | 적용 범위 |
|------|------|------|----------|
| 공통 규칙 | `.claude/rules/` | 모든 볼트에 자동 적용되는 강제 규칙 | 전체 |
| 볼트 규칙 | `{볼트}/CLAUDE.md` | 볼트별 역할·진입·편집 규칙 | 해당 볼트 |
| 운용 규칙 | `{볼트}/_WORKFLOW.md` | 상세 운용 절차 (상태 공유, 태그, CLI 등) | 해당 볼트 |

### 공통 규칙 목록 (`.claude/rules/`)

| 규칙 | 파일 | 요약 |
|------|------|------|
| 편집 모드 분리 | `edit-mode-separation.md` | Contents/workspace 모드 혼합 금지. workspace는 AIHubVault 전용 |
| 인코딩 안전 | `encoding-safety.md` | UTF-8 고정 I/O, 한국어 마크다운 재작성 금지, 대량 수정 단계적 실행 |
| Post-Edit Review | `post-edit-review.md` | 노트 편집 후 품질 검증 스크립트 필수 실행 |
| 노트 작성 패턴 | `note-writing.md` | 한국어 기본, YYYY-MM-DD, Frontmatter 필수, WikiLink 사용 |
| 스크립트 관리 | `script-management.md` | 중복 확인, 하드코딩 금지, Script_Registry 등록 필수 |
| 스크립트 생성 승인 | `script-creation-approval.md` | 새 스크립트 생성 전 사용자 승인 필수 |
| 세션 종료 | `session-exit.md` | 세션 종료 시 `_STATUS.md` 직접 갱신 필수 |
| 임시 파일 관리 | `temp-file-management.md` | `$env:TEMP`에만 생성, 볼트 내 임시 파일 방치 금지 |
| 토큰 절약 | `token-optimization.md` | 핀포인트 접근, 반복 읽기 금지, 고비용 작업 사전 보고 |
| Juggl 스타일 | `juggl-style-sync.md` | graph.css와 스타일 가이드 동시 갱신, 임베드 규칙 |
| 배포 동기화 | `distribution-sync.md` | 공통 규칙/워크스페이스 변경 시 배포 반영 확인 |

---

## 새 볼트 추가

1. `_forge/clone_vault.ps1`로 AIHubVault 복제 또는 수동 생성
2. `Vaults/` 하위 적절한 위치에 배치
3. Obsidian에서 볼트 등록 + Shell Commands 플러그인 설정
4. 루트 `CLAUDE.md` 볼트 레지스트리에 추가

---

## 상세 문서

| 문서 | 위치 | 내용 |
|------|------|------|
| 설치·설정 가이드 | `Vaults/BasicVaults/AIHubVault/README.md` | Prerequisites, Quick Start, 플러그인 목록 |
| 핵심 개념 | `Vaults/BasicVaults/AIHubVault/CORE_CONCEPTS.md` | Hub-Sync, 편집 모드, 라우팅 다이어그램 |
| 도구 목록 | `Vaults/BasicVaults/AIHubVault/_tools/TOOLS_INDEX.md` | 사용자용·AI전용 도구 인덱스 |
| 운용 규칙 | `Vaults/BasicVaults/AIHubVault/_WORKFLOW.md` | 세션 부트스트랩, 상태 공유, 태그, CLI |

---

## License

MIT
