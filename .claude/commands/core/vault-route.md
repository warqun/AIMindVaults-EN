# /vault-route — Vault Routing and Entry

Argument: $ARGUMENTS
Usage: `/vault-route [vault-name or task description]`

---

## Execution Order

### 1. Identify the target vault

Resolve the vault from `$ARGUMENTS`:

| Input pattern | Target vault |
|---------------|--------------|
| "AIHubVault", "AI workspace", "agent", "_Standards" | AIHubVault |
| "BasicContentsVault", "content", "note authoring" | BasicContentsVault |
| Contains a file path | Extract the vault from the path |
| Ambiguous | Confirm with the user |

Vault path reference: the vault registry table in `CLAUDE.md`.

### 2. Enter the vault

Read in order:
1. Root `_STATUS.md` — overall vault state + cross-vault conflict check.
2. `{vault-path}/CLAUDE.md` — vault-specific rules.
3. `{vault-path}/_STATUS.md` — current progress.

### 3. Entry completion report

```
═══════════════════════════════════════
✅ Vault entry complete
═══════════════════════════════════════
Vault: [name]
Path: [path]
Current state: [one-line _STATUS.md summary]
═══════════════════════════════════════
```

### 4. Wait for work

Wait for the user's task instruction. Subsequent work happens inside the entered vault's context.
