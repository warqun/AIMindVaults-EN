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
│   ├── core/           ← Mandatory rules (shared across agents, always injected, sync target)
│   ├── custom/         ← Personal rules (always injected, not synced)
│   └── MANIFEST.md     ← list for core/
├── rules-archive/      ← Not auto-injected; read on demand via Skill Router triggers
├── commands/
│   ├── core/           ← Skills (sync target)
│   ├── custom/         ← Personal skills (not synced)
│   └── MANIFEST.md     ← list for core/
└── settings.local.json ← Claude Code local settings
```

### core vs custom rules

- **core/**: product rules that apply to every user. Propagated automatically via `aimv sync`.
- **custom/**: personal rules. Not a sync target. Add and modify freely.
- New rules start in custom/ — promote to core/ after validation.

### Skill Router dynamic loading (Claude Code behavior)

How Claude Code executes the "Dynamic rule loading" described in the shared onboarding §15:

- On every turn, match the user message against the trigger keywords in `_skill-router.md`.
- On a match, invoke the mapped Skill (e.g. `/distribute`, `/create-vault`) via the `Skill` tool. If the Skill's body instructs further archive reads, load them with the `Read` tool.
- Rows that map directly to a file are loaded with `Read` — no `Skill` call needed.
- Skills/rules already loaded in the current session must not be reloaded.

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

Users configure their own MCP servers. Document the server's usage policy under `.claude/rules/custom/<server-name>.md` so agents can look up what to prefer, what to avoid, and when the server takes priority over generic file tools.
