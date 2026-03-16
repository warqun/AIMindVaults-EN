---
description: How to migrate knowledge notes between different vaults
---
# Cross-Vault Knowledge Migration Workflow

This workflow guides the agent on how to migrate or promote knowledge notes from one vault to another (e.g., from a Project Vault to the Global AIHubVault or BasicContentsVault).

## Prerequisites
- Identify the **Source Vault** and the **Target Vault**.
- Ensure you have read the local rules (`.antigravity/SESSION_RULES.md` or equivalent) of both the Source and Target vaults before making modifications.

## Procedure

1. **Locate Source Material**
   - Search the Source Vault for the note(s) to be migrated.
   - Example: Find `feature_design.md` in `ProjectVaultA/Contents/`.

2. **Prepare Target Location**
   - Determine the correct destination directory in the Target Vault.
   - If promoting to a standard, determine if it belongs in `AIHubVault/_Standards/` or another structured path.

3. **Migrate and Update Links (Isolation Rule)**
   - **Step 3a:** Copy the content from the Source Vault to the Target Vault. Do not delete the source yet.
   - **Step 3b:** Switch context to the Target Vault. Update any internal Obsidian links within the newly copied note so they are valid in the Target Vault's context.
   - **Step 3c:** Apply the Target Vault's specific frontmatter and formatting rules (e.g., specific `type`, `tags`, Juggl styling).

4. **Clean up Source**
   - Switch context back to the Source Vault.
   - Either delete the original file, or replace its content with a pointer/link to the new global location (depending on the user's preference for archiving).

5. **Validation**
   - Run any required post-edit reviews or sync scripts in the Target Vault (e.g., `post_note_edit_review.ps1` if applicable).
