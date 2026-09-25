---
date: 2025-11-25
status: Current
tags:
  - datawarehouse
  - redshift
  - aws

---

# Amazon Redshift

## Quick Reference

**Definition:** AWS managed data warehouse optimized for analytic workloads over large datasets.

**When to use:**
- Large-scale analytics when tight integration with AWS ecosystem is desired.

**Key Takeaways:**
- **Columnar storage** and MPP architecture for high-performance analytics.
- Tip: **Costs & maintenance:** Provisioning and tuning may be required for optimal performance.

**Limit:** AUTO optimization and Serverless reduce but do not remove workload-specific tuning and cost checks.

---

## Deep Dive

### Tips
- Review AUTO distribution and sort choices and measured query plans before manual keys.

---

## AUTO and workload cost

Redshift can choose distribution and sort styles automatically. Inspect query plans and skew before overriding AUTO. Compare provisioned capacity with Serverless billing for the actual workload.

## Related Concepts
- [[Data Warehouses]]

## Resources

- [Primary documentation](https://docs.aws.amazon.com/redshift/latest/dg/c_choosing_dist_sort.html) (accessed 2026-09-24).
- [Amazon Redshift docs](https://docs.aws.amazon.com/redshift/) (accessed 2026-09-24).

## Practice Exercises
1. Design a schema optimized for star schema analytics in Redshift.

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
