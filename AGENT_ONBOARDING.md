# AIMindVaults — Agent Onboarding (Common)

> This document is for AI agents accessing this environment for the first time.
> Any agent capable of local file read/write can use this system.
> For agent-specific onboarding details, refer to the documents below.

| Agent | Dedicated Onboarding | Entry Point |
|-------|---------------------|-------------|
| Claude Code | `AGENT_ONBOARDING_CLAUDE.md` | `CLAUDE.md` |
| Codex | `AGENT_ONBOARDING_CODEX.md` | `AGENTS.md` |
| Other | This document + choose an entry point | `CLAUDE.md` or `AGENTS.md` |

---

## 1. Environment Overview

AIMindVaults is an Obsidian-based multi-vault knowledge management system.

- 27+ vaults are organized by purpose (domain knowledge, projects, personal records, reference materials, etc.).
- AIHubVault serves as the single source of truth (Hub), synchronizing the workspace (rules, scripts, standards) across all vaults.
- To add a vault, clone BasicContentsVault using `aimv clone`.

### Configuration

- External software installation guide: See `SETUP_GUIDE.md`.
- System architecture details: See `docs/architecture.md`.
- CLI tool reference: See `docs/cli-reference.md`.
- User customization: See `docs/customization.md`.

---

## 2. Vault Organization

The full registry is in `CLAUDE.md` or `AGENTS.md`. Main categories:

| Category | Path Pattern | Examples |
|----------|-------------|---------|
| BasicVaults | `Vaults/BasicVaults/` | AIHubVault (Hub), BasicContentsVault (template) |
| Domains_Game | `Vaults/Domains_Game/` | Unity, GameDesign, GameArt |
| Domains_Video | `Vaults/Domains_Video/` | CapCut |
| Domains_Infra | `Vaults/Domains_Infra/` | Notion, CICD, Search, AI, AppFlowy |
| Domain_Art | `Vaults/Domain_Art/` | LightAndColor |
| Domains_Business | `Vaults/Domains_Business/` | Funding |
| Lab_Infra | `Vaults/Lab_Infra/` | ObsidianDev |
| Lab_Game | `Vaults/Lab_Game/` | CombatToolKit, TileMapToolKit |
| Projects_Game | `Vaults/Projects_Game/` | JissouGame |
| Projects_Infra | `Vaults/Projects_Infra/` | Project_AIMindVaults |
| Personal | `Vaults/Personal/` | Diary |
| References | `References/` | Unity_Documentation (readonly) |

---

## 3. Core File Structure

```
AIMindVaults/                    ← Multi-vault root
├── CLAUDE.md                    ← Claude Code entry point
├── AGENTS.md                    ← Codex entry point
├── AGENT_ONBOARDING.md          ← This document (common)
├── AGENT_ONBOARDING_CLAUDE.md   ← Claude Code specific onboarding
├── AGENT_ONBOARDING_CODEX.md    ← Codex specific onboarding
├── _STATUS.md                   ← Vault registry (type, working agent, date)
├── _SESSION_HANDOFF_{agent}.md  ← Previous session context
├── .claude/
│   ├── rules/core/              ← 15 mandatory rules
│   ├── rules/custom/            ← Personal rules (not distributed)
│   ├── commands/core/           ← 17 skills
│   └── commands/custom/         ← Personal skills
├── .codex/
│   ├── CODEX.md                 ← Codex internal routing hub
│   ├── AGENT_STATUS.md          ← Codex status
│   ├── rules/                   ← 4 Codex-specific rules
│   └── skills/                  ← 7 Codex-specific skills
└── Vaults/
    └── {vault}/
        ├── Contents/            ← Contents (notes)
        ├── _STATUS.md           ← Vault status
        ├── _VAULT-INDEX.md      ← Folder structure map
        ├── _WORKSPACE_VERSION.md ← Sync version
        ├── CLAUDE.md            ← Vault-specific rules
        └── .sync/               ← Sync mirror (propagated from Hub)
            ├── _Standards/Core/ ← Operational standards
            └── _tools/cli-node/ ← Node.js CLI tool (aimv)
```

---

## 4. Vault Routing

Before creating content, check the `_STATUS.md` vault registry to select the appropriate vault.

- Keyword-based automatic routing: Refer to the routing rules in the entry point document (`CLAUDE.md` or `AGENTS.md`).
- Explicit specification: "In AIHubVault ~", "In the Unity vault ~"
- If no suitable vault exists, ask the user. Do not place content in an unsuitable vault by arbitrary judgment.
- BasicContentsVault is for cloning only. Direct content work is prohibited.

---

## 5. Vault Entry Protocol

Before starting work in a target vault, read the following in order:

1. `_SESSION_HANDOFF_{agent}.md` (root) — Previous session context, incomplete items
2. `_STATUS.md` (root) — Overall vault status, check for conflicts with other vault work
3. `{vault}/CLAUDE.md` — Vault-specific rules
4. `{vault}/_STATUS.md` — Check Now/Next/Blocked

If the target vault is not AIHubVault, compare `_WORKSPACE_VERSION.md` with the Hub and sync first if there is a difference.

---

## 6. Environment Check (After Onboarding)

Immediately after reading this document and the agent-specific onboarding, perform the checks below before starting actual work. If issues are found, **report them to the user without fixing**.

### Required Checks

| Check Item | How to Verify | If Abnormal |
|-----------|---------------|-------------|
| Entry point file exists | `CLAUDE.md` or `AGENTS.md` exists at root | Report missing |
| Vault registry | Compare vault list in `_STATUS.md` with actual `Vaults/` folders | Report unregistered vaults |
| Hub marker | `Vaults/BasicVaults/AIHubVault/.sync/.hub_marker` exists | Report Hub identification failure |
| Sync version | Compare top version in target vault's `_WORKSPACE_VERSION.md` with Hub | Report version discrepancy |

### Optional Checks (When Anomalies Are Detected)

- **Document-reality mismatch**: Report if files referenced by rules/onboarding don't actually exist at the specified paths
- **Missing index**: Suggest running `/reindex` if the target vault lacks `vault_index.json`
- **Legacy path remnants**: Report if scripts/settings contain paths from before the `.sync/` structure (e.g., `_tools/cli/`)
- **JSON config files**: `.obsidian/` JSON files (especially `obsidian-shellcommands/data.json`) have deep structure. **Do not judge them as "empty" from partial reads.** Either read the full file or directly verify the 3 criteria in section 10.

### Check Principles

- **Report before fix**: Do not modify files during the check phase. Compile discovered issues into a list, report to the user, and fix only per user's judgment.
- **Non-blocking**: If check results don't block the currently requested task, proceed with work after reporting. Only suggest pre-resolution for issues that directly impact the task.
- **No repeated checks**: Do not repeat the same check in the same session. Perform once on first entry only.

---

## 7. Edit Mode Separation

All edits must declare one of two modes before proceeding. Mode mixing is prohibited.

### Contents Mode
- Scope: Files under `Contents/**`
- For content (note) creation/editing only
- Sub-branches: `[Contents/Domain]` (knowledge accumulation) or `[Contents/Project]` (task management)
- Prohibited: Modifying workspace files such as `.sync/`, `.claude/`, `.forge/`

### Workspace Mode
- Scope: `.sync/`, `.claude/`, `.codex/`, `.forge/`, vault root files
- **Must be performed in AIHubVault only** (mandatory). Other vaults receive changes via sync.
- Version must be recorded in `_WORKSPACE_VERSION.md` after modification (format: `YYYYMMDDNNNN`).
- Do not report work as complete without recording the version.

---

## 8. Note Writing Conventions

### Type and Tag System (New User Guide)

> **Agent requirement**: When a user writes their first note or asks "what are types?", "how do I use tags?", etc., explain concisely based on the content below.

Every note's frontmatter has two classification systems: `type` and `tags`.

**`type`** — The note's category. A fixed value selected from a predefined list.
- Study summary → `study-note`, Domain knowledge → `knowledge`, Design doc → `design`, Plan → `plan`
- Research → `research`, Reference material → `reference`, Report → `report`, Guide → `guide`
- Issue-related → `issue`, `issue-spec`, `issue-design`, `issue-report`
- Full list: `.claude/rules/core/note-writing.md` section "Core Type List"

**`tags`** — Content keywords for the note. Used for search and detailed classification.
- Default format: kebab-case (`skill-system`, `game-design`), proper nouns keep original casing (`Unity`, `AI`)
- **Tag format can be freely customized by the user.** Declaring `## Tag Rules` in a vault's `CLAUDE.md` overrides the default format.
- Role separation: Note type → `type`, Major topic → vault name/folder, Detailed keywords → `tags`

### Frontmatter Required
```yaml
---
type: knowledge       # Select from core type list
tags: [Unity, skill-system]  # Content-based search keywords
agent: claude         # Cumulative record of agents that worked on this note (claude, codex, etc.)
updated: 2026-04-08
---
```

### Structure
- One H1 heading. Use H2/H3 for structure.
- Use `[[WikiLink]]` for internal links. **At least 1 required.**
- URI reserved characters (`#`, `%`, `&`, `?`, `+`) and emojis are prohibited in H1 headings and filenames.
  - Alternatives: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`
- Figurative/metaphorical expressions prohibited. Use direct descriptions.
- `**text(parentheses)**` pattern prohibited → use `**text** (parentheses)`

### Juggl Embed
Insert immediately below the heading. The `local:` value is the filename (without extension).
```juggl
local: filename_without_extension
```
Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, files inside `.claude/`.

---

## 9. Session Exit Protocol

All of the following must be completed at session exit. The session cannot be closed if any item is missing.

### Vault _STATUS.md Update
- **Now**: Completed or in-progress work
- **Next**: Work to continue in the next session
- **Blocked**: Blockers (write "None" if none)
- **Decisions**: Decisions made this session (YYYY-MM-DD)

### Root _STATUS.md Update
- Update the working agent/date for the relevant vault in the vault registry.
- Format: `agent-name / YYYY-MM-DD`

### Session Handoff
- Overwrite `_SESSION_HANDOFF_{agent}.md`.
- Record: Work summary, changed files, decisions, recommended work for next session.
- When writing per-vault handoffs, also add a reference in the root handoff.

---

## 10. Hub-Sync Synchronization

- AIHubVault is the single source of truth (Hub). All files inside the `.sync/` folder are sync targets.
- Hub identification: Presence of `.sync/.hub_marker` file.
- Sync execution: `node cli.js pre-sync` → version comparison → `.sync/` mirroring → plugin merge.
- When a vault is opened in Obsidian, `node cli.js pre-sync` runs automatically via the `on-layout-ready` event (Shell Commands plugin).
- Workspace edits must be performed in AIHubVault only → propagated via sync.

### Shell Commands Configuration Verification Notes

When inspecting `.obsidian/plugins/obsidian-shellcommands/data.json`, you must read the actual content of the `shell_commands` array to the end. This JSON has deep structure (approximately 70 lines), and partial reads can easily lead to false conclusions like "it's empty" or "the path is different."

**Normal state criteria** (common to all vaults):
- `shell_commands[0].id` = `"syncworkspace"`
- `shell_commands[0].platform_specific_commands.default` contains `node "{{vault_path}}/.sync/_tools/cli-node/bin/cli.js" pre-sync`
- `shell_commands[0].events.on-layout-ready.enabled` = `true`

If all three are confirmed, the automatic sync configuration is normal.

---

## 11. Post-Edit Review

Run immediately after completing note edits:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault-path}" -s Contents
```
- Validates: frontmatter integrity, encoding safety, WikiLink presence.
- Do not report completion until `POST_EDIT_REVIEW_BAD=0` is confirmed.
- On pass, the content indexer incremental build is automatically invoked (`aimv index build -i`).
- Completion condition: `POST_EDIT_INDEX_UPDATED=1` confirmed. On failure, run manual indexing:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}" -i
```

---

## 12. Content Indexer

Crawls `Contents/**/*.md` in each vault to generate a JSON index in `.vault_data/`.

- Extracts: path, title, type, tags, headings, summary, links_to, links_from, mtime, hash
- Incremental build: Only updates changed notes by comparing mtime/hash.
- Skills: `/reindex` (current vault), `/reindex all` (all vaults), `/reindex {vault-name}` (specific)

---

## 13. Script Management

- Check `.sync/_Standards/Core/Script_Registry.md` for duplicates before creating new scripts.
- **User approval is required before creation.** Report purpose, path, impact scope, and whether it's one-time.
- No hardcoded paths — use auto-detection based on script location.
- Register in Script_Registry.md after creation.

---

## 14. Encoding Safety

- Encoding validation is required before bulk modifications to `Contents`.
- Bulk modifications must use UTF-8 fixed I/O only.
- Do not rewrite Korean markdown using PowerShell's `Get-Content + Set-Content` pipeline.
- Bulk replacement: dry-run → 3-file sample → full run.

---

## 15. Token Conservation

- **Pinpoint access**: Specify only the needed files precisely. No broad searches.
- If the path is unknown, ask the user first.
- For large files (100+ lines), read only the needed portion. No repeated reads of the same file.
- High-cost operations (bulk scans, multiple script executions) require user approval before proceeding.
- No self-debugging loops — present a fix and delegate execution to the user.

---

## 16. Temporary File Management

- When running CLI commands, create temporary files only under `$env:TEMP`.
- Do not leave temporary files (`.vtt`, `.json`, `.tmp`, `.log`, etc.) inside vaults.
- Delete immediately after work completion. Do not report completion before confirming deletion.

---

## 17. Opening Obsidian Notes/Vaults

`.md` notes in this environment reside inside Obsidian vaults. Use Obsidian URIs to open notes.

```powershell
Start-Process 'obsidian://open?vault=VaultName&file=relative_path_from_vault_root'
```

- `vault`: The vault folder name registered in Obsidian (e.g., `AIHubVault`, `Unity`, `JissouGame`)
- `file`: Relative path from vault root, omit `.md` extension (e.g., `Contents/Domain/Example_Note`)
- Path separator: Use `/`. Non-ASCII filenames can be used as-is.
- `Start-Process <filepath.md>`, `code`, `Invoke-Item`, etc. are prohibited as they open in VS Code.

### Registering a New Vault in Obsidian

When opening a newly created vault in Obsidian for the first time, **always guide the user to register it directly through the Obsidian vault manager**.

**Guidance text:**
> Obsidian vault manager → "Open folder as vault" → select `{vault path}`

**Opening unregistered vaults via `obsidian://open?path=` URI is prohibited.**
- The URI method triggers app state transition + registration + plugin loading simultaneously, resulting in very slow loading.
- Opening directly from the vault manager is faster because Obsidian is already in a ready state.
- URIs should only be used for **switching between already registered vaults** (`obsidian://open?vault=VaultName`).

---

## 18. Security Notice

This system operates exclusively with **local files + local agents**, without network services or separate authentication systems.

### Security Boundaries

- **OS level**: Windows user account permissions = vault access permissions. If only you use the PC, file security is sufficient.
- **Agent level**: AI agents (Claude Code, Codex, etc.) can read/write/execute local files. Setting tool execution permission to **"confirm before approve"** mode can prevent unintended file operations.

### Precautions

- **Avoid cloud sync folders**: Placing vaults in auto-sync folders like OneDrive exposes notes in plaintext to the cloud. If handling sensitive research data, place vaults outside sync folders.
- **Auto-execution scripts**: When a vault is opened in Obsidian, `node cli.js pre-sync` runs automatically, performing Hub → satellite vault configuration sync. Source: `.sync/_tools/cli-node/src/commands/pre-sync.js`
- **Prompt injection**: When agents read notes, they may follow malicious instructions embedded in note content. Verify the content of externally sourced notes before adding them to vaults.

---

## Rule Detail Reference

| Rule | File |
|------|------|
| Vault routing | `.claude/rules/core/vault-routing.md` |
| Edit mode separation | `.claude/rules/core/edit-mode-separation.md` |
| Note writing | `.claude/rules/core/note-writing.md` |
| Session exit | `.claude/rules/core/session-exit.md` |
| Distribution sync | `.claude/rules/core/distribution-sync.md` |
| Post-Edit Review | `.claude/rules/core/post-edit-review.md` |
| Script management | `.claude/rules/core/script-management.md` |
| Script creation approval | `.claude/rules/core/script-creation-approval.md` |
| Encoding safety | `.claude/rules/core/encoding-safety.md` |
| Token optimization | `.claude/rules/core/token-optimization.md` |
| Temporary file management | `.claude/rules/core/temp-file-management.md` |
| Juggl style | `.claude/rules/core/juggl-style-sync.md` |
| Obsidian config | `.claude/rules/core/obsidian-config-safety.md` |
| Vault individualization | `.claude/rules/core/vault-individualization.md` |
| User guidance | `.claude/rules/core/user-guidance.md` |
