# /create-vault — Create a New Vault

Create a new Obsidian vault by cloning BasicContentsVault as the source.

## Usage

```
/create-vault <category>/<vault-name>
```

Examples:
- `/create-vault Domains_<area>/<YourDomainVault>`
- `/create-vault Projects_<area>/<YourProject>`
- `/create-vault Personal/<YourPersonalVault>`

## Process

### 1. Path check

- Target path: `C:/AIMindVaults/Vaults/<category>/<vault-name>`
- If the category folder does not exist, stop — confirm with the user.
- Abort if a vault with that name already exists.

### 2. Run the clone command (required — no manual copy)

```bash
node "{BasicContentsVault}/.sync/_tools/cli-node/bin/cli.js" clone -t "C:/AIMindVaults/Vaults/<category>/<vault-name>" -n "<vault-name>"
```

- Source: **BasicContentsVault** (general-purpose template, auto-detected).
- Must use this CLI. Manual copy (`Copy-Item`, `cp`, `xcopy`, etc.) is forbidden.
- AIHubVault is not used as the source (too heavy as the workspace hub).
- Details: `.claude/rules/core/vault-individualization.md` § Vault creation method.

### 3. Required post-creation steps

1. Edit the new vault's `CLAUDE.md`:
   - Rename the title to `# <vault-name> — <role description>`.
   - Rewrite "Role of this vault" for the actual purpose.
   - Update the directory structure to match reality.
   - Add a vault-specific tag to `tags`.
2. Initialize `_STATUS.md`:
   - Rewrite "Role of this vault" (remove clone-source text).
   - Empty Now / Next / Blocked.
3. Register the new vault in the root `CLAUDE.md` registry.
4. Add a row to the root `_STATUS.md` registry (type, content summary, working agent).
5. Log the change in `_ROOT_VERSION.md`.

### 4. Guide the user to register the vault in Obsidian

Ask the user to register it themselves:

> Obsidian Vault Manager → "Open folder as vault" → select `{new vault path}`.

**Do not use the `obsidian://open?path=` URI on an unregistered vault.**
That URI triggers app-state switching + registration + plugin loading simultaneously and is very slow.
Use `obsidian://open?vault=` only for switching between already-registered vaults.

### 5. Completion report

Report the created vault path and the follow-up actions taken.
