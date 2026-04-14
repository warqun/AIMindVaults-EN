---
type: workspace-changelog
tags:
  - AIMindVault
  - Meta
updated: 2026-03-21
---

# Workspace Changelog (Hub Only)

> AIHubVault development history. Not a deployment target and not synced.
> Only the top version number in `_WORKSPACE_VERSION.md` is used for sync decisions.

| Version           | Changes                                                                                                                          |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| 202603210013 | Streamlined _WORKSPACE_VERSION.md — separated development log to _WORKSPACE_CHANGELOG.md (Hub only). Distribution includes only 1 row with the latest version |
| 202603210012 | Applied trampoline pattern to pre_sync.ps1 — re-executes in new process on self-update, then terminates old version. Structural solution for chicken-and-egg issue                      |
| 202603210011 | Moved Obsidian reload logic to sync_workspace.ps1 (chicken-and-egg fix). Removed from pre_sync.ps1, reload now works for both PLUGIN_ONLY and full sync |
| 202603210010 | Auto-reload Obsidian via Local REST API when new plugins detected after sync. Added reload flag to sync_workspace.ps1, reload trigger to pre_sync.ps1 |
| 202603210009 | Added Excalidraw plugin                                                                                                             |
| 202603210008 | sync_workspace.ps1 Batch 0 — changed community-plugins.json to text-based direct merge (Hub+target union, sorted, BOM-free UTF-8). Removed Advanced URI .bat method |
| 202603200007 | sync_workspace.ps1 Batch 0 — run enable-plugin as independent process script (Shell Commands Hidden bypass)                                        |
| 202603200006 | sync_workspace.ps1 Batch 0 — removed direct community-plugins.json editing, switched to Advanced URI enable-plugin for plugin activation                      |
| 202603200005 | Created open_vault.ps1 + Open Vault.bat — external Obsidian launcher. Safely opens vault after plugin sync. Registered pre_sync.ps1 in Shell Commands. Deployed to all vaults           |
| 202603200004 | pre_sync.ps1 auto-sync followed by plugin auto-activation test 1                                                                                         |
| 202603200003 | Created pre_sync.ps1 — pre-sync script update wrapper. Removed sync_workspace.ps1 self-update, delegated externally. Batch 0 always runs even with same version                         |
| 202603200002 | sync_workspace.ps1 — added Batch 0 plugin merge sync                                                                                    |
| 202603200001 | Installed .obsidian/plugins/obsidian-advanced-uri, registered in community-plugins.json                                                         |
| 202603180001 | Created _Standards/Core/VaultTypes/VaultTypes.md — vault type definitions (Basic, Domain, Lab, Project, Reference). Reflects new Lab category                |
| 202603170012 | CLAUDE.md — added AI_Rules_Index.md to detailed rules references, removed dead reference (NoteProperties.md)                                                        |
| 202603170011 | Created _Standards/Core/AI_Rules_Index.md — full index of 11 .claude/rules/ rules, documented 3-tier rule system                                             |
| 202603170010 | Full rewrite of _WORKFLOW.md — registered Claudian agent, removed deleted document references, updated CLI bridge and edit mode sections                                                      |
| 202603170009 | Extended CLAUDE.md edit mode section — added Contents/workspace prohibition/exception rules, 3 mode operation clauses                                                            |
| 202603170008 | Deleted _tools/cli_launchers/RUN_OBSIDIAN_VAMSURLIKE.bat — hardcoded path, unsuitable for Hub distribution                                                      |
| 202603170007 | Created _tools/TOOLS_INDEX.md — documented user/AI tool listings. Deleted cli/README.md                                                               |
| 202603170006 | obsidian_ai_bridge.ps1 — added open action (open notes in Obsidian, supports path or file name)                                                   |
| 202603170005 | claudian-settings.json — added Claudian self-awareness and workspace mode prohibition rules to systemPrompt (both AIHubVault and BasicContentsVault)               |
| 202603170004 | .antigravity/SESSION_RULES.md — added token conservation and execution delegation section (minimize file exploration, ping-pong pattern, prevent context bloat, pre-assess costs)                                   |
| 202603170003 | Recreated _tools/MakeCloneVault.bat — clone_vault.ps1 launcher (parent path + vault name input)                                                         |
| 202603170002 | sync_workspace.ps1 — enabled prune by default. Files deleted in Hub are now auto-deleted in other vaults. Disable with -NoPrune                                           |
| 202603170001 | Source cleanup — deleted 14 _Standards/Core/ reference docs, _VaultReview/, 5 one-off _tools/, CLI_MEMORY/. Updated Script_Registry.md                        |
| 202603150009 | Hub_Sync_Targets.md — removed NOT Synced section, emphasized only explicitly listed targets are synced                                                                         |
| 202603150008 | Distribution prep — removed hardcoded absolute paths (C:\AIMindVaults), converted to relative paths (_WORKFLOW, _VAULT-INDEX, VaultTypes, SESSION_RULES, root agent files)               |
| 202603150007 | Hub-Sync pipeline fully operational                                                                                                         |
| 202603150006 | sync_workspace.ps1 — Hub auto-discovery (_forge/ marker), fixed SELF bug, added Windows toast notification on failure                                                  |
| 202603150005 | Created _Standards/Core/Hub_Sync_Targets.md — documented sync target list                                                                         |
| 202603150004 | Changed workspace editing to AIHubVault-only, other vaults propagated via sync_workspace.ps1 (removed 3-step version recording rule)                                              |
| 202603150003 | Status system redesign — mandatory direct _STATUS.md update, AGENT_STATUS changed to recommended (new session-exit.md, batch update of all 4 agent entry points, commands, _WORKFLOW)              |
| 202603150002 | Added mandatory workspace version recording rule to all 4 agent entry points (edit-mode-separation, edit-scope, SESSION_RULES)                                        |
| 202603150001 | Registered Cursor agent (SESSION_RULES.md), fixed sync_workspace.ps1 UTF-8 BOM, completed VerifyContent sync                                       |
| 202603140001 | Converted hardcoded paths in 5 _tools/ scripts to auto-detection ($ScriptDir)                                                                                  |
| 202603110006 | Added mandatory version recording rule to _WORKFLOW.md workspace mode                                                                                      |
| 202603110005 | Deprecated open_agents.ps1 (replaced by single multi-vault root IDE launch), updated PLUGIN_SHELL_COMMANDS/CAPABILITIES                                             |
| 202603110004 | Created sync_workspace.ps1, changed SESSION_RULES.md to sync script invocation, registered in Script_Registry                                                 |
| 202603110003 | Restructured _VAULT-INDEX.md to workspace-only, separated Contents/CONTENTS_INDEX.md                                                                   |
| 202603110002 | Updated 3 VaultTypes documents (generalized folder structure, unified AI agent references)                                                                                    |
| 202603110001 | Introduced Hub-Sync protocol, updated CLAUDE.md/ANTIGRAVITY.md entry protocols                                                                          |
