---
date: 2026-04-30
status: Current
tags:
  - architecture
  - clean-architecture
  - design

---

# Clean Architecture

## Quick Reference

**Definition:** An approach to structure applications so that source-code dependencies point inward toward business policies, keeping frameworks and UI at the edge. This can improve testability and maintainability when the boundaries are enforced.

**When to use:**
- Applications requiring clear separation between domain, application, and infrastructure layers.
- Systems where long-term maintainability, testability, and framework independence matter more than minimizing upfront structure.

**Key Takeaways:**
- **Dependency rule:** Inner layers should not depend on outer layers.
- **Frameworks and infrastructure stay at the edges** instead of shaping core business rules.
- Caution: **Extra structure has a cost**: over-applying it to simple systems can create unnecessary indirection.

---

## Deep Dive

### Core Idea
Clean Architecture organizes code so the most important business rules sit at the center, while frameworks, databases, and delivery mechanisms remain replaceable details at the edges. The main rule is directional: dependencies point inward.

### Typical Layers
- **Domain or Core:** entities, value objects, and business rules.
- **Application:** use cases, orchestration, and workflow logic.
- **Infrastructure:** persistence, external integrations, messaging, and framework-specific implementations.
- **Presentation:** controllers, APIs, UI, or other delivery mechanisms.

### Benefits
- Business logic becomes easier to test without booting the whole application stack.
- Infrastructure changes have less impact on core behavior.
- Team boundaries and responsibilities become clearer when layers are respected.

### Common Failure Modes
- Treating every simple CRUD app as if it needs the full layering model.
- Letting infrastructure types leak into application or domain code.
- Adding abstractions with no clear boundary or replacement need, which creates ceremony without value.

### Practical Guidance
- Put policies and business decisions in the core, not in controllers or repositories.
- Use interfaces at real architectural seams rather than wrapping everything automatically.
- Keep the composition root and dependency wiring near the application edge.

### Boundary example

A `PlaceOrder` use case depends on an `OrderRepository` port defined in an inner layer. A SQL adapter implements the port in the outer layer. The use case need not import SQL client types; changing persistence still requires tests and can affect behavior. Domain/application/infrastructure/presentation are one useful layout, not mandatory circles. [Martin's original description](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) (2012; checked 2026-09-24).

## Related Concepts
- [[SOLID Principles]]
- [[Dependency Injection]]
- [[Repository Pattern]]

## Resources
- Robert C. Martin: Clean Architecture
- Microsoft Docs: Architecture guidance for layered .NET applications

## Practice Exercises
1. Take a controller that mixes validation, business rules, and persistence, then separate it into presentation, application, and infrastructure responsibilities.
2. Identify one place in a current project where a framework type leaks into core logic and describe how to move that dependency outward.

## Personal Notes

**Practitioner observation, retained from the source:** Reusing business rules across products is harder when those rules are embedded in controllers or infrastructure adapters; teams may duplicate the logic and maintain it in multiple places. Separating policy from platform code can also reduce the work of a cloud-provider migration, although deployment, data, and integration changes still need their own plan. These are observed scenarios, not guaranteed outcomes.

## Sources

- [Robert C. Martin, The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) — 2012; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 3 months
