# Skill Router (Mandatory · Always Loaded)

> The agent reviews this table **on every user message**, invokes the matching Skill or manually Reads the rule file, then begins the work.
> If no match, proceed using `_essentials.md` only. Process multiple matches sequentially.
> Do not re-invoke / re-Read a rule that is already loaded in this session (token saving).

## Operating Rules

1. Review on the user's first message and whenever a new trigger is detected mid-task.
2. Mapping values are either **Skill invocations** or **rule-file paths to Read**. Prefer the Skill when one exists.
3. Invoke a Skill via the `Skill` tool with `<name>`. If a file Read is needed, follow the Skill body's instructions to Read the archive rule.
4. Apply the loaded rule while doing the work.

## Trigger Mapping Table

| Work Type | Trigger Keywords | Target |
|-----------|------------------|--------|
| Unity scripting | Unity, C#, script, skill system, mcp-unity, unity-cli, Serena, find_symbol, replace_symbol_body, symbol-based editing | `/unity-dev` Skill |
| Blender work | Blender, 3D modeling, bpy, Hyper3D, Polyhaven, Sketchfab | `/blender-workflow` Skill |
| Meshy API | Meshy, AI texture, 3D generation, Meshy credit, text-to-3d, image-to-3d | `/meshy-workflow` Skill |
| Discord operations | Discord, bot, Admin Bot, channel, Forum, Community, allowed_mentions | `/discord-admin` Skill (add `/discord-manage` for actual operations) |
| Notion logging | Notion, task-management DB, dev-status sharing, Notion log | `/notion-record` Skill |
| Deploy / Git push, sync feature change | deploy, SellingVault, git push, distribution sync, English deploy, distribute, deploy, cli.js sync, pre-sync, _WORKSPACE_VERSION, sync-version, pre-sync trampoline | `/distribute` Skill |
| Multi-Hub | Core Hub, Preset Hub, CoreHub, core-sync, core-sync-all, hub-source.json, hub-marker.json, multi-hub, bump-version --broadcast, hubId, hubType, hub-resolver | Read the Multi-Hub architecture-design + Phase 1 implementation-result notes (under Project_AIMindVaults plan / architecture) |
| New vault (satellite) | Vault creation, create-vault, new vault, vault split | `/create-vault` Skill + Read `.claude/rules-archive/vault-individualization.md` |
| New Preset Hub | Preset Hub creation, create-preset-hub, create-hub, new Hub, AIHubVault_ creation, Hub derivation | `/create-preset-hub` Skill |
| Bulk editing · encoding | Bulk modification, bulk replace, encoding, mojibake, Korean garbled, bulk rewrite | `.claude/rules/core/encoding-safety.md` + `.claude/rules/core/temp-file-management.md` (core-injected) |
| Script creation | Script creation, new .ps1, new .py, automation script | `.claude/rules/core/script-creation-approval.md` + `.claude/rules/core/script-management.md` (core-injected) |
| Juggl edits | Juggl, graph.css, Juggl embed | `.claude/rules/core/juggl-style-sync.md` (core-injected) |
| `.obsidian/` edits | .obsidian, plug-in settings, community-plugins.json | `.claude/rules/core/obsidian-config-safety.md` (core-injected) |
| User guidance — low risk (§1, §3, §6, §7, §9, §12) | Open Obsidian, where to put a note, which vault, plug-in install, session end, "I'm done", "wrap up", "where's that note", how to deploy, SellingVault, how, what should I, "I forgot", "method", "procedure", "what next", how to, what should I | Read `.claude/rules-archive/user-guidance-detail.md` |
| Agent collaboration | Concurrent with Codex, conflict, agent split | `.claude/rules/custom/agent-ownership.md` (custom-injected) |
| Temp files · recursive deletion | Temp file, MAX_PATH, infinite recursion, flatten-and-delete, robocopy | `.claude/rules/core/temp-file-management.md` (core-injected) |
| Obsidian instance control | Obsidian window, instance, "match to N", "shrink to N", "expand to N", "tidy up Obsidian", "close Obsidian", "how many Obsidian" | `/obsidian-windows` Skill + `.claude/rules/custom/obsidian-instance-control.md` (custom-injected) |
| Agent task delegation | delegate, hand off, in the background, separate instance, worker, delegate, parallel work, concurrent work, another Claude, another agent does it, "queue it", "long task so separately", "this in a different session" | `/delegate-task` Skill (queue-write + spawn + trigger + tracking + completion-handling SOP) |

## On Match Failure

- No keyword → proceed with `_essentials.md` only.
- It feels like a rule should apply but is missing from the table → ask the user "is there a rule that applies here?" before proceeding.
- A new work type recurs → after user approval, add it to the table.

## Phase 2-A Complete (2026-04-18)

6 domain rules transitioned to Skills. 7 custom/ rules → relocated to rules-archive/.

| Skill | Consolidated archive rules |
|-------|----------------------------|
| `/distribute` | distribution-deploy + sync-version-priority |
| `/unity-dev` | unity-tools + unity-scripting-style + serena-mcp |
| `/blender-workflow` | blender-mcp |
| `/meshy-workflow` | meshy-api |
| `/discord-admin` | discord-bot |
| `/notion-record` | notion-sync |

Custom rules kept (always-injected): `agent-ownership.md`, `multivault-personalization.md`
On hold: `bulk-edit-safe` Skill (core safety rules; needs separate review)
