---
name: session-end
description: Procedure to run post-review, update AGENT_STATUS, and merge _STATUS.md at session end
---

# Session end

> When to use: after work is complete, before ending the Codex session

## Step 1 — post-review (if any documents were edited)

```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```

Confirm `POST_EDIT_REVIEW_BAD=0`. On failure, restore and re-check.

## Step 2 — Update AGENT_STATUS.md

Update `.codex/AGENT_STATUS.md`:

```markdown
## This session summary
- Scope: [one line]
- Done: [bullet list]
- On hold / risk: [if any]

## What I did this session (Done)
- [per-file changes]

## Next up (Next)
- [entry point for next session]

## Blocked / Questions
- [none or items]
```

## Step 3 — Decide whether to merge into _STATUS.md

Update `_STATUS.md` if any of the following apply:
- The next task will be picked up by another agent
- The session ended with file edits incomplete
- Inconsistency detected

Otherwise, skip the merge (only update AGENT_STATUS).

## Step 4 — Update root _STATUS.md

In the root `_STATUS.md` vault registry, update the working agent as `codex / YYYY-MM-DD`.

## Checklist

```
[ ] post-review BAD_COUNT=0 confirmed
[ ] AGENT_STATUS.md updated
[ ] Decided whether to merge vault _STATUS.md
[ ] Root _STATUS.md working-agent updated
[ ] Index / link integrity verified
```
