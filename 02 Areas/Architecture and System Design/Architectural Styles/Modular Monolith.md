---
date: 2026-06-23
status: Current
tags:
  - architecture
  - modular-monolith
  - monolith
  - distributed-systems

---

# Modular Monolith

## Quick Reference

**Definition:** A modular monolith is a single deployable application with strong internal module boundaries, usually organized around business capabilities or bounded contexts.

**When to use:**
- When the domain needs clearer boundaries but the team does not yet need independent service deployment.
- When you want microservice-style modularity without distributed-system operational cost.

**Key Takeaways:**
- A modular monolith is a possible stepping stone before microservices.
- Module boundaries should be enforced through code structure, dependency rules, and data ownership conventions.
- If modules freely share internals and database tables, the system becomes an ordinary tightly coupled monolith.

---

## Deep Dive

### Good Fit

- Small to medium teams that need fast delivery and simple deployment.
- Domains with separable capabilities but limited operational maturity.
- Systems where most workflows still benefit from local transactions and in-process calls.

### Design Guidance

- Organize modules around business capabilities, not technical layers alone.
- Keep module APIs explicit and avoid direct access to another module's internals.
- Use tests or fitness functions to prevent dependency drift.
- Treat module boundaries as candidates for future service extraction, not a promise that every module will become a service.

### Tradeoffs

- Simpler deployment and debugging than microservices.
- Less independent scaling and technology choice than microservices.
- Requires discipline because the compiler and runtime will not automatically enforce all architectural boundaries.

### Enforcing a module boundary

For `Orders` and `Billing`, expose a small public application API from each module. Reject imports of the other's internal types in architecture tests; mediate cross-module calls through that API. A single database may remain, but limit direct table access across modules if ownership matters. Extracting a service later is an option, not a promise. [Microsoft common architectures](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures) (updated 2023-03-07; checked 2026-09-24).

## Related Concepts

- [[Monolith]]
- [[Microservices]]
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Architectural Styles/_Index]]
- [[Clean Architecture]]
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Domain-Driven Design/_Index]]

## Sources

- [Microsoft, Common web application architectures](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures) — last updated 2023-03-07; accessed 2026-09-24.
- [Microsoft, Microservices architecture style](https://learn.microsoft.com/en-us/azure/architecture/microservices/) — last updated 2025-07-11; accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
