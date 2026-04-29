# Script Management (Mandatory)

> Applied uniformly to every vault.

## Rules

- Before creating a new script, always check the vault's `_Standards/Core/Script_Registry.md` to determine whether the same functionality already exists.
- If the existing script can be extended to solve the problem, do not create a new one.
- Hard-coded paths are forbidden — use script-location-based auto-detection (`$ScriptDir\..\..`).
- Always register a newly created script in `Script_Registry.md`.
- When deleting a script, move the entry to the registry's "Deleted scripts" section with the reason recorded.
