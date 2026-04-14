# Commands Manifest

> For distribution sync, only the files listed here are managed under `core/`.
> `custom/` is not a sync target.

## Classification

- **core/**: skills included in the distribution. Product features every user needs.
- **custom/**: personal skills excluded from distribution. For both the maintainer and each user.
- **New skills start in custom/**. After validation, promote to core/ if needed.
- When promoting to core/, register here + log in the distribution changelog.

## core/ — Distribution Skills (sync targets)

| File | Purpose |
|------|---------|
| auto-organize.md | Auto-classify on note/vault creation |
| create-vault.md | Create a new vault |
| grok-route.md | Pre-work routing via Grok |
| juggl-note.md | Standard note with Juggl embed |
| note-link.md | Semantic linking between notes |
| status-update.md | Status refresh |
| vault-health.md | Vault health check |
| vault-route.md | Vault routing and entry |
| vault-update.md | Session-exit routine |
| install-plugin.md | Obsidian plugin install |
| open-vault.md | Open Obsidian vault |
| open-note.md | Open Obsidian note |
| reindex.md | Rebuild vault content index |
| open-notes.md | Open multiple Obsidian notes in new tabs (local-rest-api) |
| note-from-video.md | Video → vault note pipeline |
| note-from-article.md | Web article/text → vault note pipeline |
| note-from-pdf.md | PDF → vault note pipeline |
| hub-broadcast.md | Immediate Hub-file broadcast to every vault |
| sync-all.md | Bulk workspace sync across all satellite vaults |

## custom/ — User Skills (not synced)

Personal skills users add freely.
Distribution sync does not touch this folder.
