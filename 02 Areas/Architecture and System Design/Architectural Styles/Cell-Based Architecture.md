---
date: 2026-06-23
status: Current
tags:
  - architecture
  - cell-based-architecture
  - resilience
  - distributed-systems

---

# Cell-Based Architecture

## Quick Reference

**Definition:** Cell-based architecture partitions a system into isolated cells, where each cell owns enough compute and data for an assigned slice of traffic; shared control-plane and global dependencies can remain.

**When to use:**
- Large-scale platforms that need blast-radius reduction, tenant isolation, regional isolation, or controlled horizontal growth.
- Systems where failures should affect one cell rather than the entire platform.

**Key Takeaways:**
- Cells can reduce blast radius when serving paths and failure-prone dependencies remain isolated; shared services can restore a common failure domain.
- The architecture trades infrastructure duplication and routing complexity for isolation and resilience.
- Cell boundaries must include data ownership, deployment, observability, and failover strategy.

---

## Deep Dive

### Good Fit

- Multi-tenant SaaS platforms.
- Large consumer platforms with strong isolation needs.
- Systems where one tenant or region must not overload the entire estate.

### Be Careful When

- The platform is not yet large enough to justify duplicated infrastructure.
- Cross-cell workflows dominate the system.
- Routing, provisioning, migration, and observability are not automated.

### Design Questions

- What is the cell key: tenant, region, account, user cohort, or workload class?
- What services and data must exist inside each cell?
- What global control-plane services remain shared?
- How are tenants moved between cells?
- How is cell health routed around during failure?

### Example cell boundary

Assign each tenant to a stable cell key and route requests through a mapping service. Keep tenant writes and the serving data inside that cell; keep shared authentication or provisioning outside only after assessing its failure impact. Moving a tenant requires a data-copy and cutover plan with reconciliation. If a cell fails, route only to a replica with current data and sufficient capacity; routing alone is not failover. [AWS cell guidance](https://docs.aws.amazon.com/pdfs/wellarchitected/latest/reducing-scope-of-impact-with-cell-based-architecture/reducing-scope-of-impact-with-cell-based-architecture.pdf) (published 2023-09-20; checked 2026-09-24).

## Related Concepts

- [[Microservices]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Replication and Partitioning/_Index]]
- [[Consistency Models]]
- [[40 Knowledge/Software Engineering/02 Areas/Reliability and Operations/_Index]]
- [[Service Mesh]]

## Sources

- [AWS, Reducing the Scope of Impact with Cell-Based Architecture](https://docs.aws.amazon.com/pdfs/wellarchitected/latest/reducing-scope-of-impact-with-cell-based-architecture/reducing-scope-of-impact-with-cell-based-architecture.pdf) — published 2023-09-20; accessed 2026-09-24.
- [Microsoft, Bulkhead pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/bulkhead) — online page, date not shown; accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
