---
type: meta
tags: [forge, deploy]
agent: claude
updated: 2026-03-08
---

# .forge — External Agent Output Staging

A space for deploying this vault's (AIMindVault) workspace configuration to other vaults.

## Structure

| Folder | Purpose |
|--------|---------|
| `inbox/` | Receives outputs from external agents (Grok, Codex, etc.) |
| `staging/` | Scripts/configs that have been reviewed and are ready for deployment |
| `tasks/` | Draft task directives related to deployment |

## Workflow

```
External agent output
    -> inbox/ (received)
    -> Review
    -> staging/ (deployment-ready)
    -> Deploy to target vault
```

## Related Documents

- [[_tools/GitMirrorSync_DecisionPoints]] — Vault cloning/sync decision points
- [[_tools/clone_vault.ps1]] — Vault cloning script
