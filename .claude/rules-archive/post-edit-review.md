# Post-Edit Review (Mandatory)

> Applies to all vaults.

## Rules

- Immediately after finishing a note edit, run:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault-path}" -s Contents
```
- Do not report completion until `POST_EDIT_REVIEW_BAD=0` is confirmed.
- **Note add/edit work is not done until content indexing finishes.**
  - Default path: the `review` command auto-invokes `index build -i` on success.
  - Completion condition: `POST_EDIT_INDEX_UPDATED=1`.
  - If `POST_EDIT_INDEX_SKIPPED=1` or `POST_EDIT_INDEX_UPDATED=0`, run manual indexing before reporting completion:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}" -i
```

## Prefer the Obsidian CLI

- For lookups, searches, and history recovery, try the vault's `node cli.js bridge` commands first.
- Parse files directly only when the CLI's output is insufficient.
- After editing, use `bridge -a post-review` to finish review + indexing.
