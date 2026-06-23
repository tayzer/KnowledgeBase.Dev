# Data Warehouses
Date: 2026-06-23
Status: Needs Review
Tags: #datawarehouse #analytics #bi #data

## TL;DR / Quick Reference

**Definition:** Data platforms optimized for analytical queries over integrated datasets rather than low-latency transactional application writes.

**When to use:**
- Business intelligence, dashboards, reporting, trend analysis, and cross-domain analytics.
- Workloads where read-heavy analytical queries matter more than OLTP-style writes.

**Key Takeaways:**
- Warehouses answer business and analytical questions; they should not be treated as primary transactional stores.
- Ingestion, modeling, governance, query cost, and freshness are central design concerns.
- Data lakes and warehouses often work together: lakes store raw or semi-processed data, warehouses serve curated analytical models.

---

## Deep Dive

### Choose A Warehouse When

- Users need SQL analytics across historical or integrated datasets.
- Query performance and concurrency matter for reports or dashboards.
- Data should be modeled into facts, dimensions, marts, or curated business-friendly shapes.

### Be Careful When

- The workload needs strict transactional consistency for application writes.
- The data freshness requirement is truly real-time and latency-sensitive.
- Costs are hard to predict because query patterns are exploratory or uncontrolled.

### Design Questions

- What data is raw, staged, curated, or presentation-ready?
- How fresh does each dataset need to be?
- Who owns definitions for metrics and dimensions?
- How are access controls, lineage, retention, and cost monitored?

### Child Notes

- [[Data Lakes]] - durable raw and semi-processed analytical storage.
- [[Amazon Redshift]] - AWS-focused warehouse optimized for analytical workloads inside the AWS ecosystem.
- [[Google BigQuery]] - serverless GCP warehouse designed for large-scale SQL analytics.
- [[Snowflake]] - cloud-native warehouse with strong separation of compute and storage and broad platform flexibility.

## Related Concepts

- [[Relational Databases]]
- [[Cloud Storage Services]]
- [[Data Modeling]]

## Review Schedule

- [ ] Review in 3 months