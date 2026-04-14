# Post-Edit Review (Mandatory)

> Applies uniformly to all vaults.

## Rules

- Immediately after completing a note edit, run the following review:
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault_path}" -s Contents
```
- Do not report completion until `POST_EDIT_REVIEW_BAD=0` is confirmed.
- **Note creation/editing tasks are not complete until content indexing is finished.**
  - Default path: The `review` command automatically calls `index build -i` after passing review
  - Completion condition: `POST_EDIT_INDEX_UPDATED=1`
  - If `POST_EDIT_INDEX_SKIPPED=1` or `POST_EDIT_INDEX_UPDATED=0`, run manual indexing before reporting completion:
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault_path}" -i
```

## Obsidian CLI First

- For lookups, searches, and history recovery, use the vault's `node cli.js bridge` command first.
- Use direct file parsing only when CLI results are insufficient.
- After editing, complete review and indexing with `bridge -a post-review`.
