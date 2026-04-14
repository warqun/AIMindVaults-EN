# /status-update — Status Refresh

> Update the vault `_STATUS.md` to the latest state and reflect it in the root `_STATUS.md`.
> Multi-vault: pass the target vault as an argument, or auto-detect.

Argument: $ARGUMENTS (vault-name | `all` | omitted)

- Omitted: auto-detect the current working vault.
- `all`: iterate every active vault.
- No-arg run: show the full root `_STATUS.md` and compare against each vault's `_STATUS.md`.

## Execution Order

1. Decide the target vault (argument or auto-detect; with `all`, iterate every active vault).
2. Read `{vault-path}/_STATUS.md` (current state).
3. Update `{vault-path}/_STATUS.md` based on this session's work.
   - Update Now / Next / Blocked / Decisions.
4. Update the vault's section in the root `_STATUS.md`.
   - Reflect Now / Last Agent / Next / Blocked.
5. (Optional) If AGENT_STATUS needs updating, update `{vault-path}/.claude/AGENT_STATUS.md`.
6. Output
   - "STATUS update complete" + 3-line summary of remaining Blocked/Decisions.
