# Vault Routing (Mandatory)

> Applies uniformly to all vaults. Common to all agents.

## Pre-Placement Check

- Before creating notes/content, check the **root `_STATUS.md` vault registry** to select the appropriate vault.
- Also refer to the vault entry protocol in the root `CLAUDE.md`.

## Prohibited Vaults

- **BasicContentsVault**: A distribution clone of AIHubVault. Direct content work is prohibited. Used exclusively by the `/create-vault` skill.

## On Discovering Unregistered Vaults

- When first accessing a vault that is not in the root `_STATUS.md` vault registry, register it immediately.
- Registration fields: vault name, type (inferred from category), content description, working agent
- The same applies to vaults created directly by the user.

## Index Build on First Vault Access (Mandatory)

When an agent first accesses a vault (whether newly created or user-created), **build the content index** if `vault_index.json` does not exist.

```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault_path}"
```

- If the CLI script (`.sync/_tools/cli-node/bin/cli.js`) does not exist, skip and log
- After the build completes, searching via `node cli.js index search` becomes available
- For subsequent note browsing/inspection, the indexer-first search rule (`token-optimization.md` § 0) applies

## Routing Rules

- Domain knowledge (Unity, CapCut, Notion, Git, etc.) → the corresponding `Vaults/Domains_*/` vault
- Game planning/design → `Vaults/Domains_Game/GameDesign/`
- AI workspace design/operations → `Vaults/BasicVaults/AIHubVault/`
- Project deliverables → the corresponding `Vaults/Projects_*/` vault
- If no suitable vault exists → confirm with the user before placement. Do not place content in an unsuitable vault based on arbitrary judgment.

## Refer to Vault CLAUDE.md for Routing Decisions (Mandatory)

- When the target vault is not clear from the category alone, **read the candidate vault's CLAUDE.md to check its collection scope and boundaries** before deciding.
- Especially when boundaries between adjacent domains are ambiguous (e.g., GameArt vs LightAndColor, AI vs AI_Coding), check the "What this vault does NOT collect" section in CLAUDE.md.
- For vaults where CLAUDE.md does not specify a collection scope, judge based on "This vault's role", and recommend reinforcing the collection scope after the task is complete.
