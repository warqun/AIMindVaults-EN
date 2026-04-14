# AIMindVaults — Claude Code Onboarding

> Onboarding for the Claude Code agent.
> Read `AGENT_ONBOARDING.md` first for the shared rules.

---

## 1. Entry Points

- **Root entry point**: `CLAUDE.md` — vault registry, routing keywords, entry protocol.
- **Vault entry point**: `{vault}/CLAUDE.md` — vault-specific rules, edit modes, session rules.

## 2. Session Start Order

1. `CLAUDE.md` (root) — routing hub.
2. `_SESSION_HANDOFF_CLAUDE.md` (root) — previous session context.
3. `_STATUS.md` (root) — overall vault state.
4. Target vault's `CLAUDE.md`.
5. Target vault's `_STATUS.md`.

Complete this sequence before editing anything.

---

## 3. Agent Identity

- **Identifier**: `claude`.
- frontmatter `agent: claude` (multi-agent work: `agent: [claude, codex]`).
- At session end, log `claude / YYYY-MM-DD` in `_STATUS.md`.
- Handoff file: `_SESSION_HANDOFF_CLAUDE.md`.

---

## 4. Claude Code Role Scope

| Area | Claude Code | Codex |
|------|-------------|-------|
| Multi-vault structural change (create vault, reshape folders) | Y | N |
| Script development / modification (`_tools/cli-node/`) | Y | N |
| Rules / skills authoring (`.claude/rules/`, `.claude/commands/`) | Y | N |
| `.obsidian/` config changes | Y | N |
| Cross-vault work | Y | N |
| Note editing within a single vault | Y | Y |
| Source-note pipeline (video/article/PDF → note) | Y | Y |

---

## 5. Skill List (`.claude/commands/core/` — 17)

| Skill | Purpose |
|-------|---------|
| `/auto-organize` | Auto-classify on note/vault creation |
| `/create-vault` | Create a new vault (clone from BasicContentsVault) |
| `/grok-route` | Pre-work routing via Grok |
| `/juggl-note` | Standard note with Juggl embed |
| `/note-link` | Semantic linking between notes |
| `/status-update` | Status refresh |
| `/vault-health` | Vault health check |
| `/vault-route` | Vault routing and entry |
| `/vault-update` | Session-exit routine |
| `/install-plugin` | Obsidian plugin install |
| `/open-vault` | Open Obsidian vault |
| `/open-note` | Open Obsidian note |
| `/open-notes` | Open multiple notes in new tabs (local-rest-api) |
| `/reindex` | Rebuild vault content index |
| `/note-from-video` | Video → vault note pipeline |
| `/note-from-article` | Web article/text → vault note pipeline |
| `/note-from-pdf` | PDF → vault note pipeline |

Skill details: see `.claude/commands/MANIFEST.md`.

---

## 6. Config Structure

```
.claude/
├── rules/
│   ├── core/           ← 15 mandatory rules (shared across agents, sync target)
│   ├── custom/         ← personal rules (not synced)
│   └── MANIFEST.md     ← list for core/
├── commands/
│   ├── core/           ← 17 skills (sync target)
│   ├── custom/         ← personal skills (not synced)
│   └── MANIFEST.md     ← list for core/
└── settings.local.json ← Claude Code local settings
```

### core vs custom rules

- **core/**: product rules that apply to every user. Propagated automatically via `aimv sync`.
- **custom/**: personal rules. Not a sync target. Add and modify freely.
- New rules start in custom/ — promote to core/ after validation.

---

## 7. Mandatory Rules — Summary (`.claude/rules/core/`)

| Rule | Core idea |
|------|-----------|
| `vault-routing.md` | Check the vault registry before placing content |
| `edit-mode-separation.md` | Separate Contents/workspace modes; workspace edits in AIHubVault only |
| `note-writing.md` | Frontmatter required, WikiLink required, no URI-reserved characters |
| `session-exit.md` | Update both _STATUS.md and the handoff file |
| `post-edit-review.md` | Validation + indexing complete = task done |
| `encoding-safety.md` | UTF-8 fixed I/O; no Get-Content pipeline |
| `token-optimization.md` | Pinpoint access, no re-reads, pre-approve expensive work |
| `script-creation-approval.md` | User approval required before creating a script |
| `script-management.md` | Check Script_Registry for duplicates, no hardcoded paths |
| `temp-file-management.md` | Use $env:TEMP; no temp files left inside a vault |
| `distribution-sync.md` | Log distribution-relevant changes in the changelog |
| `juggl-style-sync.md` | Update graph.css when Juggl style changes |
| `obsidian-config-safety.md` | `.obsidian/` edits in AIHubVault only, Read→Edit approach |
| `vault-individualization.md` | Use `aimv clone` to create vaults; concretize name/category/tag |
| `user-guidance.md` | Agent playbook for guiding users on core features |

---

## 8. MCP Server Integration

Claude Code connects to external tools via MCP (Model Context Protocol) servers.
Configure in `~/.claude/settings.json` or the per-project `.claude/settings.local.json`.

### MCP servers commonly used in this environment

| Server | Purpose | Details |
|--------|---------|---------|
| Serena | Semantic code analysis (C# symbol-based) | `.claude/rules/custom/serena-mcp.md` |
| mcp-unity | Unity editor control | Not used (unity-cli preferred) |
| Notion | Notion page read/write | `.claude/rules/custom/notion-sync.md` |
| Blender | Blender 3D control | `.claude/rules/custom/blender-mcp.md` |
| Google Calendar | Scheduling | — |
| Gmail | Email | — |
| Claude in Chrome | Browser automation | — |

These are examples from a maintainer's environment. Users configure their own servers under `custom/`.

### Unity Tool Priority (Mandatory)

1. **unity-cli** — highest priority (`unity-cli console`, `unity-cli editor refresh --compile`).
2. **Serena MCP** — C# symbol navigation/editing.
3. **mcp-unity** — fallback only when unity-cli is unavailable.

Details: `.claude/rules/custom/unity-tools.md`, `.claude/rules/custom/serena-mcp.md`.
