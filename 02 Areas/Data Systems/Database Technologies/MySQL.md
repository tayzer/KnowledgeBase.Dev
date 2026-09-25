---
date: 2025-11-25
status: Current
tags:
  - mysql
  - rdbms
  - open-source

---

# MySQL

## Quick Reference
**Definition:** Open-source relational database supporting SQL and multiple storage engines; InnoDB is the default engine in MySQL 8.4.

**When to use:**
- OLTP workloads and web applications with common relational patterns.

**Key Takeaways:**
- **InnoDB** supports transactions, row-level locking, foreign keys, and crash recovery in MySQL 8.4.
- **Multiple storage engines:** InnoDB is the default transactional engine in MySQL 8.4 and provides ACID support.

**Limit:** MySQL behavior depends on storage engine, isolation, schema, and deployment topology.

---

## Operational decisions

MySQL 8.4 defaults to InnoDB, which supports transactions, foreign keys, and crash recovery. Isolation, replication, backup/recovery, and schema-change strategy still affect correctness. Test concurrent order checkout with real constraints.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]

## Resources

- [Primary documentation](https://dev.mysql.com/doc/refman/8.4/en/innodb-introduction.html) (accessed 2026-09-24).
- [InnoDB introduction](https://dev.mysql.com/doc/refman/8.4/en/innodb-introduction.html) (MySQL documentation; checked 2026-09-24).
- [MySQL docs](https://dev.mysql.com/doc/refman/8.4/en/) (accessed 2026-09-24).

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
