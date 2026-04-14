---
description: "Open an Obsidian vault"
---

# /open-vault — Open an Obsidian Vault

## Purpose

Open and activate a specified Obsidian vault.

## Procedure

1. **Identify the vault name**
   - Use the argument if supplied.
   - Otherwise check the root `CLAUDE.md` vault registry and ask the user.

2. **Open the vault**
   ```powershell
   Start-Process 'obsidian://open?vault=VaultName'
   ```

3. **Confirm it opened**
   - Ask the user whether the vault opened.
   - On failure, suspect a typo in the vault name.

## Examples

```
/open-vault Unity
/open-vault AIHubVault
/open-vault ObsidianDev
```

## Notes

- The vault name must match exactly the one registered with Obsidian.
- Fails if the vault isn't registered in Obsidian.
- **If you need to open an unregistered vault**: do not use `obsidian://open?path=`. Instruct the user to register it via the Vault Manager:
  > Obsidian Vault Manager → "Open folder as vault" → select `{vault-path}`.
