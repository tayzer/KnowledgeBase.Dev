---
date: 2025-11-25
status: Current
tags:
  - architecture
  - monolith
  - design

---

# Monolith

## Quick Reference

**Definition:** A software architecture where the application is built as a single, unified unit.

**When to use:**
- Small-to-medium applications or early-stage products where simplicity is valuable.

**Key Takeaways:**
- **Simplicity:** Easier local development and deployment.
- Caution: **Scaling:** May become harder to scale and evolve as the codebase grows.

---

### Deployment and boundaries

A monolith is one deployable application, even if its modules are cleanly separated. A layered architecture describes dependency organization; a monolith may use layers or another internal structure. Replicating the whole application can increase throughput, while independently scaling one component requires further separation. Code coupling, shared database assumptions, and build/deploy time affect change cost more than size alone. Start with one deployable when a single release cadence and operational simplicity fit; preserve module boundaries if parts may diverge later. [Microsoft architecture guidance](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures) (updated 2023-03-07; checked 2026-09-24).

## Related Concepts
- [[Modular Monolith]]
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Architectural Styles/_Index]]
- [[Microservices]]
- [[Distributed Monolith]]

## Sources

- [Microsoft, Common web application architectures](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures) — last updated 2023-03-07; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
