---
description: "Install an Obsidian plug-in (AIHubVault as the source)"
---

# /install-plugin — Install an Obsidian Plug-In

## Usage

```
/install-plugin <plug-in name or GitHub URL>
```

## Procedure

### 1. Identify the target

- Install target vault: **AIHubVault only** (workspace-edit rule).
- Plug-in path: `AIHubVault/.obsidian/plugins/<plugin-id>/`.

### 2. Download the plug-in

```powershell
$pluginDir = '<AIHubVault path>/.obsidian/plugins/<plugin-id>'
New-Item -ItemType Directory -Path $pluginDir -Force
```

- Download the latest release's `main.js`, `manifest.json`, `styles.css` from the GitHub Releases API.
- Some plug-ins do not ship `styles.css` (that is normal).

### 3. Register in `community-plugins.json`

**Forbidden**: do not use the PowerShell `ConvertFrom-Json` → `ConvertTo-Json` pipeline (array-corruption risk).

**Correct method**: read the file with the `Read` tool and append the plug-in id to the array via the `Edit` tool.

```
Before:
  "templater-obsidian",
  "ytranscript"
]

After:
  "templater-obsidian",
  "ytranscript",
  "<new-plugin-id>"
]
```

### 4. Propagate to other vaults

- Run `aimv sync` to propagate the plug-in to the target vaults (Batch 0 merge style).
- Confirm with the user before kicking off the propagation.

### 5. Verify activation

- Tell the user to open / restart the target vault in Obsidian.
- **Do not proceed to follow-up tasks (such as opening a note) until the user has confirmed activation.**
- Activation: Obsidian Settings → Community plug-ins → toggle the plug-in ON.

### 6. Version record

- Record the version in the AIHubVault `_WORKSPACE_VERSION.md` (workspace-edit rule).

## Pre-Conditions for Opening a Note

Before the AI opens a note via `obsidian://advanced-uri`, always check:

1. **Is the Advanced URI plug-in installed in the target vault?** — verify `.obsidian/plugins/obsidian-advanced-uri/` exists.
2. **Is it registered in `community-plugins.json`?** — verify `obsidian-advanced-uri` is included.
3. If either is missing → install via this skill (`/install-plugin`) first.
4. After install → only attempt to open the note after step 5 (activation verified).

## Cautions

- For `.obsidian/` JSON files, do not use the PowerShell JSON pipeline — direct text edits only.
- Same applies to plug-in removal: remove the line from `community-plugins.json` and delete the folder.
- Beta plug-ins (via BRAT) are out of scope for this skill.
