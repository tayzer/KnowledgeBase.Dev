# Data Access
Date: 2026-06-23
Status: Needs Review
Tags: #data-access #orm #persistence #application-architecture

## TL;DR / Quick Reference

**Definition:** Application-layer techniques for reading and writing persistent data through repositories, query objects, ORMs, SQL clients, or service adapters.

**When to use:**
- When deciding how application code should talk to a database or storage service.
- When tuning ORM queries, reducing coupling to infrastructure, or separating domain logic from persistence details.

**Key Takeaways:**
- Data access should make common persistence paths clear without hiding important query and transaction behavior.
- ORMs improve productivity but can obscure SQL, loading behavior, allocations, and transaction boundaries.
- Keep domain rules and persistence mechanics separate enough to test and evolve, but avoid abstraction layers that add ceremony without flexibility.

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

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[SQL Joins and Indexes]]
- [[Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern]]
- [[Areas/Data Systems/Data Access/Unit of Work]]
- [[Linq]]

## Review Schedule

- [ ] Review in 3 months
