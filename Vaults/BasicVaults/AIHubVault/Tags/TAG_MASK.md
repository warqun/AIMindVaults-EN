---
type: tag-mask
updated: 2026-03-08
---

# TAG_MASK — Tag Masking (Legacy Tags -> Canonical Tags)

> Purpose: Gradually unify scattered tags into "canonical tags".
> Principle: Automatic replacement is risky, so **staged/manual review** is the default approach.

## Masking Rules

1. Start with core documents (`_Standards/`, `Domain/`)
2. Gradually extend to other folders
3. Agent memory files only when needed (optional)

---

## Mapping Table

| Legacy Tag | Canonical Tag | Notes |
|----------|----------|------|
| `Project_VamSurLike` | `AIMindVault` | Vault transition complete (2026-03-08) |
| `high` | `priority/high` | Priority |
| `medium` | `priority/medium` | Priority |
| `low` | `priority/low` | Priority |

---

## Checklist (When Masking)

- [x] Verify which folder the note belongs to
- [x] Keep existing `tags:` while adding canonical tags (intermediate step)
- [ ] Verify that notes with only legacy tags are decreasing via search
- [ ] Decide when to remove legacy tags (bulk deletion comes last)

---

## Transition Log

### 2026-03-08: Project_VamSurLike -> AIMindVault Bulk Transition

- Replaced all frontmatter tags following vault purpose transition (game planning -> AI workspace hub)
- Completed for core files: `_Standards/`, `_forge/`, `CLAUDE.md`, `CODEX.md`, etc.
