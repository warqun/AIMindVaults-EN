---
description: "Open an Obsidian note"
---

# /open-note — Open an Obsidian Note

## Purpose

Open and display a specified Obsidian note inside its vault.

## Prerequisites

- The Advanced URI plugin must be installed and enabled in the target vault.
- If it isn't, guide the user through `/install-plugin`.

## Procedure

### 1. Identify the target file

- If an argument supplies a note path or title, use it.
- If only a title is given, search via Glob and resolve the path.
- If the vault name isn't specified, extract it from the path or ask the user.

### 2. Filename safety check

- Check whether the filename contains URI-reserved characters (`#`, `%`, `&`, `?`, `+`).
- **If it does**: tell the user — "This filename contains a special character like `#` and cannot be opened via URI. Please rename the file from within Obsidian."
- Do not attempt to open via URI (to avoid creating a blank note).

### 3. Open the vault

```powershell
Start-Process 'obsidian://open?vault=VaultName'
```

- Wait 3 seconds for vault load.

### 4. Open the note

```powershell
Start-Process 'obsidian://advanced-uri?vault=VaultName&filepath=relative_path_inside_vault'
```

- Apply URL encoding to the path (non-ASCII, spaces, etc.).
- Omit the `.md` extension.

### 5. Confirm it opened

- Ask the user whether the note opened.
- On failure:
  - Check whether the Advanced URI plugin is enabled.
  - Consider a file-path error.
  - Fall back to Obsidian quick-switch (`Ctrl+O`) manually.

## Examples

```
/open-note AIHubVault weekly review
/open-note C:\AIMindVaults\Vaults\BasicVaults\AIHubVault\Contents\Domain\Example\Example_Note.md
```

## Limitations

- **Files with `#`, `%`, `&`, `?`, `+` in the name cannot be opened** — structural limit of Obsidian URIs.
- Rename in Obsidian, then retry.

## References

- `/install-plugin` — install Advanced URI
- `/open-vault` — open a vault
