# Data Lakes
Date: 2026-06-23
Status: Needs Review
Tags: #data-lake #analytics #object-storage #data-platform

## TL;DR / Quick Reference

**Definition:** A data lake stores large volumes of raw, semi-processed, and curated data, commonly on object storage, for analytics, machine learning, and downstream processing.

**When to use:**
- When multiple producers need to land data before it is modeled for analytics.
- When retaining raw history, semi-structured files, logs, events, or large analytical datasets matters.

**Key Takeaways:**
- A data lake is a storage and governance pattern, not just a bucket full of files.
- Without ownership, cataloging, quality checks, and lifecycle rules, a lake can become hard to trust.
- Warehouses and lakes often complement each other: raw and broad data in the lake, curated business models in the warehouse.

---

## Deep Dive

### Choose A Data Lake When

- You need to keep raw source data for replay, audit, or future analysis.
- Data arrives in many formats or from many producers.
- Analytical processing can happen in batches or pipelines before serving users.
- Object storage cost and scale are useful for the workload.

### Be Careful When

- Users need governed, consistent business metrics immediately.
- There is no plan for cataloging, ownership, security, retention, or quality.
- Teams treat the lake as a dumping ground rather than a managed data product.

### Design Questions

- What zones exist: raw, staged, curated, trusted, or presentation-ready?
- How are datasets cataloged and discovered?
- Who owns schema, quality, retention, and access?
- What file formats and partitioning strategy support common queries?
- How does data move into warehouses, marts, or downstream services?

## Related Concepts

- [[Data Warehouses]]
- [[Cloud Storage Services]]
- [[Data Modeling]]
- [[Google BigQuery]]
- [[Snowflake]]

## Review Schedule

- [ ] Review in 3 months