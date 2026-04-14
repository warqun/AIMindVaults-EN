# Script Management (Mandatory)

> Applies to all vaults.

## Rules

- Before creating a new script, check `_Standards/Core/Script_Registry.md` in the target vault to see whether an equivalent script already exists.
- If the goal can be met by extending an existing script, do not create a new one.
- No hardcoded paths — use script-location-based auto-detection (`$ScriptDir\..\..` or equivalent).
- After creating a script, register it in `Script_Registry.md`.
- When deleting a script, move its entry to the registry's "Deleted Scripts" section and record the reason.
