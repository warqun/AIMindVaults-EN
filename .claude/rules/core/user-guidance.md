# 유저 가이드 (Mandatory)

> 모든 볼트에 동일 적용. 모든 에이전트 공통.
> 유저가 AIMindVaults 코어 기능 사용 중 막히거나 헷갈려하면 에이전트가 아래 가이드를 참조하여 안내한다.

## 적용 원칙

- 유저가 절차를 모르거나 잘못된 방법으로 시도하면, 올바른 절차를 간결하게 안내한다.
- 유저가 명시적으로 묻지 않아도, 잘못된 시도를 감지하면 선제적으로 안내한다.
- 안내는 해당 상황에 필요한 최소 정보만 전달. 전체 규칙을 읊지 않는다.

---

## 1. 새 볼트를 Obsidian에서 열기

### 유저가 막히는 상황
- 새로 생성한 볼트를 Obsidian에서 열고 싶은데 방법을 모름
- `obsidian://open?path=`로 열었더니 로딩이 매우 느림

### 안내
> Obsidian 볼트 매니저 → "보관함 폴더 열기" → 볼트 경로 선택

- `obsidian://open?path=` URI로 미등록 볼트를 열면 앱 상태 전환 + 등록 + 플러그인 로드가 동시에 일어나 매우 느리다.
- URI는 **이미 등록된 볼트 전환** (`obsidian://open?vault=볼트명`) 용도로만 사용한다.
- 에이전트도 미등록 볼트에 `obsidian://open?path=`를 사용하지 않는다.

---

## 2. 볼트 생성

### 유저가 막히는 상황
- 폴더를 직접 복사해서 새 볼트를 만들려고 함
- 어디에 볼트를 만들어야 할지 모름
- 생성 후 뭘 해야 하는지 모름

### 안내
- **생성 방법**: `/create-vault` 스킬 또는 `BasicContentsVault/.sync/clone_vault.ps1` 사용. 수동 복사 금지.
- **위치 선택**: 용도에 맞는 카테고리 안내 (Domains_Game, Domains_Infra, Projects_Game 등)
- **생성 후 필수**: CLAUDE.md 개별화, _STATUS.md 초기화, 루트 레지스트리 등록, Obsidian 등록(볼트 매니저에서 직접)

---

## 3. 노트는 어느 볼트에 넣어야 하는지

### 유저가 막히는 상황
- 노트를 작성하려는데 어떤 볼트에 넣어야 할지 모름
- 비슷한 볼트가 여러 개라 혼동

### 안내
- `_STATUS.md` 볼트 레지스트리에서 카테고리별 볼트 목록을 보여준다.
- 키워드로 적합한 볼트를 추천한다 (CLAUDE.md 라우팅 규칙 참조).
- 적합한 볼트가 없으면 새 볼트 생성을 제안한다.
- BasicContentsVault에는 콘텐츠를 넣지 않는다 (클론 템플릿 전용).

---

## 4. 편집 모드 혼동

### 유저가 막히는 상황
- 노트 편집 중에 워크스페이스 파일도 수정하고 싶음
- 어떤 파일이 Contents 모드이고 어떤 게 Workspace 모드인지 모름

### 안내
- `Contents/**` = Contents 모드. 노트 작성/수정.
- `.sync/`, `.claude/`, 볼트 루트 파일 = Workspace 모드. AIHubVault에서만 수정.
- 한 작업에서 두 모드를 혼합하지 않는다. 모드 전환 시 선언.
- "이 파일은 workspace 편집이라 AIHubVault에서 수정해야 합니다" 식으로 안내.

---

## 5. Workspace 동기화

### 유저가 막히는 상황
- 다른 볼트에서 직접 `.sync/` 파일을 수정하려고 함
- 볼트 간 설정이 다른 것 같은데 왜 그런지 모름
- 동기화가 안 된 것 같음

### 안내
- Workspace 편집은 AIHubVault에서만. 다른 볼트는 동기화로 자동 전파.
- `_WORKSPACE_VERSION.md` 버전을 비교하여 차이가 있으면 동기화 수행.
- 동기화 실행: 볼트를 Obsidian에서 열면 자동 실행. 수동: `pre_sync.ps1`.

---

## 6. 플러그인 설치/설정

### 유저가 막히는 상황
- 특정 볼트에 플러그인을 직접 설치하려고 함
- 플러그인 설정을 바꿨는데 다른 볼트에는 적용 안 됨

### 안내
- 플러그인 설치/설정 변경은 AIHubVault에서 수행 → 동기화로 전파.
- `/install-plugin` 스킬 사용 권장.
- `.obsidian/` 편집은 Workspace 모드. `_WORKSPACE_VERSION.md` 버전 기록 필수.

---

## 7. 세션 종료

### 유저가 막히는 상황
- 작업을 끝냈는데 뭘 정리해야 하는지 모름
- _STATUS.md만 갱신하고 핸드오프를 잊음

### 안내
- `/vault-update` 스킬로 세션 종료 루틴을 실행하면 자동 처리.
- 수동 시: 볼트 `_STATUS.md` + 루트 `_STATUS.md` + `_SESSION_HANDOFF_{에이전트}.md` 3개 모두 갱신.
- 하나라도 빠지면 세션 종료 불완전.

---

## 8. 노트 작성 후 검증

### 유저가 막히는 상황
- 노트를 작성했는데 리뷰/인덱싱을 안 했음
- POST_EDIT_REVIEW_BAD가 0이 아닌데 뭘 해야 할지 모름
- 인덱싱이 안 된 것 같음

### 안내
- 노트 편집 후 `post_note_edit_review.ps1` 실행 필수.
- BAD가 0이 아니면 해당 파일의 문제(frontmatter 누락, 인코딩 등)를 수정.
- 인덱싱(`POST_EDIT_INDEX_UPDATED=1`)까지 확인해야 작업 완료.
- 인덱싱 실패 시 수동: `vault_index_build.ps1 -VaultRoot {볼트경로} -Incremental`

---

## 9. 콘텐츠 검색

### 유저가 막히는 상황
- 노트를 찾고 싶은데 어디 있는지 모름
- Grep/Glob으로 전체 스캔을 하려고 함

### 안내
- **인덱서를 먼저 사용**: `vault_index_search.ps1 -Query "검색어"`
- 인덱서 결과가 없을 때만 Grep/Glob 사용.
- 인덱스가 오래된 것 같으면 `/reindex` 실행.

---

## 10. 무한 재귀 경로 삭제

### 유저가 막히는 상황
- clone_vault 등으로 무한 재귀 폴더가 생김
- 일반 삭제(rm, Remove-Item, rd)가 전부 실패

### 안내
- 상세 해결법: `temp-file-management.md` § "무한 재귀 경로 삭제 (Incident Rule)"
- 1순위: PowerShell flatten-and-delete
- 2순위: robocopy mirror 반복
- 7z, Remove-Item, rd, .NET Delete는 모두 실패한다.

---

## 11. 스크립트 생성

### 유저가 막히는 상황
- 에이전트가 자동으로 스크립트를 만들어서 실행하려고 함
- 기존 스크립트와 중복되는 스크립트를 만들려고 함

### 안내
- 스크립트 생성 전 반드시 사용자 승인. 목적, 경로, 영향 범위 보고.
- `Script_Registry.md`에서 중복 확인. 기존 스크립트 확장으로 해결 가능하면 새로 만들지 않는다.

---

## 12. 배포 동기화

### 유저가 막히는 상황
- 코어 규칙을 수정했는데 배포에 반영하는 법을 모름
- SellingVault가 뭔지 모름

### 안내
- 코어 규칙/스킬 변경은 배포 대상. `_ROOT_VERSION.md`에 기록.
- 배포 경로: SellingVault (`C:\SellingVault\Korean\AIMindVaults`).
- 배포 + git push는 사용자가 명시적으로 요청한 경우에만 수행.
