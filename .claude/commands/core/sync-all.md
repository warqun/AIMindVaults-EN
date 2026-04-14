# /sync-all — Sync Every Satellite Vault's Workspace

Bring every satellite vault's workspace up to date against AIHubVault.
Runs `aimv sync` per vault in sequence — a batch sync.

## Usage

```
/sync-all [options]
```

Examples:
- `/sync-all` — sync all satellites.
- `/sync-all --dry-run` — preview only (no sync).
- `/sync-all --exclude TestVault` — skip a specific vault.

## Procedure

### 1. Run per-vault sync

For each satellite vault directory, run the Node.js CLI in sequence:

```bash
# for each satellite vault:
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" sync -r "{vault-path}"
```

Or glob for vaults containing `cli.js` and iterate. Skip AIHubVault (it is the source).

### 2. Check results

- Each vault emits a `SYNC_RESULT=` log line.
- `SYNC_RESULT=OK` or `SYNC_RESULT=ALREADY_LATEST` → fine.
- `SYNC_RESULT=ERROR` → inspect that vault individually.

## Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `--dry-run` | Pass DryRun to each `aimv sync` | false |
| `--exclude <vault>` | Skip named vault (repeatable) | none |

## Difference from hub-broadcast

| Aspect | /sync-all | /hub-broadcast |
|--------|-----------|----------------|
| Scope | Whole workspace (all sync targets) | One specific file |
| Method | Bidirectional version compare | Hub → satellite forced copy |
| Use | Routine full refresh | Urgent push of a specific file |
| Speed | Slow (version + hash check per vault) | Fast (plain copy) |

## Rules

- AIHubVault is the source and is never synced into itself.
- Each vault's `_WORKSPACE_VERSION.md` is compared against the Hub; only differing vaults actually copy files.
- Already-current vaults are skipped quickly as `ALREADY_LATEST`.
- After sync, each vault's `_WORKSPACE_VERSION.md` is updated to the Hub version.

## When to Use

- After finishing workspace edits in the Hub, to roll them out.
- After creating multiple new vaults at once, for a bulk first sync.
- As a periodic check to catch drift.
