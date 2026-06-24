# Service-Oriented Architecture
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #soa #services #distributed-systems

## TL;DR / Quick Reference

**Definition:** Service-Oriented Architecture (SOA) structures systems as reusable services exposed through contracts, often with enterprise integration, governance, and shared platform concerns.

**When to use:**
- When an organization needs reusable business services across multiple applications or channels.
- When integration governance, contract stability, and enterprise interoperability matter more than independent product-team autonomy.

**Key Takeaways:**
- SOA is not the same as microservices; it usually emphasizes enterprise service reuse and governance more than small autonomous deployables.
- SOA can work well for integration-heavy estates, but centralized governance can become slow or overly coupled.
- Avoid turning shared services into bottlenecks that every change must coordinate through.

---

## Deep Dive

### SOA Compared With Nearby Styles

| Style | Primary emphasis | Common risk |
| --- | --- | --- |
| SOA | Reusable enterprise services and integration contracts | Centralized governance and shared-service bottlenecks |
| Service-based architecture | Coarse business services with moderate operational complexity | Boundaries may be weak if data is shared freely |
| Microservices | Independent deployment and team autonomy | Operational and data-consistency complexity |

### Good Fit

- Enterprise integration across many systems.
- Stable service contracts used by multiple consumers.
- Organizations with mature governance but a need to avoid duplicated capabilities.

### Be Careful When

- Every service change requires centralized approval.
- Service contracts become generic and hard to evolve.
- Shared canonical models force unrelated domains to change together.

## Related Concepts

- [[Service Based Architecture]]
- [[Microservices]]
- [[ServiceCommunication]]
- [[API Gateway Pattern]]
- [[Backend for Frontend]]

## Review Schedule

- [ ] Review in 3 months