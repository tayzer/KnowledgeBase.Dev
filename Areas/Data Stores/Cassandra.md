# Cassandra
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #cassandra #nosql #wide-column #distributed

## 🎯 TL;DR / Quick Reference

**Definition:** A distributed wide-column NoSQL database built for high availability, horizontal scale, and write-heavy workloads across multiple nodes or regions.

**When to use:**
- High-write, high-availability systems where scaling across nodes is a core requirement.
- Workloads such as event, telemetry, time-series, or large distributed data sets that are modeled around known query patterns.

**Key Takeaways:**
- ✅ **Horizontal scale and availability** are core strengths of Cassandra.
- ✅ **Tunable consistency** lets teams choose tradeoffs per workload.
- ⚠️ **Query-first data modeling is mandatory**: poor partition-key and access-pattern decisions are expensive to fix later.

---

## 📚 Deep Dive

### Good Fit
Cassandra is often used for write-heavy operational data, append-heavy event streams, and systems that must tolerate node or regional failures.

### Design Considerations
- Model tables around known queries rather than around a normalized relational schema.
- Choose partition keys carefully to avoid hot partitions and uneven distribution.
- Be explicit about consistency, repair, compaction, and operational complexity.

## 🔗 Related Concepts
- [[NoSQL Databases]]
- [[Relational Databases]]

## 🔄 Review Schedule
- [ ] Review in 3 months
