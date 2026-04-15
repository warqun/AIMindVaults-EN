---
type: tag-mask
updated: 2026-04-15
---

# TAG_MASK — Tag masking (legacy tag → canonical tag)

> Purpose: gradually unify scattered tags into a canonical tag set.
> Principle: automatic replacement is risky — default to **staged/manual review**.

## Masking rules

1. Start with core documents (`_Standards/`, `Domain/`).
2. Expand gradually to the rest of the folders.
3. Agent memory files only when needed (optional).

---

## Mapping table

| Legacy tag | Canonical tag | Notes |
|------------|---------------|-------|
| `Project_VamSurLike` | `AIMindVault` | Vault migration complete (2026-03-08) |
| `high` | `priority/high` | Priority |
| `medium` | `priority/medium` | Priority |
| `low` | `priority/low` | Priority |

---

## Checklist (when masking)

- [x] Verify which folder the note belongs to
- [x] Keep the existing `tags:` while adding the canonical tag (intermediate step)
- [ ] Check via search that notes carrying only the legacy tag are decreasing
- [ ] Decide when to remove the legacy tag (bulk deletion is the final step)

---

## Migration log

### 2026-03-08: Project_VamSurLike → AIMindVault bulk migration

- Swapped frontmatter tags across the vault after its purpose shifted (game design → AI workspace hub).
- Completed for core files: `_Standards/`, `_forge/`, `CLAUDE.md`, `CODEX.md`, etc.
