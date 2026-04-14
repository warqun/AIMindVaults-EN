# /auto-organize — Auto-Classify on Note/Vault Creation

When creating a note or vault, if no suitable folder exists, propose and create one that matches the topic.

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

- Extract key keywords from the topic/title.
- For note: scan `Contents/Domain/` and `Contents/Project/` subfolders of the current vault.
- For vault: scan category folders under `C:/AIMindVaults/Vaults/`.

### 2. Match against existing folders

Query the existing folder list and decide whether a matching folder exists.

- **Match found**: create there directly → report the location to the user.
- **No match**: proceed to step 3.

### 3. Propose a new folder (no match)

Present the following to the user and ask for approval:

1. **Proposed folder path**: aligned with existing structure and naming patterns.
2. **Rationale**: why this location/name.
3. **Alternatives**: 1–2 closest existing folders.

```
Proposed: Contents/Domain/webhook/ (new)
Rationale: the existing integration/ folder covers external-tool integration broadly; webhooks can stand as their own topic.
Alternative: nest under integration/ (reuse existing folder)
```

### 4. Execute after approval

After approval:

**For notes:**
1. Create the folder.
2. Create the note in the same format as `/juggl-note`.
3. Register the new folder in `_VAULT-INDEX.md`.

**For vaults:**
1. Create the category folder (if missing).
2. Invoke `/create-vault` to create the vault.
3. Register in the root `CLAUDE.md` registry.

### 5. Completion report

Report the created folder path, note/vault path, and any follow-up actions taken.

## Folder Naming Rules

- Lowercase + underscore for note folders: `db_design`, `permissions`, `workflow`.
- Keep existing category patterns for vaults: `Domains_<area>`, `Projects_<area>`.
- Vault names in PascalCase: `Notion`, `Docker`, `Unity`.

## Judgment Criteria

### Note folder matching

1. Direct match between folder name and topic keyword.
2. Similarity between topic and existing note titles in the folder.
3. If match rate is low, propose a new folder.

### Vault category matching

| Topic | Category |
|-------|----------|
| Game engine / game domain knowledge | `Domains_Game` |
| Game dev tools / toolkits | `Projects_GameTool` |
| Video editing / media | `Domains_Video` |
| Infra / DevOps / tools | `Domains_Infra` |
| 3D modeling / rendering | `Domains_3D` |
| AI asset production | `Domains_AI_Asset` |
| Version control | `Domains_VCS` |
| None | Propose a new category to the user |

## Forbidden

- Do not create folders without user approval.
- Do not restructure existing folders (new folders only).
