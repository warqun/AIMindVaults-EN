# /create-vault — Create a New Vault (Multi-Hub Architecture)

Create a new Obsidian vault. Clones BasicContentsVault as the source and binds it to a Hub of the user's choice.

## Usage

```
/create-vault <category>/<vault-name>
```

Examples:
- `/create-vault Domains_Infra/Notion`
- `/create-vault Domains_Game/<engine>`
- `/create-vault Projects_<area>/<project-name>`

## Process

### 1. Confirm the path

- Target path: `<AIMindVaults root>/Vaults/<category>/<vault-name>`
- If the category folder does not exist — confirm with the user before creating.
- If a vault with that name already exists — abort.

### 2. Hub selection (Multi-Hub · since 2026-04-20)

Confirm with the user which Hub the satellite vault binds to.

| Choice | Description | When |
|--------|-------------|------|
| **(default) AIHubVault — Default Preset Hub** | `hubId="default"`, `hubType="preset"`. The default bundle (Core + Custom A) most existing satellites already bind to. | Regular work · same as the existing environment |
| **CoreHub — Core Hub** | `hubId="core"`, `hubType="core"`. Core bundle only (no Custom plug-ins). | Minimal-environment preference; user manages Custom themselves |
| **Other Preset Hub** | A user-created Preset Hub | When the user maintains their own Preset |

**If ambiguous, default to (AIHubVault, Default Preset).** Use the explicit value when the user specifies it (`--hub` option, "bind to Core Hub", "bind to AIHubVault_xxx").

### 3. Run `clone` (mandatory — no manual copies)

```bash
node "{BasicContentsVault}/.sync/_tools/cli-node/bin/cli.js" clone \
  -t "<AIMindVaults root>/Vaults/<category>/<vault-name>" \
  -n "<vault-name>" \
  --hub "<absolute Hub path>"
```

- Source: **BasicContentsVault** (the universal vault template, auto-detected).
- The `--hub` option writes the binding Hub path to `.sync/hub-source.json` automatically.
- Without `--hub`: legacy scan fallback (the first Hub under `Vaults/` = AIHubVault).
- Always use this CLI. Do not use `Copy-Item`, `cp`, `xcopy`, etc. for manual copies.
- AIHubVault is not used as the source (Preset Hubs are Custom-bundled and heavy). BasicContentsVault is the minimum template.
- **For detailed rules (required decision items · follow-ups · parent-folder classification · deployment exclusions)** see: Read `.claude/rules-archive/vault-individualization.md`.

### Examples

Bind to AIHubVault (Default Preset):
```bash
node "{BasicContentsVault}/.sync/_tools/cli-node/bin/cli.js" clone \
  -t "<AIMindVaults root>/Vaults/Domains_Infra/Notion" \
  -n "Notion" \
  --hub "<AIMindVaults root>/Vaults/BasicVaults/AIHubVault"
```

Bind to CoreHub (Core Hub · minimal environment):
```bash
node "{BasicContentsVault}/.sync/_tools/cli-node/bin/cli.js" clone \
  -t "<AIMindVaults root>/Vaults/Domains_Dev/Rust" \
  -n "Rust" \
  --hub "<AIMindVaults root>/Vaults/BasicVaults/CoreHub"
```

### 4. Required follow-ups

1. Edit the new vault's `CLAUDE.md`:
   - Change the title to `# <vault-name> — <vault role description>`.
   - Update the "Role of this vault" section to the actual purpose.
   - Update the directory structure to match reality.
   - Add vault-specific tags to `tags`.
2. Initialize the new vault's `_STATUS.md`:
   - Update "Role of this vault" to the actual purpose (remove the source-template description).
   - Empty out Now / Next / Blocked.
3. Register the new vault in the root `CLAUDE.md` vault registry.
4. Add a row to the root `_STATUS.md` vault registry (type, content description, working agent).
5. Record the change in `_ROOT_VERSION.md`.

### 5. Tell the user how to register the vault in Obsidian

Tell the user to register it manually:

> Obsidian vault manager → "Open vault folder" → choose `{the created vault path}`

**Do not open an unregistered vault via `obsidian://open?path=`.**
That URI handles app-state transition + registration + plug-in load all at once and is very slow.
Use `obsidian://open?vault=` only for switching to vaults that are already registered.

### 6. Completion report

Report the created vault path and any follow-ups performed.
