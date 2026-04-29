# AIMindVaults CLI Reference

A Node.js-based cross-platform CLI tool. Provides the core AIMindVaults capabilities — vault indexing, synchronization, review, vault management, and so on.

- Location: `.sync/_tools/cli-node/bin/cli.js`
- Program name: `aimv`
- Runtime: Node.js ESM
- Platforms: Windows / macOS / Linux

## How to run

```bash
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" <command> [options]
```

After global install or alias setup:

```bash
aimv <command> [options]
```

---

## Indexer

### index build

Builds the vault content index. Produces `vault_index.json`, which is then the search source for `index search`.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |
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

Searches notes from the index. Combines keyword, tag, and type filters.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |
| `-q, --query <keyword>` | Keyword search (weighted ranking on title, tags, headings) | |
| `-t, --tag <tag>` | Tag filter | |
| `--type <type>` | Frontmatter type filter | |
| `-f, --format <fmt>` | Output format (`table` \| `compact`) | `table` |
| `-n, --top <n>` | Maximum result count | 10 |

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

Builds the cross-vault master index spanning all AIMindVaults vaults. Use this when you need to search notes beyond a single vault boundary.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --root <path>` | AIMindVaults root path | Auto-detected |
| `--vault-name <name>` | Partially update a specific vault only | |

```bash
# Full master-index build
node cli.js index master-build

# Update a specific vault only
node cli.js index master-build --vault-name "Unity"
```

---

### index master-search

Performs cross-vault search against the master index.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --root <path>` | AIMindVaults root path | Auto-detected |
| `-q, --query <keyword>` | Keyword search | |
| `-t, --tag <tag>` | Tag filter | |
| `--vault <vault>` | Vault-name filter | |
| `-f, --format <fmt>` | Output format (`table` \| `compact`) | `table` |
| `-n, --top <n>` | Maximum result count | 15 |
| `-c, --concepts-only` | Show the cross-vault concept map only | false |

```bash
# Cross-vault keyword search
node cli.js index master-search -q "skill system"

# Search inside a specific vault
node cli.js index master-search -q "ECS" --vault "Unity"

# Show only the cross-vault concept map
node cli.js index master-search -c
```

---

## Review

### review

Runs UTF-8 encoding validation and automatic indexing after a note edit. Must be run immediately after edits complete.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |
| `-s, --scope <name>` | Folder name to scope the inspection | |
| `-v, --verbose` | Verbose output | false |

**Output codes:**

| Output | Meaning |
|--------|---------|
| `POST_EDIT_REVIEW_BAD=0` | No encoding errors (good) |
| `POST_EDIT_REVIEW_BAD=N` | N errors — affected files need fixing |
| `POST_EDIT_INDEX_UPDATED=1` | Indexing completed |
| `POST_EDIT_INDEX_SKIPPED=1` | Indexing skipped — manual build required |

When the review passes, `index build -i` is invoked automatically.

```bash
# Default review
node cli.js review -r "/path/to/vault"

# Limit inspection to the Contents folder
node cli.js review -r "/path/to/vault" -s "Contents"
```

If `POST_EDIT_INDEX_SKIPPED=1` is reported, refresh the index manually:

```bash
node cli.js index build -r "/path/to/vault" -i
```

---

## Synchronization

### sync

Syncs workspace files between the Hub (AIHubVault) and the satellite vaults.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |
| `--hub-path <path>` | Hub path | Auto-detected |
| `-d, --dry-run` | Preview without applying changes | false |
| `--no-prune` | Do not delete files that exist only on the target | false |
| `--verify-content` | Force file-hash verification even when versions match | false |

```bash
# Sync preview
node cli.js sync -r "/path/to/vault" -d

# Run actual sync
node cli.js sync -r "/path/to/vault"

# Sync without file deletion
node cli.js sync -r "/path/to/vault" --no-prune
```

---

### pre-sync

The trampoline command. Hash-compares the running `cli.js` against the Hub's `cli.js`; if outdated, replaces it with the Hub version and re-executes `sync`.

Wired to the Obsidian Shell Commands plug-in's `on-layout-ready` event so it runs automatically when a vault is opened.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |

```bash
node cli.js pre-sync -r "/path/to/vault"
```

---

## Vault Management

### clone

Clones a new vault based on BasicContentsVault. Use this command instead of manual folder copying.

| Option | Description | Default |
|--------|-------------|---------|
| `-t, --target-path <path>` | Target vault path (required) | |
| `-n, --project-name <name>` | Vault display name | |
| `-s, --source-path <path>` | Source vault path | Auto-detected |

```bash
node cli.js clone \
  -t "/path/to/Vaults/Domains_Game/NewVault" \
  -n "NewVault"
```

---

### broadcast

Propagates a specific file under the Hub's `.sync/` to every satellite vault. Use this to deploy a single script or settings file at the per-file level.

| Option | Description | Default |
|--------|-------------|---------|
| `-p, --relative-path <path>` | Relative path under `.sync/` (required) | |
| `-d, --dry-run` | Preview | false |
| `-f, --force` | Create the file even if it does not exist on the target | false |
| `-e, --exclude <patterns...>` | Vault-name patterns to exclude | |
| `--vaults-root <path>` | Path to the `Vaults/` folder | Auto-detected |

```bash
# Preview
node cli.js broadcast -p "_tools/cli-node/bin/cli.js" -d

# Run propagation
node cli.js broadcast -p "_tools/cli-node/bin/cli.js"

# Exclude a specific vault
node cli.js broadcast -p "_tools/cli-node/bin/cli.js" -e "BasicContentsVault"
```

---

## Utilities

### trash-clean

Bulk-cleans every vault's `.trash/` folder.

| Option | Description | Default |
|--------|-------------|---------|
| `-v, --vault <names...>` | Limit to specific vaults | All |
| `-d, --dry-run` | Preview | false |
| `--vaults-root <path>` | Path to the `Vaults/` folder | Auto-detected |

```bash
# Preview every vault
node cli.js trash-clean -d

# Clean specific vaults only
node cli.js trash-clean -v "Unity" "GameDesign"

# Apply deletions
node cli.js trash-clean
```

---

### open

Runs `pre-sync`, then opens the vault in Obsidian.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |

```bash
node cli.js open -r "/path/to/vault"
```

---

### bridge

CLI wrapper for the Obsidian local-rest-api plug-in. Provides note read/write, search, history lookup, and similar operations.

| Option | Description |
|--------|-------------|
| `-a, --action <action>` | Action to run (see list below) |
| `-r, --vault-root <path>` | Vault path |
| `--vault-name <name>` | Vault name |
| `-p, --path <path>` | Target note path |
| `-q, --query <query>` | Search query |
| `-c, --content <text>` | Content to append/create |
| `--version` | Version info |
| `--from` | History start date |
| `--to` | History end date |
| `-l` | List output |
| `--plugin-id` | Plug-in ID |
| `-s` | Compact output |

**Supported actions:**

| Action | Description |
|--------|-------------|
| `vault-info` | Look up vault info |
| `search` | Full-text note search |
| `read` | Read note content |
| `open` | Open the note in Obsidian |
| `append` | Append content to a note |
| `create` | Create a note |
| `history` | Look up edit history |
| `plugins-list` | List installed plug-ins |
| `post-review` | Trigger a post-edit review |

```bash
# Get vault info
node cli.js bridge -a vault-info -r "/path/to/vault"

# Read a note
node cli.js bridge -a read -p "Contents/Domain/note-title.md" -r "/path/to/vault"

# Append content to a note
node cli.js bridge -a append -p "Contents/Domain/note.md" -c "content to append" -r "/path/to/vault"
```

---

### route

Given a task description, recommends a suitable agent and vault.

| Option | Description |
|--------|-------------|
| `-t, --task <description>` | Task description (required) |

```bash
node cli.js route -t "Unity tile-map rendering optimization task"
```

---

### standards

Inspects the `_Standards/` directory structure of a vault.

| Option | Description | Default |
|--------|-------------|---------|
| `-r, --vault-root <path>` | Vault path | Auto-detected |
| `-d, --deep` | Show subdirectories | false |

```bash
# Default structure view
node cli.js standards -r "/path/to/vault"

# Include subdirectories
node cli.js standards -r "/path/to/vault" -d
```

---

## Common Workflows

### Review after note edits

Run `review` whenever you finish editing a note. Confirm `POST_EDIT_REVIEW_BAD=0` and `POST_EDIT_INDEX_UPDATED=1`.

```bash
node cli.js review -r "/path/to/vault"
```

### Refresh an entire vault index

Run after the index has gone stale or a large batch of notes was added.

```bash
# Incremental build (recommended)
node cli.js index build -r "/path/to/vault" -i

# Full rebuild
node cli.js index build -r "/path/to/vault"
```

### Manual sync

Run manually when the on-open auto-sync did not fire.

```bash
# Preview, then run
node cli.js sync -r "/path/to/vault" -d
node cli.js sync -r "/path/to/vault"
```

### Bulk sync every satellite vault (bash loop)

Sync every satellite vault in turn, excluding AIHubVault.

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

## References

- Migrated from PS1 scripts (2026-04-13)
- Previous scripts: `.sync/_tools/cli/vault_index_build.ps1`, `vault_index_search.ps1`, `post_note_edit_review.ps1`, `sync_workspace.ps1`
- Indexer-first search rule: when looking up notes, use `index search` before Grep/Glob (see `token-optimization.md` § 0)
