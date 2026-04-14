---
name: session-end
description: Procedure for sequentially performing post-review, AGENT_STATUS update, and _STATUS.md merge at session end
---

# Session End

> When to use: Before ending Codex session after work completion

## Step 1 — post-review (if documents were modified)

```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```

Confirm `POST_EDIT_REVIEW_BAD=0`. If failed, recover and re-verify.

## Step 2 — Update AGENT_STATUS.md

Update `.codex/AGENT_STATUS.md`:

```markdown
## This Session Summary
- Scope: [one line]
- Completed: [item list]
- Pending/Risks: [if any]

## Done This Session
- [Changes per file]

## Next To Do
- [Entry point for next session]

## Blocked / Questions
- [None or items]
```

## Step 3 — _STATUS.md Merge Decision

Update _STATUS.md if any of the following apply:
- Next task will be continued by a different agent
- File editing work is ending in incomplete state
- Inconsistency detected

If none apply, skip merge (update AGENT_STATUS only).

## Step 4 — Update Root _STATUS.md

Update the working agent in the root `_STATUS.md` vault registry to `codex / YYYY-MM-DD`.

## Checklist

```
[ ] Confirmed post-review BAD_COUNT=0
[ ] AGENT_STATUS.md updated
[ ] Vault _STATUS.md merge decision made
[ ] Root _STATUS.md working agent updated
[ ] Index/link integrity verified
```
