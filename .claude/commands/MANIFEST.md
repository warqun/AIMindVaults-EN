# Commands Manifest

> Only files listed here are managed in `core/` during distribution sync.
> `custom/` is not a sync target.

## Classification Criteria

- **core/**: Skills included in the distribution. Product features needed by all users.
- **custom/**: Personal skills not included in the distribution. Applies to both creators and users.
- **New skills should be created in custom/ first**. Promote to core/ after validation.
- When promoting to core/, register in this MANIFEST + record in the distribution change log.

## core/ — Distribution Skills (sync target)

| Filename | Purpose |
|----------|---------|
| auto-organize.md | Auto-classify folders when creating notes/vaults |
| create-vault.md | Create a new vault |
| grok-route.md | Grok branch router |
| juggl-note.md | Create standard note with Juggl embed |
| note-link.md | Create semantic links between notes |
| status-update.md | Update status |
| vault-health.md | Vault health diagnosis |
| vault-route.md | Vault routing and entry |
| vault-update.md | Session exit routine |
| install-plugin.md | Install Obsidian plugin |
| open-vault.md | Open Obsidian vault |
| open-note.md | Open Obsidian note |
| reindex.md | Rebuild vault contents index |
| open-notes.md | Open multiple Obsidian notes in new tabs (local-rest-api) |
| note-from-video.md | Video to vault note conversion pipeline |
| note-from-article.md | Web article/text to vault note conversion pipeline |
| note-from-pdf.md | PDF to vault note conversion pipeline |

## custom/ — User Skills (not synced)

Personal skills freely added by the user.
Distribution sync does not touch this folder.
