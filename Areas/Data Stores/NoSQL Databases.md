# NoSQL Databases
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #databases #nosql #distributed #data

## 🎯 TL;DR / Quick Reference

**Definition:** A category of non-relational databases optimized around specific data models such as document, key-value, or wide-column storage rather than a single relational-table approach.

**When to use:**
- Systems with high scale, flexible schemas, or access patterns that map poorly to relational joins and rigid schemas.
- Workloads where the chosen data model is more important than having one standardized query model across everything.

**Key Takeaways:**
- ✅ **Data-model specialization** can simplify certain workloads and scale patterns.
- ✅ **Horizontal scaling and operational flexibility** are common reasons to choose NoSQL systems.
- ⚠️ **Tradeoffs are product-specific**: consistency, transactions, querying, and tooling vary widely across NoSQL databases.

---

## 📚 Deep Dive

### What This Category Covers
NoSQL is not one thing. It is a grouping of database families that make different tradeoffs around schema, consistency, distribution, and query behavior.

### How To Choose Within This Category
- Start with the data model: document, key-value, wide-column, or graph.
- Match the database to the dominant access patterns rather than trying to force one store to fit every problem.
- Be explicit about consistency requirements, operational complexity, and how much query flexibility the system really needs.

### Child Notes
- [[MongoDB]] - Document database for flexible, aggregate-oriented application data.
- [[Cassandra]] - Wide-column distributed store for high-write, highly available workloads.
- [[Redis]] - In-memory key-value store often used for caching, fast lookup, messaging, and queue-like workloads.

## 🔗 Related Concepts
- [[Relational Databases]]
- [[Data Warehouses]]

## 🔄 Review Schedule
- [ ] Review in 3 months