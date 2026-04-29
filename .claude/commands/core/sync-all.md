# /sync-all — Bulk-Sync Workspace Across All Satellite Vaults

Brings every satellite vault's workspace up to date relative to the AIHubVault.
This is the bulk version of running `aimv sync` in each vault.

## Usage

```
/sync-all [options]
```

Examples:
- `/sync-all` — sync every satellite vault
- `/sync-all --dry-run` — preview only (no actual sync)
- `/sync-all --exclude TestVault` — exclude specific vaults

## Procedure

### 1. Run the bulk sync

In each satellite vault directory, run the Node.js CLI sequentially:

```bash
# For each satellite vault:
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" sync -r "{vault path}"
```

Or auto-discover vaults that have `cli.js` via Glob and iterate. Skip the AIHubVault (it is the source).

### 2. Verify results

- Each vault prints a `SYNC_RESULT=` log.
- `SYNC_RESULT=OK` or `SYNC_RESULT=ALREADY_LATEST` → success.
- `SYNC_RESULT=ERROR` → inspect that vault individually.

## Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `--dry-run` | Forward DryRun to each `aimv sync` | false |
| `--exclude <vault>` | Skip the named vault (repeatable) | none |

## vs. hub-broadcast

| Item | /sync-all | /hub-broadcast |
|------|-----------|----------------|
| Scope | Whole workspace (every sync target) | A single specific file |
| Mode | Bidirectional, version-compared | Hub → satellite forced copy |
| Use case | Routine bulk refresh | Urgent propagation of one file |
| Speed | Slow (per-vault version compare + hash check) | Fast (simple copy) |

## Behavior

- The AIHubVault is the source and is not synced to itself.
- Each vault's `_WORKSPACE_VERSION.md` is compared with the Hub's; only mismatching vaults perform actual file copies.
- Already-current vaults are skipped quickly as `ALREADY_LATEST`.
- After syncing, each vault's `_WORKSPACE_VERSION.md` is updated to the Hub version.

## When to Use

- After completing a workspace edit on the Hub and you want to propagate it to everyone.
- After creating multiple new vaults and you want to initialize them in bulk.
- A periodic check-up of the sync state.
