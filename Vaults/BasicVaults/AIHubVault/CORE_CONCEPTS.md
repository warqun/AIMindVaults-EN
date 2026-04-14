---
type: reference
tags:
  - AIMindVault
  - Meta
updated: 2026-03-15
---

# AIMindVaults Core Concepts

> Core concept guide for users new to the multi-vault system.

---

## 1. Hub & Spoke — Single Source of Truth

```
        ┌─────────────────┐
        │   AIHubVault     │
        │  (Single Source   │
        │   of Truth)      │
        └────────┬────────┘
                 │ workspace file distribution
        ┌────────┴────────┐
        │                  │
   ┌────▼─────┐     ┌─────▼────┐
   │ Contents  │     │  Other   │
   │  Vault    │     │  Vault   │
   │ (receive  │     │ (receive │
   │  only)    │     │  only)   │
   └──────────┘     └──────────┘
```

- **AIHubVault** is the sole source (Hub). Workspace files like `_Standards/Core/`, `_tools/`, `_WORKFLOW.md` are edited only here.
- Other vaults (Spoke) only receive these files. Modifying them directly will be overwritten on the next sync.
- Hub identification marker: `_forge/` directory (exists only in AIHubVault).

---

## 2. Hub-Sync — Automatic Synchronization

```
  Open vault in Obsidian
         │
         ▼
  Shell Commands plugin
  (on-layout-ready event)
         │
         ▼
  Run sync_workspace.ps1
         │
         ▼
  Compare _WORKSPACE_VERSION.md
         │
    ┌────┴────┐
    │ Same     │ Different
    │          │
    ▼          ▼
  SKIP      Batch sync
            (Hub → this vault)
```

- Every time a vault is opened, version is automatically compared with the Hub.
- If different, sync proceeds in 4 batches:
  1. Guides (`Juggl_StyleGuide/`)
  2. Rules & Standards (`_Standards/Core/`, `_WORKFLOW.md`, `_VAULT-INDEX.md`) — aborts remaining steps on failure
  3. Scripts (`_tools/`)
  4. Version Record (`_WORKSPACE_VERSION.md`)
- Sync target list: `_Standards/Core/Hub_Sync_Targets.md`
- **Only listed items are synced. Everything else is vault-specific.**

---

## 3. Edit Mode Separation

```
  ┌─────────────────────────────────────────┐
  │              Inside a Vault              │
  │                                          │
  │  ┌──────────────┐  ┌──────────────────┐ │
  │  │ [Contents]   │  │ [workspace]      │ │
  │  │              │  │                  │ │
  │  │ Contents/    │  │ _Standards/      │ │
  │  │  ├ Domain/   │  │ _tools/          │ │
  │  │  └ Project/  │  │ _WORKFLOW.md     │ │
  │  │              │  │ .claude/         │ │
  │  │ Knowledge &  │  │ Rules, tools,    │ │
  │  │ work items   │  │ settings         │ │
  │  └──────────────┘  └──────────────────┘ │
  │                                          │
  │     No mixing two modes in one task      │
  └─────────────────────────────────────────┘
```

- **Contents mode**: Modify `Contents/**` only. Knowledge accumulation, work management.
- **Workspace mode**: Modify `_Standards/`, `_tools/`, `.claude/`, etc. only. Rules and tools management.
- Do not mix both modes in a single task. Explicitly declare when switching.

---

## 4. Vault Routing

```
  Agent session starts
         │
         ▼
  Read root entry point
  (CLAUDE.md / CODEX.md)
         │
         ▼
  Identify target vault
  (explicit designation / keyword inference / user confirmation)
         │
         ▼
  Vault entry protocol
  ┌──────────────────┐
  │ 1. Vault CLAUDE.md│
  │ 2. Vault _STATUS.md│
  │ 3. Begin work      │
  └──────────────────┘
```

- AI agents **start from the multi-vault root (`AIMindVaults/`)**.
- The root routing hub (`CLAUDE.md`, `CODEX.md`) provides the vault registry.
- Determine the target vault from the user's request, read that vault's rule files, then begin work.

---

## 5. Sync Targets — Only Listed Items Are Synced

```
  AIHubVault (Hub)
  ┌────────────────────────────────────┐
  │                                    │
  │  Synced (propagated to Spokes)     │
  │  ├── Juggl_StyleGuide/             │
  │  ├── _Standards/Core/              │
  │  ├── _WORKFLOW.md                  │
  │  ├── _VAULT-INDEX.md               │
  │  ├── _tools/                       │
  │  └── _WORKSPACE_VERSION.md         │
  │                                    │
  │  Not Synced (Hub only)             │
  │  ├── Contents/        ← vault-specific │
  │  ├── _Standards/Contents/ ← vault-specific│
  │  ├── _forge/          ← Hub only   │
  │  ├── .claude/         ← vault-specific │
  │  ├── .antigravity/    ← vault-specific │
  │  └── ...                           │
  └────────────────────────────────────┘
```

- **Only** files/folders listed in `Hub_Sync_Targets.md` are synced.
- Everything not on the list is vault-specific — never synced.

---

## 6. Multi-Agent — Conflict Prevention via Status Sharing

```
  ┌──────────┐  ┌──────────┐  ┌──────────────┐
  │ Claude   │  │  Codex   │  │ Antigravity  │
  │  Code    │  │          │  │              │
  └────┬─────┘  └────┬─────┘  └──────┬───────┘
       │              │               │
       │   Each updates their own     │
       │   status file                │
       │              │               │
       ▼              ▼               ▼
  ┌─────────────────────────────────────────┐
  │        Status Files Inside Vault         │
  │                                          │
  │  _STATUS.md              ← unified status│
  │  .claude/AGENT_STATUS.md ← Claude only   │
  │  .codex/AGENT_STATUS.md  ← Codex only    │
  │  .antigravity/SESSION_RULES.md ← AG only │
  └─────────────────────────────────────────┘
```

- Multiple AI agents can work in the same vault.
- Each agent updates their own status file (`AGENT_STATUS.md`) at session end.
- `_STATUS.md` is the unified status. Check other agents' last work to prevent conflicts.
- At session start, read `_STATUS.md` first to understand the current situation before beginning work.
