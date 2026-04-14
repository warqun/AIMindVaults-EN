---
description: "Open an Obsidian vault"
---

# /open-vault — Open an Obsidian Vault

## Purpose

Opens and activates a specified Obsidian vault.

## Procedure

1. **Identify Vault Name**
   - If a vault name is provided as an argument, use it
   - If not, check the root `CLAUDE.md` vault registry and ask the user

2. **Open the Vault**
   ```powershell
   Start-Process 'obsidian://open?vault=VaultName'
   ```

3. **Verify Opening**
   - Confirm with the user that the vault has opened
   - On failure, note possible vault name errors

## Usage Examples

```
/open-vault Unity
/open-vault AIHubVault
/open-vault ObsidianDev
```

## Notes

- The vault name must exactly match the name registered in Obsidian
- Opening fails if the vault is not registered in Obsidian
- **If you need to open an unregistered vault**: Do not use the `obsidian://open?path=` URI. Guide the user to register it directly via the vault manager:
  > Obsidian Vault Manager -> "Open folder as vault" -> Select `{vault path}`
