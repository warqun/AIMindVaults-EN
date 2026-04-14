# Session Exit Status Update (Mandatory)

> Applies uniformly to all vaults. Common to all agents.

## _STATUS.md Update (Required)

At session exit, **directly update** the `_STATUS.md` of the vault(s) you worked on.

Fields to update:
- **Now**: Tasks completed or in progress during this session
- **Next**: Tasks to continue in the next session
- **Blocked**: Blockers (if none, write "None")
- **Decisions**: Decisions made during this session (if any, add in `(YYYY-MM-DD)` format)

Additionally, update the working agent date for the vault in the root `_STATUS.md` vault registry.
- Format: `agent_name / YYYY-MM-DD`
- If the vault is not in the registry, add a new row under the appropriate category.

**Do not end the session without updating both the vault `_STATUS.md` and the root `_STATUS.md`.**

## Session Handoff Note (Required)

At session exit, **overwrite** the **per-agent handoff file**.

- Claude → `_SESSION_HANDOFF_CLAUDE.md`
- Codex → `_SESSION_HANDOFF_CODEX.md`
- Other agents → `_SESSION_HANDOFF_{agent_name}.md`

Each agent updates **only its own handoff file**. Do not modify another agent's file.

Fields to record:
- **Work Summary**: 1-3 lines of what was done in this session
- **Per-Vault Changes**: Changed/new/deleted file paths, incomplete items, caveats
- **Decisions**: In `(YYYY-MM-DD)` format
- **Recommended Next Session Tasks**: Specifically what to do first
- **Warnings/Cautions**: Things that could go wrong in the next session

The handoff note maintains **only the latest entry**, not a cumulative history. History is tracked in _STATUS.md + Notion.

**Do not end the session without updating the handoff note.**

## Vault-Level Handoff and Root Handoff Linkage (Required)

If a `_SESSION_HANDOFF_{agent_name}.md` was written for an individual vault, **also leave a reference in the root handoff.**

Record in the root handoff's **Per-Vault Changes** section using this format:

```markdown
### {vault_name} (`{vault_path}`)
- Detailed handoff: See `{vault_path}/_SESSION_HANDOFF_{agent_name}.md`
- 1-line summary (key work done in this session)
```

**Purpose**: Enables the next session to determine at a glance which vaults have detailed handoffs just by reading the root handoff.

**Do not write vault-level handoffs without a corresponding reference in the root handoff.**

## AGENT_STATUS Update (Recommended)

Each agent's individual status file (`AGENT_STATUS.md`) is updated at the agent's own discretion.
- Recommended for complex tasks or when there is context to carry over to the next session
- Can be skipped for simple tasks

## Design Rationale

- Vault `_STATUS.md`: Detailed work log (Now/Next/Blocked/Decisions)
- Root `_STATUS.md`: Vault registry + most recent working agent date only (lightweight)
- When the user looks for recent work, they check vaults in order of work date from the root
- Actual operation follows a 1-agent-1-vault alternating pattern
