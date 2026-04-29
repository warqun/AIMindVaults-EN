# /vault-route — Vault Routing and Entry

Argument: $ARGUMENTS
Usage: `/vault-route [vault-name or work description]`

---

## Execution Order

### 1. Identify the Target Vault

Resolve the vault from `$ARGUMENTS`:

| Input pattern | Target vault |
|---------------|--------------|
| (per-user vault keywords; see CLAUDE.md routing table) | (resolved vault ID) |
| File path included | Extract the vault from the path |
| Ambiguous | Confirm with the user |

Vault paths: see the vault-registry table in `CLAUDE.md` / `_STATUS.md`.

### 2. Enter the Vault

Read in this order:
1. Root `_STATUS.md` — overall vault state + cross-vault work check
2. `{vault path}/CLAUDE.md` — vault-specific rules
3. `{vault path}/_STATUS.md` — current progress

### 3. Entry Report

```
═══════════════════════════════════════
✅ Vault entry complete
═══════════════════════════════════════
Vault : [name]
Path  : [path]
State : [1-line _STATUS.md summary]
═══════════════════════════════════════
```

### 4. Wait for Work

Wait for the user's instruction. Subsequent work is performed inside that vault's context.
