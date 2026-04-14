---
name: session-end
description: Procedure for sequentially performing post-review, AGENT_STATUS update, and _STATUS.md merge at session end
---

# Session End

> When to use: Before ending a Codex session after work is complete

## Step 1 — post-review (if documents were modified)

```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```

Confirm `POST_EDIT_REVIEW_BAD=0`. If failed, recover and verify again.

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
- Another agent is expected to continue the next task
- File modification work is ending in an incomplete state
- Inconsistency detected

If none apply, skip the merge (update AGENT_STATUS only).

## Step 4 — Update Root _STATUS.md

Update the working agent in the root `_STATUS.md` vault registry to `codex / YYYY-MM-DD`.

## Checklist

```
[ ] post-review BAD_COUNT=0 confirmed
[ ] AGENT_STATUS.md update complete
[ ] Vault _STATUS.md merge decision made
[ ] Root _STATUS.md working agent updated
[ ] Index/link integrity verified
```
