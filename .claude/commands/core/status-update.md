# /status-update — Update Status

> Updates the vault's `_STATUS.md` to the latest state and reflects changes in the root `_STATUS.md`.
> Multi-vault: Specify the target vault as an argument, or auto-detect.

Arguments: $ARGUMENTS (vault name | `all` | omitted)

- Omitted: Auto-detect the currently active vault
- `all`: Iterate through all active vaults
- No arguments: Display the root `_STATUS.md` in full and compare with each vault's `_STATUS.md`

## Execution Order

1. Determine target vault (from argument, auto-detect, or iterate all active vaults if `all`)
2. Read `{vault-path}/_STATUS.md` (check current status)
3. Update `{vault-path}/_STATUS.md` based on this session's work
   - Update Now / Next / Blocked / Decisions
4. Update the corresponding vault section in root `_STATUS.md`
   - Reflect Now / Last Agent / Next / Blocked
5. (Optional) If AGENT_STATUS needs updating, update `{vault-path}/.claude/AGENT_STATUS.md`
6. Output
   - "STATUS update complete" + 3-line summary of remaining Blocked/Decisions
