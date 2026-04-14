# Rules Manifest

> For distribution sync, only the files listed here are managed under `core/`.
> `custom/` is not a sync target.

## Classification

- **core/**: rules included in the distribution. Product features every user needs.
- **custom/**: personal rules excluded from distribution. For both the maintainer and each user.
- **New rules start in custom/**. After validation, promote to core/ if needed.
- When promoting to core/, register here + log in the distribution changelog.

## core/ — Distribution Rules (sync targets)

| File | Purpose |
|------|---------|
| distribution-sync.md | Distribution sync rules |
| edit-mode-separation.md | Edit-mode separation |
| encoding-safety.md | Encoding safety |
| juggl-style-sync.md | Juggl style sync |
| note-writing.md | Note writing pattern |
| post-edit-review.md | Post-edit review |
| script-creation-approval.md | Script creation pre-approval |
| script-management.md | Script management |
| session-exit.md | Session-exit state update |
| temp-file-management.md | Temp file management |
| token-optimization.md | Token optimization |
| vault-routing.md | Vault routing |
| obsidian-config-safety.md | Safe editing of Obsidian config files |
| vault-individualization.md | Vault individualization (name/category/role at creation) |
| user-guidance.md | User guidance (agent playbook for core-feature usage) |

## custom/ — User Rules (not synced)

Personal rules users add freely.
Distribution sync does not touch this folder.

| File | Purpose |
|------|---------|
| multivault-personalization.md | Multi-vault personalization (agent/plugin/skill customization) |
