---
type: standards
tags:
  - Standards
  - AIMindVault
  - script-management
  - rule
updated: 2026-03-09
agent: claude
---

# Script Creation Rule — 스크립트 생성 규칙

> 에이전트가 새 스크립트를 만들기 전에 따라야 하는 필수 절차.
> 중복 생성 방지와 레지스트리 일관성 유지가 목적이다.

---

## 1. 생성 전 — 중복 확인 (필수)

새 스크립트를 만들기 전에 반드시:

1. [[Script_Registry]] 확인 — 같은 기능의 스크립트가 이미 있는지
2. `_tools/` 및 `_forge/` 폴더 검색 — 레지스트리에 미등록된 스크립트도 확인
3. 기존 스크립트 확장으로 해결 가능한지 판단

> 기존 스크립트에 파라미터를 추가하는 것이 새 스크립트를 만드는 것보다 우선이다.

---

## 2. 생성 시 — 배치 규칙

| 성격 | 위치 | 예시 |
|------|------|------|
| 상시 운영 CLI 도구 | `_tools/cli/` | `post_note_edit_review.ps1` |
| 상시 운영 유틸리티 | `_tools/` | `clone_vault.ps1` |
| 일회성/실험/마이그레이션 | `_forge/staging/` | `fix_false_positives.ps1` |

---

## 3. 생성 시 — 코딩 규칙

### 경로 자동탐지 (필수)

하드코딩된 볼트 경로를 넣지 않는다. 스크립트 위치 기반 자동탐지를 사용한다.

```powershell
# Root — 스크립트 위치에서 볼트 루트 탐지
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path "$ScriptDir\..\..").Path

# Scope — 컨텐츠 폴더 자동 탐지
if (Test-Path (Join-Path $Root "Contents"))      { $Scope = "Contents" }
elseif (Test-Path (Join-Path $Root "Project"))  { $Scope = "Project" }
elseif (Test-Path (Join-Path $Root "docs"))     { $Scope = "docs" }
else { Write-Error "Content folder not found"; exit 1 }
```

### 인코딩 안전 (필수)

- `Get-Content | Set-Content` 파이프라인 사용 금지
- `.NET UTF-8 API`만 허용: `[System.IO.File]::ReadAllText()` / `WriteAllText()`
- 상세 → [[Encoding_BulkEdit_Safety]]

### 파라미터 설계

- 자동탐지 가능한 값은 기본값을 비워두고 자동탐지 로직 사용
- 파라미터 명시 시 그 값을 그대로 사용 (기존 호환)

---

## 4. 생성 후 — 레지스트리 등록 (필수)

[[Script_Registry]]에 아래 정보를 추가한다:

| 항목 | 설명 |
|------|------|
| 스크립트명 | 파일명 |
| 위치 | `_tools/cli/`, `_tools/`, `_forge/staging/` 중 하나 |
| 용도 | 한 줄 설명 |
| 생성자 | 만든 에이전트 (claude/codex/antigravity/user) |
| 사용자 | 실제 사용 주체 |

---

## 5. 삭제 시

- [[Script_Registry]]의 "삭제된 스크립트" 섹션에 이동
- 삭제 사유 기록
- 해당 스크립트를 참조하는 규칙/문서 정리

---

## 6. 일회성 스크립트 정책

- `_forge/staging/`에 배치
- [[Script_Registry]]에 `one-time` 상태로 등록
- 목적 달성 후 `완료` 표시 (삭제 여부는 사용자 판단)

---

## 참조

- 스크립트 인벤토리 → [[Script_Registry]]
- 인코딩 안전 → [[Encoding_BulkEdit_Safety]]
