---
description: "Open an Obsidian vault"
---

# /open-vault — Open an Obsidian Vault

## Purpose

Open and activate the specified Obsidian vault.

## Execution

1. **Identify the vault**
   - If a vault name is given as an argument, use it.
   - Otherwise, look it up in the root `CLAUDE.md` vault registry and ask the user.

2. **Open the vault**
   ```powershell
   Start-Process 'obsidian://open?vault=<vault-name>'
   ```

3. **Verify**
   - Ask the user whether the vault opened.
   - On failure, mention a possible vault-name typo.

## Examples

```
/open-vault <vault-name>
```

## Cautions

- The vault name must match the name registered in Obsidian exactly.
- Fails if the vault is not registered in Obsidian.
- **If you must open an unregistered vault**: do not use `obsidian://open?path=`. Instead, ask the user to register it via the vault manager:
  > Obsidian vault manager → "Open vault folder" → select `{vault path}`
