# Schema Migrations
Date: 2026-06-23
Status: Needs Review
Tags: #schema-migrations #databases #delivery #data

## TL;DR / Quick Reference

**Definition:** Controlled changes to database structure, constraints, indexes, and reference data that keep application and data evolution safe over time.

**When to use:**
- When changing tables, columns, indexes, constraints, stored procedures, or data shape.
- When coordinating application deployments with database changes.

**Key Takeaways:**
- Prefer small, reversible, backward-compatible changes when production systems are already running.
- Separate schema change, data backfill, application switch-over, and cleanup when the risk is high.
- Test migrations against realistic data volume, not only empty local databases.

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

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Transactions and Isolation Levels]]
- [[Areas/Cloud and Platform Engineering/_Index]]

## Review Schedule

- [ ] Review in 3 months
