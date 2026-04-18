# Skill Router (Mandatory · Always Loaded)

> The agent reviews this table on **every incoming user message** and either invokes the matching Skill or manually Reads the rule file before starting work.
> If no match, proceed with `_essentials.md` alone. For multiple matches, handle sequentially.
> Do not re-run a rule already called / read in the same session (token economy).

## Operating Rules

1. Review at the first user message, and again each time a new trigger appears during work.
2. A mapping value is either a **Skill invocation** or a **rule file path to Read**. Prefer Skill when available.
3. Invoke Skills with the `Skill` tool and `<name>`. For file reads required by a Skill body, follow its instructions to read archive rules.
4. Apply the loaded rules while working.

## Trigger Mapping Table

| Task Type | Trigger Keywords | Target |
|-----------|------------------|--------|
| New vault creation | create vault, clone vault, new vault, split vault | `/create-vault` Skill + Read `.claude/rules-archive/vault-individualization.md` |
| Bulk editing · encoding | bulk edit, mass change, encoding, mojibake, garbled Korean, bulk rewrite | `.claude/rules/core/encoding-safety.md` + `.claude/rules/core/temp-file-management.md` (already injected) |
| Script creation | create script, new .ps1, new .py, automation script | `.claude/rules/core/script-creation-approval.md` + `.claude/rules/core/script-management.md` (already injected) |
| Juggl editing | Juggl, graph.css, Juggl embed | `.claude/rules/core/juggl-style-sync.md` (already injected) |
| .obsidian/ editing | .obsidian, plugin settings, community-plugins.json | `.claude/rules/core/obsidian-config-safety.md` (already injected) |
| User guidance low-risk (§1, §3, §6, §7, §9, §12) | open Obsidian, where to put note, which vault, install plugin, end session, wrap up, where is the note, how to, what should I | Read `.claude/rules-archive/user-guidance-detail.md` |
| Temp files · recursive deletion | temp file, MAX_PATH, infinite recursion, flatten-and-delete, robocopy | `.claude/rules/core/temp-file-management.md` (already injected) |

## On No Match

- No keyword → proceed with `_essentials.md` alone.
- Rule seems needed but not in the table → ask the user whether a rule applies, then proceed.
- New task type recurring often → add a row to this router or user-private `custom/` rules.

## User Extension

Users can extend this table for their domain:

1. Add a personal Skill under `.claude/commands/custom/`.
2. Place related rule files in `.claude/rules-archive/`.
3. Add a row here mapping trigger keywords to the Skill / file path.

Examples: Unity scripting, Blender 3D work, Notion logging — create a Skill per workflow and register it in this router.
