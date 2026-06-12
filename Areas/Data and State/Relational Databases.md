# Relational Databases
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #databases #relational #sql #data

## 🎯 TL;DR / Quick Reference

**Definition:** A category of databases that store data in related tables and usually use SQL, schema design, and transactional guarantees to manage consistency.

**When to use:**
- Transactional systems that need strong consistency and well-defined relationships.
- Applications that depend on structured querying, joins, reporting, or mature operational tooling.

**Key Takeaways:**
- ✅ **Strong consistency and data integrity** make relational databases a default choice for many business systems.
- ✅ **SQL and mature tooling** support complex querying, administration, and reporting.
- ⚠️ **Schema and scale tradeoffs** mean they are not always the best fit for rapidly changing or highly distributed workloads.

---

## 📚 Deep Dive

### What This Category Covers
Relational databases are best known for tables, relationships, schema management, and transactional guarantees. They are a strong fit for operational systems where correctness, consistency, and query flexibility matter more than schema looseness.

### How To Choose Within This Category
- Choose based on operational model: self-hosted versus managed service, ecosystem fit, and licensing constraints.
- Choose based on feature depth: extensions, indexing, JSON support, replication, and analytics needs.
- Choose based on workload shape: OLTP-heavy applications, mixed transactional/reporting, or enterprise-grade requirements.

### Child Notes
- [[MySQL]] - Common default for straightforward web applications and transactional workloads.
- [[PostgreSQL]] - Feature-rich and extensible option for teams that want strong SQL support and advanced capabilities.
- [[Oracle]] - Enterprise-oriented commercial platform with mature governance and operational features.

## 🔗 Related Concepts
- [[NoSQL Databases]]
- [[Data Warehouses]]

## 🔄 Review Schedule
- [ ] Review in 3 months