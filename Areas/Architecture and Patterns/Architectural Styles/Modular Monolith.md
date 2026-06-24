# Modular Monolith
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #modular-monolith #monolith #distributed-systems

## TL;DR / Quick Reference

**Definition:** A modular monolith is a single deployable application with strong internal module boundaries, usually organized around business capabilities or bounded contexts.

**When to use:**
- When the domain needs clearer boundaries but the team does not yet need independent service deployment.
- When you want microservice-style modularity without distributed-system operational cost.

**Key Takeaways:**
- A modular monolith is often the best stepping stone before microservices.
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

## Related Concepts

- [[Monolith]]
- [[Microservices]]
- [[Service Based Architecture]]
- [[Clean Architecture]]
- [[Domain-Driven Design]]

## Review Schedule

- [ ] Review in 3 months