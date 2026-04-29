---
description: "Rebuild a vault content index"
---

# /reindex — Rebuild Vault Content Index

## Purpose

Rebuild `vault_index.json` for a single vault or for every active vault.

## Usage

```
/reindex                — incremental build for the current vault only
/reindex all            — incremental build, iterating every active vault
/reindex Unity          — incremental build for a specific vault
/reindex all --full     — full rebuild for every vault (ignoring cache)
```

## Procedure

### Single vault

1. Resolve the target vault path (argument or current vault).
2. Verify `{vault path}/.sync/_tools/cli-node/bin/cli.js` exists.
3. Run:
```bash
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault path}" -i
```
4. With `--full`, drop the `-i` (incremental) flag for a full build.

### All vaults (`all`)

1. Collect the active-vault list from the root `_STATUS.md`.
2. Iterate:
   a. Verify `.sync/_tools/cli-node/bin/cli.js` exists.
   b. Skip if missing (logged).
   c. Otherwise run `node cli.js index build -r "{vault path}" -i` (incremental).
3. Print per-vault results (success / failure / note count / elapsed).
4. Print an overall summary.

### Vault-name → path mapping

Vault-name → path mapping is taken from the root `CLAUDE.md` vault registry.
Iterate the directories under `Vaults/` and match by vault name.

## Output

```
=== Vault reindex result ===
<Vault A>     : 114 notes, 0.12s (incremental, 2 updated)
<Vault B>     : 183 notes, 0.21s (incremental, 0 updated)
<Vault C>     :  32 notes, 0.08s (incremental, 5 new)
<Vault D>     : skipped (no indexer script)
...
Total: 15 vaults, 1 skipped, 0 failed, 1.2s total
```

## References

- `aimv index build` — the indexer (`.sync/_tools/cli-node/`)
- `aimv index search` — the search engine (`.sync/_tools/cli-node/`)
- `aimv review` — auto-invokes the indexer after note edits
