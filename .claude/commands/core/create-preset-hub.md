# /create-preset-hub — Create a New Preset Hub (Multi-Hub Architecture)

Fork a new Preset Hub vault from CoreHub.
A skill that systematically performs "where to specify the path and how the syncs are wired up".

---

## 1. Usage

```
/create-preset-hub <hubId> [--name "<Display Name>"] [--desc "<one-line>"]
```

Examples:
- `/create-preset-hub gamedev --name "Game Dev Preset Hub" --desc "Game-development bundle"`
- `/create-preset-hub writing`
- `/create-preset-hub diary-v2 --name "Diary Preset v2"`

`hubId` rules: **kebab-case lowercase** · digits allowed · first char alphanumeric (`^[a-z0-9][a-z0-9-]*$`). It is the **unique identifier** within the Multi-Hub topology, so it must not collide with existing hubIds (`core`, `default`, `minimal`, `diary`, `domain`, `lab`, `project`).

---

## 2. Prerequisites

1. **CoreHub exists** — `<AIMindVaults root>/Vaults/BasicVaults/CoreHub/` must contain `hub-marker.json` (hubType=core).
2. **Preset spec authored in advance (recommended)** — for complex Presets (plug-in bundle, folder structure, templates, QuickAdd, Dataview), author `YYYYMMDD_<Hub-name>_spec.md` under `Vaults/Projects_Infra/Project_AIMindVaults/Contents/Project/plan/architecture/` first, then run this skill. Skippable for simple Presets.
3. **hubId uniqueness check** — list `Vaults/BasicVaults/` and verify no collision with existing Preset Hub hubIds.

---

## 3. Path Specification — What Is Decided Where

| Item | Where | Example | Auto / Manual |
|------|-------|---------|---------------|
| **Target Path** (physical path of the new Preset Hub) | CLI `--target-path` | `<root>/Vaults/BasicVaults/AIHubVault_<suffix>/` | User-specified |
| **Source Core Hub** | CLI `--from` (auto-detected if omitted) | `<root>/Vaults/BasicVaults/CoreHub/` | Auto (5-level ascent from script location) |
| **hubId** | CLI `--hub-id` | `gamedev`, `writing` | User-specified · required |
| **hubName** | CLI `--hub-name` | `"Game Dev Preset Hub"` | Optional · folder name if omitted |
| **coreHub relative path** | Auto-written into `hub-marker.json` | `"../CoreHub"` | Auto (computed Target → Source relative path) |
| **coreHubVersion** (compat range) | **Manual** edit in `hub-marker.json` | `"^1.0.0"` | **Manual** (create-hub does not write it) |

**Important**: `create-hub` only auto-writes `hubId`, `hubType`, `hubName`, `coreHub`, `version`, `description`, `createdAt` in `hub-marker.json`. **The user must manually fill in `coreHubVersion`** so that compatibility checks engage during `core-sync-all`.

---

## 4. Step-by-Step Execution

### 4.1 Step 1 — Run the `create-hub` CLI (auto clone + initialization)

```bash
cd <root>/Vaults/BasicVaults/CoreHub
node .sync/_tools/cli-node/bin/cli.js create-hub \
  --target-path "<root>/Vaults/BasicVaults/AIHubVault_<suffix>" \
  --hub-id "<hubId>" \
  --hub-name "<Display Name>" \
  --description "<one-line summary>"
```

**The 5 steps `create-hub` performs automatically** (see `create-hub.js`):

| # | Step | Output |
|---|------|--------|
| 1/5 | Mirror-copy Core Hub | Full file structure of the new vault (excluding `.git`, `smart-connections`, `cache`, `workspace.json`, etc.) |
| 2/5 | Remove per-device plug-in settings | Deletes `.obsidian/plugins/obsidian-git/data.json`, `.obsidian/plugins/claudian/data.json` |
| 3/5 | Write `.sync/hub-marker.json` | `hubType=preset`, `coreHub=<relative-path>`, `createdAt=<today>` |
| 4/5 | Re-author Preset entry files | `CLAUDE.md`, `_STATUS.md`, `README.md` (overwrite the Core Hub originals to Preset-specific versions) |
| 5/5 | Update `make-md` `systemName` | Rewrite to the vault name (sidebar nav label) |

**What the CLI does NOT do automatically** (manual follow-ups):

- Install Custom plug-ins (only Core 7 are copied)
- Fill in `coreHubVersion` in `hub-marker.json`
- Add Custom plug-in IDs to `.obsidian/community-plugins.json`
- Place templates · register QuickAdd commands · author Dataview dashboards
- Register the new vault in the root `_STATUS.md` registry

### 4.2 Step 2 — Finalize `hub-marker.json` (manual edit)

**Edit location**: `{new Preset Hub}/.sync/hub-marker.json`

```json
{
  "hubId": "<hubId>",
  "hubType": "preset",
  "hubName": "<Display Name>",
  "version": "1.0.0",
  "coreHub": "../CoreHub",
  "coreHubVersion": "^1.0.0",              // ← add manually (compat range)
  "description": "<spec-based summary>",   // ← refine
  "defaultTemplate": "BasicContentsVault", // ← add manually (default source for satellite clone)
  "createdAt": "YYYY-MM-DD"
}
```

**`coreHubVersion` range guide**:

| Range | Meaning | Recommended for |
|-------|---------|-----------------|
| `^1.0.0` | Same major (1.x.x) | General Preset (default) |
| `~1.2.0` | Same minor (1.2.x) | Sensitive to breaking changes |
| `>=1.0.0` | 1.0.0 or later | Open compatibility |
| `"1.0.0"` | Exactly 1.0.0 | Strict pin (not recommended — blocks upgrades) |

**`defaultTemplate` resolution rules** (see `clone-vault.js`):

| Form | Resolution | Example |
|------|------------|---------|
| Name only (`"BasicDomainVault"`) | `BasicVaults/<name>` (Hub sibling) | `<root>/Vaults/BasicVaults/BasicDomainVault` |
| Relative (`"../BasicDiaryVault"`) | Relative to Hub root | Climbs to upper levels |
| Absolute | Used as-is | Windows: `C:/...`, Unix: `/...` |
| Unspecified or non-existent | Fallback to `BasicContentsVault` | Common template |

When a satellite binds to this Preset via `clone --hub <Preset>` and omits `--source-path`, this value selects the clone source. Same applies when the user creates via `Vaults/BasicVaults/MakeCloneVault.bat/.sh`.

### 4.3 Step 3 — Install Custom Plug-Ins

**The Core 7 plug-ins are already copied** (`obsidian-local-rest-api`, `obsidian-advanced-uri`, `obsidian-shellcommands`, `dataview`, `templater-obsidian`, `obsidian-linter`, `make-md`).

**Custom plug-in install** (pick one):

#### Method A: Install directly in Obsidian (recommended)

1. Obsidian vault manager → "Open vault folder" → the new Preset Hub path.
2. From Community Plugins, install the spec's Custom bundle.
3. Toggle each plug-in to **Enable**.

#### Method B: Copy from an existing Preset (when the spec is similar)

```bash
# Example: copy quickadd, metadata-menu from AIHubVault (Default Preset)
SRC=<root>/Vaults/BasicVaults/AIHubVault/.obsidian/plugins
TGT=<root>/Vaults/BasicVaults/AIHubVault_<suffix>/.obsidian/plugins
cp -r "$SRC/quickadd" "$TGT/"
cp -r "$SRC/metadata-menu" "$TGT/"
```

Then add the plug-in IDs to `.obsidian/community-plugins.json`. **Edit this JSON via Read → Edit (direct text edit only)** — do not use the PowerShell `ConvertFrom-Json | ConvertTo-Json` pipeline (see `obsidian-config-safety.md`).

### 4.4 Step 4 — Spec-Driven Configuration (optional)

Per the Preset spec:

- **Templater**: place templates under `{Hub}/.obsidian/plugins/templater-obsidian/templates/` and bind folder templates in Templater settings.
- **QuickAdd**: register shortcut commands (Obsidian UI).
- **Dataview dashboard**: place queries in `_STATUS.md` or a separate `Dashboard.md`.
- **Folder structure**: create per-type Zettelkasten folders (`00_Fleeting/`, `02_Permanent/`, etc.).

For details, see the corresponding Preset spec under `Vaults/Projects_Infra/Project_AIMindVaults/Contents/Project/plan/architecture/`.

### 4.5 Step 5 — Register in the Root Registry

#### 5a. Add to the root `_STATUS.md` vault registry

Add a row to the **BasicVaults** section table in the root `_STATUS.md`:

```markdown
| AIHubVault_<suffix> | Preset Hub (<hubId>) | `Vaults/BasicVaults/AIHubVault_<suffix>/` | <description> | claude / YYYY-MM-DD |
```

#### 5b. Record in `_ROOT_VERSION.md`

```markdown
| R0XX | YYYY-MM-DD | 🕓 | 🕓 | **New Preset Hub `AIHubVault_<suffix>`** — hubId="<hubId>", coreHub=../CoreHub, coreHubVersion=^1.0.0. Core 7 + Custom <N>. Spec: `<spec file path>`. |
```

---

## 5. Sync Flow — How It Connects After Creation

### 5.1 Core Layer (CoreHub → this Preset Hub, push)

**Who**: CoreHub editor
**When**: Right after editing `.sync/_tools/`, `.sync/_Standards/Core/`, `.sync/schemas/`, or Core 7 plug-ins on CoreHub
**How**:

```bash
cd <root>/Vaults/BasicVaults/CoreHub
node .sync/_tools/cli-node/bin/cli.js bump-version -m "change description" --broadcast
```

`--broadcast` auto-chains `core-sync-all` → push the Core layer to every Preset Hub (including the new one).

**Compat check**: if a Preset's `hub-marker.json` `coreHubVersion` does not match the CoreHub `version`, it is skipped. Use `--force` to override.

### 5.2 Custom Layer (edits inside this Preset Hub)

**Who**: editor of this Preset Hub
**When**: When adding / removing Custom plug-ins under `.obsidian/plugins/` or editing `.claude/rules/custom/`, `.claude/commands/custom/`
**How**:

```bash
cd <root>/Vaults/BasicVaults/AIHubVault_<suffix>
node .sync/_tools/cli-node/bin/cli.js bump-version -m "Custom change description"
```

Only this Preset Hub's `_WORKSPACE_VERSION.md` advances; CoreHub is unaffected. Satellites detect the version bump on the next pre-sync → re-execute the Hub trampoline.

### 5.3 Satellite Binding (satellite → this Preset Hub)

#### Method A: Specify `--hub` when creating a new satellite (recommended)

```bash
cd <root>/Vaults/BasicVaults/BasicContentsVault
node .sync/_tools/cli-node/bin/cli.js clone \
  --target-path "<root>/Vaults/<category>/<vault-name>" \
  --project-name "<vault-name>" \
  --hub "<root>/Vaults/BasicVaults/AIHubVault_<suffix>"
```

`clone-vault.js` auto-writes `.sync/hub-source.json`:

```json
{
  "hubPath": "../../BasicVaults/AIHubVault_<suffix>",
  "hubId": "<hubId>",
  "bindAt": "YYYY-MM-DD"
}
```

#### Method B: Rebase an existing satellite (`rebase`)

```bash
cd <root>/Vaults/<category>/<vault-name>
node .sync/_tools/cli-node/bin/cli.js rebase \
  --hub "<root>/Vaults/BasicVaults/AIHubVault_<suffix>" --dry-run
# Re-run without --dry-run if there are no problems.
```

#### Method C: Manually author `.sync/hub-source.json`

Author the satellite's `.sync/hub-source.json` directly:

```json
{
  "hubPath": "<satellite → Preset Hub relative path>",
  "hubId": "<hubId>",
  "bindAt": "YYYY-MM-DD"
}
```

`hubPath` is the **relative path** from the satellite's vault root to the Preset Hub root (e.g., `../../BasicVaults/AIHubVault_gamedev`). Absolute paths are forbidden.

### 5.4 Sync Execution (satellite → Preset Hub → satellite)

When a satellite syncs its workspace:

```bash
cd <root>/Vaults/<category>/<vault-name>
node .sync/_tools/cli-node/bin/cli.js sync
```

`pre-sync.js` automatically:
1. Reads `.sync/hub-source.json` → resolves the Preset Hub from `hubPath`.
2. Compares the Preset Hub `_WORKSPACE_VERSION.md` against the satellite version.
3. If the Preset Hub is newer, **re-executes via the trampoline** (re-invokes itself using the Hub's CLI).
4. `sync-workspace.js` pulls Preset Hub files into the satellite + merges `community-plugins.json` (folder-set union).

---

## 6. Verification

### 6.1 CoreHub detects the Preset

```bash
cd <root>/Vaults/BasicVaults/CoreHub
node .sync/_tools/cli-node/bin/cli.js core-sync-all --dry-run
```

The output should contain a section `--- Preset Hub: <hubId> (...) ---`.

### 6.2 Satellite recognizes this Preset as its Hub

```bash
cd <root>/Vaults/<bound satellite>
node .sync/_tools/cli-node/bin/cli.js sync --dry-run
```

The output should show `Hub: AIHubVault_<suffix>` (taken from `hub-source.json`).

### 6.3 hub-marker.json schema check

Validate against `Vaults/BasicVaults/CoreHub/.sync/schemas/hub-marker.schema.json`:
- `hubId` matches the kebab-case pattern
- `hubType = "preset"`
- The `coreHub` path exists
- (recommended) `coreHubVersion` is set

### 6.4 Validate in Obsidian

Open this Preset Hub via Obsidian's vault manager and verify:
- Core 7 plug-ins load
- Custom plug-ins are activated
- The vault name appears in `make-md`'s left navigation

---

## 7. Forbidden

- **No manual folder copies** — do not clone CoreHub via `cp -r`, `Copy-Item`, or `robocopy`. Always use the `create-hub` CLI (otherwise per-device cleanup, hub-marker authoring, and make-md systemName updates are missed).
- **Do not reuse an existing hubId** — hubIds must be unique across the Multi-Hub.
- **No Preset-of-preset forks (MVP)** — passing another Preset Hub as `--from` triggers a warning. Keep the flat topology (Core 1 + Preset N).
- **Do not edit `.sync/_tools/`, `.sync/_Standards/Core/`, or `.sync/schemas/`** in this Preset — the Core layer is editable on CoreHub only. Edits here will be overwritten on the next `core-sync-all` and lost.
- **Do not bind this Preset as a satellite of CoreHub** — CoreHub does not directly take satellites. Satellites go via Preset Hubs.

---

## 8. References

- **CLI source**: `Vaults/BasicVaults/CoreHub/.sync/_tools/cli-node/src/commands/create-hub.js`
- **Schemas**: `Vaults/BasicVaults/CoreHub/.sync/schemas/hub-marker.schema.json` · `hub-source.schema.json`
- **Multi-Hub design**: under `Project_AIMindVaults` plan / architecture (multi-hub design + Phase 1 implementation results)
- **Preset specs**: under `Project_AIMindVaults` plan / architecture (Diary / Domain / Lab / Project Hub specs)
- **Related skills**: `/create-vault` (satellite creation; bind to this Preset via `--hub`), `/install-plugin` (Custom plug-in install), `/hub-broadcast` (single-file Hub → satellite propagation)
- **Related rules**: `.claude/rules/core/_essentials.md § 4` (edit modes · Multi-Hub mandatory), `.claude/rules/core/obsidian-config-safety.md` (community-plugins.json editing)
