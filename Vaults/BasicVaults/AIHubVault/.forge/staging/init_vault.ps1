#Requires -Version 5.1
<#
.SYNOPSIS
    새 Obsidian Vault를 AI 워크플로우 인프라와 함께 초기화합니다.
.PARAMETER TargetPath
    새 Vault를 생성할 경로 (예: C:\Obsidian\BasicObsidianVault)
.PARAMETER ProjectName
    새 프로젝트 이름 (예: BasicObsidianVault)
.PARAMETER VaultType
    볼트 타입: domain (분야별 지식 관리) 또는 project (작업 관리). 기본값: project
.EXAMPLE
    .\init_vault.ps1 -TargetPath "C:\Obsidian\MyPKM" -ProjectName "MyPKM" -VaultType domain
.EXAMPLE
    .\init_vault.ps1 -TargetPath "C:\Obsidian\MyProject" -ProjectName "MyProject" -VaultType project
#>
param(
    [Parameter(Mandatory=$true)][string]$TargetPath,
    [Parameter(Mandatory=$true)][string]$ProjectName,
    [string]$SourceProjectName = "",   # 미입력 시 소스 볼트 폴더명에서 자동 추출
    [ValidateSet("domain","project")][string]$VaultType = "project"   # 볼트 타입
)

$ErrorActionPreference = "Stop"
$sourceRoot = Split-Path -Parent $PSScriptRoot
$today = (Get-Date).ToString("yyyy-MM-dd")
$projLower = $ProjectName.ToLower()

# ── 구조 선언 (폴더명 변경 시 이 섹션만 수정) ─────────────────
$DIR_OBSIDIAN    = ".obsidian"
$DIR_CLAUDE      = ".claude"
$DIR_CODEX       = ".codex"
$DIR_ANTIGRAVITY = ".antigravity"
$DIR_STANDARDS   = "_Standards"
$DIR_TOOLS       = "_tools"
$DIR_TAGS        = "Tags"
$DIR_DOCS        = "docs"
# ──────────────────────────────────────────────────────────────

# 소스 볼트명 자동 추출 (Projects_ 접두사 제거)
if (-not $SourceProjectName) {
    $SourceProjectName = (Split-Path -Leaf $sourceRoot) -replace '^Projects?_', ''
}
$SOURCE_NAME_PATTERN = [regex]::Escape($SourceProjectName)

# ── 헬퍼 ──────────────────────────────────────────
function Copy-Dir {
    param([string]$Src, [string]$Dst, [string[]]$Exclude = @())
    if (-not (Test-Path $Src)) { return }
    New-Item -ItemType Directory -Path $Dst -Force | Out-Null
    Get-ChildItem -Path $Src -Recurse | ForEach-Object {
        $rel = $_.FullName.Substring($Src.Length).TrimStart('\','/')
        foreach ($ex in $Exclude) { if ($rel -like $ex) { return } }
        $dest = Join-Path $Dst $rel
        if ($_.PSIsContainer) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
        else { Copy-Item -Path $_.FullName -Destination $dest -Force }
    }
}

function Write-Utf8 {
    param([string]$Path, [string]$Content)
    $dir = Split-Path -Parent $Path
    if ($dir) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, (New-Object System.Text.UTF8Encoding $false))
}

function Log { param([string]$M, [string]$C="Cyan"); Write-Host $M -ForegroundColor $C }

# ── 0. 사전 확인 ───────────────────────────────────
if (Test-Path $TargetPath) {
    if (Get-ChildItem $TargetPath -ErrorAction SilentlyContinue) {
        Write-Host "경고: '$TargetPath' 폴더가 비어있지 않습니다." -ForegroundColor Yellow
        $c = Read-Host "계속하면 파일이 덮어쓰기됩니다. 계속할까요? (y/N)"
        if ($c -ne 'y') { exit 0 }
    }
}
New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
Log "[OK] 대상 Vault 경로 준비: $TargetPath (타입: $VaultType)"

# ── 1. Obsidian 플러그인 + 설정 ────────────────────
Log "[1] Obsidian 플러그인 + 설정 복사 중..."
Copy-Dir (Join-Path $sourceRoot $DIR_OBSIDIAN) (Join-Path $TargetPath $DIR_OBSIDIAN) `
    -Exclude @("workspace.json","workspace-mobile.json","plugins\obsidian-git*")
$snippetCount = (Get-ChildItem (Join-Path $sourceRoot "$DIR_OBSIDIAN\snippets") -Filter "*.css" -ErrorAction SilentlyContinue).Count
$pluginCount = (Get-ChildItem (Join-Path $sourceRoot "$DIR_OBSIDIAN\plugins") -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne "obsidian-git" }).Count
Log "  - 커뮤니티 플러그인 $pluginCount 종 (obsidian-git 제외) + CSS 스니펫 $snippetCount 개 + 설정 완료"

# make-md systemName 갱신
$makeMdData = Join-Path $TargetPath "$DIR_OBSIDIAN\plugins\make-md\data.json"
if (Test-Path $makeMdData) {
    $mmd = [System.IO.File]::ReadAllText($makeMdData, (New-Object System.Text.UTF8Encoding $false))
    $mmd = $mmd -replace '"systemName"\s*:\s*"[^"]*"', """systemName"": ""$ProjectName"""
    [System.IO.File]::WriteAllText($makeMdData, $mmd, (New-Object System.Text.UTF8Encoding $false))
    Log "  - make-md systemName -> $ProjectName"
}

# ── 2. Claude 인프라 ───────────────────────────────
Log "[2] $DIR_CLAUDE/ 복사 중..."
Copy-Dir (Join-Path $sourceRoot $DIR_CLAUDE) (Join-Path $TargetPath $DIR_CLAUDE) `
    -Exclude @("AGENT_STATUS.md")
Get-ChildItem (Join-Path $TargetPath "$DIR_CLAUDE\rules") -Filter "*.md" -ErrorAction SilentlyContinue | ForEach-Object {
    $c = Get-Content $_.FullName -Raw -Encoding UTF8
    $c = $c -replace $SOURCE_NAME_PATTERN, $ProjectName
    [System.IO.File]::WriteAllText($_.FullName, $c, (New-Object System.Text.UTF8Encoding $false))
}
Log "  - $DIR_CLAUDE/rules/ + commands/ 완료"

# ── 3. Standards/ ──────────────────────────────────
Log "[3] $DIR_STANDARDS/ 복사 중..."
# Core/ 만 복사 (공통 운영 표준 — 모든 볼트에 공유)
Copy-Dir (Join-Path $sourceRoot "$DIR_STANDARDS\Core") `
         (Join-Path $TargetPath "$DIR_STANDARDS\Core") `
         -Exclude @("CLAUDE.md","SystemInterfaces.md")

# Domain/ 스켈레톤 생성 (복사 안 함 — 볼트별 커스텀, 덮어쓰기 방지)
Write-Utf8 (Join-Path $TargetPath "$DIR_STANDARDS\Domain\DOMAIN_SPEC.md") @'
---
type: standard
tags:
  - domain
updated:
---

# DOMAIN_SPEC — 볼트 도메인 정의

> AI 에이전트는 작업 시 이 파일을 읽어 볼트 도메인을 파악합니다.

## 볼트 목적

[이 볼트의 주제와 목적을 작성하세요.]

## 대상 사용자

- [주요 사용자 설명]

## 주요 산출물

1. [산출물 1]
2. [산출물 2]

## 범위

- 포함: [포함 범위]
- 미포함: [미포함 범위]
'@

Write-Utf8 (Join-Path $TargetPath "$DIR_STANDARDS\Domain\DOMAIN_GLOSSARY.md") @'
---
type: standard
tags:
  - domain
updated:
---

# DOMAIN_GLOSSARY — 도메인 용어집

| 용어 | 정의 |
|------|------|
| (용어) | (정의) |
'@

Write-Utf8 (Join-Path $TargetPath "$DIR_STANDARDS\Domain\DOMAIN_AI_RULES.md") @'
---
type: standard
tags:
  - domain
updated:
---

# DOMAIN_AI_RULES — 도메인별 AI 작업 규칙

> _Standards/Core/ 규칙에 추가(override)된다.

## 작업 우선순위

1. _STATUS.md 먼저 확인
2. _VAULT-INDEX.md 로 관련 파일 위치 확인

## 도메인 특이 규칙

- [이 볼트 주제에 특화된 AI 작업 규칙을 작성하세요.]
'@

Log "  - Core/ 복사 + Domain/ 스켈레톤 생성 완료"

# ── 4. tools/ ──────────────────────────────────────
Log "[4] $DIR_TOOLS/ 복사 중..."
Copy-Dir (Join-Path $sourceRoot $DIR_TOOLS) (Join-Path $TargetPath $DIR_TOOLS)
Log "  - open_agents.ps1 + antigravity.exe.txt 완료"

# ── 5. Tags/TAGS.md ────────────────────────────────
$tagsSrc = Join-Path $sourceRoot "$DIR_TAGS\TAGS.md"
if (Test-Path $tagsSrc) {
    New-Item -ItemType Directory -Path (Join-Path $TargetPath $DIR_TAGS) -Force | Out-Null
    Copy-Item $tagsSrc (Join-Path $TargetPath "$DIR_TAGS\TAGS.md") -Force
    Log "[5] $DIR_TAGS/TAGS.md 완료"
}

# ── 6. 멀티에이전트 메모리 ─────────────────────────
Log "[6] 멀티에이전트 메모리 생성 중..."

# .claude/AGENT_STATUS.md
Write-Utf8 (Join-Path $TargetPath "$DIR_CLAUDE\AGENT_STATUS.md") (@'
---
type: agent-status
agent: claude
updated: {{today}}
---

# Claude AGENT_STATUS — {{proj}}

## 이번 세션 요약
- 초기화: _tools/init_vault.ps1 실행으로 Vault 생성

## Done
- Vault 인프라 초기화 완료

## Next
- {{standards}}/CLAUDE.md 목표 작성
- VAULT-INDEX.md 구조 확정

## Blocked
없음
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
   -replace '{{standards}}',$DIR_STANDARDS)

if ($VaultType -ne "domain") {
    # .codex/CODEX.md
    $codexSrc = Join-Path $sourceRoot "$DIR_CODEX\CODEX.md"
    if (Test-Path $codexSrc) {
        $cc = Get-Content $codexSrc -Raw -Encoding UTF8
        $cc = $cc -replace $SOURCE_NAME_PATTERN, $ProjectName
        Write-Utf8 (Join-Path $TargetPath "$DIR_CODEX\CODEX.md") $cc
    } else {
        Write-Utf8 (Join-Path $TargetPath "$DIR_CODEX\CODEX.md") (@'
---
type: codex-memory
updated: {{today}}
---

# CODEX.md — {{proj}}

## 세션 시작 체크리스트
- {{codex}}/AGENT_STATUS.md 확인
- STATUS.md 확인
- VAULT-INDEX.md로 문서 위치 파악
- {{standards}}/SystemInterfaces.md 확인
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
           -replace '{{codex}}',$DIR_CODEX -replace '{{standards}}',$DIR_STANDARDS)
    }

    Write-Utf8 (Join-Path $TargetPath "$DIR_CODEX\AGENT_STATUS.md") (@'
---
type: agent-status
agent: codex
updated: {{today}}
---

# Codex AGENT_STATUS — {{proj}}

## Done
- Vault 초기화

## Next
- 첫 작업 대기

## Blocked
없음
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName)

    # .antigravity/ANTIGRAVITY.md
    $agSrc = Join-Path $sourceRoot "$DIR_ANTIGRAVITY\ANTIGRAVITY.md"
    if (Test-Path $agSrc) {
        $ag = Get-Content $agSrc -Raw -Encoding UTF8
        $ag = $ag -replace $SOURCE_NAME_PATTERN, $ProjectName
        Write-Utf8 (Join-Path $TargetPath "$DIR_ANTIGRAVITY\ANTIGRAVITY.md") $ag
    }

    Write-Utf8 (Join-Path $TargetPath "$DIR_ANTIGRAVITY\AGENT_STATUS.md") (@'
---
type: agent-status
agent: antigravity
updated: {{today}}
---

# Antigravity AGENT_STATUS — {{proj}}

## Done
- Vault 초기화

## Next
- 구현 대상 Spec 확인 후 착수

## Blocked
없음
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName)

    Log "  - $DIR_CLAUDE / $DIR_CODEX / $DIR_ANTIGRAVITY 완료"
} else {
    Log "  - $DIR_CLAUDE 완료 (domain 타입: Codex/Antigravity 생략)"
}

# ── 7. 핵심 파일 생성 ──────────────────────────────
Log "[7] 핵심 파일 생성 중..."

# CLAUDE.md (루트 리다이렉트)
Write-Utf8 (Join-Path $TargetPath "CLAUDE.md") (@'
# CLAUDE.md (루트 리다이렉트)

이 Vault의 Claude 컨텍스트 본문은 `{{standards}}/CLAUDE.md`로 이동했습니다.

- 표준 문서: `{{standards}}/CLAUDE.md`
'@ -replace '{{standards}}',$DIR_STANDARDS)

# _Standards/CLAUDE.md (타입별 분기)
if ($VaultType -eq "domain") {
    Write-Utf8 (Join-Path $TargetPath "$DIR_STANDARDS\CLAUDE.md") (@'
---
type: project-memory
project: {{proj}}
updated: {{today}}
---

# {{standards}}/CLAUDE.md — {{proj}} 도메인 볼트

## 볼트 개요

- **타입**: 도메인 볼트 (분야별 지식 관리 — 정보 축적)
- **주제**: [이 볼트의 주제를 작성]
- **목적**: [정보 수집, 정착, 연결의 목표]

## 핵심 문서 경로

| 문서 | 경로 |
|------|------|
| Vault 지도 | `VAULT-INDEX.md` |
| 도메인 스펙 | `{{standards}}/Domain/DOMAIN_SPEC.md` |
| 도메인 규칙 | `{{standards}}/Domain/DOMAIN_AI_RULES.md` |

## 폴더 역할

| 폴더 | 역할 |
|------|------|
| `inbox/` | 수집 대기 (미분류 캡처) |
| `daily/` | 일일 노트 |
| `topics/` | 주제별 개념 카드 |
| `people/` | 인물, 관계 노트 |
| `references/` | 출처, 참고자료 |
| `media/` | 첨부 이미지, 파일 |

## 세션 시작 루틴

1. `{{standards}}/CLAUDE.md` (이 파일) 확인
2. `VAULT-INDEX.md` 확인
3. `_STATUS.md` 확인
4. 이전 세션 미완료 작업 이어서 진행

## 에이전트

- Claude 단독 운용 (Codex/Copilot 비활성)
- 도메인 커스텀 규칙: `{{standards}}/Domain/DOMAIN_AI_RULES.md` 참조
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
       -replace '{{standards}}',$DIR_STANDARDS)
} else {
    Write-Utf8 (Join-Path $TargetPath "$DIR_STANDARDS\CLAUDE.md") (@'
---
type: project-memory
project: {{proj}}
updated: {{today}}
---

# {{standards}}/CLAUDE.md — {{proj}} 프로젝트 메모리

## 프로젝트 개요

- **종류**: [프로젝트 종류 작성]
- **목표**: [핵심 목표 작성]
- **Obsidian 보관함**: [볼트 경로]

## 핵심 문서 경로

| 문서 | 경로 |
|------|------|
| Vault 지도 | `VAULT-INDEX.md` |
| 이슈 인덱스 | `{{docs}}/issues/ISSUE_INDEX.md` |
| 도메인 스펙 | `{{standards}}/Domain/DOMAIN_SPEC.md` |
| 도메인 규칙 | `{{standards}}/Domain/DOMAIN_AI_RULES.md` |

## 시스템 기획 우선순위

1. [시스템 1] <- 현재
2. [시스템 2] <- 대기

## 현재 진행 상태

**최종 업데이트**: {{today}}
**다음 할 일**: 프로젝트 목표 및 첫 번째 시스템 설계 시작

## 세션 시작 루틴

1. `{{standards}}/CLAUDE.md` (이 파일) 확인
2. `VAULT-INDEX.md` 확인
3. `STATUS.md` 확인
4. 이전 세션 미완료 작업 이어서 진행

## 에이전트 구성

- Claude: 설계, 기획, 문서
- Codex: 코드 구현 (.codex/)
- Copilot: IDE 코드 보완 (.antigravity/)
- 도메인 커스텀 규칙: `{{standards}}/Domain/DOMAIN_AI_RULES.md` 참조
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
       -replace '{{standards}}',$DIR_STANDARDS -replace '{{docs}}',$DIR_DOCS)
}

# STATUS.md
Write-Utf8 (Join-Path $TargetPath "STATUS.md") (@'
---
type: master-status
project: {{proj}}
updated: {{today}}
last_agent: claude
---

# STATUS — {{proj}}

## Now (현재 작업)

Claude: 초기 설계 시작

## Next (다음 작업)

- 도메인 스펙 작성 (_Standards/Domain/DOMAIN_SPEC.md)
- VAULT-INDEX.md 구조 확정

## Decisions (확정 사항)

| 날짜 | 결정 내용 |
|------|-----------|
| {{today}} | Vault 인프라 초기화 완료 |

## Blocked

없음
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName)

# VAULT-INDEX.md (타입별 분기)
if ($VaultType -eq "domain") {
    Write-Utf8 (Join-Path $TargetPath "VAULT-INDEX.md") (@'
---
aliases:
  - "Vault 인덱스"
  - "보관함 지도"
tags:
  - Meta
type: vault-index
updated: {{today}}
---

# VAULT-INDEX — {{proj}} 보관함 지도

> Claude가 이 Vault에서 "무엇이 어디 있는지" 파악하기 위한 지도.

---

## 1. Vault 루트 구조

```
{{proj}}/
├── CLAUDE.md           <- 루트 리다이렉트 -> {{standards}}/CLAUDE.md
├── VAULT-INDEX.md      <- 이 파일
├── STATUS.md           <- 마스터 진행 현황
├── inbox/              <- 수집 대기
├── daily/              <- 일일 노트
├── topics/             <- 주제별 개념 카드
├── people/             <- 인물, 관계 노트
├── references/         <- 출처, 참고자료
├── media/              <- 첨부 파일
├── NoteTemplates/      <- 복사된 노트 템플릿
├── {{tags}}/           <- 태그 노트
├── {{tools}}/          <- 자동화 스크립트
├── {{claude}}/
│   ├── commands/       <- 프로젝트 전용 스킬
│   └── rules/          <- 자동 적용 규칙
└── {{standards}}/      <- Vault 일관성 기준
    ├── Core/           <- 공통 운영 표준 (AIMindVault 배포)
    └── Domain/         <- 이 볼트 전용 커스텀
```

---

## 2. {{standards}}/Domain/ (이 볼트 커스텀)

| 파일 | 내용 | 상태 |
|------|------|------|
| `DOMAIN_SPEC.md` | 볼트 주제, 목적 | 작성 필요 |
| `DOMAIN_GLOSSARY.md` | 도메인 용어집 | 작성 필요 |
| `DOMAIN_AI_RULES.md` | AI 작업 커스텀 규칙 | 작성 필요 |

---

## 3. {{standards}}/Core/ 일관성 기준

| 파일/폴더 | 내용 |
|-----------|------|
| `WritingStandards.md` | 문서 작성 표준 |
| `NoteProperties.md` | Frontmatter 표준 |
| `NoteTemplates/` | 노트 템플릿 모음 |

---

> 최종 수정: {{today}}
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
       -replace '{{standards}}',$DIR_STANDARDS -replace '{{tools}}',$DIR_TOOLS `
       -replace '{{tags}}',$DIR_TAGS -replace '{{claude}}',$DIR_CLAUDE)
} else {
    Write-Utf8 (Join-Path $TargetPath "VAULT-INDEX.md") (@'
---
aliases:
  - "Vault 인덱스"
  - "보관함 지도"
tags:
  - Meta
type: vault-index
updated: {{today}}
---

# VAULT-INDEX — {{proj}} 보관함 지도

> Claude가 이 Vault에서 "무엇이 어디 있는지" 파악하기 위한 지도.

---

## 1. Vault 루트 구조

```
{{proj}}/
├── CLAUDE.md           <- 루트 리다이렉트 -> {{standards}}/CLAUDE.md
├── VAULT-INDEX.md      <- 이 파일
├── STATUS.md           <- 마스터 진행 현황
├── {{tags}}/           <- 태그 노트
├── {{tools}}/          <- 자동화 스크립트
├── {{codex}}/          <- Codex 전용 메모리
├── {{antigravity}}/    <- Antigravity 전용 메모리
├── {{claude}}/
│   ├── commands/       <- 프로젝트 전용 스킬
│   └── rules/          <- 자동 적용 규칙
├── {{docs}}/           <- 프로젝트 문서
├── {{standards}}/      <- Vault 일관성 기준
│   ├── Core/           <- 공통 운영 표준 (AIMindVault 배포)
│   └── Domain/         <- 이 볼트 전용 커스텀
└── References/         <- 참조 자료
```

---

## 2. {{docs}}/ 핵심 문서

### 02-design/ (설계 문서)

| 파일/폴더 | 내용 | 상태 |
|-----------|------|------|
| (비어있음) | | |

### 03-spec/ (AI 구현 명세)

| 파일 | 내용 | 상태 |
|------|------|------|
| (비어있음) | | |

---

## 3. {{standards}}/Domain/ (이 볼트 커스텀)

| 파일 | 내용 | 상태 |
|------|------|------|
| `DOMAIN_SPEC.md` | 볼트 주제, 목적 | 작성 필요 |
| `DOMAIN_GLOSSARY.md` | 도메인 용어집 | 작성 필요 |
| `DOMAIN_AI_RULES.md` | AI 작업 커스텀 규칙 | 작성 필요 |

---

## 4. {{standards}}/Core/ 일관성 기준

| 파일/폴더 | 내용 |
|-----------|------|
| `WritingStandards.md` | 문서 작성 표준 |
| `NoteProperties.md` | Frontmatter 표준 |
| `NoteTemplates/` | 노트 템플릿 모음 |
| `MultiAgent_Coordination_Pattern.md` | 멀티 에이전트 협업 패턴 |

---

> 최종 수정: {{today}}
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
       -replace '{{standards}}',$DIR_STANDARDS -replace '{{tools}}',$DIR_TOOLS `
       -replace '{{tags}}',$DIR_TAGS -replace '{{docs}}',$DIR_DOCS `
       -replace '{{claude}}',$DIR_CLAUDE -replace '{{codex}}',$DIR_CODEX `
       -replace '{{antigravity}}',$DIR_ANTIGRAVITY)
}

Log "  - CLAUDE.md / STATUS.md / VAULT-INDEX.md / $DIR_STANDARDS/CLAUDE.md 완료"

# Tags/TAG_MASK.md
Write-Utf8 (Join-Path $TargetPath "$DIR_TAGS\TAG_MASK.md") (@'
---
type: tag-mask
updated: {{today}}
---

# TAG_MASK — {{proj}} 태그 마스킹 절차

> 기존 태그 -> 정규 태그 매핑 테이블.
> 정규 태그 목록은 `{{tags}}/TAGS.md` 참조.

## 매핑 테이블

| 기존 태그 | 정규 태그 | 비고 |
|-----------|-----------|------|
| (작성 예정) | | |

## 적용 절차

1. `{{docs}}/issues/**` 먼저 적용
2. `{{docs}}/02-design/**` 적용
3. `{{docs}}/03-spec/**` 적용
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
   -replace '{{tags}}',$DIR_TAGS -replace '{{docs}}',$DIR_DOCS)

# SETUP_GUIDE.md (타입별 분기)
if ($VaultType -eq "domain") {
    Write-Utf8 (Join-Path $TargetPath "SETUP_GUIDE.md") (@'
---
type: setup-guide
project: {{proj}}
vaultType: domain
created: {{today}}
---

# SETUP_GUIDE — {{proj}} 초기 설정 가이드 (domain)

> Vault 초기화 직후 해야 할 설정 체크리스트.

---

## 1. 사용자 (Obsidian)

- [ ] Obsidian에서 이 폴더를 새 Vault로 열기
- [ ] 커뮤니티 플러그인 "신뢰" 허용 클릭 (플러그인 활성화)
- [ ] Obsidian 재시작

### Smart Connections
- [ ] 설정 → Smart Connections → API Key → OpenAI API 키 입력

### Templater
- [ ] 설정 → Templater → Template folder: `{{standards}}/Core/NoteTemplates`

---

## 2. Claude 설정

### `~/.claude/CLAUDE.md` — 프로젝트 목록에 추가
```
| {{proj}} | C:/경로/{{proj}}/ | 있음 |
```

### `{{standards}}/CLAUDE.md`
- [ ] 볼트 주제, 목적 작성

### `{{standards}}/Domain/DOMAIN_SPEC.md`
- [ ] 이 볼트의 주제, 목적, 범위 작성

### `{{standards}}/Domain/DOMAIN_GLOSSARY.md`
- [ ] 주제별 용어 정의 추가

### `{{standards}}/Domain/DOMAIN_AI_RULES.md`
- [ ] 이 볼트에서 Claude에게 요구할 특별 규칙 작성

---

## 3. 첫 세션 시작 루틴 (Claude)

```
1. SETUP_GUIDE.md 확인 (이 파일)
2. {{standards}}/CLAUDE.md 볼트 목표 작성
3. VAULT-INDEX.md 구조 확정
4. inbox/ 에 첫 노트 캡처
```

---

> 모든 항목 완료 후 이 파일을 보관하거나 삭제합니다.
> 최종 수정: {{today}}
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
       -replace '{{standards}}',$DIR_STANDARDS -replace '{{tools}}',$DIR_TOOLS `
       -replace '{{claude}}',$DIR_CLAUDE)
} else {
    Write-Utf8 (Join-Path $TargetPath "SETUP_GUIDE.md") (@'
---
type: setup-guide
project: {{proj}}
vaultType: project
created: {{today}}
---

# SETUP_GUIDE — {{proj}} 초기 설정 가이드 (project)

> Vault 초기화 직후 사람과 각 에이전트가 해야 할 설정 체크리스트.

---

## 1. 사용자 (Obsidian)

### Obsidian 기본
- [ ] Obsidian에서 이 폴더를 새 Vault로 열기
- [ ] 커뮤니티 플러그인 "신뢰" 허용 클릭 (플러그인 활성화)
- [ ] Obsidian 재시작 (Shell Commands 자동 실행 활성화)

### Smart Connections
- [ ] 설정 → Smart Connections → API Key → OpenAI API 키 입력

### Templater
- [ ] 설정 → Templater → Template folder: `{{standards}}/Core/NoteTemplates`

### Shell Commands (open_agents 자동 실행)
- [ ] 설정 → Shell Commands → "open_agents" 커맨드 확인
- [ ] `{{tools}}/antigravity.exe.txt` 내 Antigravity 실행 경로가 올바른지 확인

---

## 2. Claude 설정

### `~/.claude/CLAUDE.md` — 프로젝트 목록에 추가
```
| {{proj}} | C:/경로/{{proj}}/ | 있음 |
```

### `~/.claude/settings.json` — GitHub MCP 토큰 교체
- [ ] `GITHUB_PERSONAL_ACCESS_TOKEN` 값을 실제 토큰으로 교체

### `{{standards}}/CLAUDE.md`
- [ ] 프로젝트 종류, 목표 작성
- [ ] 핵심 문서 경로 확정 후 업데이트

### `{{standards}}/Domain/DOMAIN_SPEC.md`
- [ ] 이 볼트의 주제, 목적, 범위 작성

### `{{claude}}/AGENT_STATUS.md`
- [ ] 첫 세션 시작 시 "Next" 항목 업데이트

---

## 3. Codex 설정

### `{{codex}}/CODEX.md`
- [ ] 프로젝트명, 경로 업데이트

### `{{codex}}/AGENT_STATUS.md`
- [ ] "Next" 항목: 첫 작업 대상 기입

---

## 4. Antigravity 설정

### `{{antigravity}}/ANTIGRAVITY.md`
- [ ] 이 프로젝트의 핵심 파일 경로 목록 업데이트

### `{{antigravity}}/AGENT_STATUS.md`
- [ ] 첫 구현 대상 Spec 경로 기입

---

## 5. MCP 서버 상태 확인

| MCP 서버 | 필요 여부 | 설정 항목 |
|----------|----------|-----------|
| context7 | 항상 | 없음 (자동) |
| github | 코드 연동 시 | 토큰 교체 필요 |
| playwright | 브라우저 자동화 시 | 없음 (자동) |
| mcp-unity | Unity 프로젝트 시 | Unity Editor 실행 필요 |

---

## 6. 첫 세션 시작 루틴 (Claude)

```
1. SETUP_GUIDE.md 확인 (이 파일)
2. {{standards}}/CLAUDE.md 프로젝트 목표 작성
3. VAULT-INDEX.md 구조 확정
4. {{docs}}/02-design/ 에 첫 설계서 생성
```

---

> 모든 항목 완료 후 이 파일을 보관하거나 삭제합니다.
> 최종 수정: {{today}}
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
       -replace '{{standards}}',$DIR_STANDARDS -replace '{{tools}}',$DIR_TOOLS `
       -replace '{{docs}}',$DIR_DOCS -replace '{{claude}}',$DIR_CLAUDE `
       -replace '{{codex}}',$DIR_CODEX -replace '{{antigravity}}',$DIR_ANTIGRAVITY)
}

Log "  - SETUP_GUIDE.md 완료"

# AI_SETTINGS.md
Write-Utf8 (Join-Path $TargetPath "AI_SETTINGS.md") (@'
---
type: ai-settings
project: {{proj}}
created: {{today}}
---

# AI_SETTINGS — {{proj}} AI & MCP 설정 참조

> 이 Vault에서 사용하는 AI 에이전트와 MCP 서버의 설정 정보.

---

## 1. 멀티 에이전트 구조

| 에이전트 | 역할 | 메모리 경로 | 진입점 |
|----------|------|------------|--------|
| **Claude (Claudian)** | 설계, 기획, 문서 | `{{claude}}/` | Obsidian Claudian 플러그인 |
| **Codex** | 코드 구현, 리팩토링 | `{{codex}}/` | `codex` CLI |
| **Antigravity** | 코드 탐색, 리뷰 | `{{antigravity}}/` | `{{tools}}/open_agents.ps1` 자동 실행 |

---

## 2. MCP 서버

설정 파일: `~/.claude/settings.json` → `mcpServers` 섹션

| MCP | 명령 | 용도 |
|-----|------|------|
| **context7** | `npx -y @upstash/context7-mcp` | 최신 라이브러리 문서 자동 참조 |
| **github** | `npx -y @modelcontextprotocol/server-github` | GitHub 이슈, PR, 코드 |
| **playwright** | `npx @playwright/mcp@latest` | 브라우저 자동화 |
| **mcp-unity** | 별도 설치 | Unity Editor 직접 조작 |
| **notion** | `@notionhq/notion-mcp-server` | Notion 읽기/쓰기 |

### settings.json 구조

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_..." }
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

---

## 3. Claude 설정 파일 경로

| 파일 | 범위 | 내용 |
|------|------|------|
| `~/.claude/CLAUDE.md` | 전역 | 사용자 메모리, 프로젝트 목록 |
| `~/.claude/settings.json` | 전역 | MCP 서버 목록 |
| `{{standards}}/CLAUDE.md` | 이 Vault | 프로젝트 메모리, 진행 상태 |
| `{{standards}}/Domain/DOMAIN_AI_RULES.md` | 이 Vault | 도메인 AI 커스텀 규칙 |
| `{{claude}}/rules/*.md` | 이 Vault | 자동 적용 규칙 |
| `{{claude}}/commands/*.md` | 이 Vault | 프로젝트 전용 스킬 |

---

## 4. Codex CLI 설정

```bash
npm install -g @openai/codex
# Vault 루트에서 실행 -> {{codex}}/CODEX.md 자동 로드
codex
```

---

> 최종 수정: {{today}}
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName `
   -replace '{{standards}}',$DIR_STANDARDS -replace '{{tools}}',$DIR_TOOLS `
   -replace '{{claude}}',$DIR_CLAUDE -replace '{{codex}}',$DIR_CODEX `
   -replace '{{antigravity}}',$DIR_ANTIGRAVITY)

Log "  - AI_SETTINGS.md 완료"

# ── 8. 타입별 폴더 구조 + NoteTemplates ───────────
Log "[8] 타입별 폴더 구조 생성 중..."

if ($VaultType -eq "domain") {
    # 도메인 볼트 폴더 구조
    @("inbox","daily","topics","people","references","media") | ForEach-Object {
        New-Item -ItemType Directory -Path (Join-Path $TargetPath $_) -Force | Out-Null
    }
    # NoteTemplates 복사 (Common + Memory)
    Copy-Dir (Join-Path $sourceRoot "$DIR_STANDARDS\Core\NoteTemplates\Common") `
             (Join-Path $TargetPath "NoteTemplates\Common")
    Copy-Dir (Join-Path $sourceRoot "$DIR_STANDARDS\Core\NoteTemplates\Domain") `
             (Join-Path $TargetPath "NoteTemplates")
    Log "  - domain 폴더 구조 (inbox/daily/topics/people/references/media) + NoteTemplates 완료"
} else {
    # 프로젝트 볼트 폴더 구조
    @(
        "$DIR_DOCS\01-concept",
        "$DIR_DOCS\02-design",
        "$DIR_DOCS\03-spec",
        "$DIR_DOCS\04-debug",
        "$DIR_DOCS\issues\design",
        "$DIR_DOCS\issues\spec",
        "$DIR_DOCS\issues\epics",
        "$DIR_DOCS\temp",
        "References"
    ) | ForEach-Object {
        New-Item -ItemType Directory -Path (Join-Path $TargetPath $_) -Force | Out-Null
    }
    # NoteTemplates 복사 (Common + Project)
    Copy-Dir (Join-Path $sourceRoot "$DIR_STANDARDS\Core\NoteTemplates\Common") `
             (Join-Path $TargetPath "NoteTemplates\Common")
    Copy-Dir (Join-Path $sourceRoot "$DIR_STANDARDS\Core\NoteTemplates\Project") `
             (Join-Path $TargetPath "NoteTemplates\Project")

    # docs/issues/ISSUE_INDEX.md
    Write-Utf8 (Join-Path $TargetPath "$DIR_DOCS\issues\ISSUE_INDEX.md") (@'
---
type: issue-index
scope: master
updated: {{today}}
tags: [doc/issue, project/{{projlower}}]
---

# ISSUE_INDEX — {{proj}} 이슈 마스터 인덱스

## 미결 이슈

| ID | 시스템 | 내용 | 우선순위 | 상태 |
|----|--------|------|----------|------|
| (없음) | | | | |

## 확정 사항

| 날짜 | 내용 |
|------|------|
| {{today}} | Vault 초기화 |
'@ -replace '{{today}}',$today -replace '{{proj}}',$ProjectName -replace '{{projlower}}',$projLower)

    Log "  - project 폴더 구조 (docs/, References/) + NoteTemplates + ISSUE_INDEX.md 완료"
}

# ── 완료 ───────────────────────────────────────────
Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  [OK] '$ProjectName' Vault 초기화 완료! (타입: $VaultType)" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""
Write-Host ">> 위치: $TargetPath" -ForegroundColor White
Write-Host ""
Write-Host "[Next Steps]" -ForegroundColor Yellow
Write-Host "  1. Obsidian에서 '$TargetPath' 열기"
Write-Host "     -> 신뢰 허용 클릭 (플러그인 활성화)"
Write-Host "  2. Smart Connections API 키 재입력"
Write-Host "     -> Settings -> Smart Connections -> API Key"
Write-Host "  3. Templater 설정 확인"
Write-Host "     -> Template folder: $DIR_STANDARDS/Core/NoteTemplates"
Write-Host "  4. $DIR_STANDARDS/CLAUDE.md 에 목표 작성"
Write-Host "  5. $DIR_STANDARDS/Domain/ 파일 3개 작성"
Write-Host "     -> DOMAIN_SPEC.md / DOMAIN_GLOSSARY.md / DOMAIN_AI_RULES.md"
Write-Host ""
if ($VaultType -eq "domain") {
    Write-Host "  [domain] inbox/ 에 첫 캡처 시작" -ForegroundColor DarkCyan
} else {
    Write-Host "  [project] docs/02-design/ 에 첫 설계서 생성" -ForegroundColor DarkCyan
    Write-Host "  Shell Commands 자동 실행은 Obsidian 재시작 후 활성화됩니다." -ForegroundColor DarkYellow
}
Write-Host ""
