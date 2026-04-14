# Session-Exit State Update (Mandatory)

> Applies to all vaults. All agents.

## _STATUS.md Update (Required)

At session exit, **directly update** `_STATUS.md` for the vault you worked in.

Fields to update:
- **Now**: what this session completed or left in progress.
- **Next**: what to pick up next time.
- **Blocked**: current blockers (write "none" if none).
- **Decisions**: decisions made this session (if any), tagged with `(YYYY-MM-DD)`.

Also update the working-agent date for this vault in the **root** `_STATUS.md` registry.
- Format: `agent-name / YYYY-MM-DD`.
- If the vault isn't in the registry yet, add it under the appropriate category.

**Do not end the session without updating both the vault `_STATUS.md` AND the root `_STATUS.md`.**

## Session Handoff Notes (Required)

At session exit, **overwrite** the handoff file specific to your agent:

- Claude → `_SESSION_HANDOFF_CLAUDE.md`
- Codex → `_SESSION_HANDOFF_CODEX.md`
- Other → `_SESSION_HANDOFF_{agent-name}.md`

Each agent updates **only its own** handoff file. Never modify another agent's handoff.

What to record:
- **Work summary**: 1–3 lines on what this session did.
- **Per-vault changes**: changed/new/deleted file paths, incomplete items, warnings.
- **Decisions**: tagged `(YYYY-MM-DD)`.
- **Recommended next-session work**: concretely, what to start with.
- **Cautions/warnings**: what the next session could easily get wrong.

Handoff notes keep **only the latest session** — not history. History lives in `_STATUS.md` and Notion.

**Do not end the session without updating the handoff note.**

## Linking Per-Vault Handoffs to the Root Handoff (Required)

When you write a `_SESSION_HANDOFF_{agent}.md` inside an individual vault, **leave a pointer in the root handoff.**

In the root handoff's **Per-Vault Changes** section, record:

```markdown
### {vault-name} (`{vault-path}`)
- Detailed handoff: see `{vault-path}/_SESSION_HANDOFF_{agent}.md`
- 1-line summary (the key work of this session)
```

**Purpose**: at the start of the next session, reading just the root handoff tells you which vaults have detailed handoffs to open.

**Do not write per-vault handoffs without also adding a root-handoff reference.**

## AGENT_STATUS Update (Recommended)

Each agent's `AGENT_STATUS.md` is updated at the agent's own discretion.
- Recommended for complex work or when the next session needs carry-over context.
- Skippable for simple tasks.

## Design Rationale

- Vault `_STATUS.md`: detailed work record (Now/Next/Blocked/Decisions).
- Root `_STATUS.md`: lightweight — just the registry + most-recent working-agent date.
- When searching for recent work, users scan root by date and drill into the matching vault.
- In practice, operation is one-agent-per-vault with handoffs between sessions.
