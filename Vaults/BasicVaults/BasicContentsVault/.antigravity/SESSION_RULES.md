---
type: workflow
tags:
  - Meta
  - antigravity
updated: 2026-03-10
agent: antigravity
---

# Antigravity Session Rules (DEPRECATED)

> **DEPRECATED (2026-03-21)**: Migrated from Antigravity to Codex desktop app. Use `AGENTS.md` in the vault root.

> Antigravity-specific session entry point.
> Read this file at session start and follow the rules.

## Role of This Vault

**AI workspace design, improvement, and deployment hub** — Manages AI operational structures such as `_Standards`, `_tools`, `.claude`, `_forge`.
Game development/planning work is not performed in this vault.

## Session Start Routine (Mandatory)

1. Check root `_STATUS.md` — Overall vault status + check work in other vaults
2. Check `_STATUS.md` — This vault's current focus/next/blocking
3. Check `.antigravity/AGENT_STATUS.md` — My last work status
3. Understand document locations via `_VAULT-INDEX.md`
4. If needed, check `.codex/AGENT_STATUS.md` — Codex's last work (conflict prevention)

## Edit Mode Separation (Mandatory)

- All edits are performed in either **`[Contents]` mode** or **`[workspace]` mode**.
- `[Contents]` mode: Only `Contents/**` content can be modified. Modifying `_Standards/`, `_tools/`, `.codex/`, `.claude/`, `.antigravity/`, vault root is prohibited.
- `[workspace]` mode: Only `_Standards/`, `_tools/`, `.codex/`, `.claude/`, `.antigravity/`, vault root can be modified. Modifying `Contents/**` is prohibited.
- Explicit declaration is required when switching modes. Mixing two modes in one task is prohibited.
- **Version recording is mandatory when [workspace] mode completes**: If workspace files were created/modified/deleted, a new version (`YYYYMMDDNNNN`) must be added to `_WORKSPACE_VERSION.md`. Do not report workspace work as complete without version recording.
- Details: `_WORKFLOW.md` section 5) Edit Mode Separation

## Note Writing Rules

- Documents are written in the vault's primary language. Code/identifiers/paths retain original text.
- Frontmatter rules from `_Standards/Core/NoteProperties.md` must be followed.
  - `type`, `tags` (including AIMindVault), `updated` or `created` are required.
- Register new folders in `_VAULT-INDEX.md` root structure.
- Juggl block: Insert directly below title (`local: Note_Title`). Exceptions: _STATUS.md, _VAULT-INDEX.md.

## Script Creation/Management Rules (2026-03-09)

- Before creating a new script, always check `_Standards/Core/Script_Registry.md` — duplicate functionality is prohibited.
- If the functionality can be achieved by extending an existing script, do not create a new one.
- Path hardcoding is prohibited — use script-location-based auto-detection (`$ScriptDir\..\..`).
- After creation, always register in `Script_Registry.md`. On deletion, move entry to "Deleted Scripts" section with reason.
- Details: [[_Standards/Core/Script_Creation_Rule]]

## Encoding Safety Rules (Mandatory)

- Always run encoding verification before bulk `Contents` edits.
- Bulk edit scripts must use UTF-8 fixed I/O only.
- `Get-Content | Set-Content` pipeline is prohibited — use `.NET UTF-8 API` only.
- No follow-up work before confirming `BAD_COUNT=0`.
- Details: [[_Standards/Core/Encoding_BulkEdit_Safety]]

## Edit Completion Gate (Required)

```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```

- Do not report completion before confirming `POST_EDIT_REVIEW_BAD=0`.

## Obsidian CLI Priority Usage Rules

- For queries/search/history recovery, first use `_tools/cli/aimv bridge`.
- Use direct file parsing only when CLI results are insufficient.
- After editing, complete review with `-Action post-review`.
- Details: [[_Standards/Core/AI_ObsidianCLI_Usage]]

## At Session End

1. **Update `_STATUS.md` (Required)**: Directly update `_STATUS.md` (Now/Next/Blocked/Decisions). **Do not end session without updating `_STATUS.md`.**
2. **Update root `_STATUS.md` (Required)**: Update this vault's section in the root `_STATUS.md` (Now/Last Agent/Next/Blocked).
3. **Update AGENT_STATUS (Recommended)**: `.antigravity/AGENT_STATUS.md` — Update for complex work or when context needs to be passed. Can be skipped for simple tasks.

## Relationship with Other Agents

| Agent | Entry Point | Rules Folder |
|-------|------------|-------------|
| Antigravity (me) | `.antigravity/SESSION_RULES.md` (this file) | `.antigravity/` |
| Claude Code | `CLAUDE.md` | `.claude/rules/`, `.claude/commands/` |
| Codex | `AGENTS.md` | `.codex/rules/`, `.codex/playbooks/` |
| Cursor | `.cursor/rules/` (auto-loaded at root) | `.cursor/` |
