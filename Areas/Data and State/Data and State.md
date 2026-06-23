# Data and State
Date: 2026-06-23
Status: Needs Review
Tags: #taxonomy #data #state #persistence

## TL;DR / Quick Reference

**Definition:** Hub for data modeling, persistence, storage systems, data access, consistency, and state-management tradeoffs.

**When to use:**
- When deciding where application data should live and how it should be queried, changed, cached, distributed, or analyzed.
- When choosing between relational databases, NoSQL stores, object storage, data warehouses, and data-access patterns.

**Key Takeaways:**
- Data choices should start from access patterns, consistency needs, lifecycle, and operational constraints.
- Use this area for data modeling, persistence, query design, storage systems, and data tradeoffs.
- Keep hosting, deployment, and runtime operations in Cloud and Delivery or Operations and Reliability, then link back here when the data shape drives the decision.

---

## Deep Dive

### Decision Paths

| Question | Start here | Good next notes |
| --- | --- | --- |
| Do I need structured transactional data? | [[Relational Databases]] | [[Data Modeling]], [[SQL Joins and Indexes]], [[Transactions and Isolation Levels]] |
| Do I need flexible or specialized non-relational storage? | [[NoSQL Databases]] | [[Consistency Models]], [[Replication and Partitioning]], [[MongoDB]], [[Cassandra]], [[Redis]] |
| Do I need durable file or object storage? | [[Cloud Storage Services]] | [[Amazon S3]], [[Azure Blob Storage]], [[Google Cloud Storage]] |
| Do I need analytics, reporting, or historical query workloads? | [[Data Warehouses]] | [[Data Lakes]], [[Amazon Redshift]], [[Google BigQuery]], [[Snowflake]] |
| Do I need to evolve a database safely? | [[Schema Migrations]] | [[Data Modeling]], [[Transactions and Isolation Levels]] |
| Do I need to tune application data access? | [[Data Access]] | [[QueryOptimisations]], [[MemoryAllocations]], [[Linq]] |

### Folder Map

- `Relational Databases/` - SQL, transactions, query tuning, and relational engines.
- `NoSQL Databases/` - document, key-value, wide-column, cache, and specialized non-relational stores.
- `Object Storage/` - cloud object storage and unstructured data storage.
- `Analytics and Warehousing/` - warehouses, data lakes, and analytical platforms.
- `Data Access/` - ORM and application data-access patterns.
- `Data Modeling/` - modeling techniques and data-shape decisions.
- `Data Evolution/` - schema migration and data-change practices.
- `Distributed Data/` - consistency, replication, partitioning, and distributed-storage tradeoffs.

### Placement Rule

If the main question is "where should data live or how should it be shaped?", put the note here. If the main question is "how do I deploy or operate the service?", put it under Cloud and Delivery or Operations and Reliability and link back to the relevant data note.

## Related Concepts

- [[Architecture and Patterns]]
- [[Cloud and Delivery]]
- [[Operations and Reliability]]
- [[Testing and Quality]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## Review Schedule

- [ ] Review in 3 months