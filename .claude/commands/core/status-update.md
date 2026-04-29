# /status-update — Status Update

> Refreshes the vault's `_STATUS.md` and reflects it in the root `_STATUS.md`.
> Multi-vault: pass the target vault as an argument or auto-detect.

Argument: $ARGUMENTS (vault name | `all` | omitted)

- Omitted: auto-detect the currently-worked vault
- `all`: iterate every active vault
- Run with no argument: show the full root `_STATUS.md` and cross-check against each vault's `_STATUS.md`

## Execution Order

1. Decide the target vault (argument or auto-detect; for `all`, iterate every active vault).
2. Read `{vault path}/_STATUS.md` (current state).
3. Update `{vault path}/_STATUS.md` based on this session's work.
   - Update Now / Next / Blocked / Decisions.
4. Update the corresponding vault section in the root `_STATUS.md`.
   - Reflect Now / Last Agent / Next / Blocked.
5. (Optional) Update `{vault path}/.claude/AGENT_STATUS.md` if AGENT_STATUS needs to change.
6. Output:
   - "Status update complete" + a 3-line summary of remaining Blocked / Decisions.
