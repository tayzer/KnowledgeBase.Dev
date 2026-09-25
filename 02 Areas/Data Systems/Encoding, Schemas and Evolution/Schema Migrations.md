---
date: 2026-06-23
status: Current
tags:
  - schema-migrations
  - databases
  - delivery
  - data

---

# Schema Migrations

## Quick Reference

**Definition:** Controlled changes to database structure, constraints, indexes, and reference data that keep application and data evolution safe over time.

**When to use:**
- When changing tables, columns, indexes, constraints, stored procedures, or data shape.
- When coordinating application deployments with database changes.

**Key Takeaways:**
- Prefer small, reversible, backward-compatible changes when production systems are already running.
- Separate schema change, data backfill, application switch-over, and cleanup when the risk is high.
- Test migrations against realistic data volume, not only empty local databases.

**Limit:** Rollback is not always safe or supported; rehearse forward recovery against realistic data.

---

## Deep Dive

### Migration Principles

- Keep migrations versioned with the application or a clearly owned database project.
- Make changes repeatable and observable.
- Avoid long locks and large blocking operations during peak usage.
- Plan rollback or roll-forward paths before release.
- Treat data backfills as production work with monitoring and batching.

### Expand-And-Contract Pattern

1. Add the new schema in a backward-compatible way.
2. Deploy application code that can read or write both old and new shapes if needed.
3. Backfill existing data safely.
4. Switch reads and writes to the new shape.
5. Remove old columns, tables, or code paths later.

### Common Risks

- Dropping or renaming columns in the same release that code still depends on them.
- Adding non-null columns without defaults or backfill strategy.
- Creating large indexes without considering locks or online-build support.
- Assuming local migration success proves production safety.

## Safe migration example

For a new required customer field, first add it nullable, deploy writers that populate it, backfill existing rows in bounded batches, then enforce NOT NULL after old readers/writers are retired. Test locks, rollback, backup/recovery, and application compatibility against realistic data. Some DDL changes cannot be rolled back or are engine-specific; prefer a tested forward fix when reversal is unsafe.

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/applying) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Transactions and Isolation Levels]]
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/_Index]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
