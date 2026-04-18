# Vault Individualization (Mandatory)

> Applies whenever a new vault is created. Rule for tailoring per-vault settings to the vault's purpose and subject.

## Vault Creation Method (Mandatory)

**All new vaults are created by cloning BasicContentsVault with `node cli.js clone`.**

- Source: `Vaults/BasicVaults/BasicContentsVault/` (the general-purpose template).
- Tool: `.sync/_tools/cli-node/bin/cli.js clone`.
- Do not manually copy folders (`Copy-Item`, `cp`, `xcopy`, etc.).
- Do not clone from AIHubVault (workspace hub, too heavy).

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" clone -t "<target-path>" -n "<vault-name>"
```

What the script handles:
- Excludes `.git`, caches, and sync folders from the copy (robocopy).
- Auto-removes device-specific plugin settings (obsidian-git, claudian).
- Auto-updates `make-md` systemName.

After cloning, complete the **required decisions** and **required follow-ups** below.

## Required Decisions at Creation

### 1. Vault Name

- Use a name whose role is immediately obvious.
- No URI-reserved characters (`#`, `%`, `&`, `?`, `+`) and no emoji.
- Examples: `YourDomainVault`, `YourProject`.

### 2. Parent Category

Place under the right parent based on the vault's nature:

| Category | Path | Criterion |
|----------|------|-----------|
| Domains_<area> | `Vaults/Domains_<area>/` | Domain knowledge grouped by area (e.g. language, tool, topic) |
| Projects_<area> | `Vaults/Projects_<area>/` | Project deliverables grouped by area |
| Lab_<area> | `Vaults/Lab_<area>/` | Domain + project hybrid (e.g. plugin dev, research + build) |
| Personal | `Vaults/Personal/` | Personal records |
| References | `References/` | Readonly external references |
| BasicVaults | `Vaults/BasicVaults/` | System vaults (Hub, distribution) |

If a new category is needed, confirm with the user first.

### 3. CLAUDE.md Authoring

Write a vault-specific CLAUDE.md:

- **Role of this vault**: 1–2 lines, explicit.
- **Scope**: what kinds of content belong here, and the criteria.
- **What NOT to collect**: the boundary with adjacent vaults that could cause confusion. Name the neighboring vault explicitly (e.g. "shader styling here; color theory → `<YourArtTheoryVault>`").
- **Directory layout**: the `Contents/` subfolder structure.
- **Tag rule**: the vault identifier tag.
- **Session entry rule**: must include mandatory pre-read of `_STATUS.md`.

### 4. Content Structure

Pick the right `Contents/` layout for the vault type:

- **Domain vault**: subject-based folders under `Contents/Domain/`.
- **Project vault**: `Contents/Project/plan/`, `Contents/Project/idea/`, etc.
- Design the structure for the vault's purpose, then register it in `_VAULT-INDEX.md`.

### 5. Tag Rule

- Pick one vault identifier tag (matching the vault name).
- Every note's frontmatter `tags` must include this tag.

## Required Post-Creation Work

1. Run workspace sync (propagate Core files from the Hub).
2. Register in the root `_STATUS.md` vault registry.
3. Add routing keywords to the root `CLAUDE.md` vault entry protocol.
4. **Build the initial content index** (mandatory):
```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}"
```
   - If the CLI script isn't there, the workspace sync didn't happen — redo step 1.
   - Verify `vault_index.json` exists after the build.

## Files Excluded from Distribution Sync

These per-vault files are NOT included in distribution sync:

- `CLAUDE.md` (per-vault content differs)
- `CODEX.md` (depends on agent choice)
- `AGENT_STATUS.md` (depends on agent choice)
- `_STATUS.md` (per-vault status)
- `_VAULT-INDEX.md` (per-vault structure)
- `_Standards/CONTENTS_SPEC.md` (per-vault content scope)
