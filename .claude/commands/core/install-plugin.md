---
description: "Install Obsidian plugin (AIHubVault-based)"
---

# /install-plugin — Install Obsidian Plugin

## Usage

```
/install-plugin <plugin-name or GitHub URL>
```

## Procedure

### 1. Identify Target

- Installation target vault: **AIHubVault only** (workspace editing rule)
- Plugin path: `AIHubVault/.obsidian/plugins/<plugin-ID>/`

### 2. Download Plugin

```powershell
$pluginDir = 'C:/AIMindVaults/Vaults/BasicVaults/AIHubVault/.obsidian/plugins/<plugin-ID>'
New-Item -ItemType Directory -Path $pluginDir -Force
```

- Download `main.js`, `manifest.json`, `styles.css` from the latest release via GitHub Releases API
- Some plugins may not have `styles.css` (this is normal)

### 3. Register in community-plugins.json

**Prohibited**: Do not use PowerShell `ConvertFrom-Json` -> `ConvertTo-Json` pipeline (risk of array corruption)

**Correct method**: Read the file with the `Read` tool, then add the plugin ID directly to the array with the `Edit` tool

```
Before:
  "templater-obsidian",
  "ytranscript"
]

After:
  "templater-obsidian",
  "ytranscript",
  "<new-plugin-ID>"
]
```

### 4. Propagate to Other Vaults

- Run `aimv sync` to propagate the plugin to target vaults (Batch 0 merge method)
- Confirm with the user before proceeding with propagation

### 5. Verify Activation

- Guide the user to open/restart the target vault in Obsidian
- **Do not proceed with follow-up tasks (e.g., opening notes) until the user confirms plugin activation**
- How to verify activation: Obsidian Settings -> Community plugins -> Toggle ON the plugin

### 6. Record Version

- Record version in AIHubVault `_WORKSPACE_VERSION.md` (workspace editing rule)

## Prerequisites for Opening Notes

Before the AI opens a note via `obsidian://advanced-uri`, verify the following:

1. **Is the Advanced URI plugin installed in the target vault?** — Check for `.obsidian/plugins/obsidian-advanced-uri/`
2. **Is it registered in `community-plugins.json`?** — Check for `obsidian-advanced-uri` inclusion
3. If the above conditions are not met -> Install first using this skill (`/install-plugin`)
4. After installation -> Only attempt to open notes after completing step 5 (activation verification)

## Notes

- For `.obsidian/` JSON files, use direct text editing only instead of PowerShell JSON pipelines
- The same applies when deleting plugins: remove the line from `community-plugins.json` + delete the folder
- Beta plugins (via BRAT) are not covered by this skill
