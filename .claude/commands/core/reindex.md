---
description: "Rebuild vault contents index"
---

# /reindex — Rebuild Vault Contents Index

## Purpose

Rebuilds `vault_index.json` for a single vault or all active vaults.

## Usage

```
/reindex              — Incremental build for the currently active vault only
/reindex all          — Incremental build across all active vaults
/reindex Unity        — Incremental build for a specific vault
/reindex all --full   — Full build for all vaults (ignoring cache)
```

## Procedure

### Single Vault

1. Identify target vault path (from argument or currently active vault)
2. Verify `{vault-path}/.sync/_tools/cli-node/bin/cli.js` exists
3. Execute:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}" -i
```
4. With the `--full` option, remove `-i` (incremental) for a full build

### All Vaults (`all`)

1. Collect the list of active vaults from root `C:\AIMindVaults\_STATUS.md`
2. Iterate through each vault:
   a. Verify `.sync/_tools/cli-node/bin/cli.js` exists
   b. If not found, skip (log it)
   c. If found, run `node cli.js index build -r "{vault-path}" -i` for incremental build
3. Output per-vault results (success/failure/note count/elapsed time)
4. Output overall summary

### Vault Path Mapping

Vault name to path mapping references the vault registry in the root `CLAUDE.md`.
Iterates through subdirectories under `Vaults/` to find a folder matching the vault name.

## Result Output

```
=== Vault Reindex Results ===
AIHubVault    : 114 notes, 0.12s (incremental, 2 updated)
Unity         : 183 notes, 0.21s (incremental, 0 updated)
JissouGame    : 32 notes, 0.08s (incremental, 5 new)
Search        : skipped (no indexer script)
...
Total: 15 vaults, 1 skipped, 0 failed, 1.2s total
```

## References

- `aimv index build` — Indexer core (`.sync/_tools/cli-node/`)
- `aimv index search` — Search engine (`.sync/_tools/cli-node/`)
- `aimv review` — Auto-invokes indexer after note editing
