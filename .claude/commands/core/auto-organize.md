# /auto-organize — Auto-classify folders when creating notes/vaults

Suggests and creates appropriate folders based on the topic when creating a note or vault.

## Usage

```
/auto-organize note <topic or title>
/auto-organize vault <topic or title>
```

Examples:
- `/auto-organize note Notion API webhook usage patterns`
- `/auto-organize vault Docker`

## Process

### 1. Analyze Target

- Extract key keywords from the provided topic/title
- For notes: scan subfolders under the current vault's `Contents/Domain/`, `Contents/Project/`
- For vaults: scan category folders under `C:/AIMindVaults/Vaults/`

### 2. Match Existing Folders

Query the existing folder list to determine if a folder matches the topic.

- **Match found**: Create directly in that folder and report the location to the user
- **No match**: Proceed to step 3

### 3. Suggest New Folder (on match failure)

Present the following information to the user and request approval:

1. **Suggested folder path**: Proposed based on existing structure and naming patterns
2. **Rationale**: Explain why this location/name was chosen
3. **Alternatives**: Present 1-2 closest existing folder candidates

```
Suggestion: Contents/Domain/webhook/ (new creation)
Rationale: The existing integration/ folder covers external tool integration broadly; webhooks can be separated as a distinct topic
Alternative: Place under integration/ (reuse existing folder)
```

### 4. Execute After Approval

After receiving user approval:

**For notes:**
1. Create the folder
2. Create the note in the same format as the `/juggl-note` skill
3. Register the new folder in `_VAULT-INDEX.md`

**For vaults:**
1. Create the category folder (if it doesn't exist)
2. Invoke the `/create-vault` skill to create the vault
3. Register in the root `CLAUDE.md` registry

### 5. Completion Report

Report the created folder path, note/vault path, and any follow-up tasks performed.

## Folder Naming Rules

- Lowercase English + underscores (for note folders): `db_design`, `permissions`, `workflow`
- Vault categories follow existing patterns: `Domains_<area>`, `Projects_<area>`
- Vault names use PascalCase: `Notion`, `Docker`, `Unity`

## Decision Criteria

### Note Folder Matching

1. Direct match between folder name and topic keywords
2. Similarity between existing note titles in the folder and the topic
3. If match rate is low, suggest a new folder

### Vault Category Matching

| Topic | Category |
|-------|----------|
| Game engines, game domain knowledge | `Domains_Game` |
| Game development tools, toolkits | `Projects_GameTool` |
| Video editing, media | `Domains_Video` |
| Infrastructure, DevOps, tools | `Domains_Infra` |
| 3D modeling, rendering | `Domains_3D` |
| AI asset creation | `Domains_AI_Asset` |
| Version control | `Domains_VCS` |
| None of the above | Suggest a new category to the user

## Restrictions

- Do not create folders without user approval.
- Do not modify existing folder structures (only adding new folders is allowed).
