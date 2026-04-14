# Vault Routing (Mandatory)

> Applies to all vaults. All agents.

## Required Check Before Placing Content

- Before creating a note/content, check the **root `_STATUS.md` vault registry** to pick the right vault.
- Also consult the vault entry protocol in root `CLAUDE.md`.

## Forbidden Vault

- **BasicContentsVault**: a distribution clone template. No direct content work. `/create-vault` skill only.

## When You Find an Unregistered Vault

- If you hit a vault that isn't in root `_STATUS.md`'s registry on first access, register it immediately.
- Registration fields: vault name, type (inferred from category), content description, working agent.
- Same applies to vaults the user created directly.

## Index Build on First Vault Access (Mandatory)

When an agent accesses a vault for the first time (whether newly created or user-created), if `vault_index.json` doesn't exist, **build the content index**.

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}"
```

- If the CLI script (`.sync/_tools/cli-node/bin/cli.js`) is missing, skip and log.
- After the build, `node cli.js index search` becomes usable.
- From then on, apply the indexer-first rule (`token-optimization.md` § 0) for any note exploration.

## Routing Rules

- Domain knowledge (Unity, CapCut, Notion, Git, etc.) → matching `Vaults/Domains_*/` vault.
- Game design → `Vaults/Domains_Game/GameDesign/`.
- AI workspace design/operation → `Vaults/BasicVaults/AIHubVault/`.
- Project work → matching `Vaults/Projects_*/` vault.
- No suitable vault? → ask the user before placing. Do not default to an unrelated vault.

## Reference Vault CLAUDE.md When Routing (Mandatory)

- When category alone doesn't make the target clear, read the **scope and boundaries in each candidate vault's CLAUDE.md** before deciding.
- Especially for adjacent-domain ambiguity (e.g. GameArt vs LightAndColor, AI vs AI_Coding), check the "What this vault does NOT collect" section.
- For vaults whose CLAUDE.md doesn't declare a scope, route by the "Role of this vault" line — and after the work, recommend adding an explicit scope declaration.
