# Hub Sharing Guide (Multi-Hub Phase 3)

The full process of **sharing your own Preset Hub or Core Hub via a GitHub repository** under the Multi-Hub architecture, and letting other users install it via `aimv install-hub`.

## 1. Overview

AIMindVaults consists of one Core Hub (the canonical Core layer) and N Preset Hubs (themed bundles). From Phase 3 onwards, these Hubs can be shared as independent GitHub repositories.

### Distribute vs. Share

|        | Distribute (`aimv deploy`) | Share (`aimv install-hub`) |
|--------|----------------------------|------------------------------|
| **Direction** | creator → SellingVault | creator ↔ other users |
| **Scope** | full AIMindVaults | a single Hub vault |
| **Repo** | `AIMindVaults` / `AIMindVaults-EN` | arbitrary (user's choice) |
| **Use** | product release | reuse a Hub bundle |

## 2. Hub Packaging (creator)

### 2.1 Create a Preset Hub repository

Initialize the Preset Hub vault root as an independent git repo.

```bash
cd Vaults/BasicVaults/AIHubVault_GameDev
git init
git add -A
git commit -m "Initial: Game Development Preset Hub"
git remote add origin https://github.com/<user>/<repo>.git
git push -u origin main
```

### 2.2 Verify required metadata (`hub-marker.json`)

`.sync/hub-marker.json` at the Hub root must contain:

```json
{
  "hubId": "game-dev",
  "hubType": "preset",
  "hubName": "Game Development Preset Hub",
  "version": "1.0.0",
  "coreHub": "../CoreHub",
  "coreHubVersion": "^1.0.0",
  "description": "Game-development-focused bundle (Unity, Unreal, game design, etc.)"
}
```

| Field | Meaning | Sharing notes |
|-------|---------|---------------|
| `hubId` | Unique identifier | Avoid collisions with other users' environments |
| `hubType` | `core` / `preset` | If `preset`, `coreHub` is required |
| `version` | Hub bundle version (semver recommended) | Bumped per release |
| `coreHubVersion` | Required Core Hub version | Compatibility (`^1.0.0`, etc.) |
| `coreHub` | Relative path to the Core Hub | Designed to remain valid in the user's environment after install |

### 2.3 Pre-Share Cleanup Checklist

- [ ] Beyond `.git`, remove per-device files: `.obsidian/plugins/*/data.json` containing login sessions / tokens
- [ ] Remove individual editing state: `.obsidian/workspace.json`, `workspace-mobile.json`, etc. (gitignore recommended)
- [ ] Verify no personal API keys / credentials are present in notes or `data.json`
- [ ] Include a `LICENSE` file (MIT / Apache / CC, etc.)
- [ ] In `README.md`, document the Preset's purpose, included plug-ins, install method, and `coreHubVersion`
- [ ] Use a namespaced `hubId` (`acme-dev`, `myteam-writer`) instead of generic nouns (`dev`, `writer`, `student`)

### 2.4 Recommended `.gitignore`

```gitignore
# Obsidian per-device
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/graph.json
.obsidian/backlink-in-document.json

# Plugin per-device data
.obsidian/plugins/obsidian-git/data.json
.obsidian/plugins/claudian/data.json

# OS
.DS_Store
Thumbs.db

# Caches
.trash/
.vault_data/
```

## 3. Hub Installation (consumer)

### 3.1 Prerequisites

- Local AIMindVaults repo (with the Core Hub)
- git installed
- `aimv` CLI available

### 3.2 Install

```bash
aimv install-hub --url https://github.com/<user>/<repo>.git
```

Automatic actions:
1. `git clone` to the default path `Vaults/BasicVaults/<repo-name>/`
2. Validate `.sync/hub-marker.json`
3. If `hubType=preset`, check compatibility against the local Core Hub version using `coreHubVersion`
4. Strip per-device settings

### 3.3 Options

| Option | Purpose |
|--------|---------|
| `-t, --target <path>` | Override the install path (default: `Vaults/BasicVaults/<repo-name>`) |
| `-b, --branch <name>` | Check out a specific branch |
| `-d, --dry-run` | Print the plan without cloning |
| `--skip-compat-check` | Ignore `coreHubVersion` mismatch warnings |

### 3.4 On Compatibility Mismatch

If the local Core Hub version does not satisfy the Preset's `coreHubVersion`:

```
[WARN]     Compatibility WARNING: 1.0.0 < required ^2.0.0
```

Choices:
- Update the local Core Hub (`cd Vaults/BasicVaults/CoreHub && git pull` or reinstall)
- Force install via `--skip-compat-check` (not recommended)
- Abort

### 3.5 After Installation

```bash
# (Optional) Apply the local Core's latest to the new Preset
aimv core-sync-all --target Vaults/BasicVaults/<repo-name>

# Bind a satellite vault to the new Preset
aimv rebase --hub Vaults/BasicVaults/<repo-name> --dry-run
aimv rebase --hub Vaults/BasicVaults/<repo-name>

# Or create a new satellite
aimv clone --target-path <new satellite path> --hub Vaults/BasicVaults/<repo-name>
```

## 4. Version Management (creator)

### 4.1 Release Procedure

1. Make changes in the Preset Hub vault (Custom plug-in additions, rule edits, etc.).
2. Bump the `version` field in `hub-marker.json` (semver recommended).
3. Update `coreHubVersion` if any Core-layer dependency changed.
4. Add an entry to `_WORKSPACE_VERSION.md`.
5. `git commit` + `git push`.

### 4.2 When the Core Hub Version Changes

If the Core Hub gets a major upgrade, re-check existing Presets' `coreHubVersion`:
- Bump `^1.0.0` → `^2.0.0` and migrate the parts that broke major compatibility
- Maintain a previous branch for legacy Core users (`legacy-v1`)

## 5. Operating Notes

### 5.1 No Cyclic Hub References

If Preset A's `coreHub` points to Preset B and B's `coreHub` points to A, the resolver loops forever. `coreHub` must always point to a Hub of `hubType=core` (flat 2-tier constraint).

### 5.2 Avoid hubId Collisions

If two Hubs with `hubId="dev"` exist locally after installation, `core-sync-all` treats both as Preset targets, leading to ambiguous intent. Prefer namespaced `hubId` (`acme-dev`).

### 5.3 Licensing

- Plug-ins included in a Hub bundle follow each plug-in's license.
- Rules / skills / standards documents are governed by the Hub repo's LICENSE.
- Satellite content is owned by the user — Hub creators have no rights to it.

## 6. References

- Design: the Multi-Hub architecture-design note (under the Project_AIMindVaults plan / architecture)
- Schema: `Vaults/BasicVaults/CoreHub/.sync/schemas/hub-marker.schema.json`
- CLI reference: `docs/cli-reference.md`
