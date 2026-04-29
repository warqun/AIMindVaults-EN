# /auto-organize — Auto-Classify Folders During Note / Vault Creation

Whenever a note or vault is created, if no appropriate folder exists, propose and create a topic-fitting folder.

## Usage

```
/auto-organize note <topic or title>
/auto-organize vault <topic or title>
```

Examples:
- `/auto-organize note Notion API webhook patterns`
- `/auto-organize vault Docker`

## Process

### 1. Analyze the target

- Extract core keywords from the topic / title.
- For `note`: scan subfolders under the current vault's `Contents/Domain/` and `Contents/Project/`.
- For `vault`: scan category folders under `Vaults/`.

### 2. Match against existing folders

Search the existing-folder list for a topic match.

- **Match found**: create directly in that folder → report the location.
- **No match**: continue to step 3.

### 3. Propose a new folder (no match)

Present and request approval for:

1. **Proposed folder path**: aligned with the existing structure and naming pattern.
2. **Rationale**: why this location / name.
3. **Alternatives**: 1–2 closest existing folder candidates.

```
Proposal: Contents/Domain/webhook/ (new)
Rationale: the existing integration/ folder covers external-tool integration broadly;
           webhooks can be split into their own topic.
Alternative: place under integration/ (use the existing folder)
```

### 4. Execute after approval

After user approval:

**Note**:
1. Create the folder.
2. Create the note in the same format as the `/juggl-note` skill.
3. Register the new folder in `_VAULT-INDEX.md`.

**Vault**:
1. Create the category folder (if missing).
2. Invoke `/create-vault` to create the vault.
3. Register in the root `CLAUDE.md` registry.

### 5. Completion report

Report the created folder path, the note / vault path, and any follow-ups performed.

## Folder Naming Rules

- Note folders: lowercase + underscores (`db_design`, `permissions`, `workflow`).
- Vault category names follow the existing pattern: `Domains_<area>`, `Projects_<area>`.
- Vault names use PascalCase: `Notion`, `Docker`, `Unity`.

## Decision Criteria

### Note-folder matching

1. Direct match between folder name and topic keywords.
2. Topic similarity to titles of existing notes inside the folder.
3. If matching is low, propose a new folder.

### Vault-category matching

| Topic | Category |
|-------|----------|
| Game engine, game-domain knowledge | `Domains_Game` |
| Game-development tools, toolkits | `Projects_GameTool` |
| Video editing, media | `Domains_Video` |
| Infra, DevOps, tooling | `Domains_Infra` |
| 3D modeling, rendering | `Domains_3D` |
| AI-asset production | `Domains_AI_Asset` |
| Version control | `Domains_VCS` |
| Not applicable | Propose a new category to the user |

## Forbidden

- Do not create folders without user approval.
- Do not change the existing folder structure (new folders only).
