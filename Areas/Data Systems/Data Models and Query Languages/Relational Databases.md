# Relational Databases
Date: 2026-06-23
Status: Needs Review
Tags: #databases #relational #sql #data

## TL;DR / Quick Reference

**Definition:** Databases that organize data into tables, relationships, constraints, and SQL queries, usually with strong transactional guarantees.

**When to use:**
- Business systems that need correctness, constraints, joins, reporting, and mature operational tooling.
- Workloads where data integrity and query flexibility matter more than schema looseness.

**Key Takeaways:**
- Relational databases are a strong default for many transactional applications.
- Schema design, indexing, transactions, and migration discipline matter as much as the engine choice.
- They can scale far, but highly distributed workloads may expose tradeoffs around latency, availability, and operational complexity.

---

## Deep Dive

### Choose Relational When

- The domain has clear entities, relationships, and invariants.
- You need transactions across related changes.
- You need ad hoc querying, joins, reporting, or mature SQL tooling.
- You want constraints to protect data integrity close to storage.

### Be Careful When

- The data model is extremely fluid and mostly aggregate-shaped.
- The workload is globally distributed with low-latency writes in many regions.
- The system needs simple key-value access at very high scale more than rich querying.

### Core Topics

- [[Areas/Data Systems/Data Models and Query Languages/_Index]] - choosing tables, keys, aggregates, constraints, and boundaries.
- [[SQL Joins and Indexes]] - practical query and indexing fundamentals.
- [[Transactions and Isolation Levels]] - consistency guarantees and concurrency tradeoffs.
- [[Schema Migrations]] - evolving relational schemas safely.

### Child Notes

- [[MySQL]] - common default for straightforward web applications and transactional workloads.
- [[PostgreSQL]] - feature-rich and extensible option for teams that want strong SQL support and advanced capabilities.
- [[Oracle]] - enterprise-oriented commercial platform with mature governance and operational features.

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Data Warehouses]]
- [[Data Access]]
- [[Consistency Models]]

## Review Schedule

- [ ] Review in 3 months
