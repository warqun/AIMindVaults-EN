# fix_false_positives.ps1
# Fix: issue-_WORKFLOW.md -> issue-workflow.md (false positive from rename script)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VaultRoot = (Resolve-Path "$ScriptDir\..\..").Path
$files = Get-ChildItem -Path $VaultRoot -Recurse -Filter "*.md"
$fixCount = 0

foreach ($file in $files) {
    $path = $file.FullName
    $text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
    $orig = $text

    $text = $text -replace 'issue-_WORKFLOW\.md', 'issue-workflow.md'

    if ($text -ne $orig) {
        $fixCount++
        Write-Host "Fixed: $($file.Name)"
        [System.IO.File]::WriteAllText($path, $text, [Text.UTF8Encoding]::new($false))
    }
}

Write-Host "FIX_COMPLETE=1 | Fixed: $fixCount files"
