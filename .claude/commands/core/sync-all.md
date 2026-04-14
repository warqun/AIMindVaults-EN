# /sync-all — Sync All Satellite Vault Workspaces

Synchronizes workspaces of all satellite vaults to the latest state based on AIHubVault.
Runs `aimv sync` sequentially on each vault for batch synchronization.

## Usage

```
/sync-all [options]
```

Examples:
- `/sync-all` — Sync all satellite vaults
- `/sync-all --dry-run` — Preview only (no actual sync)
- `/sync-all --exclude TestVault` — Exclude a specific vault

## Procedure

### 1. Execute Full Sync

Run the Node.js CLI sequentially in each satellite vault directory:

```bash
# For each satellite vault:
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" sync -r "{vault-path}"
```

Alternatively, auto-detect vaults with `cli.js` via Glob and iterate. AIHubVault is the source and is excluded.

### 2. Verify Results

- Each vault outputs a `SYNC_RESULT=` log.
- `SYNC_RESULT=OK` or `SYNC_RESULT=ALREADY_LATEST` -> Normal
- `SYNC_RESULT=ERROR` -> Individual vault investigation required

## Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `--dry-run` | Pass the DryRun flag to each `aimv sync` | false |
| `--exclude <vault-name>` | Skip specified vaults (multiple allowed) | None |

## Difference from hub-broadcast

| Aspect | /sync-all | /hub-broadcast |
|--------|-----------|----------------|
| Scope | Entire workspace (all sync target files) | Single specific file |
| Method | Bidirectional based on version comparison | Hub -> satellite one-way forced copy |
| Use case | Regular full refresh | Urgent propagation of a specific file |
| Speed | Slow (version comparison + hash check per vault) | Fast (simple copy) |

## Behavior Rules

- AIHubVault is the source and does not sync to itself.
- Each vault's `_WORKSPACE_VERSION.md` is compared with Hub; actual file copying occurs only for vaults with differences.
- Vaults already up to date are quickly skipped as `ALREADY_LATEST`.
- After sync, each vault's `_WORKSPACE_VERSION.md` is updated to the Hub version.

## Recommended Usage

- After completing workspace edits in Hub, to propagate changes across all vaults
- After creating multiple new vaults, for batch initialization
- When checking sync status after a long period
