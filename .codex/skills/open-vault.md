---
description: "Open an Obsidian vault"
---

# open-vault

Opens the specified Obsidian vault.

## Parameters

- `vault`: Vault name registered in Obsidian (required)

## Execution

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$vault
)

$encodedVault = [System.Uri]::EscapeDataString($vault)
$uri = "obsidian://open?vault=$encodedVault"
Start-Process $uri
```

## Usage Example

```powershell
# open-vault "Project_AIMindVaults"
```

## Notes

- The vault name must exactly match the name registered in Obsidian.
- If it fails, check for typos in the vault name or whether Obsidian is running/installed.
