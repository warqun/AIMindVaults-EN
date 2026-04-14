# /vault-update — Session Exit Routine

> Called before ending a conversation. Reflects changes made during this session into documents and updates memory files.
> Multi-vault: Auto-detects the vault worked on, or specify via argument.

Arguments: $ARGUMENTS (vault name; if omitted, auto-detects vaults worked on during this session)

---

## Execution Order

### 1. Determine Target Vault

- If a vault name is provided in `$ARGUMENTS`, use that vault
- Otherwise, auto-detect from file paths modified during this session
- If multiple vaults were worked on, execute sequentially for each vault

### 2. Review Finalized Items from This Session

Check if any decisions or finalizations were made during this conversation:
- Newly resolved issues (open -> resolved)
- Newly added design decisions
- Changed file structures

### 3. Document Sync (if applicable)

If there are finalized items, reflect them in this order:
1. Mark the relevant `Spec.md` section as complete
2. Update the design document (`02-design/`) finalization table
3. Update `ISSUE_INDEX.md` status

### 4. Update _VAULT-INDEX.md (on structural changes)

If new files were created or deleted:
- Update the relevant section in `{vault-path}/_VAULT-INDEX.md`

### 5. Update MEMORY.md

Reflect current progress in `memory/MEMORY.md`:
- Currently active issue numbers
- Tasks to continue in the next conversation
- Notable items

### 5.5 Update _STATUS.md (mandatory)

**Always performed**: Directly update `{vault-path}/_STATUS.md`
- Now: Tasks completed or in progress during this session
- Next: Tasks to continue next
- Blocked: Blockers (if none, "None")
- Decisions: Decisions made during this session (if any)

**Do not end the session without updating `_STATUS.md`.**

### 5.5.1 Update AGENT_STATUS (recommended)

`{vault-path}/.claude/AGENT_STATUS.md` — Update when context needs to be carried over to the next session for complex work. Can be skipped for simple tasks.

### 5.6 Update Root _STATUS.md

**Always performed**: Update the section for the worked vault in root `_STATUS.md`:
- **Now**: Currently active work
- **Last Agent**: claude / {today's date}
- **Next**: Upcoming planned work
- **Blocked**: Blockers (if none, "None")

### 6. Output Session Exit Checklist

```
[ ] Spec.md open items synced
[ ] ISSUE_INDEX.md reflects latest state
[ ] MEMORY.md next tasks updated
[ ] _VAULT-INDEX.md structure reflected (if changes exist)
[ ] No design-spec mismatches confirmed
[ ] Root _STATUS.md vault section updated
```
