# /hub-broadcast — Broadcast Hub File to All Vaults

Immediately propagates a specific file from AIHubVault's `.sync/` to all satellite vaults.

## Usage

```
/hub-broadcast <relative-path-from-.sync> [options]
```

Examples:
- `/hub-broadcast _tools/cli-node/src/commands/index-build.js` — Propagate indexer
- `/hub-broadcast _Standards/Core/Script_Registry.md --force` — Propagate including new files
- `/hub-broadcast _tools/cli-node/bin/cli.js --exclude TestVault` — Exclude specific vault
- `/hub-broadcast _tools/cli-node/package.json --dry-run` — Preview only

## Execution Command

```bash
node "{AIHubVault}/.sync/_tools/cli-node/bin/cli.js" broadcast -p "<relative-path-from-.sync>" [-d] [-f] [-e <vault-name>]
```

- `{AIHubVault}` = `C:/AIMindVaults/Vaults/BasicVaults/AIHubVault`

## Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `-p, --relative-path` | Relative path from `.sync/` | Required |
| `-d, --dry-run` | Output target list only without actual copying | false |
| `-f, --force` | Force creation even if file doesn't exist in target vault | false |
| `-e, --exclude` | Vault name pattern to exclude (multiple allowed) | None |

## Difference from `aimv sync`

| Aspect | `aimv sync` | `aimv broadcast` |
|--------|-------------|-------------------|
| Scope | Entire workspace | Single specific file |
| Direction | Bidirectional (version comparison) | Hub -> satellite one-way |
| Unit | One vault at a time | All vaults at once |
| Use case | Regular synchronization | Urgent/immediate propagation |

## Behavior Rules

- Default: Only overwrites if the file already exists in the target vault
- `-Force`: Creates new files even in vaults that don't have them
- AIHubVault itself is always excluded
- Exits with error if the source file doesn't exist in Hub
