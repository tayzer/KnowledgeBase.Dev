# Cell-Based Architecture
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #cell-based-architecture #resilience #distributed-systems

## TL;DR / Quick Reference

**Definition:** Cell-based architecture partitions a system into isolated cells, where each cell contains the services and data needed to serve a subset of users, tenants, or traffic.

**When to use:**
- Large-scale platforms that need blast-radius reduction, tenant isolation, regional isolation, or controlled horizontal growth.
- Systems where failures should affect one cell rather than the entire platform.

**Key Takeaways:**
- Cells reduce blast radius by duplicating a slice of the platform and routing users or tenants to a cell.
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

## Related Concepts

- [[Microservices]]
- [[Replication and Partitioning]]
- [[Consistency Models]]
- [[Operations and Reliability]]
- [[Service Mesh]]

## Review Schedule

- [ ] Review in 3 months