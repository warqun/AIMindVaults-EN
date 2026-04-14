---
type: reference
tags:
  - AIHubVault
  - Meta
updated: 2026-04-15
---

# AIMindVaults Core Concepts

> Orientation guide for new users of the multi-vault system.

---

## 1. Hub & Spoke — single-source structure

```
        ┌─────────────────┐
        │   AIHubVault     │
        │  (Single Source   │
        │   of Truth)      │
        └────────┬────────┘
                 │ workspace files propagated
        ┌────────┴────────┐
        │                 │
   ┌────▼─────┐     ┌─────▼────┐
   │ Contents │     │  Other   │
   │  Vault   │     │  Vault   │
   │ (receive)│     │ (receive)│
   └──────────┘     └──────────┘
```

- **AIHubVault** is the sole source (Hub). `_Standards/Core/`, `.sync/_tools/`, `_WORKFLOW.md`, and similar workspace files are edited only here.
- Other vaults (Spokes) only receive these files. Direct edits get overwritten on the next sync.
- Hub marker: `.sync/.hub_marker` (exists only in AIHubVault).

---

## 2. Hub-Sync — automatic sync

```
  Open vault in Obsidian
         │
         ▼
  Shell Commands plugin
  (on-layout-ready event)
         │
         ▼
  `aimv pre-sync` runs
         │
         ▼
  Compare _WORKSPACE_VERSION.md
         │
    ┌────┴────┐
    │  same   │ different
    │         │
    ▼         ▼
  SKIP     Mirror workspace files
           (Hub → this vault)
```

- Each vault open auto-compares its version against the Hub.
- If different, workspace files mirror from Hub.
- Sync targets: `_Standards/Core/Hub_Sync_Targets.md`.
- **Only listed targets sync. Everything else is vault-specific.**

---

## 3. Edit-mode separation

```
  ┌─────────────────────────────────────────┐
  │              inside a vault              │
  │                                          │
  │  ┌──────────────┐  ┌──────────────────┐ │
  │  │ [Contents]   │  │ [workspace]      │ │
  │  │              │  │                  │ │
  │  │ Contents/    │  │ _Standards/      │ │
  │  │  ├ Domain/   │  │ .sync/_tools/    │ │
  │  │  └ Project/  │  │ _WORKFLOW.md     │ │
  │  │              │  │ .claude/         │ │
  │  │ notes & work │  │ rules / tools    │ │
  │  └──────────────┘  └──────────────────┘ │
  │                                          │
  │    Never mix both modes in one task      │
  └─────────────────────────────────────────┘
```

- **Contents mode**: edits `Contents/**` only. Knowledge + project notes.
- **Workspace mode**: edits `_Standards/`, `.sync/_tools/`, `.claude/`, etc. only. Rules / tools.
- Declare the mode explicitly when switching.

---

## 4. Vault routing

```
  Agent session starts
         │
         ▼
  Read the root entry point
  (CLAUDE.md / AGENTS.md)
         │
         ▼
  Identify the target vault
  (explicit / keyword inference / ask user)
         │
         ▼
  Vault entry protocol
  ┌──────────────────┐
  │ 1. vault CLAUDE.md│
  │ 2. vault _STATUS  │
  │ 3. start work     │
  └──────────────────┘
```

- The AI agent always starts at the multi-vault root (`AIMindVaults/`).
- The root routing hub (`CLAUDE.md`, `AGENTS.md`) provides the vault registry.
- The agent picks a target vault from the user's request, reads that vault's rules, then starts work.

---

## 5. Sync Targets — only listed items sync

```
  AIHubVault (Hub)
  ┌────────────────────────────────────┐
  │                                    │
  │  synced (propagated to Spokes)     │
  │  ├── Juggl_StyleGuide/             │
  │  ├── _Standards/Core/              │
  │  ├── _WORKFLOW.md                  │
  │  ├── _VAULT-INDEX.md               │
  │  ├── .sync/_tools/                 │
  │  └── _WORKSPACE_VERSION.md         │
  │                                    │
  │  NOT synced (Hub-only or per-vault)│
  │  ├── Contents/          ← per-vault│
  │  ├── _Standards/Contents/          │
  │  ├── .sync/.hub_marker  ← Hub-only │
  │  ├── .claude/           ← per-vault│
  │  └── ...                           │
  └────────────────────────────────────┘
```

- Only items listed in `Hub_Sync_Targets.md` sync.
- Everything else is vault-specific and is not touched by sync.

---

## 6. Multi-agent — shared state prevents collisions

```
  ┌──────────┐  ┌──────────┐  ┌──────────────┐
  │ Claude   │  │  Codex   │  │    Cursor    │
  │  Code    │  │          │  │              │
  └────┬─────┘  └────┬─────┘  └──────┬───────┘
       │              │               │
       │     each updates its own     │
       │        state files           │
       ▼              ▼               ▼
  ┌─────────────────────────────────────────┐
  │          state files inside the vault    │
  │                                          │
  │  _STATUS.md          ← unified status    │
  │  .claude/AGENT_STATUS.md  ← Claude only  │
  │  .codex/AGENT_STATUS.md   ← Codex only   │
  │  .cursor/...                              │
  └─────────────────────────────────────────┘
```

- Multiple AI agents can share a vault.
- Each agent updates its own `AGENT_STATUS.md` at session end.
- `_STATUS.md` is the unified view. Each agent reads it at session start to see the other agents' last work and avoid collisions.
