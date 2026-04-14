---
description: "Open an Obsidian note"
---

# /open-note — Open an Obsidian Note

## Purpose

Opens and displays a specified Obsidian note in its vault.

## Prerequisites

- The Advanced URI plugin must be installed and activated in the target vault
- If not present, guide installation via the `/install-plugin` skill

## Procedure

### 1. Identify Target File

- If a note path or title is provided as an argument, use it
- If only a title is given, search via Glob to identify the path
- If the vault name is not specified, extract from the path or confirm with the user

### 2. Filename Safety Check

- Check if the filename contains URI reserved characters (`#`, `%`, `&`, `?`, `+`)
- **If present**: Inform the user — "This filename contains special characters like `#` and cannot be opened via URI. Please rename the file within Obsidian."
- Do not attempt to open via URI (to prevent blank note creation)

### 3. Open Vault

```powershell
Start-Process 'obsidian://open?vault=VaultName'
```

- Wait 3 seconds (for vault loading)

### 4. Open Note

```powershell
Start-Process 'obsidian://advanced-uri?vault=VaultName&filepath=relative_path_within_vault'
```

- Apply URL encoding to the path (for non-ASCII characters, spaces, etc.)
- Exclude the `.md` extension

### 5. Verify Opening

- Confirm with the user that the note has opened
- On failure:
  - Guide checking Advanced URI plugin activation status
  - Note potential file path errors
  - Guide manual opening via Obsidian search (`Ctrl+O`)

## Usage Examples

```
/open-note Unity CSharp Job System
/open-note C:\AIMindVaults\Vaults\Domains_Game\Unity\Contents\Domain\DOTS\04_Jobs_Burst\Unity CSharp Job System.md
```

## Limitations

- **Cannot open files with `#`, `%`, `&`, `?`, `+` in the filename** — structural limitation of Obsidian URI
- Details: ObsidianDev vault `20260320_Obsidian_URI_Hash_Final_Report.md`
- Rename such files within Obsidian and retry

## References

- [[20260320_Obsidian_URI_Hash_Final_Report]]
- `/install-plugin` — Advanced URI installation
- `/open-vault` — Open vault
