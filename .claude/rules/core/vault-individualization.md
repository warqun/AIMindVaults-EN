# Vault Individualization (Mandatory)

> Applies when creating any vault. Rules for tailoring individual settings to the vault's purpose and topic.

## Vault Creation Method (Mandatory)

**All new vaults must be created by cloning BasicContentsVault using `node cli.js clone`.**

- Source: `Vaults/BasicVaults/BasicContentsVault/` (general-purpose vault template)
- Tool: `.sync/_tools/cli-node/bin/cli.js clone`
- Do not manually copy folders (`Copy-Item`, `cp`, `xcopy`, etc.).
- Do not use AIHubVault as a source (it is a workspace hub with a heavy structure).

```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" clone -t "<target_path>" -n "<vault_name>"
```

This script handles:
- Copying while excluding `.git`, caches, and sync folders (robocopy)
- Automatic removal of device-specific plugin settings (obsidian-git, claudian)
- Automatic update of make-md systemName

After cloning, perform the **required decisions** and **required tasks** below.

## Required Decisions When Creating a Vault

### 1. Vault Name

- Use a name that immediately conveys the vault's role.
- No URI reserved characters (`#`, `%`, `&`, `?`, `+`) or emojis.
- Examples: `Unity`, `AppFlowy`, `Project_VamSurLike`

### 2. Parent Folder Category

Place the vault under the appropriate parent folder based on its nature:

| Category | Path | Criteria |
|----------|------|----------|
| Domains_Game | `Vaults/Domains_Game/` | Game-related domain knowledge |
| Domains_Video | `Vaults/Domains_Video/` | Video/media domain knowledge |
| Domains_Infra | `Vaults/Domains_Infra/` | Infrastructure/tools domain knowledge |
| Projects_GameTool | `Vaults/Projects_GameTool/` | Game development tools/toolkit projects |
| Projects_Game | `Vaults/Projects_Game/` | Game development projects |
| Projects_Infra | `Vaults/Projects_Infra/` | Infrastructure project deliverables |
| Lab_Infra | `Vaults/Lab_Infra/` | Domain + project hybrid (plugin development, etc.) |
| Personal | `Vaults/Personal/` | Personal records |
| BasicVaults | `Vaults/BasicVaults/` | System vaults (Hub, distribution copy) |

If a new category is needed, confirm with the user before creating it.

### 3. CLAUDE.md Authoring

Write CLAUDE.md tailored to the vault's role:

- **This vault's role**: 1-2 clear lines
- **Collection scope**: Types and criteria for content that should go in this vault
- **What this vault does NOT collect**: Boundaries for similar content that should be routed to other vaults. Specify adjacent vaults that may cause confusion (e.g., "Shader styling goes here; color theory goes to LightAndColor")
- **Directory structure**: Folder structure under Contents/
- **Tag rules**: Designate the vault identification tag
- **Session entry rules**: Include mandatory pre-read of _STATUS.md

### 4. Content Structure

Set up the Contents/ subdirectory structure based on vault type:

- **Domain vaults**: Topic-based folders under `Contents/Domain/`
- **Project vaults**: `Contents/Project/plan/`, `Contents/Project/idea/`, etc.
- Structure can be freely set to match the vault's purpose, but must be registered in `_VAULT-INDEX.md`

### 5. Tag Rules

- Designate one vault identification tag (e.g., `Unity`, `AppFlowy`, `Project_VamSurLike`)
- This tag must be included in the frontmatter `tags` of every note

## Required Tasks After Vault Creation

1. Run workspace sync (propagate Core files from Hub)
2. Register in the root `_STATUS.md` vault registry
3. Add keywords to the vault entry protocol in the root `CLAUDE.md`
4. **Initial content index build** (Mandatory):
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault_path}"
```
   - If the CLI script is missing, workspace sync was not completed — re-check from step 1
   - After the build completes, verify that `vault_index.json` was created

## Items Excluded from Distribution Sync

Vault-individual files are not included in distribution sync:

- `CLAUDE.md` (content differs per vault)
- `CODEX.md` (varies by agent selection)
- `AGENT_STATUS.md` (varies by agent selection)
- `_STATUS.md` (status differs per vault)
- `_VAULT-INDEX.md` (structure differs per vault)
- `_Standards/CONTENTS_SPEC.md` (content scope differs per vault)
