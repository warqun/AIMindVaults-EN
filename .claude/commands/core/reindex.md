---
description: "Rebuild vault content index"
---

# /reindex — Rebuild Vault Content Index

## Purpose

Rebuild `vault_index.json` for a single vault or for every active vault.

## Usage

```
/reindex              — incremental build for the current vault
/reindex all          — iterate every active vault, incremental build
/reindex <YourVault>  — incremental build for a specific vault
/reindex all --full   — full rebuild for every vault (ignore cache)
```

## Procedure

### Single vault

1. Identify the target vault path (argument or current working vault).
2. Confirm `{vault-path}/.sync/_tools/cli-node/bin/cli.js` exists.
3. Run:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}" -i
```
4. With `--full`, drop the `-i` flag to force a full rebuild.

### All vaults (`all`)

1. Collect the active vault list from the root `_STATUS.md`.
2. Iterate each vault:
   a. Confirm `.sync/_tools/cli-node/bin/cli.js` exists.
   b. If missing, skip (log it).
   c. Otherwise run `node cli.js index build -r "{vault-path}" -i` for incremental build.
3. Print per-vault result (success/fail/note count/elapsed).
4. Print the overall summary.

### Vault name → path mapping

Look up the mapping in the vault registry in the root `CLAUDE.md`.
Iterate the `Vaults/` subdirectory to find the folder matching the name.

## Output

```
=== Vault Reindex Result ===
AIHubVault    : 114 notes, 0.12s (incremental, 2 updated)
<VaultA>      : 183 notes, 0.21s (incremental, 0 updated)
<VaultB>      : 32 notes, 0.08s (incremental, 5 new)
<VaultC>      : skipped (no indexer script)
...
Total: N vaults, 1 skipped, 0 failed, 1.2s total
```

## References

- `aimv index build` — the indexer (`.sync/_tools/cli-node/`)
- `aimv index search` — the search engine (`.sync/_tools/cli-node/`)
- `aimv review` — auto-invokes the indexer after note edits
