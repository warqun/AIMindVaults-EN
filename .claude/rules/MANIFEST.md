# Rules Manifest

> For distribution sync, only the files listed here are managed under `core/`.
> `custom/` and `rules-archive/` are not sync targets / not auto-injected.

## Classification

- **core/**: distribution rules. Product features every user needs. Always injected.
- **custom/**: personal rules excluded from distribution. For both maintainer and user.
- **rules-archive/**: excluded from auto-injection. Loaded on demand via Skill Router or manual Read.
- **New rules start in custom/**. After validation, promote to core/ if needed.
- When promoting to core/, register here + log in the distribution changelog.

## core/ — Distribution Rules (always injected)

> 2026-04-18: 7 legacy rules consolidated into `_essentials.md` and moved to `rules-archive/`. Added Skill Router.

| File | Purpose |
|------|---------|
| `_essentials.md` | Core essentials — report language, token economy, vault routing, edit mode, Post-Edit Review, note writing (frontmatter/H1/filename), session exit |
| `_skill-router.md` | Trigger keyword → Skill invocation / rule path mapping |
| distribution-sync.md | Distribution sync rules |
| encoding-safety.md | Encoding safety |
| juggl-style-sync.md | Juggl style sync |
| obsidian-config-safety.md | Safe editing of Obsidian config files |
| script-creation-approval.md | Script creation pre-approval |
| script-management.md | Script management |
| temp-file-management.md | Temp file management |
| user-guidance.md | User guidance (slim — high-risk inline triggers only; full detail in rules-archive) |

## custom/ — User Rules (not synced)

Personal rules users add freely.
Distribution sync does not touch this folder.

| File | Purpose |
|------|---------|
| multivault-personalization.md | Multi-vault personalization (agent/plugin/skill customization) |

## rules-archive/ — Excluded From Auto-Injection (loaded on trigger)

> Separated from `core/` to reduce always-loaded memory footprint.
> Skill Router (`core/_skill-router.md`) instructs agents to Read these on matching triggers.

### Absorbed into _essentials.md (detail preserved)

| File | Trigger |
|------|---------|
| token-optimization.md | Token economy details / fallback conditions |
| session-exit.md | Session exit details / handoff templates |
| note-writing.md | Full note writing (type list, tag rules, H1/filename examples) |
| vault-routing.md | Vault routing details |
| post-edit-review.md | Post-Edit Review command details |
| edit-mode-separation.md | Edit mode details / AIHubVault-only workflow |

### Split from user-guidance.md

| File | Trigger |
|------|---------|
| user-guidance-detail.md | Low-risk sections (§1, §3, §6, §7, §9, §12) + full context for all 12 sections |

### Moved from core (Phase 3)

| File | Trigger |
|------|---------|
| vault-individualization.md | New vault creation — loaded via `/create-vault` Skill |
