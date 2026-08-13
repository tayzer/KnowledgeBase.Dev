# NoSQL Databases
Date: 2026-06-23
Status: Needs Review
Tags: #databases #nosql #distributed #data

## TL;DR / Quick Reference

**Definition:** Non-relational databases optimized around specific data models such as document, key-value, wide-column, graph, or in-memory storage.

**When to use:**
- Systems where the dominant access pattern maps poorly to relational tables and joins.
- Workloads that need flexible schemas, horizontal distribution, high write throughput, or specialized lookup behavior.

**Key Takeaways:**
- NoSQL is a family of tradeoffs, not one replacement for SQL.
- Choose by access pattern and consistency needs before choosing by product name.
- Query flexibility, transaction support, indexing, consistency, and operations vary widely by system.

---

## Deep Dive

### Choose NoSQL When

- Data is naturally aggregate-shaped, document-shaped, or key-value-shaped.
- The system primarily reads and writes by known keys or predefined access patterns.
- Horizontal scaling, availability, or write throughput is more important than relational joins.

### Be Careful When

- You need ad hoc analytical SQL across many relationships.
- You need multi-entity transactional invariants and strong constraints.
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
- [[Areas/Data Systems/Replication and Partitioning/_Index]] - how data is copied and split across nodes.
- [[Areas/Data Systems/Data Models and Query Languages/_Index]] - modeling around access patterns instead of only entities.

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Data Warehouses]]
- [[Cloud Storage Services]]
- [[Caching Strategies]]

## Review Schedule

- [ ] Review in 3 months
