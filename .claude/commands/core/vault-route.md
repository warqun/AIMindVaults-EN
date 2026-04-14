# /vault-route — Vault Routing and Entry

Arguments: $ARGUMENTS
Usage: `/vault-route [vault name or task description]`

---

## Execution Order

### 1. Identify Target Vault

Determine the vault from `$ARGUMENTS`:

| Input Pattern | Target Vault |
|---------------|--------------|
| "AIHubVault", "AI workspace", "agent", "_Standards" | AIHubVault |
| "BasicContentsVault", "contents", "note writing" | BasicContentsVault |
| Includes file path | Extract vault from path |
| Ambiguous | Confirm with user |

Vault path reference: Vault registry table in `CLAUDE.md`.

### 2. Enter Vault

Read the following in order:
1. Root `_STATUS.md` — Check overall vault status + other vault activity
2. `{vault-path}/CLAUDE.md` — Check vault-specific rules
3. `{vault-path}/_STATUS.md` — Check current progress

### 3. Report Entry Complete

```
===================================
Vault Entry Complete
===================================
Vault: [vault name]
Path: [path]
Current Status: [1-line _STATUS.md summary]
===================================
```

### 4. Await Tasks

Wait for the user's task instructions. Subsequent work is performed within the context of this vault.
