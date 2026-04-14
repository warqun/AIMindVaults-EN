# Script Management (Mandatory)

> Applies uniformly to all vaults.

## Rules

- Before creating a new script, always check the vault's `_Standards/Core/Script_Registry.md` to determine if duplicate functionality already exists.
- If the goal can be achieved by extending an existing script, do not create a new one.
- No hardcoded paths — use script-location-based auto-detection (`$ScriptDir\..\..`).
- After creation, always register the script in Script_Registry.md.
- When deleting, move the entry to the "Deleted Scripts" section in the registry and record the reason.
