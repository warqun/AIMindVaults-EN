# Rules Manifest

> Only the files in this list are managed under `core/` during distribution sync.
> `custom/` is not a sync target.

## Classification Criteria

- **core/**: Rules included in the distribution. Product features needed by all users.
- **custom/**: Personal rules not included in distribution. Applies to both creators and users.
- **New rules should be created in custom/ first.** Promote to core/ after validation if needed.
- When promoting to core/, register in this MANIFEST and log in the distribution changelog.

## core/ — Distribution Rules (Sync Target)

| Filename | Purpose |
|----------|---------|
| distribution-sync.md | Distribution sync rules |
| edit-mode-separation.md | Edit Mode Separation |
| encoding-safety.md | Encoding safety |
| juggl-style-sync.md | Juggl style sync |
| note-writing.md | Note writing patterns |
| post-edit-review.md | Post-Edit Review |
| script-creation-approval.md | Script creation approval |
| script-management.md | Script management |
| session-exit.md | Session exit status update |
| temp-file-management.md | Temporary file management |
| token-optimization.md | Token optimization |
| vault-routing.md | Vault routing |
| obsidian-config-safety.md | Obsidian config file safe editing |
| vault-individualization.md | Vault individualization (name/category/role specification at creation) |
| user-guidance.md | User guidance (agent guidance rulebook for core feature usage) |

## custom/ — User Rules (Not a Sync Target)

Personal rules that users freely add.
Distribution sync does not touch this folder.

| Filename | Purpose |
|----------|---------|
| multivault-personalization.md | Multi-vault personalization (agent/plugin/skill customization) |
