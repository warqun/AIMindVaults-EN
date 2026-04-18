# AIMindVaults — Codex Onboarding

> Onboarding for Codex desktop app / Codex CLI.
> Read `AGENT_ONBOARDING.md` first for the shared rules.

---

## 1. Entry Points

- **Root entry point**: `AGENTS.md` — vault registry, routing rules, skill list.
- **Legacy**: `CODEX.md` redirects to `AGENTS.md`.
- **Internal router**: `.codex/CODEX.md` — Codex rule-reference hub.

## 2. Session Start Order

1. `AGENTS.md` (root) — Codex main entry point.
2. All of `.claude/rules/` — shared mandatory rules (the canonical set, applies to every agent).
3. `_STATUS.md` (root) — overall vault state.
4. `.codex/rules/` — Codex-specific rules.
5. `.codex/AGENT_STATUS.md` — Codex state.
6. Target vault's `AGENTS.md` or `CLAUDE.md`.
7. Target vault's `_STATUS.md`.

Complete this sequence before editing anything.

---

## 3. Agent Identity

- **Identifier**: `codex`.
- frontmatter `agent: codex` (multi-agent work: `agent: [claude, codex]`).
- At session end, log `codex / YYYY-MM-DD` in `_STATUS.md`.
- Handoff file: `_SESSION_HANDOFF_CODEX.md`.
- State file: `.codex/AGENT_STATUS.md`.

---

## 4. Read-Only Default Policy (Codex-specific)

- If the user's prompt does not explicitly request an **action (create/modify/delete/execute)**, Codex operates in **read-only** mode.
- Read-only scope: file exploration, content inspection, state checks, comparison, summarization, reporting.
- Forbidden before explicit instruction: file modification, scheduling/running automation, writing scripts, changing external state.
- When instruction is ambiguous, do not start a change operation — confirm briefly first.

---

## 5. Codex Role Scope

| Area | Codex | Claude Code |
|------|-------|-------------|
| Note editing within a single vault (`Contents/`) | Y | Y |
| Source-note pipeline (video/article/PDF → note) | Y | Y |
| Repetitive work (bulk frontmatter, Juggl insertion) | Y | Y |
| Background cleanup (link/tag cleanup) | Y | N (usually) |
| Multi-vault structural change | N | Y |
| Script development / modification | N | Y |
| `.obsidian/` config changes | N | Y |

### No-concurrent-edit files

Only one agent may edit each of these at a time:

| File | Reason |
|------|--------|
| `_STATUS.md` (vault/root) | Single source of state truth |
| `_WORKSPACE_VERSION.md` | Version-number conflicts |
| `.obsidian/**` | JSON cannot be merged |
| `_VAULT-INDEX.md` | Structure breaks on concurrent edit |

---

## 6. Codex Skills (`.codex/skills/` — 7)

| Skill | Purpose | How to run |
|-------|---------|------------|
| `create-video-note` | Video URL → structured note | See `.codex/skills/create-video-note/SKILL.md` |
| `create-article-note` | Web article/text → structured note | See `.codex/skills/create-article-note/SKILL.md` |
| `create-pdf-note` | PDF → structured note | See `.codex/skills/create-pdf-note/SKILL.md` |
| `cross-vault-migration` | Move notes between vaults | See `.codex/skills/cross-vault-migration/SKILL.md` |
| `sync-distribution` | Distribution sync | See `.codex/skills/sync-distribution/SKILL.md` |
| `open-note` | Open Obsidian note | See `.codex/skills/open-note.md` |
| `open-vault` | Open Obsidian vault | See `.codex/skills/open-vault.md` |

Each skill documents its step-by-step procedure. Read the SKILL.md and follow the steps.

---

## 7. Codex-only Rules (`.codex/rules/` — 4)

| Rule | Core idea |
|------|-----------|
| `vault-routing.md` | AIHubVault → workspace; others → keyword inference or user confirmation |
| `edit-scope.md` | Root scope definition, workspace in AIHubVault only, session-end procedure |
| `status-sync.md` | Root-state vs vault-state separation |
| `encoding-safety.md` | UTF-8 safety, no Get-Content pipeline, halt immediately on mojibake |

These **complement** the shared rules under `.claude/rules/core/`. The shared rules take precedence.

---

## 8. Config Structure

```
.codex/
├── CODEX.md            ← internal routing hub (session order, vault registry)
├── AGENT_STATUS.md     ← Codex state (updated on complex work)
├── rules/              ← 4 Codex-only rules
│   ├── vault-routing.md
│   ├── edit-scope.md
│   ├── status-sync.md
│   └── encoding-safety.md
└── skills/             ← 7 Codex-only skills
    ├── create-video-note/SKILL.md
    ├── create-article-note/SKILL.md
    ├── create-pdf-note/SKILL.md
    ├── cross-vault-migration/SKILL.md
    ├── sync-distribution/SKILL.md
    ├── open-note.md
    └── open-vault.md
```

---

## 9. Shared-Rule Compliance

Codex also follows every mandatory rule under `.claude/rules/core/`.
`AGENTS.md` § Shared Rules states: "At session start, read and follow every rule file under `.claude/rules/`."

### Skill Router dynamic loading (Codex behavior)

How Codex executes the "Dynamic rule loading" described in the shared onboarding §15:

- On every user message, scan the trigger keyword table in `.claude/rules/core/_skill-router.md`.
- On a match, Read the mapped `.claude/rules-archive/` rule file.
- Rows that invoke a Skill (Claude Code-only) — directly Read the archive rule files that the Skill integrates, as a substitute.
- Do not re-read archive files already loaded in the current session.

Key rules:

| Rule | Codex application |
|------|-------------------|
| Post-Edit Review | After note edit, run `aimv review` + complete indexing |
| Edit-mode separation | Edit notes in Contents mode; workspace edits in AIHubVault only |
| Session exit | Update both vault and root `_STATUS.md` + write the handoff file |
| Token optimization | Pinpoint access, no re-reads, pre-approve expensive work |
| Script creation | Never create a script without user approval |

Full list: see the rule-details table in `AGENT_ONBOARDING.md`.

---

## 10. Serena MCP — Semantic Code Analysis (if available)

If the Serena MCP server is connected, you can navigate and edit C# code at the symbol level.

| Tool | Purpose |
|------|---------|
| `get_symbols_overview` | List classes/methods in a file |
| `find_symbol` | Search by symbol name |
| `find_referencing_symbols` | Find references to a symbol |
| `search_for_pattern` | Pattern search in code |
| `replace_symbol_body` | Replace a symbol's body |

Before reading an entire file, use `get_symbols_overview` to understand the structure.
Details: `AGENTS.md` § Serena MCP or `.claude/rules/custom/serena-mcp.md`.
