---
date: 2026-06-23
status: Current
tags:
  - databases
  - nosql
  - distributed
  - data

---

# NoSQL Databases

## Quick Reference

**Definition:** Non-relational databases optimized around specific data models such as document, key-value, wide-column, graph, or in-memory storage.

**When to use:**
- Systems where the dominant access pattern maps poorly to relational tables and joins.
- Workloads that need flexible schemas, horizontal distribution, high write throughput, or specialized lookup behavior.

**Key Takeaways:**
- NoSQL is a family of tradeoffs, not one replacement for SQL.
- Choose by access pattern and consistency needs before choosing by product name.
- Query flexibility, transaction support, indexing, consistency, and operations vary widely by system.

**Limit:** NoSQL products differ in transactions, consistency, indexing, and operations; evaluate a specific product.

---

## Deep Dive

### Choose NoSQL When

- Data is naturally aggregate-shaped, document-shaped, or key-value-shaped.
- The system primarily reads and writes by known keys or predefined access patterns.
- Horizontal scaling, availability, or write throughput is more important than relational joins.

### Be Careful When

- You need ad hoc analytical SQL across many relationships.
- The selected product cannot meet the required multi-entity transaction and constraint semantics at acceptable cost.
- The team is choosing NoSQL only to avoid schema design.

### Common Families

| Family | Good fit | Example notes |
| --- | --- | --- |
| Document | Aggregate-oriented records and flexible nested data | [[MongoDB]] |
| Wide-column | High-write distributed workloads with planned query patterns | [[Cassandra]] |
| Key-value / in-memory | Fast lookup, caching, counters, and ephemeral state | [[Redis]] |
| Graph | Relationship traversal and network-shaped data | Gap: add a graph database note when needed |

### Core Topics

- [[Consistency Models]] - how reads and writes become visible.
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Replication and Partitioning/_Index]] - how data is copied and split across nodes.
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]] - modeling around access patterns instead of only entities.

## Family comparison

MongoDB document models support multi-document transactions. Redis key and data-structure access depends on persistence and eviction settings. Cassandra wide-column tables are modeled around partition-key queries. NoSQL alone predicts none of these guarantees.

## Sources

- [Primary documentation](https://www.mongodb.com/docs/manual/core/transactions/) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Data Warehouses]]
- [[Cloud Storage Services]]
- [[Caching Strategies]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
