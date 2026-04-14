# AIMindVaults CLI Reference

A cross-platform CLI tool built on Node.js. Provides core AIMindVaults functionality including vault indexing, synchronization, review, and vault management.

- Location: `.sync/_tools/cli-node/bin/cli.js`
- Program name: `aimv`
- Runtime: Node.js ESM
- Platforms: Windows / macOS / Linux

## How to Run

```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" <command> [options]
```

After global installation or alias setup:

```bash
aimv <command> [options]
```

---

## Indexer

### index build

Builds the vault content index. Generates `vault_index.json`, which serves as the search source for `index search`.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |
| `-i, --incremental` | Incremental build (changed files only) | false |
| `-v, --verbose` | Verbose output | false |

```bash
# Full build
node cli.js index build -r "/path/to/vault"

# Incremental build (changed files only)
node cli.js index build -r "/path/to/vault" -i
```

---

### index search

Searches notes in the index. Supports combining keyword, tag, and type filters.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |
| `-q, --query <keyword>` | Keyword search (weighted ranking on title, tags, headings) | |
| `-t, --tag <tag>` | Tag filter | |
| `--type <type>` | Frontmatter type filter | |
| `-f, --format <fmt>` | Output format (`table` \| `compact`) | `table` |
| `-n, --top <n>` | Maximum number of results | 10 |

```bash
# Keyword search
node cli.js index search -q "color theory"

# Tag + compact output
node cli.js index search -q "color theory" -t "knowledge" -f compact

# Type filter
node cli.js index search --type "study-note" -n 5
```

---

### index master-build

Builds a cross-vault master index spanning all vaults in AIMindVaults. Used for searching notes across vault boundaries.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --root <path>` | AIMindVaults root path | Auto-detect |
| `--vault-name <name>` | Partial update for a specific vault only | |

```bash
# Full master index build
node cli.js index master-build

# Update a specific vault only
node cli.js index master-build --vault-name "Unity"
```

---

### index master-search

Performs cross-vault search on the master index.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --root <path>` | AIMindVaults root path | Auto-detect |
| `-q, --query <keyword>` | Keyword search | |
| `-t, --tag <tag>` | Tag filter | |
| `--vault <vault>` | Vault name filter | |
| `-f, --format <fmt>` | Output format (`table` \| `compact`) | `table` |
| `-n, --top <n>` | Maximum number of results | 15 |
| `-c, --concepts-only` | Show cross-vault concept map only | false |

```bash
# Cross-vault keyword search
node cli.js index master-search -q "skill system"

# Search within a specific vault
node cli.js index master-search -q "ECS" --vault "Unity"

# View cross-vault concept map only
node cli.js index master-search -c
```

---

## Review

### review

Performs UTF-8 encoding validation and automatic indexing after note edits. Must be run immediately after completing edits.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |
| `-s, --scope <name>` | Folder name to limit the review scope | |
| `-v, --verbose` | Verbose output | false |

**Output Codes:**

| Output | Meaning |
|--------|---------|
| `POST_EDIT_REVIEW_BAD=0` | No encoding errors (normal) |
| `POST_EDIT_REVIEW_BAD=N` | N errors found — fix the affected files |
| `POST_EDIT_INDEX_UPDATED=1` | Indexing complete |
| `POST_EDIT_INDEX_SKIPPED=1` | Indexing skipped — manual build required |

Automatically calls `index build -i` when the review passes.

```bash
# Basic review
node cli.js review -r "/path/to/vault"

# Review limited to Contents folder
node cli.js review -r "/path/to/vault" -s "Contents"
```

If `POST_EDIT_INDEX_SKIPPED=1` is output, manually update the index:

```bash
node cli.js index build -r "/path/to/vault" -i
```

---

## Synchronization

### sync

Synchronizes workspace files between the Hub (AIHubVault) and satellite vaults.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |
| `--hub-path <path>` | Hub path | Auto-detect |
| `-d, --dry-run` | Preview without making changes | false |
| `--no-prune` | Do not delete files that only exist in the target | false |
| `--verify-content` | Force file hash verification even if versions match | false |

```bash
# Sync preview
node cli.js sync -r "/path/to/vault" -d

# Execute sync
node cli.js sync -r "/path/to/vault"

# Sync without deleting extra files
node cli.js sync -r "/path/to/vault" --no-prune
```

---

### pre-sync

Trampoline command. Compares the hash of the currently running `cli.js` with the Hub's `cli.js`. If outdated, it automatically replaces with the Hub version and then executes `sync`.

Connected to the Shell Commands plugin's on-layout-ready event in Obsidian, so it runs automatically when a vault is opened.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |

```bash
node cli.js pre-sync -r "/path/to/vault"
```

---

## Vault Management

### clone

Clones a new vault based on BasicContentsVault. Use this command instead of manual folder copying.

| Option | Description | Default |
|--------|-------------|---------|
| `-t, --target-path <path>` | Path for the new vault (required) | |
| `-n, --project-name <name>` | Vault display name | |
| `-s, --source-path <path>` | Source vault path | Auto-detect |

```bash
node cli.js clone \
  -t "/path/to/Vaults/Domains_Game/NewVault" \
  -n "NewVault"
```

---

### broadcast

Propagates a specific file from the Hub's `.sync/` directory to all satellite vaults. Used for distributing individual scripts or config files.

| Option | Description | Default |
|--------|-------------|---------|
| `-p, --relative-path <path>` | Relative path from `.sync/` (required) | |
| `-d, --dry-run` | Preview | false |
| `-f, --force` | Create the file even if it doesn't exist in the target | false |
| `-e, --exclude <patterns...>` | Vault name patterns to exclude | |
| `--vaults-root <path>` | Path to `Vaults/` folder | Auto-detect |

```bash
# Preview
node cli.js broadcast -p "_tools/cli-node/bin/cli.js" -d

# Execute broadcast
node cli.js broadcast -p "_tools/cli-node/bin/cli.js"

# Exclude specific vaults
node cli.js broadcast -p "_tools/cli-node/bin/cli.js" -e "BasicContentsVault"
```

---

## Utilities

### trash-clean

Batch cleans `.trash/` folders across vaults.

| Option | Description | Default |
|--------|-------------|---------|
| `-v, --vault <names...>` | Specify particular vaults | All |
| `-d, --dry-run` | Preview | false |
| `--vaults-root <path>` | Path to `Vaults/` folder | Auto-detect |

```bash
# Preview all vaults
node cli.js trash-clean -d

# Clean specific vaults only
node cli.js trash-clean -v "Unity" "GameDesign"

# Execute cleanup
node cli.js trash-clean
```

---

### open

Runs `pre-sync` and then opens the vault in Obsidian.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |

```bash
node cli.js open -r "/path/to/vault"
```

---

### bridge

CLI wrapper that interfaces with the Obsidian local-rest-api plugin. Performs note reading/writing, search, history lookup, and more.

| Option | Description |
|--------|-------------|
| `-a, --action <action>` | Action to execute (see list below) |
| `-r, --vault-root <path>` | Vault path |
| `--vault-name <name>` | Vault name |
| `-p, --path <path>` | Target note path |
| `-q, --query <query>` | Search query |
| `-c, --content <text>` | Content to append/create |
| `--version` | Version info |
| `--from` | History start date |
| `--to` | History end date |
| `-l` | List output |
| `--plugin-id` | Plugin ID |
| `-s` | Brief output |

**Supported Actions:**

| Action | Description |
|--------|-------------|
| `vault-info` | Retrieve vault information |
| `search` | Full-text note search |
| `read` | Read note content |
| `open` | Open note in Obsidian |
| `append` | Append content to a note |
| `create` | Create a note |
| `history` | View edit history |
| `plugins-list` | List installed plugins |
| `post-review` | Trigger post-edit review |

```bash
# Check vault info
node cli.js bridge -a vault-info -r "/path/to/vault"

# Read a note
node cli.js bridge -a read -p "Contents/Domain/note-title.md" -r "/path/to/vault"

# Append content to a note
node cli.js bridge -a append -p "Contents/Domain/note.md" -c "Content to add" -r "/path/to/vault"
```

---

### route

Recommends the appropriate agent and vault based on a task description.

| Option | Description |
|--------|-------------|
| `-t, --task <description>` | Task description (required) |

```bash
node cli.js route -t "Unity tilemap rendering optimization"
```

---

### standards

Inspects the vault's `_Standards/` directory structure.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detect |
| `-d, --deep` | Show subdirectories | false |

```bash
# Basic structure
node cli.js standards -r "/path/to/vault"

# Include subdirectories
node cli.js standards -r "/path/to/vault" -d
```

---

## Common Workflows

### Post-Edit Review

Always run `review` after finishing note edits. Verify `POST_EDIT_REVIEW_BAD=0` and `POST_EDIT_INDEX_UPDATED=1`.

```bash
node cli.js review -r "/path/to/vault"
```

### Full Vault Index Refresh

Run this when the index is stale or after adding a large number of notes.

```bash
# Incremental build (recommended)
node cli.js index build -r "/path/to/vault" -i

# Full rebuild
node cli.js index build -r "/path/to/vault"
```

### Manual Sync

Run manually if auto-sync did not trigger when opening a vault.

```bash
# Preview then execute
node cli.js sync -r "/path/to/vault" -d
node cli.js sync -r "/path/to/vault"
```

### Batch Sync All Satellite Vaults (bash loop)

Runs sync sequentially on all satellite vaults except AIHubVault.

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

- Migrated from PS1 scripts (2026-04-13)
- Previous scripts: `.sync/_tools/cli/vault_index_build.ps1`, `vault_index_search.ps1`, `post_note_edit_review.ps1`, `sync_workspace.ps1`
- Indexer-first search rule: Use `index search` before Grep/Glob when exploring notes (see `token-optimization.md` section 0)
