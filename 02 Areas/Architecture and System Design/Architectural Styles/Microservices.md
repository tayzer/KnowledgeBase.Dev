---
date: 2026-04-30
status: Current
tags:
  - microservices
  - architecture
  - distributed

---

# Microservices

## Quick Reference
**Definition:** An architectural style that organizes an application as independently deployable services around business capabilities.

**When to use:**
- Large, complex domains needing independent deployment and scaling of components.
- Organizations that can support stronger platform, observability, deployment, and operational maturity.

**Key Takeaways:**
- **Independent deployability** and team autonomy.
- **Clear service boundaries** can help align systems with business capabilities.
- **Operational complexity:** monitoring, deployment, and data consistency can be challenging.

---

## Deep Dive
### What Microservices Optimize For
Microservices trade simplicity for organizational and operational independence. The goal is not "many small services" by itself, but the ability to evolve parts of a system independently when the domain, team structure, and delivery model justify the cost.

### Good Fit
- Large domains with distinct business capabilities that evolve at different speeds.
- Organizations that want independent deployment and ownership boundaries across teams.
- Systems where different components genuinely need different scaling, runtime, or release cadences.

### Common Tradeoffs
- Every service boundary introduces more operational work: deployment pipelines, tracing, alerting, resilience, and contract management.
- Data consistency gets harder once a workflow crosses service boundaries.
- Shared libraries, shared schemas, or coordinated releases can quietly recreate monolith-style coupling.
- Shared databases often weaken service boundaries because they centralize ownership and couple change across services.

### Design Guidance
- Start from business capabilities and bounded contexts, not from technical layers.
- Keep service contracts explicit and versioned.
- Prefer automation and observability early; microservices without platform maturity usually amplify pain instead of reducing it.
- Be deliberate about synchronous versus asynchronous communication and where eventual consistency is acceptable.

### Contract and failure example

Split a capability only when its team can own a stable contract, data, deployment, and operations. For an order service calling inventory, define a timeout and a failure response; repeated synchronous calls can couple releases and availability even when binaries deploy separately. A migration can start by isolating a module and its data access, then expose a versioned contract and move consumers gradually. Independent scaling and team autonomy are potential outcomes, not inherent properties. [Microsoft microservices guidance](https://learn.microsoft.com/en-us/azure/architecture/microservices/) (updated 2025-07-11; checked 2026-09-24).

## Related Concepts
- [[Monolith]]
- [[Modular Monolith]]
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Architectural Styles/_Index]]
- [[Service-Oriented Architecture]]
- [[Service Communication]]
- [[Message-Driven Architecture]]
- [[Saga Pattern]]
- [[API Gateway Pattern]]
- [[Service Mesh]]
- [[Distributed Monolith]]

## Resources
- Martin Fowler: Microservices
- Microsoft Docs: .NET microservices architecture guidance

## Practice Exercises
1. Compare one existing application workflow as a monolith, service-based architecture, and microservices design. List what complexity changes in each version.
2. Pick a candidate service boundary and identify the contracts, data ownership, and failure modes it would introduce.

## Sources

- [Microsoft, Microservices architecture style](https://learn.microsoft.com/en-us/azure/architecture/microservices/) — last updated 2025-07-11; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 3 months
