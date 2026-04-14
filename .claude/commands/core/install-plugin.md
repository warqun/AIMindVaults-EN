---
description: "Install an Obsidian plugin (into AIHubVault)"
---

# /install-plugin — Install an Obsidian Plugin

## Usage

```
/install-plugin <plugin-name or GitHub URL>
```

## Procedure

### 1. Target check

- Install target: **AIHubVault only** (workspace edit rule).
- Plugin path: `AIHubVault/.obsidian/plugins/<plugin-id>/`.

### 2. Download the plugin

```powershell
$pluginDir = 'C:/AIMindVaults/Vaults/BasicVaults/AIHubVault/.obsidian/plugins/<plugin-id>'
New-Item -ItemType Directory -Path $pluginDir -Force
```

- Fetch `main.js`, `manifest.json`, `styles.css` from the GitHub Releases API latest release.
- Some plugins have no `styles.css` (normal).

### 3. Register in community-plugins.json

**Forbidden**: the PowerShell `ConvertFrom-Json` → `ConvertTo-Json` pipeline (risks corrupting arrays).

**Correct**: Read the file with the `Read` tool, then use the `Edit` tool to append the plugin id directly to the array.

```
before:
  "templater-obsidian",
  "ytranscript"
]

after:
  "templater-obsidian",
  "ytranscript",
  "<new-plugin-id>"
]
```

### 4. Propagate to other vaults

- Run `aimv sync` to propagate the plugin to target vaults (Batch 0 merge).
- Confirm with the user before running.

### 5. Activation check

- Tell the user to open/restart the target vault in Obsidian.
- **Do not proceed with follow-up work (opening notes, etc.) until the user confirms activation.**
- How to confirm: Obsidian Settings → Community plugins → toggle the plugin ON.

### 6. Version logging

- Record the version in AIHubVault `_WORKSPACE_VERSION.md` (workspace edit rule).

## Prerequisite for Opening Notes

Before the AI opens a note via `obsidian://advanced-uri`, verify:

1. **Advanced URI plugin is installed in the target vault** — check `.obsidian/plugins/obsidian-advanced-uri/` exists.
2. **It's registered in `community-plugins.json`** — `obsidian-advanced-uri` is listed.
3. If either fails → install it first with this skill (`/install-plugin`).
4. After install → only attempt to open notes once step 5 (activation check) is complete.

## Cautions

- For `.obsidian/` JSON files, edit the text directly — no PowerShell JSON pipeline.
- Plugin removal follows the same rule: remove the line from `community-plugins.json` and delete the folder.
- Beta plugins (via BRAT) are out of scope for this skill.
