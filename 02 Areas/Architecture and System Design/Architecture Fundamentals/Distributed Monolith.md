---
date: 2026-06-23
status: Current
tags:
  - architecture
  - anti-patterns
  - distributed-monolith
  - microservices

---

# Distributed Monolith

## Quick Reference

**Definition:** A distributed monolith is a system split into multiple deployables but still tightly coupled in data, release cadence, runtime behavior, or ownership.

**When to use:**
- As a diagnostic label when a microservice or service-based system has distributed-system costs without meaningful independence.
- When assessing whether service boundaries are helping or making delivery worse.

**Key Takeaways:**
- A distributed monolith has the operational pain of distributed systems and the coupling of a monolith.
- Common symptoms include shared databases, lockstep deployments, chatty synchronous calls, and unclear ownership.
- Fixing it usually means improving boundaries, contracts, data ownership, and deployment independence, not simply creating more services.

---

## Deep Dive

### Common Symptoms

- Services must be deployed together for most changes.
- One service reaches into another service's database tables.
- A user request requires many sequential synchronous service calls.
- Contract changes break multiple consumers at once.
- Teams cannot change their service without coordinating broadly.
- Failures cascade because every service assumes every dependency is healthy.

### Causes

- Splitting by technical layer rather than business capability.
- Extracting services before understanding domain boundaries.
- Sharing schemas, libraries, or models too aggressively.
- Missing observability, contract testing, and deployment automation.

### Improvement Paths

- Reclaim ownership of data and contracts.
- Convert chatty synchronous flows into coarser APIs or asynchronous workflows.
- Add backward-compatible contract versioning.
- Use a modular monolith when distribution is adding cost without benefit.

### Diagnostic path

Look for synchronized releases, transitive request chains, shared-schema changes, and outages that propagate across nominally separate services. Measure change lead time and correlated failures before calling the system a distributed monolith; these symptoms are indicators, not proof. Options include reducing synchronous coupling, giving services data ownership, or reuniting tightly coupled parts in one deployable. [Microsoft microservices guidance](https://learn.microsoft.com/en-us/azure/architecture/microservices/) (checked 2026-09-24).

## Related Concepts

- [[Microservices]]
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Architectural Styles/_Index]]
- [[Modular Monolith]]
- [[Service Communication]]
- [[API Versioning]]

## Sources

- [Microsoft, Microservices architecture style](https://learn.microsoft.com/en-us/azure/architecture/microservices/) — last updated 2025-07-11; accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
