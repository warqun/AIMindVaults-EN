# /create-vault — Create a New Vault

Creates a new Obsidian vault by cloning BasicContentsVault as the source.

## Usage

```
/create-vault <category>/<vault-name>
```

Examples:
- `/create-vault Domains_Infra/Notion`
- `/create-vault Domains_Game/Unreal`
- `/create-vault Projects_GameTool/Project_RPG`

## Process

### 1. Verify Path

- Target path: `C:/AIMindVaults/Vaults/<category>/<vault-name>`
- If the category folder does not exist, creation is not possible — confirm with user
- If the vault name already exists, abort

### 2. Execute Clone Command (mandatory — manual copying prohibited)

```bash
node "{BasicContentsVault}/.sync/_tools/cli-node/bin/cli.js" clone -t "C:/AIMindVaults/Vaults/<category>/<vault-name>" -n "<vault-name>"
```

- Source: **BasicContentsVault** (general-purpose vault template, auto-detected)
- This CLI must be used. Manual copying via `Copy-Item`, `cp`, `xcopy`, etc. is prohibited.
- AIHubVault is not used as a source (it is a workspace hub with a heavy structure)
- Details: `.claude/rules/core/vault-individualization.md` section on vault creation methods

### 3. Required Post-Creation Tasks

1. Edit the new vault's `CLAUDE.md`:
   - Change the title to `# <vault-name> — <vault role description>`
   - Update the "Role of this vault" section to match the actual purpose
   - Update the directory structure to match the actual structure
   - Add vault-specific tags
2. Initialize the new vault's `_STATUS.md`:
   - Update "Role of this vault" to match the actual purpose (remove clone source description)
   - Clear Now/Next/Blocked
3. Register the new vault in the root `CLAUDE.md` vault registry
4. Add a new vault row to the root `_STATUS.md` vault registry (type, content description, working agent)
5. Record the change in `_ROOT_VERSION.md`

### 4. Obsidian Vault Registration Guide

Guide the user to register the vault manually:

> Obsidian Vault Manager -> "Open folder as vault" -> Select `{created vault path}`

**Opening an unregistered vault via `obsidian://open?path=` URI is prohibited.**
The URI method handles app state transition + registration + plugin loading simultaneously, resulting in very slow loading.
Use `obsidian://open?vault=` URI only for switching between already registered vaults.

### 5. Completion Report

Report the created vault path and completed follow-up tasks to the user.
