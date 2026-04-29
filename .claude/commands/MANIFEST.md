# Commands Manifest

> When syncing the distribution, only the files in this list are managed under `core/`.
> `custom/` is not a sync target.

## Classification

- **core/**: skills included in the distribution. Product-level features needed by all users.
- **custom/**: personal skills excluded from the distribution. Applies to both creator and user.
- **New skills go to custom/ first**. Promote to core/ only after validation.
- When promoting to core/, register here in MANIFEST and record it in the deploy change log.

## core/ — Distribution Skills (sync target)

| File | Purpose |
|------|---------|
| auto-organize.md | Auto-classify folders during note / vault creation |
| create-vault.md | Create a new vault (satellite) |
| create-preset-hub.md | Create a new Preset Hub (Multi-Hub architecture) |
| grok-route.md | Grok branching router |
| juggl-note.md | Create a standard note with Juggl embed |
| note-link.md | Semantic linking between notes |
| status-update.md | Status update |
| vault-health.md | Vault health diagnosis |
| vault-route.md | Vault routing and entry |
| vault-update.md | Session-end routine |
| install-plugin.md | Install an Obsidian plug-in |
| open-vault.md | Open an Obsidian vault |
| open-note.md | Open an Obsidian note |
| reindex.md | Rebuild vault content index |
| open-notes.md | Open multiple Obsidian notes in new tabs (local-rest-api) |
| note-from-video.md | Video → vault-note conversion pipeline |
| note-from-article.md | Web article / text → vault-note conversion pipeline |
| note-from-pdf.md | PDF → vault-note conversion pipeline |
| hub-broadcast.md | Immediate Hub-file propagation across all vaults |
| sync-all.md | Bulk sync workspace across all satellite vaults |

## custom/ — User Skills (not a sync target)

Personal skills added freely by users.
The distribution sync does not touch this folder.

| File | Purpose |
|------|---------|
| (creator-only personal skills are not listed here) | |
