param(
  [string]$Root,
  [string]$Scope
)

if (-not $Root) {
    # NOTE: .sync\_tools\cli\ 기준 3단계(..\..\..),  레거시 _tools\cli\ 기준 2단계(..\..),
    #       순서대로 시도하며 Contents/ 폴더 존재로 볼트 루트를 검증한다.
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $rootCandidates = @(
        (Join-Path $ScriptDir "..\..\.."),   # .sync\_tools\cli → 볼트루트
        (Join-Path $ScriptDir "..\..")        # _tools\cli → 볼트루트 (레거시)
    )
    foreach ($candidate in $rootCandidates) {
        if (-not (Test-Path $candidate)) { continue }
        $resolved = (Resolve-Path $candidate).Path
        if (
            (Test-Path (Join-Path $resolved "Contents")) -or
            (Test-Path (Join-Path $resolved "Project")) -or
            (Test-Path (Join-Path $resolved "docs"))
        ) {
            $Root = $resolved
            break
        }
    }
    if (-not $Root) {
        Write-Error "Vault root auto-detect failed from $ScriptDir"
        exit 1
    }
}
if (-not $Scope) {
    if (Test-Path (Join-Path $Root "Contents"))      { $Scope = "Contents" }
    elseif (Test-Path (Join-Path $Root "Project"))  { $Scope = "Project" }
    elseif (Test-Path (Join-Path $Root "docs"))     { $Scope = "docs" }
    else { Write-Error "Content folder not found under $Root (Contents/, Project/, docs/)"; exit 1 }
}

$target = Join-Path $Root $Scope
if(-not (Test-Path $target)){
  Write-Error "Scope path not found: $target"
  exit 1
}

$strictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
$replacement = [char]0xFFFD
$bad = @()

$files = Get-ChildItem -Path $target -Recurse -File -Filter *.md
foreach($f in $files){
  $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
  $utf8Valid = $true
  try {
    $text = $strictUtf8.GetString($bytes)
  } catch {
    $utf8Valid = $false
    $text = ''
  }

  $repCount = 0
  if($utf8Valid){
    $repCount = ([regex]::Matches($text,[regex]::Escape([string]$replacement))).Count
  }

  if(-not $utf8Valid -or $repCount -gt 0){
    $bad += [pscustomobject]@{
      path = $f.FullName
      utf8_valid = $utf8Valid
      replacement_char_count = $repCount
    }
  }
}

"POST_EDIT_REVIEW_SCOPE=$target"
"POST_EDIT_REVIEW_FILES=$($files.Count)"
"POST_EDIT_REVIEW_BAD=$($bad.Count)"
if($bad.Count -gt 0){
  $bad | Sort-Object path | Format-Table -AutoSize
  exit 2
}

"POST_EDIT_REVIEW_OK=1"

# ── 인덱서 증분 빌드 (post-review 통과 시 자동 실행) ──
$indexerCandidates = @(
    (Join-Path $Root ".sync\_tools\cli\vault_index_build.ps1"),
    (Join-Path $Root "_tools\cli\vault_index_build.ps1")
)
$indexerPath = $indexerCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($indexerPath) {
    $dataDir = if (Test-Path (Join-Path $Root ".sync")) {
        Join-Path $Root ".sync\_tools\data"
    } else {
        Join-Path $Root "_tools\data"
    }
    $indexPath = Join-Path $dataDir "vault_index.json"
    try {
        $powershellExe = (Get-Process -Id $PID).Path
        & $powershellExe -ExecutionPolicy Bypass -File $indexerPath -VaultRoot $Root -Incremental
        if ($LASTEXITCODE -ne 0) {
            throw "vault_index_build.ps1 exited with code $LASTEXITCODE"
        }
        if (-not (Test-Path $indexPath)) {
            throw "vault_index_build.ps1 did not create $indexPath"
        }
        "POST_EDIT_INDEX_UPDATED=1"
        "POST_EDIT_INDEX_PATH=$indexPath"
    } catch {
        "POST_EDIT_INDEX_UPDATED=0"
        "POST_EDIT_INDEX_ERROR=$($_.Exception.Message)"
    }
} else {
    "POST_EDIT_INDEX_SKIPPED=1"
}

exit 0
