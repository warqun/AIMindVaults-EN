# AIMindVaults — Codex Onboarding

> Codex desktop app / Codex CLI specific onboarding document.
> Read `AGENT_ONBOARDING.md` for common rules first.

---

## 1. Entry Points

- **Root entry point**: `AGENTS.md` — Vault registry (22 vaults), routing rules, skills list
- **Legacy**: `CODEX.md` → redirects to `AGENTS.md`
- **Internal routing**: `.codex/CODEX.md` — Codex rules reference hub

## 2. Session Start Sequence

1. `AGENTS.md` (root) — Codex main entry point
2. `.claude/rules/` all files — Common mandatory rules (canonical, applies to all agents)
3. `_STATUS.md` (root) — Overall vault status
4. `.codex/rules/` — Codex-specific rules
5. `.codex/AGENT_STATUS.md` — Codex status
6. Target vault's `AGENTS.md` or `CLAUDE.md`
7. Target vault's `_STATUS.md`

Complete this sequence before editing.

---

## 3. Agent Identification

- **Identifier**: `codex`
- frontmatter `agent: codex` (for multi-agent work: `agent: [claude, codex]`)
- Record as `codex / YYYY-MM-DD` in `_STATUS.md` at session exit
- Handoff file: `_SESSION_HANDOFF_CODEX.md`
- Status file: `.codex/AGENT_STATUS.md`

---

## 4. Read-Only Default Policy (Codex-Specific)

- Unless the user explicitly specifies an **action (create/modify/delete/execute)** in their prompt, Codex operates in **read-only** mode.
- Read-only scope: file browsing, content viewing, status checks, comparisons, summaries, reports.
- Prohibited before explicit instruction: file changes, automation registration/execution, write-mode script execution, external state changes.
- If instructions are ambiguous, do not start modification work — briefly confirm first.

---

## 5. Codex Role Scope

| Area | Codex | Claude Code |
|------|-------|-------------|
| Note editing within a single vault (`Contents/`) | O | O |
| Source note pipeline (video/article/PDF → note) | O | O |
| Repetitive tasks (bulk frontmatter updates, Juggl insertion, etc.) | O | O |
| Background cleanup (link/tag cleanup) | O | X (primarily) |
| Multi-vault structural changes | X | O |
| Script development/modification | X | O |
| `.obsidian/` configuration changes | X | O |

### Concurrent Modification Prohibited Areas

The following files can only be modified by one agent at a time:

| File | Reason |
|------|--------|
| `_STATUS.md` (vault/root) | Single source of truth for status tracking |
| `_WORKSPACE_VERSION.md` | Version number conflicts |
| `.obsidian/**` | JSON merge not possible |
| `_VAULT-INDEX.md` | Structure breaks on concurrent edits |

---

## 6. Codex Skills (`.codex/skills/` — 7 skills)

| Skill | Purpose | How to Run |
|-------|---------|-----------|
| `create-video-note` | Video URL → structured note | See `.codex/skills/create-video-note/SKILL.md` |
| `create-article-note` | Web article/text → structured note | See `.codex/skills/create-article-note/SKILL.md` |
| `create-pdf-note` | PDF → structured note | See `.codex/skills/create-pdf-note/SKILL.md` |
| `cross-vault-migration` | Cross-vault note migration | See `.codex/skills/cross-vault-migration/SKILL.md` |
| `sync-distribution` | Distribution sync | See `.codex/skills/sync-distribution/SKILL.md` |
| `open-note` | Open an Obsidian note | See `.codex/skills/open-note.md` |
| `open-vault` | Open an Obsidian vault | See `.codex/skills/open-vault.md` |

Each skill has step-by-step procedures documented. Read the corresponding SKILL.md and execute in order.

---

## 7. Codex-Specific Rules (`.codex/rules/` — 4 rules)

| Rule | Key Point |
|------|-----------|
| `vault-routing.md` | AIHubVault → workspace, others → keyword inference or user confirmation |
| `edit-scope.md` | Root scope definition, workspace is AIHubVault only, session exit procedure |
| `status-sync.md` | Root status vs vault status separation principle |
| `encoding-safety.md` | UTF-8 safety, Get-Content pipeline prohibited, stop immediately on mojibake |

These rules **supplement** the common rules in `.claude/rules/core/`. Common rules take precedence.

---

## 8. Configuration Structure

```
.codex/
├── CODEX.md            ← Internal routing hub (session sequence, vault registry)
├── AGENT_STATUS.md     ← Codex status (updated during complex tasks)
├── rules/              ← 4 Codex-specific rules
│   ├── vault-routing.md
│   ├── edit-scope.md
│   ├── status-sync.md
│   └── encoding-safety.md
└── skills/             ← 7 Codex-specific skills
    ├── create-video-note/SKILL.md
    ├── create-article-note/SKILL.md
    ├── create-pdf-note/SKILL.md
    ├── cross-vault-migration/SKILL.md
    ├── sync-distribution/SKILL.md
    ├── open-note.md
    └── open-vault.md
```

---

## 9. Common Rules Application

Codex follows all 14 mandatory rules in `.claude/rules/core/`.
As stated in `AGENTS.md` section on shared rules: "At session start, read and follow all rule files in the `.claude/rules/` directory."

Key rules summary:

| Rule | Key Point for Codex |
|------|---------------------|
| Post-Edit Review | Run `aimv review` after note edits + complete indexing |
| Edit mode separation | Contents mode for note editing, workspace edits are AIHubVault only |
| Session exit | Update both vault + root `_STATUS.md` + write handoff file |
| Token conservation | Pinpoint access, no repeated reads, high-cost operations require pre-approval |
| Script creation | Creation prohibited without user approval |

Full list: See the Rule Detail Reference table in `AGENT_ONBOARDING.md`.

---

## 10. Serena MCP — Semantic Code Analysis (Depending on User Environment)

If the Serena MCP server is connected, you can explore and modify C# code at the symbol level.

| Tool | Purpose |
|------|---------|
| `get_symbols_overview` | List classes/methods in a file |
| `find_symbol` | Search by symbol name |
| `find_referencing_symbols` | Find where a specific symbol is referenced |
| `search_for_pattern` | Search for code patterns |
| `replace_symbol_body` | Replace symbol body |

Use `get_symbols_overview` to understand the structure before reading entire files.
Details: `AGENTS.md` section on Serena MCP or `.claude/rules/custom/serena-mcp.md`
