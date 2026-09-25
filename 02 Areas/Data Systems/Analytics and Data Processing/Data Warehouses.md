---
date: 2026-06-23
status: Current
tags:
  - datawarehouse
  - analytics
  - bi
  - data

---

# Data Warehouses

## Quick Reference
**Definition:** Data platforms primarily designed for analytical queries over integrated datasets; transactional capabilities vary by product.

**When to use:**
- Business intelligence, dashboards, reporting, trend analysis, and cross-domain analytics.
- Workloads where read-heavy analytical queries matter more than OLTP-style writes.

**Key Takeaways:**
- Warehouses primarily serve analytics; assess product-specific transactional features before using one for application writes.
- Ingestion, modeling, governance, query cost, and freshness are central design concerns.
- Data lakes and warehouses often work together: lakes store raw or semi-processed data, warehouses serve curated analytical models.

**Limit:** Transactional and freshness capabilities vary by warehouse and ingestion design.

---

## Deep Dive

### Choose A Warehouse When

- Users need SQL analytics across historical or integrated datasets.
- Query performance and concurrency matter for reports or dashboards.
- Data should be modeled into facts, dimensions, marts, or curated business-friendly shapes.

### Be Careful When

- The workload needs strict transactional consistency for application writes.
- The selected product or pipeline cannot meet the required ingest-to-query freshness or write latency.
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

## Freshness and cost example

For a five-minute dashboard, measure source-to-ingest, transform, and query delay separately. Streaming ingestion does not guarantee an end-to-end SLA. Test query concurrency and compare on-demand scan pricing with capacity pricing.

## Sources

- [Primary documentation](https://docs.cloud.google.com/bigquery/docs/introduction) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Cloud Storage Services]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
