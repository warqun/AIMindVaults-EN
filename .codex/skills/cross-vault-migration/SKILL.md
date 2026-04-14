---
name: cross-vault-migration
description: Cross-vault knowledge note migration procedure — copy from source to target, update links, clean up
---

# Cross-Vault Note Migration

**Purpose**: A standard procedure for migrating or promoting knowledge notes from one vault to another.

## Prerequisites

- Identify the source vault and target vault
- Review rules for both vaults (AGENTS.md, CLAUDE.md)

## Step 1: Locate Source Materials

Search for migration target notes in the source vault.

## Step 2: Determine Target Location

Determine the appropriate path in the target vault:
- Domain knowledge -> `Contents/Domain/`
- Standard promotion -> `AIHubVault/_Standards/`

## Step 3: Migrate and Update Links

1. Copy content from source to target (do not delete source)
2. Switch to target vault -> update internal links to target vault references
3. Apply target vault frontmatter/tag/Juggl rules

## Step 4: Clean Up Source

Switch to source vault:
- Delete the original or replace with a pointer/link to the target location (per user preference)

## Step 5: Verification

Run post-edit review in the target vault.
