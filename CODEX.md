# AIMindVaults — Codex Multi-Vault Hub

> This is the root Codex entry for the AIMindVaults multi-vault hub.
> Use it to route work to the correct vault or stay at root for shared agent configuration work.
> Detailed Codex rules live in `.codex/`.

## Read First

1. `.codex/CODEX.md`
2. `.codex/rules/vault-routing.md`
3. `.codex/rules/edit-scope.md`
4. `.codex/rules/status-sync.md`
5. `.codex/rules/encoding-safety.md`
6. `.codex/AGENT_STATUS.md`

## Vault Entry Protocol

1. Identify the target vault
2. Read `_STATUS.md` (루트) — 전체 볼트 현황 + 다른 볼트 작업 확인
3. Read `{vault}/.codex/CODEX.md`
4. Read `{vault}/_STATUS.md`
4. Read any additional local rules needed for the task

## Vault Registry

| Vault ID | Path | Role | Status |
|---------|------|------|------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | AI 작업환경 설계·개선·배포 허브 | active |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | 범용 콘텐츠 저장소 | active |

## Obsidian 노트 열기 (Mandatory)

> 이 환경의 모든 `.md` 노트는 **Obsidian 볼트** 안에 있다.
> 사용자가 "노트 띄워줘", "열어줘"라고 하면 **Obsidian에서 해당 노트를 포커스해서 여는 것**을 의미한다.
> VS Code나 기본 텍스트 에디터로 여는 것이 아니다.

### 문제: `Start-Process <파일경로.md>`는 Obsidian이 아닌 다른 앱으로 열린다

```powershell
# ❌ 금지 — 아래 방식은 전부 VS Code 또는 기본 앱으로 열린다
Start-Process "C:\AIMindVaults\Vaults\...\노트.md"
Start-Process -FilePath ".\Contents\Project\노트.md"
code "C:\AIMindVaults\Vaults\...\노트.md"
Invoke-Item ".\노트.md"
```

이유:
- Windows는 `.md` 확장자의 **파일 연결(file association)** 을 따른다
- 이 시스템에서 `.md`는 VS Code에 연결되어 있다
- 파일 연결을 Obsidian으로 바꿔도 **어느 볼트에서 열지** 판단할 수 없다 (같은 파일이 여러 볼트에 존재 가능)
- "파일을 여는 것"과 "Obsidian에서 해당 볼트의 노트를 포커스하는 것"은 다른 동작이다

### 해결: Obsidian URI 스킴 사용

```powershell
# ✅ 올바른 방법 — Obsidian URI
Start-Process 'obsidian://open?vault=볼트명&file=볼트루트기준_상대경로'
```

### 파라미터 규칙

| 파라미터 | 설명 | 예시 |
|----------|------|------|
| `vault` | Obsidian에 등록된 볼트 **폴더명** | `CombatToolKit`, `JissouGame`, `AIHubVault` |
| `file` | 볼트 루트 기준 상대 경로. **`.md` 확장자 생략** | `Contents/Project/01-concept/실장석_핵심_게임구조` |

- 경로 구분자: `/` 사용 (`\` 아님)
- 한글 파일명: 그대로 사용 (URL 인코딩 불필요 — Obsidian이 자체 처리)
- 공백 포함 파일명: 그대로 사용 가능

### 볼트별 실제 명령 예시

```powershell
# CombatToolKit 볼트
Start-Process 'obsidian://open?vault=CombatToolKit&file=Contents/Project/issues/spec/SISS_S2D_H6_DoTManager'

# JissouGame 볼트
Start-Process 'obsidian://open?vault=JissouGame&file=Contents/Project/01-concept/실장석_핵심_게임구조'

# AIHubVault 볼트
Start-Process 'obsidian://open?vault=AIHubVault&file=Contents/Domain/20260301_Example_Note'

# TileMapToolKit 볼트
Start-Process 'obsidian://open?vault=TileMapToolKit&file=Contents/Project/some_note'
```

### 주의사항

- Obsidian이 실행 중이어야 한다 (실행 중이 아니면 URI가 Obsidian을 시작시키지만, 볼트가 열려 있지 않으면 실패할 수 있다)
- 볼트가 Obsidian에 등록되어 있어야 한다 (이 환경의 모든 볼트는 등록 완료)
- 여러 볼트가 동시에 열려 있어도 `vault` 파라미터로 정확히 대상 지정된다
- 파일이 존재하지 않으면 Obsidian이 새 노트 생성을 제안할 수 있으므로, 경로를 정확히 확인한 후 호출한다

---

## Root Work Scope

- `CODEX.md`
- `.codex/`
- `CLAUDE.md`
- `.claude/`
- `.cursor/`
- `docs/`

Vault-internal files are not root-scope edits. Enter the vault first.
