# Distributed Monolith
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #anti-patterns #distributed-monolith #microservices

## TL;DR / Quick Reference

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

## Related Concepts

- [[Microservices]]
- [[Service Based Architecture]]
- [[Modular Monolith]]
- [[ServiceCommunication]]
- [[API Versioning]]

## Review Schedule

- [ ] Review in 3 months