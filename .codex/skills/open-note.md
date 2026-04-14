---
description: "Open an Obsidian note"
---

# open-note

Opens a note in the specified Obsidian vault.

## Parameters

- `vault`: Vault name registered in Obsidian (required)
- `file`: Relative file path from vault root (required)

## Execution

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$vault,
    [Parameter(Mandatory=$true)]
    [string]$file
)

$encodedVault = [System.Uri]::EscapeDataString($vault)
$normalizedFile = $file -replace '\\','/'
$encodedFile = [System.Uri]::EscapeDataString($normalizedFile)

$uri = "obsidian://open?vault=$encodedVault&file=$encodedFile"
Start-Process $uri
```

## Usage Example

```powershell
# open-note "Project_AIMindVaults" "Contents/Project/plan/AIMindVaults_plan/20260321_Indexing_Trigger_Design.md"
```

## Notes

- File names with non-ASCII characters, spaces, or special characters must be URI-encoded.
- File paths use relative paths from the vault root.
- If the vault name or path is incorrect, the note will not open.
