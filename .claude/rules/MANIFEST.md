# Rules Manifest

> When syncing the distribution, only the files in this list are managed under `core/`.
> `custom/` is not a sync target.

## Classification

- **core/**: rules included in the distribution. Product-level features needed by all users. Always-injected.
- **custom/**: personal rules excluded from the distribution. Applies to both creator and user.
- **rules-archive/**: excluded from auto-injection (Phase 0 PoC validated 2026-04-18). Loaded via the Skill Router or a manual Read.
- **New rules go to custom/ first.** Promote to core/ only after validation.
- When promoting to core/, register here in MANIFEST and record it in the deploy change log.

## core/ — Distribution Rules (sync target, always injected)

> Phase 1 (2026-04-18): consolidated 7 rules into `_essentials.md` and moved the originals to `rules-archive/`. Introduced the Skill Router.

| File | Purpose |
|------|---------|
| `_essentials.md` | Required core — report language, token saving, vault routing, edit modes, Post-Edit Review, note-writing frontmatter / H1 / filename, session end (consolidated) |
| `_skill-router.md` | Work-keyword → rule-file mapping table |
| `distribution-content-safety.md` | Block citation of personal vault names / categories / assets in deployment-target documents (built on the 2026-04-25 incident) |
| `distribution-sync.md` | Distribution sync rule |
| `encoding-safety.md` | Encoding safety |
| `juggl-style-sync.md` | Juggl style sync |
| `obsidian-config-safety.md` | Safe editing of Obsidian config files |
| `script-creation-approval.md` | Script-creation pre-approval |
| `script-management.md` | Script management |
| `shell-redirect-safety.md` | Per-shell NUL redirect safety (Bash `2>/dev/null` · PowerShell `2>$null` · CMD `2>nul`) |
| `temp-file-management.md` | Temporary-file management |
| `user-guidance.md` | User guidance (D-plan slim: 6 high-risk sections inline; low-risk sections delegated to the Skill Router) |

## custom/ — User Rules (not a sync target)

Personal rules added freely by users.
The distribution sync does not touch this folder.

| File | Purpose |
|------|---------|
| `multivault-personalization.md` | Multi-vault personalization (custom agent / plug-in / skill choices) |
| `agent-ownership.md` | Agent-ownership separation (prevents Claude / Codex concurrent edits) |

> Phase 2-A (2026-04-18): relocated domain rules to `rules-archive/` and switched them to per-domain Skills. Concrete domains depend on user environment — this manifest registers only generic infrastructure rules.

## rules-archive/ — Excluded from Auto-Injection (Read manually on trigger)

> Phase 0 PoC validated (2026-04-18). Files under `.claude/rules-archive/` are excluded from session-start auto-injection.
> The Skill Router (`core/_skill-router.md`) instructs a manual Read on trigger.

### Originals after Phase 1 absorption (moved 2026-04-18)

The essentials are now consolidated into `_essentials.md`. These originals are kept for detailed clauses, background, and Incident Rules.

| File | Trigger Condition | Previous Location |
|------|-------------------|-------------------|
| `token-optimization.md` | Detailed token-saving criteria / fallback conditions | core/ |
| `session-exit.md` | Detailed session-exit procedure / handoff template | core/ |
| `note-writing.md` | Note type list / tag rule / H1 / filename examples | core/ |
| `vault-routing.md` | Detailed vault-routing rules | core/ |
| `post-edit-review.md` | Detailed Post-Edit Review commands | core/ |
| `edit-mode-separation.md` | Detailed edit-mode rules / AIHubVault-only workflow | core/ |
| `report-language.md` | Original report-language text | custom/ |

### Phase 0 PoC (moved 2026-04-18)

| File | Trigger Condition | Previous Location |
|------|-------------------|-------------------|
| `meshy-api.md` | Meshy API, 3D model generation, AI texturing | custom/ |

### Phase 2-B: user-guidance split (2026-04-18 D plan)

| File | Trigger Condition | Description |
|------|-------------------|-------------|
| `user-guidance-detail.md` | Low-risk sections (§1, §3, §6, §7, §9, §12) trigger or general user questions | Full original 12 sections. `core/user-guidance.md` keeps only 6 high-risk sections in slim form |

### Phase 2-A: Domain rules → Skills (2026-04-18)

Domain rules are bundled into Skills. Each Skill instructs reading its archive file when invoked. Per-domain trigger mapping lives in `.claude/rules/core/_skill-router.md` (active / inactive domains depend on user environment).

Generic deploy / operations infrastructure archive:

| File | Trigger Condition | Skill |
|------|-------------------|-------|
| `distribution-deploy.md` | deploy, SellingVault, git push | `/distribute` |
| `sync-version-priority.md` | cli.js sync, pre-sync, _WORKSPACE_VERSION | `/distribute` |

### Phase 3: relocation of reference docs (2026-04-18)

Less frequently used reference rules moved to archive and Read on Skill invocation.

| File | Trigger Condition | Skill |
|------|-------------------|-------|
| `vault-individualization.md` | Vault creation, create-vault, new vault | `/create-vault` |

### Phase 2-A `bulk-edit-safe` final decision (2026-04-18)

`encoding-safety.md` and `temp-file-management.md` **stay in core**. They are needed in everyday bulk edits / CLI use, and a Skill-trigger approach risks delayed self-correction (e.g., the §10 infinite-recursion incident). No `bulk-edit-safe` Skill is created.
