# /hub-broadcast — Broadcast a Hub File to All Vaults

Immediately propagate a specific file inside `AIHubVault/.sync/` to every satellite vault.

## Usage

```
/hub-broadcast <path-relative-to-.sync> [options]
```

Examples:
- `/hub-broadcast _tools/cli-node/src/commands/index-build.js` — broadcast the indexer.
- `/hub-broadcast _Standards/Core/Script_Registry.md --force` — include vaults missing the file.
- `/hub-broadcast _tools/cli-node/bin/cli.js --exclude TestVault` — exclude a specific vault.
- `/hub-broadcast _tools/cli-node/package.json --dry-run` — preview only.

## Command

```bash
node "{AIHubVault}/.sync/_tools/cli-node/bin/cli.js" broadcast -p "<path-relative-to-.sync>" [-d] [-f] [-e <vault-name>]
```

- `{AIHubVault}` = `C:/AIMindVaults/Vaults/BasicVaults/AIHubVault`

## Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `-p, --relative-path` | Path relative to `.sync/` | required |
| `-d, --dry-run` | List targets without copying | false |
| `-f, --force` | Create the file even where it doesn't exist | false |
| `-e, --exclude` | Exclude vault name pattern (repeatable) | none |

## Difference from `aimv sync`

| Aspect | `aimv sync` | `aimv broadcast` |
|--------|-------------|-------------------|
| Scope | Whole workspace | One specific file |
| Direction | Bidirectional (version compare) | Hub → satellite (one-way) |
| Unit | One vault at a time | All vaults in one run |
| Use | Routine sync | Urgent / immediate push |

## Rules

- Default: overwrite only vaults that already have the file.
- `-f, --force`: also create the file in vaults that lack it.
- AIHubVault itself is always excluded.
- If the source file is missing in the Hub, the command errors out.
