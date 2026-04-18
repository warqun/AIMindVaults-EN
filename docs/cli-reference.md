# AIMindVaults CLI Reference

A Node.js cross-platform CLI that drives the core of AIMindVaults: vault indexing, sync, review, and vault management.

- Location: `.sync/_tools/cli-node/bin/cli.js`
- Program name: `aimv`
- Runtime: Node.js ESM
- Platforms: Windows / macOS / Linux

## How to run

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" <command> [options]
```

Or, after a global install / alias:

```bash
aimv <command> [options]
```

---

## Indexer

### index build

Build the vault's content index. Produces `vault_index.json`, which becomes the source for `index search`.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |
| `-i, --incremental` | Incremental build (changed files only) | false |
| `-v, --verbose` | Verbose output | false |

```bash
# full build
node cli.js index build -r "/path/to/vault"

# incremental build (changed files only)
node cli.js index build -r "/path/to/vault" -i
```

---

### index search

Search notes in the index. Combines keyword, tag, and type filters.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |
| `-q, --query <keyword>` | Keyword search (weighted by title / tags / headings) | |
| `-t, --tag <tag>` | Tag filter | |
| `--type <type>` | Frontmatter type filter | |
| `-f, --format <fmt>` | Output format (`table` \| `compact`) | `table` |
| `-n, --top <n>` | Max results | 10 |

```bash
# keyword search
node cli.js index search -q "color theory"

# tag + compact output
node cli.js index search -q "color theory" -t "knowledge" -f compact

# type filter
node cli.js index search --type "study-note" -n 5
```

---

### index master-build

Build a cross-vault master index spanning every AIMindVaults vault. Use when searching across vault boundaries.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --root <path>` | AIMindVaults root | auto-detect |
| `--vault-name <name>` | Update a single vault only | |

```bash
# build the full master index
node cli.js index master-build

# refresh a single vault
node cli.js index master-build --vault-name "YourVault"
```

---

### index master-search

Cross-vault search against the master index.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --root <path>` | AIMindVaults root | auto-detect |
| `-q, --query <keyword>` | Keyword search | |
| `-t, --tag <tag>` | Tag filter | |
| `--vault <vault>` | Vault name filter | |
| `-f, --format <fmt>` | Output format (`table` \| `compact`) | `table` |
| `-n, --top <n>` | Max results | 15 |
| `-c, --concepts-only` | Show the cross-vault concept map only | false |

```bash
# cross-vault keyword search
node cli.js index master-search -q "skill system"

# search within one vault
node cli.js index master-search -q "workflow" --vault "YourVault"

# show the cross-vault concept map only
node cli.js index master-search -c
```

---

## Review

### review

Run UTF-8 encoding validation and automatic re-indexing after a note edit. Must run immediately after any edit.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |
| `-s, --scope <name>` | Restrict to a named folder | |
| `-v, --verbose` | Verbose output | false |

**Output codes:**

| Output | Meaning |
|--------|---------|
| `POST_EDIT_REVIEW_BAD=0` | No encoding errors (good) |
| `POST_EDIT_REVIEW_BAD=N` | N errors — fix the listed files |
| `POST_EDIT_INDEX_UPDATED=1` | Indexing complete |
| `POST_EDIT_INDEX_SKIPPED=1` | Indexing skipped — manual build needed |

On pass, `review` auto-invokes `index build -i`.

```bash
# standard review
node cli.js review -r "/path/to/vault"

# scope to the Contents folder
node cli.js review -r "/path/to/vault" -s "Contents"
```

If `POST_EDIT_INDEX_SKIPPED=1`, refresh manually:

```bash
node cli.js index build -r "/path/to/vault" -i
```

---

## Sync

### sync

Sync workspace files between the Hub (AIHubVault) and a satellite vault.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |
| `--hub-path <path>` | Hub path | auto-detect |
| `-d, --dry-run` | Preview without changes | false |
| `--no-prune` | Don't delete files that exist only in the target | false |
| `--verify-content` | Force file-hash verification even when versions match | false |

```bash
# preview
node cli.js sync -r "/path/to/vault" -d

# actual sync
node cli.js sync -r "/path/to/vault"

# sync without deletes
node cli.js sync -r "/path/to/vault" --no-prune
```

---

### pre-sync

Trampoline command. Compares the running `cli.js` hash against the Hub's `cli.js`; if outdated, swaps itself for the Hub version and then runs `sync`.

Wired to the Obsidian Shell Commands plugin `on-layout-ready` event, so it runs automatically when a vault is opened.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |

```bash
node cli.js pre-sync -r "/path/to/vault"
```

---

## Vault management

### clone

Clone a new vault from BasicContentsVault. Use this instead of manual folder copy.

| Option | Description | Default |
|--------|-------------|---------|
| `-t, --target-path <path>` | Destination vault path (required) | |
| `-n, --project-name <name>` | Display name | |
| `-s, --source-path <path>` | Source vault path | auto-detect |

```bash
node cli.js clone \
  -t "/path/to/Vaults/Domains_<area>/NewVault" \
  -n "NewVault"
```

---

### broadcast

Push a specific file from the Hub's `.sync/` to every satellite vault. Use for per-file urgent rollouts.

| Option | Description | Default |
|--------|-------------|---------|
| `-p, --relative-path <path>` | Path relative to `.sync/` (required) | |
| `-d, --dry-run` | Preview | false |
| `-f, --force` | Create file even where it doesn't exist | false |
| `-e, --exclude <patterns...>` | Vault-name patterns to exclude | |
| `--vaults-root <path>` | `Vaults/` folder path | auto-detect |

```bash
# preview
node cli.js broadcast -p "_tools/cli-node/bin/cli.js" -d

# broadcast
node cli.js broadcast -p "_tools/cli-node/bin/cli.js"

# exclude a vault
node cli.js broadcast -p "_tools/cli-node/bin/cli.js" -e "BasicContentsVault"
```

---

## Utilities

### trash-clean

Bulk-empty each vault's `.trash/` folder.

| Option | Description | Default |
|--------|-------------|---------|
| `-v, --vault <names...>` | Target specific vaults | all |
| `-d, --dry-run` | Preview | false |
| `--vaults-root <path>` | `Vaults/` folder path | auto-detect |

```bash
# preview all vaults
node cli.js trash-clean -d

# clean specific vaults
node cli.js trash-clean -v "VaultA" "VaultB"

# actually delete
node cli.js trash-clean
```

---

### open

Run `pre-sync`, then open the vault in Obsidian.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |

```bash
node cli.js open -r "/path/to/vault"
```

---

### bridge

CLI wrapper for the Obsidian local-rest-api plugin: note read/write, search, history lookup, and more.

| Option | Description |
|--------|-------------|
| `-a, --action <action>` | Action to run (see list below) |
| `-r, --vault-root <path>` | Vault path |
| `--vault-name <name>` | Vault name |
| `-p, --path <path>` | Target note path |
| `-q, --query <query>` | Search query |
| `-c, --content <text>` | Content to append / create |
| `--version` | Version info |
| `--from` | History start date |
| `--to` | History end date |
| `-l` | List output |
| `--plugin-id` | Plugin id |
| `-s` | Compact output |

**Supported actions:**

| Action | Description |
|--------|-------------|
| `vault-info` | Get vault info |
| `search` | Full-text note search |
| `read` | Read a note |
| `open` | Open a note in Obsidian |
| `append` | Append content to a note |
| `create` | Create a note |
| `history` | Query edit history |
| `plugins-list` | List installed plugins |
| `post-review` | Trigger post-edit review |

```bash
# vault info
node cli.js bridge -a vault-info -r "/path/to/vault"

# read a note
node cli.js bridge -a read -p "Contents/Domain/note-title.md" -r "/path/to/vault"

# append content
node cli.js bridge -a append -p "Contents/Domain/note.md" -c "text to append" -r "/path/to/vault"
```

---

### route

Given a task description, recommend an agent and a vault.

| Option | Description |
|--------|-------------|
| `-t, --task <description>` | Task description (required) |

```bash
node cli.js route -t "refactor shared notes across research vaults"
```

---

### standards

Inspect a vault's `_Standards/` directory structure.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | auto-detect |
| `-d, --deep` | Recurse into subfolders | false |

```bash
# basic structure
node cli.js standards -r "/path/to/vault"

# include subfolders
node cli.js standards -r "/path/to/vault" -d
```

---

## Common workflows

### Review after editing notes

Always run `review` after a note edit. Confirm `POST_EDIT_REVIEW_BAD=0` and `POST_EDIT_INDEX_UPDATED=1`.

```bash
node cli.js review -r "/path/to/vault"
```

### Refresh the whole-vault index

Run after the index gets stale or after bulk-adding notes.

```bash
# incremental (recommended)
node cli.js index build -r "/path/to/vault" -i

# full rebuild
node cli.js index build -r "/path/to/vault"
```

### Manual sync

Run this when the auto-sync on vault open didn't fire.

```bash
# preview, then apply
node cli.js sync -r "/path/to/vault" -d
node cli.js sync -r "/path/to/vault"
```

### Batch-sync every satellite (bash loop)

Sync every satellite in order, excluding AIHubVault.

```bash
VAULTS_ROOT="/c/AIMindVaults/Vaults"
CLI="/c/AIMindVaults/Vaults/BasicVaults/AIHubVault/.sync/_tools/cli-node/bin/cli.js"

for vault_dir in "$VAULTS_ROOT"/*/*; do
  [ -d "$vault_dir" ] || continue
  vault_name=$(basename "$vault_dir")
  [ "$vault_name" = "AIHubVault" ] && continue
  echo "--- Syncing: $vault_name"
  node "$CLI" sync -r "$vault_dir"
done
```

---

## Notes

- Migrated from PowerShell (2026-04-13).
- Legacy scripts: `.sync/_tools/cli/vault_index_build.ps1`, `vault_index_search.ps1`, `post_note_edit_review.ps1`, `sync_workspace.ps1`.
- Indexer-first search rule: when searching notes, use `index search` before Grep/Glob (see `token-optimization.md` § 0).
