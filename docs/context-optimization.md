# Context Window Optimization Guide

AIMindVaults optimizes the rule-injection structure to fit the session lifecycle, keeping the AI agent's context window light by default.

This document covers additional steps to trim your environment (MCP servers, plugins) for an even lighter baseline.

---

## Why It Matters

AI agents such as Claude Code auto-inject the following at session start:

- **Memory files**: `CLAUDE.md`, `.claude/rules/core/` — always-loaded rules
- **MCP tools**: every registered MCP server's tool schema (injected even when unused)
- **Custom agents / Skills**: agent and skill metadata from installed plugins

The larger these become, the **bigger your baseline** and the less room you have for actual conversation and work. Even a 1M window starts at ~830k free if the baseline is 170k.

The AIMindVaults default structure **keeps Memory files around ~23k**, but user-installed MCP servers and plugins can balloon the baseline.

---

## Built-In Rule Injection Structure

AIMindVaults ships a three-tier rule layout.

### Always Injected (`core/`, every session)

| File | Role |
|------|------|
| `_essentials.md` | Unified core (report language, token economy, vault routing, edit mode, note writing, session exit) |
| `_skill-router.md` | Trigger keyword → Skill invocation / rule file mapping |
| `distribution-sync.md` | Distribution sync rules |
| `encoding-safety.md` | Encoding safety (immediate self-correction halt) |
| `juggl-style-sync.md` | Juggl style rules |
| `obsidian-config-safety.md` | `.obsidian/` editing safety |
| `script-creation-approval.md` | Pre-approval for script creation |
| `script-management.md` | Script management |
| `temp-file-management.md` | Temp file management (includes MAX_PATH incident rule) |
| `user-guidance.md` | User guidance (slim — high-risk 6 sections only) |

### Conditional Load (`rules-archive/`, Read on trigger)

- `token-optimization.md`, `session-exit.md`, `note-writing.md`, `vault-routing.md`, `post-edit-review.md`, `edit-mode-separation.md` — summarized in `_essentials.md`, full detail on demand
- `vault-individualization.md` — on `/create-vault` Skill
- `user-guidance-detail.md` — on low-risk triggers (§1, §3, §6, §7, §9, §12)

### Personal Extensions (`custom/`)

- `.claude/rules/custom/` — personal rule files
- `.claude/commands/custom/` — personal Skills

This structure alone brings Memory files from ~45k down to ~23k.

---

## MCP Server Optimization

### Problem

MCP servers registered in global `~/.claude/settings.json` inject their tool schemas **in every project session**. They load even if unused.

Example: 7 MCP servers registered → ~67k tokens added to baseline.

### Principle

**Global for always-needed only. Move domain-specific servers to their project.**

| Category | Global | Per-project |
|----------|--------|-------------|
| Always needed | ✅ | |
| Domain-specific (Unity, Blender, etc.) | | ✅ project `.claude/settings.json` |
| Unused | remove | remove |

### How To Apply

**1. Remove domain-specific servers from global**

Edit `~/.claude/settings.json` → drop domain entries from `mcpServers`.

```json
{
  "mcpServers": {
    "notion": { "command": "npx", "args": ["-y", "@notionhq/notion-mcp-server"] }
  }
}
```

**2. Redefine servers per project**

Create `.claude/settings.json` at project root:

```json
{
  "mcpServers": {
    "blender": {
      "command": "uvx",
      "args": ["blender-mcp"]
    }
  }
}
```

These servers load only when Claude Code is started from that project as CWD.

### Example: AIMindVaults Default

- **Global**: `notion` only (always-on for note/record work)
- **AIMindVaults project**: `blender`, `youtube-transcript` — 3D / video note work
- **Unity game project**: `mcp-unity`, `serena` — Unity editor manipulation
- **Remove entirely**: unused servers (`playwright`, `context7`, etc.)

---

## Plugin Optimization

### Problem

Claude Code plugins inject **Custom agents + Skills**. A large plugin like `bkit` adds ~7k tokens once enabled.

### Principle

**Enable plugins only in projects where their flavor fits.**

### How To Apply

**1. Disable globally**

`~/.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "bkit@bkit-marketplace": false
  }
}
```

**2. Re-enable in specific projects**

project `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "bkit@bkit-marketplace": true
  }
}
```

### Example: bkit Plugin

`bkit` is for PDCA-based development workflows. Unnecessary for AIMindVaults root work (knowledge management), useful for game toolkit vaults or fullstack projects.

- **Global**: disabled
- **AIMindVaults root work (game toolkit vaults etc.)**: re-enabled in AIMindVaults `.claude/settings.json`
- **Standalone game engine project**: enabled in that project's `.claude/settings.json`

---

## Desktop / Claude.ai Connectors

These are not controlled by Claude Code settings. Manage them in the Claude Desktop app or Claude.ai account settings directly.

- Desktop-app MCPs (e.g., `Claude_Preview`, `ccd_directory`, `mcp-registry`, `scheduled-tasks`)
- Claude.ai Connectors (e.g., `calendar`, `gmail`, `microsoft_docs`)

**Recommendation**: Disable items you don't use via the Desktop app settings or Claude.ai Settings → Connectors.

---

## Measure

After changes, restart Claude Code and run `/context`:

```
Tokens: X / 1m (Y%)

Estimated usage by category:
  Memory files ........ ?k
  MCP tools (deferred) ?k
  Custom agents ....... ?k
```

### Targets

| Metric | Before | After |
|--------|--------|-------|
| Memory files | ~45k | ~23k (built-in) |
| MCP tools (deferred) | ~67k | ≤15k |
| Custom agents | ~6k | ~0k (outside AIMindVaults sessions) |
| Total baseline | ~170k | ~80k |

---

## Backup

Back up before changing settings:

```bash
cp ~/.claude/settings.json ~/.claude/settings.json.backup-$(date +%Y%m%d)
```

Restore:

```bash
cp ~/.claude/settings.json.backup-YYYYMMDD ~/.claude/settings.json
```

---

## References

- [architecture.md](architecture.md) — overall system structure
- [customization.md](customization.md) — user customization
- [cli-reference.md](cli-reference.md) — CLI command reference
