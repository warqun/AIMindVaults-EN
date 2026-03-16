---
aliases:
  - "Encoding Safety"
  - "대량 수정 인코딩 안전 규칙"
tags:
  - Standards
  - Meta
  - AIMindVault
  - Safety
type: standards
updated: 2026-03-04
agent: codex
---

# Encoding & Bulk Edit Safety

## 목적
- 한글 문서가 대량 수정 중 인코딩 손상(모지바케, `�`)되는 사고를 방지한다.

## 절대 규칙
1. 대량 수정 스크립트는 파일 읽기/쓰기를 **UTF-8 고정**으로 처리한다.
2. `Set-Content`/`Add-Content` 기본 인코딩에 의존하지 않는다.
3. 대량 수정 전 `Contents` 대상 검증을 먼저 실행한다.
4. 대량 수정 후 검증 결과가 실패하면 즉시 중단하고 원인 분석 후 재시도한다.

## 권장 구현
- PowerShell: `[System.IO.File]::ReadAllText(path, [Text.Encoding]::UTF8)`
- PowerShell: `[System.IO.File]::WriteAllText(path, text, [Text.UTF8Encoding]::new($false))`

## 필수 검증
- 인코딩 검증:
```powershell
powershell -ExecutionPolicy Bypass -File .\_tools\cli\post_note_edit_review.ps1
```
- 기대값: `POST_EDIT_REVIEW_BAD=0`

## Juggl 대량 삽입 규칙
- 삽입 대상은 `Contents/**/*.md`
- 제외 대상: `Contents/Project/temp/agent_packets/**`
- 삽입 위치: 첫 번째 H1 바로 아래
- 중복 블록이 있으면 스킵

## 실패 대응
- `BAD_COUNT > 0`이면 추가 수정 금지
- 복구 후 재검증 완료(`BAD_COUNT=0`) 뒤에만 후속 자동화 실행

## 2026-03-04 Incident Root Cause (Mandatory)
- Root cause: a markdown file was rewritten via PowerShell text round-trip (Get-Content -Raw -> regex -> Set-Content) and Korean text became mojibake.
- Hard ban: Do NOT use Get-Content/Set-Content or Get-Content/Add-Content round-trip for Korean markdown files.
- Safe method only: use .NET UTF-8 fixed I/O ([System.IO.File]::ReadAllText(..., [Text.Encoding]::UTF8) / WriteAllText(..., [Text.UTF8Encoding]::new(False))).
- If a file is already corrupted, restore from Obsidian snapshot first, then apply minimal patch.
## 2026-03-04 Bulk-Replace Incident #2 (Mandatory)
- Incident: a bulk Juggl-local normalization script injected local: <filename> across many lines, causing whitespace/line-break corruption.
- Root cause class: unsafe global text rewrite without strict block-scoped parser and without staged sample validation.

### Hard bans
- Ban full-document global replace for structured markdown blocks unless parser-scope is guaranteed.
- Ban any bulk script that rewrites line delimiters or performs delimiter replacement with content tokens.
- Ban executing bulk rewrite on all files without sample pass (3 files minimum) and invariant checks.

### Mandatory bulk-edit protocol
1. Dry-run mode first: print target files + planned diff summary only.
2. Sample mode second: apply to 3 files only, then manual visual check in Obsidian.
3. Invariant checks required before full run:
   - one Juggl block remains valid per target note
   - local: count per note is expected
   - no frontmatter damage
4. Full run allowed only after sample verification success.
5. Post-run gate required: post_note_edit_review.ps1 must report POST_EDIT_REVIEW_BAD=0.

### Emergency stop rule
- If any structural corruption is detected, stop immediately and restore from snapshot before further edits.