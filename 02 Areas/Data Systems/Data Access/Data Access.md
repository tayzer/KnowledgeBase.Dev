---
date: 2026-06-23
status: Current
tags:
  - data-access
  - orm
  - persistence
  - application-architecture

---

# Data Access

## Quick Reference

**Definition:** Application-layer techniques for reading and writing persistent data through repositories, query objects, ORMs, SQL clients, or service adapters.

**When to use:**
- When deciding how application code should talk to a database or storage service.
- When tuning ORM queries, reducing coupling to infrastructure, or separating domain logic from persistence details.

**Key Takeaways:**
- Data access should make common persistence paths clear without hiding important query and transaction behavior.
- ORMs can reduce repetitive mapping work but can obscure SQL, loading behavior, allocations, and transaction boundaries.
- Keep domain rules and persistence mechanics separate enough to test and evolve, but avoid abstraction layers that add ceremony without flexibility.

**Limit:** Abstractions can hide query and transaction behavior; inspect actual SQL and ownership.

---

## Deep Dive

### Common Choices

| Approach | Best fit | Watch out for |
| --- | --- | --- |
| Direct SQL | Precise control, reporting queries, performance-sensitive paths | Duplication, mapping boilerplate, SQL scattered through code |
| ORM | CRUD-heavy applications and domain models with relational persistence | N+1 queries, accidental tracking, unclear transaction boundaries |
| Repository | Protecting domain/application code from infrastructure details | Over-generic abstractions that hide useful query capabilities |
| Query object/specification | Reusable business queries and composable filters | Complexity if every query becomes a framework |

### Entity Framework Notes

- [[QueryOptimisations]] - efficient EF query shape, loading, and translation.
- [[MemoryAllocations]] - reducing tracking and allocation overhead.

## Access boundary choice

A scoped EF Core DbContext can be used directly in an application service. Inspect generated SQL for slow queries and use direct SQL where query shape warrants it. Add a repository only for a meaningful domain contract. One SaveChanges call differs from several writes coordinated by an explicit transaction.

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/ef/core/saving/transactions) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[SQL Joins and Indexes]]
- [[Repository Pattern]]
- [[Unit of Work]]
- [[LINQ|LINQ]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
