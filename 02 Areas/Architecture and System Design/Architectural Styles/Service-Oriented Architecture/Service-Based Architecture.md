---
date: 2026-04-30
status: Current
tags:
  - architecture
  - service-based-architecture
  - distributed
  - design

---

# Service-Based Architecture

## Quick Reference

**Definition:** In this note, a service-based architecture organizes a system into a modest number of business services with explicit contracts. The exact number, deployment autonomy, and data ownership are design choices, not defining thresholds.

**When to use:**
- Medium-to-large systems that need clearer service boundaries without the full operational overhead of microservices.
- Teams that want modular ownership and separation of concerns while keeping deployment and data management relatively simple.

**Key Takeaways:**
- **Clearer service boundaries** can improve ownership when contracts and data access are enforced.
- **Coarser-grained services** may need fewer deployments, but actual cost depends on release and hosting design.
- Caution: **Shared deployment or shared data** can preserve coupling if service boundaries are not enforced carefully.

---

## Deep Dive

### Position On The Spectrum
Some authors present service-based architecture between a monolith and microservices on a granularity spectrum; this is a comparison aid, not a universal taxonomy.

- Compared with an unmodular monolith, separate services can make boundaries more explicit.
- Compared with finer-grained microservice deployments, it may use fewer coarser services and a smaller operational platform.

### Good Fit
- Applications that have multiple business capabilities but are not yet large enough to justify a full microservice platform.
- Teams that want clearer contracts between components.
- Systems where deployment simplicity still matters more than full service independence.

### Common Tradeoffs
- Shared databases can make service boundaries feel cleaner on paper than they are in practice.
- Coordinated releases are often simpler than in microservices, but they reduce independence.
- Service communication still needs explicit contracts, versioning discipline, and failure handling.

### Boundary and example

“Service-based” is used here as an editorial distinction for a small set of coarse business services, often deployed separately; neither a service count nor a shared database is a defining rule. For example, `Orders` and `Billing` can deploy separately while still coordinating releases around a shared schema. If each owns its data and contract, release independence is more plausible, with integration costs. Compare this with broader SOA integration concerns and finer-grained microservice deployments; treat the terms as overlapping conventions. Source for a universal service-based taxonomy remains unresolved.

## Related Concepts
- [[Monolith]]
- [[Modular Monolith]]
- [[Microservices]]
- [[Service-Oriented Architecture]]
- [[Distributed Monolith]]

## Sources

- [Microsoft, Microservices architecture style](https://learn.microsoft.com/en-us/azure/architecture/microservices/) — last updated 2025-07-11; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 3 months
