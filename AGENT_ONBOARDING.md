# AIMindVaults — Agent Onboarding (Shared)

> The document an AI agent reads on first contact with this environment.
> Any agent that can read and write local files works.
> For agent-specific onboarding, see the per-agent docs below.

| Agent | Dedicated onboarding | Entry point |
|-------|----------------------|-------------|
| Claude Code | `AGENT_ONBOARDING_CLAUDE.md` | `CLAUDE.md` |
| Codex | `AGENT_ONBOARDING_CODEX.md` | `AGENTS.md` |
| Others | this doc + either entry point | `CLAUDE.md` or `AGENTS.md` |

---

## 1. Environment Overview

AIMindVaults is an Obsidian-based multi-vault knowledge management system.

- Vaults are organized by purpose (domain knowledge, projects, personal notes, reference docs, etc.). The distribution ships with two: AIHubVault (Hub) and BasicContentsVault (clone template). The user adds more.
- AIHubVault is the single source of truth (Hub) — it syncs the workspace (rules, scripts, standards) to every other vault.
- New vaults are created by cloning BasicContentsVault via `aimv clone`.

### Environment setup

- External software install guide: `SETUP_GUIDE.md`.
- System architecture details: `docs/architecture.md`.
- CLI tool reference: `docs/cli-reference.md`.
- User customization: `docs/customization.md`.
- Context window optimization (MCP/plugins): `docs/context-optimization.md`.

---

## 2. Vault Layout

The full registry lives in `CLAUDE.md` or `AGENTS.md`. Only `BasicVaults` ships pre-populated; the remaining categories are optional shapes the user may adopt.

| Category | Path pattern | Purpose |
|----------|--------------|---------|
| BasicVaults | `Vaults/BasicVaults/` | AIHubVault (Hub), BasicContentsVault (clone template) — shipped |
| Domains_<area> | `Vaults/Domains_<area>/` | Domain-knowledge vaults — user-added |
| Projects_<area> | `Vaults/Projects_<area>/` | Project work vaults — user-added |
| Lab_<area> | `Vaults/Lab_<area>/` | Mixed domain + project — user-added |
| Personal | `Vaults/Personal/` | Personal notes — user-added |
| References | `References/` | Readonly reference material — user-added |

---

## 3. Key File Structure

```
AIMindVaults/                    ← multi-vault root
├── CLAUDE.md                    ← Claude Code entry point
├── AGENTS.md                    ← Codex entry point
├── AGENT_ONBOARDING.md          ← this doc (shared)
├── AGENT_ONBOARDING_CLAUDE.md   ← Claude-Code-only onboarding
├── AGENT_ONBOARDING_CODEX.md    ← Codex-only onboarding
├── _STATUS.md                   ← vault registry (type, working agent, date)
├── _SESSION_HANDOFF_{agent}.md  ← previous session context
├── .claude/
│   ├── rules/core/              ← 15 mandatory rules
│   ├── rules/custom/            ← personal rules (not distributed)
│   ├── commands/core/           ← 17 skills
│   └── commands/custom/         ← personal skills
├── .codex/
│   ├── CODEX.md                 ← Codex internal routing hub
│   ├── AGENT_STATUS.md          ← Codex state
│   ├── rules/                   ← 4 Codex-only rules
│   └── skills/                  ← 7 Codex-only skills
└── Vaults/
    └── {vault}/
        ├── Contents/            ← content (notes)
        ├── _STATUS.md           ← vault state
        ├── _VAULT-INDEX.md      ← folder structure map
        ├── _WORKSPACE_VERSION.md ← sync version
        ├── CLAUDE.md            ← vault-specific rules
        └── .sync/               ← sync mirror (propagated from Hub)
            ├── _Standards/Core/ ← operational standards
            └── _tools/cli-node/ ← Node.js CLI tool (aimv)
```

---

## 4. Vault Routing

Before creating content, check the `_STATUS.md` vault registry to pick the right vault.

- Keyword-based auto-routing: see the routing rules in the entry point doc (`CLAUDE.md` or `AGENTS.md`).
- Explicit naming: "in AIHubVault...", "in the <YourDomainVault>..."
- If nothing fits, ask the user. Never drop a note into an ill-fitting vault on your own.
- BasicContentsVault is for clone templates only. No direct content work.

---

## 5. Vault Entry Protocol

Before starting work in a target vault, read these in order:

1. `_SESSION_HANDOFF_{agent}.md` (root) — prior session context, unfinished items.
2. `_STATUS.md` (root) — overall vault state, cross-vault conflicts to watch for.
3. `{vault}/CLAUDE.md` — vault-specific rules.
4. `{vault}/_STATUS.md` — current Now/Next/Blocked.

If the target isn't AIHubVault, compare `_WORKSPACE_VERSION.md` with the Hub — if different, sync first.

---

## 6. Environment Check (after onboarding)

Right after reading this doc and the per-agent onboarding, before starting real work, run the checks below. If you find a problem, **report it to the user instead of fixing it**.

### Required checks

| Item | How to verify | If wrong |
|------|---------------|----------|
| Entry point exists | `CLAUDE.md` or `AGENTS.md` at the root | Report missing |
| Vault registry | Compare `_STATUS.md`'s list to the actual `Vaults/` folders | Report unregistered vaults |
| Hub marker | `Vaults/BasicVaults/AIHubVault/.sync/.hub_marker` exists | Report Hub not identifiable |
| Sync version | Target vault's `_WORKSPACE_VERSION.md` top version vs Hub | Report version drift |

### Optional checks (on smelly signals)

- **Docs ↔ reality mismatch**: if a rule or onboarding doc references a path that doesn't exist, report it.
- **Missing index**: if the target vault has no `vault_index.json`, suggest `/reindex`.
- **Stale paths**: if you see pre-`.sync/` paths (e.g. `_tools/cli/`) in scripts or configs, report them.
- **JSON config files**: `.obsidian/` JSON (especially `obsidian-shellcommands/data.json`) is deeply nested. **Do not conclude "empty" from a partial read.** Read fully, or directly verify the three healthy-state criteria in §10.

### Check principles

- **Report over fix**: during checks, don't edit files. List the issues and let the user decide.
- **Not a blocker**: if the check result doesn't block the current request, report and proceed. Only propose fixing first if the issue directly affects the task.
- **Don't re-check**: don't repeat the same check in the same session. Once on entry, not more.

---

## 7. Edit-Mode Separation

All edits declare one of two modes. No mixing.

### Contents mode
- Target: files under `Contents/**`
- Content (note) authoring/editing only.
- Sub-declaration: `[Contents/Domain]` (knowledge accumulation) or `[Contents/Project]` (task management).
- Forbidden: editing workspace files (`.sync/`, `.claude/`, `.codex/`, etc.).

### Workspace mode
- Target: `.sync/`, `.claude/`, `.codex/`, vault root files.
- **Only in AIHubVault** (mandatory). Other vaults receive these via sync automatically.
- After editing, log the version in `_WORKSPACE_VERSION.md` (format: `YYYYMMDDNNNN`). Required.
- Do not report the work done without the version entry.

---

## 8. Note Writing Conventions

### Type and tag system (guidance for new users)

> **Agent mandatory**: when the user is writing their first note or asks "what's a type?" / "how do I use tags?", give a concise explanation based on the below.

Every note's frontmatter carries two classification axes: `type` and `tags`.

**`type`** — the note's kind. A fixed value picked from the list.
- study notes → `study-note`, domain knowledge → `knowledge`, design docs → `design`, plans → `plan`
- research → `research`, reference material → `reference`, reports → `report`, guides → `guide`
- issue-related → `issue`, `issue-spec`, `issue-design`, `issue-report`
- Full list: `.claude/rules/core/note-writing.md` § "Core Type List"

**`tags`** — content keywords for the note. For search and fine-grained classification.
- Default format: kebab-case (`skill-system`, `game-design`); proper nouns keep their original casing (`Unity`, `AI`).
- **Tag format is user-configurable.** Declare `## Tag Rules` in the vault's `CLAUDE.md` to override the default.
- Roles: kind → `type`, broad subject → vault name / folder, detailed keywords → `tags`.

### Required frontmatter
```yaml
---
type: knowledge       # pick from the core type list
tags: [AI, workflow]  # content-based search keywords
agent: claude         # cumulative record of agents that worked on this note
updated: 2026-04-15
---
```

### Structure
- One H1. Use H2/H3 for structure.
- Internal links use `[[WikiLink]]`. **At least one is required.**
- No URI-reserved characters (`#`, `%`, `&`, `?`, `+`) or emoji in the H1 or filename.
  - Alternates: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`.
- No metaphors or figurative language. Describe directly.
- No `**text(paren)**` — rewrite as `**text** (paren)`.

### Juggl embed
Insert right below the H1. The `local:` value is the filename (without extension).
```juggl
local: filename_without_extension
```
Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, files under `.claude/`.

---

## 9. Session Exit Protocol

Every item below must be completed at session end. Missing any one means the session isn't closed.

### Vault _STATUS.md update
- **Now**: completed / in-progress work
- **Next**: what to pick up next time
- **Blocked**: blockers (write "none" if none)
- **Decisions**: decisions made this session (YYYY-MM-DD)

### Root _STATUS.md update
- Update the working-agent/date entry for this vault in the registry.
- Format: `agent-name / YYYY-MM-DD`

### Session handoff
- Overwrite `_SESSION_HANDOFF_{agent}.md`.
- Record: work summary, changed files, decisions, recommended next-session work.
- When writing a per-vault handoff, leave a pointer in the root handoff.

---

## 10. Hub-Sync

- AIHubVault is the single source of truth (Hub). Everything under `.sync/` is a sync target.
- Hub identification: presence of `.sync/.hub_marker`.
- Sync run: `node cli.js pre-sync` → version compare → `.sync/` mirror → plugin merge.
- When Obsidian opens a vault, the `on-layout-ready` event runs `node cli.js pre-sync` automatically (via the Shell Commands plugin).
- Workspace edits must happen in AIHubVault → propagated via sync.

### Verifying the Shell Commands config

When inspecting `.obsidian/plugins/obsidian-shellcommands/data.json`, read the `shell_commands` array through to the end. The JSON is deeply nested (~70 lines) — a partial read easily misleads you into "empty" or "wrong path".

**Healthy-state criteria** (same across all vaults):
- `shell_commands[0].id` = `"syncworkspace"`
- `shell_commands[0].platform_specific_commands.default` contains `node "{{vault_path}}/.sync/_tools/cli-node/bin/cli.js" pre-sync`
- `shell_commands[0].events.on-layout-ready.enabled` = `true`

If all three check out, auto-sync is configured correctly.

---

## 11. Post-Edit Review

Run immediately after note edits:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault-path}" -s Contents
```
- Verifies: frontmatter integrity, encoding safety, WikiLink presence.
- Do not report done before `POST_EDIT_REVIEW_BAD=0`.
- On pass, it auto-invokes the incremental content indexer build (`aimv index build -i`).
- Work is complete only when `POST_EDIT_INDEX_UPDATED=1`. If it fails, index manually:
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}" -i
```

---

## 12. Content Indexer

Crawls each vault's `Contents/**/*.md` and emits a JSON index under `.vault_data/`.

- Extracts: path, title, type, tags, headings, summary, links_to, links_from, mtime, hash.
- Incremental build: only updates notes whose mtime/hash changed.
- Skills: `/reindex` (current vault), `/reindex all` (all), `/reindex {vault-name}` (specific).

---

## 13. Script Management

- Before creating a new script, check `.sync/_Standards/Core/Script_Registry.md` for duplicates.
- **User approval required before creation.** Report purpose, path, impact scope, one-off vs permanent.
- No hardcoded paths — use script-location-based auto-resolution.
- After creation, register in Script_Registry.md.

---

## 14. Encoding Safety

- Bulk edits under `Contents` require encoding verification first.
- Bulk edits must use UTF-8-fixed I/O only.
- Do not rewrite markdown with the PowerShell `Get-Content + Set-Content` pipeline.
- Bulk replace: dry-run → 3-file sample → full run.

---

## 15. Token Optimization

### Dynamic rule loading

- Only `_essentials.md` (integrated core) and `_skill-router.md` (keyword → rule/Skill mapping) under `.claude/rules/core/` are always injected.
- Domain rules and reference guides live in `.claude/rules-archive/` and are **not auto-injected**.
- On every user message, review `_skill-router.md` — when a trigger keyword matches, invoke the mapped Skill or Read the archive rule file.
- Skills and rules already loaded in the current session must not be reloaded (avoid duplicate token cost).
- If nothing matches, proceed with `_essentials.md` alone.

### General token optimization

- **Pinpoint access**: read the exact file you need. No broad scans.
- If you don't know the path, ask the user first.
- For large files (100+ lines), read only the needed range. Don't re-read the same file.
- High-cost work (bulk scans, multiple script runs) needs user approval first.
- No self-debug loops — propose a fix and delegate execution.

---

## 16. Temp File Management

- CLI-generated temp files go under `$env:TEMP` only.
- Don't leave temp files (`.vtt`, `.json`, `.tmp`, `.log`, etc.) inside the vault.
- Delete immediately after the task. No completion report before deletion is confirmed.

---

## 17. Opening Obsidian Notes / Vaults

The `.md` notes here live inside Obsidian vaults. Use an Obsidian URI to open them.

```powershell
Start-Process 'obsidian://open?vault=VaultName&file=relative/path/from/vault/root'
```

- `vault`: the vault folder name Obsidian has registered (e.g. `AIHubVault`, `BasicContentsVault`, or any vault the user has added).
- `file`: path relative to the vault root, without `.md` (e.g. `Contents/Domain/Example_Note`).
- Separator: `/`. Non-ASCII filenames are fine.
- Do not use `Start-Process <file.md>`, `code`, `Invoke-Item`, etc. — they open VS Code.

### Registering a new vault in Obsidian

For a freshly created vault, **always instruct the user to register it via the Obsidian Vault Manager themselves**.

**Wording:**
> Obsidian Vault Manager → "Open folder as vault" → select `{vault path}`.

**Do not open an unregistered vault via `obsidian://open?path=`.**
- The URI path does app-state switch + registration + plugin load all at once — very slow.
- Opening via the Vault Manager is fast because Obsidian is already warm.
- Use the URI only for **switching between already-registered vaults** (`obsidian://open?vault=name`).

---

## 18. Security

This system runs on **local files + local agents** — no network service, no auth layer.

### Security boundaries

- **OS level**: your Windows user account permissions = vault access permissions. If the PC is single-user, file security is sufficient.
- **Agent level**: AI agents (Claude Code, Codex, etc.) can read, write, and execute local files. Set tool-execution policy to **"ask before approving"** to avoid unintended file operations.

### Cautions

- **Avoid cloud-sync folders**: putting the vault inside OneDrive or similar exposes notes in plaintext to the cloud. Keep sensitive research data outside such folders.
- **Auto-run scripts**: opening a vault in Obsidian auto-runs `node cli.js pre-sync` for Hub→satellite config sync. Source: `.sync/_tools/cli-node/src/commands/pre-sync.js`.
- **Prompt injection**: when the agent reads a note, it may follow malicious instructions embedded inside. Review externally sourced notes before adding them to a vault.

---

## Rule Details

| Rule | File |
|------|------|
| Vault routing | `.claude/rules/core/vault-routing.md` |
| Edit-mode separation | `.claude/rules/core/edit-mode-separation.md` |
| Note writing | `.claude/rules/core/note-writing.md` |
| Session exit | `.claude/rules/core/session-exit.md` |
| Distribution sync | `.claude/rules/core/distribution-sync.md` |
| Post-edit review | `.claude/rules/core/post-edit-review.md` |
| Script management | `.claude/rules/core/script-management.md` |
| Script creation approval | `.claude/rules/core/script-creation-approval.md` |
| Encoding safety | `.claude/rules/core/encoding-safety.md` |
| Token optimization | `.claude/rules/core/token-optimization.md` |
| Temp file management | `.claude/rules/core/temp-file-management.md` |
| Juggl style | `.claude/rules/core/juggl-style-sync.md` |
| Obsidian config | `.claude/rules/core/obsidian-config-safety.md` |
| Vault individualization | `.claude/rules/core/vault-individualization.md` |
| User guidance | `.claude/rules/core/user-guidance.md` |
