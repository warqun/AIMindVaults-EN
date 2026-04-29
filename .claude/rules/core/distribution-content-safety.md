# Distribution Content Privacy Safety (Mandatory)

> Applies uniformly to every vault and every agent. Built from the 2026-04-25 incident.

## Background (Incident)

The `AGENT_ONBOARDING.md § 2 Vault structure` table cited the user's personal vault names directly as category examples. When deployed to SellingVault, this leaked the author's personal context into documents the new user reads, and presented vault names that the new user had not created at all — creating confusion.

## Rule

### Hard Forbid — No citation of personal user assets in distribution-target documents

The following assets must NOT appear in **distribution-target documents** (body, examples, tables, code blocks):

| Forbidden Asset | Examples (real user-registered assets) |
|----------------|-----------------------------------------|
| User-added vault names | (any personal toolkit / project / hobby vault names the user created) |
| User-added categories | (any user-defined category folders such as `Domains_*`, `Lab_*`, `Projects_*`) |
| External read-only material names | (read-only reference material the user downloaded) |
| Personal project names | (any vault named `Project_*` for personal operations) |
| Personal hostnames / usernames / device names | (never cited at all) |

### Distribution-Target Documents (identification)

**Distribution targets**:
- Root entry points: `CLAUDE.md`, `AGENTS.md`, parts of `CODEX.md`, `AGENT_ONBOARDING.md`, `AGENT_ONBOARDING_*.md`
- Root `README.md`, the core/ areas under `.claude/`, `.codex/`, `.cursor/`
- All of `Vaults/BasicVaults/` (CoreHub · Preset Hub · Basic*Vault clone templates)
- Guides under `_Standards/Core/`
- `.claude/rules/core/`, `.claude/commands/core/`
- `.claude/templates/`

**Not distribution targets (personal assets allowed)**:
- `_STATUS.md` (user vault registry — stripped to a blank template or excluded from deploy)
- `_SESSION_HANDOFF_*.md` (session context)
- `_ROOT_VERSION.md` (change history)
- `_AGENT_COMMS/` (inter-agent comms — not deployed)
- `Contents/**` (per-vault user content)
- `.claude/rules/custom/`, `.claude/commands/custom/`
- Worktrees (`.claude/worktrees/`)
- Memory (`~/.claude/projects/*/memory/`)

### Category-Example Convention

When describing categories / structure in distributed docs:

**✗ Forbidden** (citing real user assets):
```
| Domains_Game | Vaults/Domains_Game/ | Unity, GameDesign, GameArt |
| Personal | Vaults/Personal/ | Diary |
```

**✓ Recommended** (abstract pattern + use-case description):
```
| Domains_* | Vaults/Domains_*/ | Domain-knowledge vaults (added per user's areas of interest) |
| Personal | Vaults/Personal/ | Personal-record vaults (Diary etc.; AI-access can be restricted) |
```

Or redirect via the `_STATUS.md` vault registry:
```
For the actually registered vaults, see the vault-registry section in _STATUS.md
(it is environment-specific to each user).
```

### Keyword-Routing / Mapping Convention

Keyword → vault-ID mappings in `CLAUDE.md` / `AGENTS.md` are kept as **blank templates or generic examples** at deploy time:

**✗ Forbidden**:
```
| Unity, Unity engine | Unity |
| Game design, level design | GameDesign |
```

**✓ Recommended** (generic pattern):
```
| <domain keyword> | <corresponding vault ID> |
| (e.g., Python) | (e.g., Python) |
```

Or a user-guidance note:
```
Each user maintains the keyword mapping per the vault set they add.
```

### Change-Log / History Convention

When writing entries in `_ROOT_VERSION.md` or in distribution-sync rule change logs:
- Personal vault names **may appear** in the change body (history-tracking purposes). Mark such entries with `–` in both Korean and English columns to exclude them from the SellingVault deploy.
- General rule / tooling / structural changes use ✅ / 🕓.

## Incident Rule: Pre-Check When Authoring or Editing Distribution-Target Documents (Mandatory)

Workflow:

1. Determine whether the target document is a **deployment target** using the classification above.
2. If it is a deployment target, verify **0 citations of personal user assets**.
3. Commit after verification.
4. If unsure, ask the user: "this part cites a personal asset — should we generalize it?"

Optional automated check (recommended at authoring time):

```powershell
# Scan personal-asset keywords whenever a deployment-target document changes
$personal = @('<list of personal vault names>', '<other personal assets>')
$file = '<path to deployment-target file>'
$content = Get-Content $file -Raw
$found = $personal | Where-Object { $content -match $_ }
if ($found) { Write-Warning "Personal-asset citation found: $($found -join ', ')" }
```

(The personal-asset list can be derived dynamically from the `_STATUS.md` vault registry — a future automation candidate.)

## Cleanup of the SellingVault Distribution (separate task)

Before this rule was introduced, the following files in the deployed SellingVault (Korean / English) may still contain personal assets — the next `/distribute` invocation must inspect and generalize them:

- `AGENT_ONBOARDING.md` (confirmed — generalized together with this rule via R084)
- `CLAUDE.md` keyword mapping (needs check)
- `AGENTS.md` keyword mapping (needs check)
- `_STATUS.md` vault registry (must be stripped to a blank template at deploy time)
- Other user-asset citations in `.claude/rules/core/` and `.claude/commands/core/` bodies (needs check)

## References

- Incident discovered: 2026-04-25 user report ("personal information exposed in onboarding § 2 Vault structure")
- Related rule: `.claude/rules/core/distribution-sync.md` (general distribution sync)
- Distribution change log: the distribution-sync rules note under the project plan vault.
