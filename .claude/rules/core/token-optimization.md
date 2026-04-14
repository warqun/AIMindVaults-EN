# Token Saving & Execution Delegation (Mandatory)

> Applies to all vaults. All agents.
> Background: prevent runaway token consumption by background agents (Antigravity etc.).

## 0. Content-Indexer-First Search (Mandatory)

When looking for notes, checking content, or listing files in a vault, **use the content indexer first**.

### Search Order (Mandatory)

```
Step 1: node cli.js index search — keyword/tag/type search via the index
Step 2: Only if the indexer is insufficient → direct file tools (Grep, Glob, Read)
```

**Never jump straight to Grep / Glob / find / ls without going through the indexer.**

### Usage

```bash
# Keyword search
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault-path}" -q "query"

# Tag filter
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault-path}" -t "tag"

# Type filter
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault-path}" --type "knowledge"

# Compact output for AI context
... -f compact -n 5
```

### Parameters

| Param | Purpose | Default |
|-------|---------|---------|
| `-q, --query` | Keyword search (weighted ranking on title/tags/headings) | |
| `-t, --tag` | Tag filter | |
| `--type` | Frontmatter `type` filter | |
| `-f, --format` | Output format (`table` / `compact`) | `table` |
| `-n, --top` | Top N | 10 |

### Fallback Conditions

Switch to direct file tools only when:
- `vault_index.json` doesn't exist or has never been built in this vault.
- Indexer returns 0 hits but the file is likely to exist.
- The file isn't covered by the index (`.obsidian/`, `_tools/`, scripts, etc.).

### Staleness Check

- If indexer results look wrong, run `/reindex` for an incremental rebuild, then search again.
- After bulk add/delete, running `/reindex` is recommended.

## 1. Minimize File Exploration

- Reads and searches must be **pinpoint**. No broad scans (`find`, full-directory `grep`).
- If you don't know the exact path, **try the indexer first**; if still nothing, ask the user.
- For large files (100+ lines), read **only the range you need**. No full-file loads.
- **Do not re-read** the same file in one session. Remember and reuse.

## 2. Delegate Terminal Execution (Ping-Pong)

- Agents do not iterate scripts locally, debugging in a loop.
- **Present a command you're confident in** → user runs it → agent uses the result to proceed.
- No self-correction loops: if a command fails, **diagnose and propose a fix**; don't re-run it yourself.
- Exception: only when the user explicitly says "run it yourself" does the agent run directly.

## 3. Avoid Context Bloat

- Don't re-send accumulated file logs and search results every turn.
- Reference summaries of earlier turns instead of repeating data.
- Skip redundant verification of facts already established.

## 4. Pre-Task Cost Assessment

- Before starting, identify **high-token actions** (bulk file scans, multiple script runs, full-document reads).
- Report expensive actions to the user and get approval before running them.
- If a **cheaper alternative** achieves the same goal, propose that first.

## Forbidden Actions (Summary)

| Forbidden | Alternative |
|-----------|-------------|
| Broad file search (full-directory scan) | Ask the user for the path |
| Full-file read of large files | Read only the needed line range |
| Self-debug loops (run → fail → retry) | Propose a fix, delegate execution |
| Re-reading the same file | Remember and reuse the first read |
| Redundant verification | Skip facts already known |
