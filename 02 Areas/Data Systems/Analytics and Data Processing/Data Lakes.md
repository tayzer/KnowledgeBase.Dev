---
date: 2026-06-23
status: Current
tags:
  - data-lake
  - analytics
  - object-storage
  - data-platform

---

# Data Lakes

## Quick Reference
**Definition:** A data lake stores large volumes of raw, semi-processed, and curated data, commonly on object storage, for analytics, machine learning, and downstream processing.

**When to use:**
- When multiple producers need to land data before it is modeled for analytics.
- When retaining raw history, semi-structured files, logs, events, or large analytical datasets matters.

**Key Takeaways:**
- A data lake is a storage and governance pattern, not just a bucket full of files.
- Without ownership, cataloging, quality checks, and lifecycle rules, a lake can become hard to trust.
- Warehouses and lakes often complement each other: raw and broad data in the lake, curated business models in the warehouse.

**Limit:** A lake needs catalog, quality, ownership, and access controls; object storage alone is not governed data.

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

## Ingestion and replay example

Land an orders feed with source ID, ingestion time, and schema version; catalog it, validate it, quarantine errors, then publish curated data. Assign schema, access, quality, and retention owners. Retained raw data enables reprocessing; audit use also needs access and immutability controls.

## Sources

- [Primary documentation](https://docs.aws.amazon.com/whitepapers/latest/building-data-lakes/building-data-lake-aws.html) (accessed 2026-09-24).

## Related Concepts

- [[Data Warehouses]]
- [[Cloud Storage Services]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Google BigQuery]]
- [[Snowflake]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
