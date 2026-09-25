---
date: 2025-11-25
status: Current
tags:
  - postgresql
  - rdbms
  - sql

---

# PostgreSQL

## Quick Reference

**Definition:** An open-source object-relational database with SQL, extensibility, multiple index methods, and release-specific transactional behavior.

**When to use:**
- Feature-rich relational workloads, GIS (PostGIS), and complex queries.

**Key Takeaways:**
- **Rich feature set** (window functions, JSONB, extensions).
- Tip: **Extensible**: custom types, functions, and indexing.

**Limit:** Indexing, vacuum, backup, and extensions need release-specific operational choices.

---

## Deep Dive

### Best Practices
- Use `EXPLAIN` to analyze queries, and choose appropriate indexes and vacuuming strategies.

---

## Operations and selection

For PostgreSQL 18, inspect EXPLAIN (ANALYZE, BUFFERS) before adding an index. Routine vacuum handles dead tuples; WAL supports crash recovery and configured point-in-time recovery. PostGIS is an extension, not installed everywhere.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]

## Resources

- [Primary documentation](https://www.postgresql.org/docs/18/routine-vacuuming.html) (accessed 2026-09-24).
- [PostgreSQL docs](https://www.postgresql.org/docs/18/) (accessed 2026-09-24).

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
