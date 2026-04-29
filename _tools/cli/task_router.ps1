param(
    [Parameter(Mandatory=$true)]
    [string]$Task
)

$taskLower = $Task.ToLowerInvariant()

$primary = 'Claude'
$secondary = 'Codex'
$reason = 'default: goal / structuring-centric work'

if ($taskLower -match 'script|automation|batch|cli|rg|regex|validation|test|refactor|parse') {
    $primary = 'Codex'
    $secondary = 'Claude'
    $reason = 'automation / technical verification / repetitive processing'
} elseif ($taskLower -match 'alternative|compare|summary|restructure|sentence|description|documentation') {
    $primary = 'Gemini'
    $secondary = 'Claude'
    $reason = 'alternative-comparison / explanatory restructuring'
} elseif ($taskLower -match 'risk|review|threat') {
    $primary = 'Antigravity'
    $secondary = 'Codex'
    $reason = 'risk detection / review'
}

$handoff = @"
Task: $Task
Primary: $primary
Input: (required files / logs, 1-3)
Output: (one of: checklist / patch / summary)
Completion criteria: (1-2 completion conditions)
Next agent (optional): $secondary
"@

[pscustomobject]@{
    task = $Task
    primary = $primary
    secondary = $secondary
    reason = $reason
    handoff = $handoff
} | Format-List | Out-String | Write-Output
