# rename_env_prefix.ps1
# Usage: .\rename_env_prefix.ps1           (apply changes)
#        .\rename_env_prefix.ps1 -DryRun   (preview only)

param([switch]$DryRun)

$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$VaultRoot  = Split-Path -Parent (Split-Path -Parent $ScriptDir)
Set-Location $VaultRoot

$dryLabel = if ($DryRun) { "[DRY-RUN] " } else { "" }
Write-Host "${dryLabel}Vault Root: $VaultRoot"
Write-Host "---"

# ── Phase 1: Rename folders and root files ──────────────────
$renames = @(
    @{ From = "Standards";       To = "_Standards"       },
    @{ From = "tools";           To = "_tools"           },
    @{ From = "VaultReview";     To = "_VaultReview"     },
    @{ From = "VAULT-INDEX.md";  To = "_VAULT-INDEX.md"  },
    @{ From = "STATUS.md";       To = "_STATUS.md"       },
    @{ From = "WORKFLOW.md";     To = "_WORKFLOW.md"     }
)

Write-Host "${dryLabel}=== Phase 1: Rename ==="
foreach ($r in $renames) {
    $fromPath = Join-Path $VaultRoot $r.From
    if (Test-Path $fromPath) {
        Write-Host "${dryLabel}  $($r.From) -> $($r.To)"
        if (-not $DryRun) {
            Rename-Item -Path $fromPath -NewName $r.To -ErrorAction Stop
        }
    } else {
        Write-Host "  [SKIP] $($r.From) not found"
    }
}

# ── Phase 2: Update text references in all .md files ────────
Write-Host ""
Write-Host "${dryLabel}=== Phase 2: Text reference update ==="

$mdFiles = Get-ChildItem -Path $VaultRoot -Recurse -Filter "*.md" |
           Where-Object { $_.FullName -notmatch "\\_forge\\staging\\" }

$updatedCount = 0

foreach ($file in $mdFiles) {
    $path = $file.FullName
    $text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
    $orig = $text

    # Standards/ -> _Standards/ (skip if already _Standards/)
    $text = $text -replace '(?<![_\w])Standards/', '_Standards/'

    # tools/ -> _tools/ (forward slash)
    $text = $text -replace '(?<![_\w])tools/', '_tools/'

    # tools\ -> _tools\ (backslash, Windows path in code blocks)
    $text = $text -replace '(?<![_\w])tools\\', '_tools\'

    # VaultReview/ -> _VaultReview/
    $text = $text -replace '(?<![_\w])VaultReview/', '_VaultReview/'

    # VAULT-INDEX -> _VAULT-INDEX (covers [[VAULT-INDEX]], VAULT-INDEX.md etc.)
    $text = $text -replace '(?<![_\w])VAULT-INDEX', '_VAULT-INDEX'

    # STATUS.md -> _STATUS.md (AGENT_STATUS.md is safe: _ before STATUS)
    $text = $text -replace '(?<![_\w])STATUS\.md', '_STATUS.md'
    $text = $text -replace '\[\[STATUS\]\]',        '[[_STATUS]]'

    # WORKFLOW.md -> _WORKFLOW.md
    $text = $text -replace '(?<![_\w])WORKFLOW\.md', '_WORKFLOW.md'
    $text = $text -replace '\[\[WORKFLOW\]\]',        '[[_WORKFLOW]]'

    if ($text -ne $orig) {
        $updatedCount++
        Write-Host "${dryLabel}  $($file.Name)"
        if (-not $DryRun) {
            [System.IO.File]::WriteAllText($path, $text, [Text.UTF8Encoding]::new($false))
        }
    }
}

Write-Host ""
Write-Host "${dryLabel}Files to update: $updatedCount"
Write-Host ""

if ($DryRun) {
    Write-Host "DRY-RUN done. No changes made."
    Write-Host "To apply: .\rename_env_prefix.ps1"
} else {
    Write-Host "RENAME_COMPLETE=1"
}
