---
description: "Open an Obsidian note"
---

# /open-note — Open an Obsidian Note

## Purpose

Open the specified Obsidian note inside its vault.

## Prerequisite

- The Advanced URI plug-in must be installed and enabled in the target vault.
- If missing, use `/install-plugin` to install it.

## Procedure

### 1. Resolve the target file

- If a note path or title is given as the argument, use it.
- If only the title is given, find the path via Glob.
- If the vault name is unspecified, derive it from the path or confirm with the user.

### 2. Filename safety check

- Check whether the filename contains URI-reserved characters (`#`, `%`, `&`, `?`, `+`).
- **If it does**: tell the user — "the filename contains special characters such as `#`; this URI cannot open it. Please rename the file from inside Obsidian."
- Do not attempt the URI open (avoids creating an empty note).

### 3. Open the vault

```powershell
Start-Process 'obsidian://open?vault=<vault-name>'
```

- Wait 3 seconds (vault loading).

### 4. Open the note

```powershell
Start-Process 'obsidian://advanced-uri?vault=<vault-name>&filepath=<vault-relative-path>'
```

- The path must be URL-encoded (handles spaces and non-ASCII chars).
- Drop the `.md` extension.

### 5. Verify

- Ask the user whether the note opened.
- On failure:
  - Confirm the Advanced URI plug-in is enabled.
  - Mention a possible filename / path typo.
  - Suggest opening manually via Obsidian search (`Ctrl+O`).

## Examples

```
/open-note <Note Title>
/open-note <full vault-relative path>.md
```

## Limitations

- **A filename containing `#`, `%`, `&`, `?`, or `+` cannot be opened** — a structural Obsidian-URI limitation.
- For details, see the ObsidianDev report on the URI hash issue.
- Rename the file from inside Obsidian and retry.

## References

- `/install-plugin` — install Advanced URI
- `/open-vault` — open a vault
