# AIMindVaults — Claude Code Onboarding

> Claude Code agent-specific onboarding document.
> Read `AGENT_ONBOARDING.md` for common rules first.

---

## 1. Entry Points

- **Root entry point**: `CLAUDE.md` — Vault registry (22 vaults), routing keywords, entry protocol
- **Vault entry point**: `{vault}/CLAUDE.md` — Vault-specific rules, edit modes, session rules

## 2. Session Start Sequence

1. `CLAUDE.md` (root) — Routing hub
2. `_SESSION_HANDOFF_CLAUDE.md` (root) — Previous session context
3. `_STATUS.md` (root) — Overall vault status
4. Target vault's `CLAUDE.md`
5. Target vault's `_STATUS.md`

Complete this sequence before editing.

---

## 3. Agent Identification

- **Identifier**: `claude`
- frontmatter `agent: claude` (for multi-agent work: `agent: [claude, codex]`)
- Record as `claude / YYYY-MM-DD` in `_STATUS.md` at session exit
- Handoff file: `_SESSION_HANDOFF_CLAUDE.md`

---

## 4. Claude Code Role Scope

| Area | Claude Code | Codex |
|------|-------------|-------|
| Multi-vault structural changes (vault creation, folder restructuring) | O | X |
| Script development/modification (`_tools/cli-node/`) | O | X |
| Rules/skills authoring (`.claude/rules/`, `.claude/commands/`) | O | X |
| `.obsidian/` configuration changes | O | X |
| Cross-vault work | O | X |
| Note editing within a single vault | O | O |
| Source note pipeline (video/article/PDF → note) | O | O |

---

## 5. Skills List (`.claude/commands/core/` — 17 skills)

| Skill | Purpose |
|-------|---------|
| `/auto-organize` | Auto-classify folders when creating notes/vaults |
| `/create-vault` | Create a new vault (clone from BasicContentsVault) |
| `/grok-route` | Grok branch router |
| `/juggl-note` | Create a standard note with Juggl embed |
| `/note-link` | Create semantic links between notes |
| `/status-update` | Update status |
| `/vault-health` | Vault health diagnosis |
| `/vault-route` | Vault routing and entry |
| `/vault-update` | Session exit routine |
| `/install-plugin` | Install Obsidian plugins |
| `/open-vault` | Open an Obsidian vault |
| `/open-note` | Open an Obsidian note |
| `/open-notes` | Open multiple notes in new tabs (local-rest-api) |
| `/reindex` | Rebuild vault content index |
| `/note-from-video` | Video → vault note conversion pipeline |
| `/note-from-article` | Web article/text → vault note conversion pipeline |
| `/note-from-pdf` | PDF → vault note conversion pipeline |

Skill details: See `.claude/commands/MANIFEST.md`.

---

## 6. Configuration Structure

```
.claude/
├── rules/
│   ├── core/           ← 14 mandatory rules (common to all agents, distribution sync target)
│   ├── custom/         ← Personal rules (not distributed)
│   └── MANIFEST.md     ← core/ file list
├── commands/
│   ├── core/           ← 17 skills (distribution sync target)
│   ├── custom/         ← Personal skills (not distributed)
│   └── MANIFEST.md     ← core/ file list
└── settings.local.json ← Claude Code local settings
```

### core vs custom Rules

- **core/**: Product rules applied to all users. Automatically propagated via `aimv sync`.
- **custom/**: User personal rules. Not subject to distribution sync. Freely add/modify.
- New rules are created in custom/ first → promoted to core/ after validation.

---

## 7. Mandatory Rules Summary (`.claude/rules/core/`)

| Rule | Key Point |
|------|-----------|
| `vault-routing.md` | Check vault registry before placing content |
| `edit-mode-separation.md` | Contents/workspace mode separation, workspace is AIHubVault only |
| `note-writing.md` | Frontmatter required, WikiLink required, URI reserved characters prohibited |
| `session-exit.md` | Both _STATUS.md and handoff must be updated |
| `post-edit-review.md` | Post-edit validation + indexing completion = task done |
| `encoding-safety.md` | UTF-8 fixed I/O, Get-Content pipeline prohibited |
| `token-optimization.md` | Pinpoint access, no repeated reads, high-cost operations require pre-approval |
| `script-creation-approval.md` | User approval required before script creation |
| `script-management.md` | Check Script_Registry for duplicates, no hardcoded paths |
| `temp-file-management.md` | Use $env:TEMP, no temporary files left in vaults |
| `distribution-sync.md` | Log changes when modifying distribution targets |
| `juggl-style-sync.md` | Update graph.css when Juggl styles change |
| `obsidian-config-safety.md` | .obsidian/ edits only in AIHubVault, use Read→Edit method |
| `vault-individualization.md` | Use `aimv clone` for vault creation, specify name/category/tags |

---

## 8. MCP Server Integration

Claude Code integrates with external tools via MCP (Model Context Protocol) servers.
Configuration: `~/.claude/settings.json` or project-specific `.claude/settings.local.json`.

### MCP Servers Connected in This Environment

| Server | Purpose | Details |
|--------|---------|---------|
| Serena | Semantic code analysis (C# symbol-based) | `.claude/rules/custom/serena-mcp.md` |
| mcp-unity | Unity editor manipulation | Not used (unity-cli takes priority) |
| Notion | Notion page read/write | `.claude/rules/custom/notion-sync.md` |
| Blender | Blender 3D manipulation | `.claude/rules/custom/blender-mcp.md` |
| Google Calendar | Calendar management | — |
| Gmail | Email | — |
| Claude in Chrome | Browser automation | — |

### Unity Tool Priority (Mandatory)

1. **unity-cli** — Top priority (`unity-cli console`, `unity-cli editor refresh --compile`)
2. **Serena MCP** — C# code symbol exploration/modification
3. **mcp-unity** — Only as fallback in projects without unity-cli

Details: `.claude/rules/custom/unity-tools.md`, `.claude/rules/custom/serena-mcp.md`
