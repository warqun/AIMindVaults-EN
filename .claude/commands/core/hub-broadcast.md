# /hub-broadcast — Propagate a Hub File to Every Vault

Immediately propagates a specific file in the AIHubVault `.sync/` to every satellite vault.

## Usage

```
/hub-broadcast <relative path under .sync> [options]
```

Examples:
- `/hub-broadcast _tools/cli-node/src/commands/index-build.js` — propagate the indexer
- `/hub-broadcast _Standards/Core/Script_Registry.md --force` — propagate including new files
- `/hub-broadcast _tools/cli-node/bin/cli.js --exclude TestVault` — exclude specific vaults
- `/hub-broadcast _tools/cli-node/package.json --dry-run` — preview only

## Command

```bash
node "{AIHubVault}/.sync/_tools/cli-node/bin/cli.js" broadcast -p "<relative path under .sync>" [-d] [-f] [-e <vault-name>]
```

- `{AIHubVault}` is the Preset Hub path (e.g., `Vaults/BasicVaults/AIHubVault`).

## Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `-p, --relative-path` | Path relative to `.sync/` | required |
| `-d, --dry-run` | Print the target list without copying | false |
| `-f, --force` | Create the file even on vaults that lack it | false |
| `-e, --exclude` | Vault-name pattern(s) to exclude (repeatable) | none |

## vs. `aimv sync`

| Item | `aimv sync` | `aimv broadcast` |
|------|-------------|-------------------|
| Scope | Whole workspace | A single specific file |
| Direction | Two-way (version compared) | Hub → satellite (one-way) |
| Unit | One vault at a time | All vaults at once |
| Use case | Routine sync | Urgent / immediate propagation |

## Behavior

- Default: overwrite only when the target vault already has the file.
- `-Force`: also create the file on vaults that lack it.
- The AIHubVault itself is always excluded.
- If the source file is missing on the Hub, exit with an error.

## Canon / Propagated-Copy / Generated-Artifact Split

Before invoking broadcast, classify the target file:
- If it is the **canon**, broadcast is appropriate.
- If it is a **propagated copy** or **generated artifact**, fix the canon (or the installer / sync logic) first; broadcasting the copy leaves stale duplicates on satellites.
