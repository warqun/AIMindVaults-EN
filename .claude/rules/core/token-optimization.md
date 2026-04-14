# Token Optimization and Execution Delegation (Mandatory)

> Applies uniformly to all vaults. Common to all agents.
> Background: Prevents excessive token consumption by background agents such as Antigravity.

## 0. Content Indexer First Search (Mandatory)

When finding notes in a vault, inspecting content, or getting file listings, **always use the content indexer first**.

### Search Order (Mandatory)

```
Step 1: node cli.js index search — index-based keyword/tag/type search
Step 2: Only when indexer results are insufficient → direct file exploration with Grep, Glob, Read, etc.
```

**Do not jump directly to file exploration (Grep, Glob, find, ls) without going through the indexer.**

### Usage

```bash
# Keyword search
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault_path}" -q "search_term"

# Tag filter
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault_path}" -t "tag_name"

# Type filter
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault_path}" --type "knowledge"

# Compact output for AI context
... -f compact -n 5
```

### Parameters

| Parameter | Purpose | Default |
|-----------|---------|---------|
| `-q, --query` | Keyword search (weighted ranking on title, tags, headings) | |
| `-t, --tag` | Tag filter | |
| `--type` | Frontmatter type filter | |
| `-f, --format` | Output format (`table` / `compact`) | `table` |
| `-n, --top` | Top N results | 10 |

### Indexer Fallback Conditions

Switch to direct file exploration only in these cases:
- `vault_index.json` does not exist or has never been built for the vault
- Indexer search returns 0 results and files are likely to exist
- Files not included in the indexer (`.obsidian/`, `_tools/`, scripts, and other non-content files)

### Index Freshness Check

- If indexer results seem suspicious, run `/reindex` skill for incremental build and re-search
- Running `/reindex` is recommended after bulk note additions/deletions

## 1. Minimize File Exploration

- When reading or finding files, only **pinpoint access** is allowed. Broad searches (`find`, full `grep` scans) are prohibited.
- If the exact path is unknown, **try the indexer search first**, and only ask the user for the path if that also fails.
- For large files (100+ lines), **read only the needed portion**. Full file loading is prohibited.
- **Do not re-read the same file** within a session. Remember and reuse content from the first read.

## 2. Terminal Execution Delegation (Ping-Pong Pattern)

- The agent must not repeatedly execute scripts on its own for debugging.
- **Present confident code/commands to the user** → the user runs them directly → receive results and proceed to the next step.
- Self-correction loops are prohibited: if a command fails, **analyze the cause and present a fix**, rather than re-executing directly.
- Exception: The agent may execute directly only when the user explicitly instructs "run it yourself".

## 3. Prevent Context Bloat

- Do not retransmit accumulated file logs and search results every turn in long sessions.
- Replace information already confirmed in previous turns with summary references.
- Skip unnecessary verification steps (re-verifying facts already known).

## 4. Pre-Task Cost Assessment

- Before starting a task, identify **tasks with high expected token consumption** (bulk file scans, multiple script executions, reading entire large documents).
- For high-cost tasks, **report to the user and obtain approval** beforehand.
- If a **lower-cost alternative** exists to achieve the same goal, propose it first.

## Prohibited Actions Summary

| Prohibited Action | Alternative |
|-------------------|-------------|
| Broad file search (full directory scan) | Ask user for the path |
| Reading entire large files | Read only the needed line range |
| Self-debugging loops (run → fail → retry) | Present fix, delegate execution to user |
| Re-reading the same file | Remember and reuse first read results |
| Unnecessary verification steps | Skip already-known information |
