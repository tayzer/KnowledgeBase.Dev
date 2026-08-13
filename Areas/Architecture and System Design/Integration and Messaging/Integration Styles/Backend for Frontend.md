# Backend for Frontend
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #bff #frontend-architecture #api-design

## TL;DR / Quick Reference

**Definition:** Backend for Frontend (BFF) gives a specific client or user experience its own backend layer, shaped around that client's needs rather than exposing generic backend service contracts directly.

**When to use:**
- When web, mobile, partner, or internal clients need different API shapes, aggregation, auth flows, or performance tradeoffs.
- When a generic API gateway cannot safely handle client-specific composition without accumulating business logic.

**Key Takeaways:**
- BFFs optimize client experience while protecting backend services from UI-specific contract churn.
- A BFF should own presentation-oriented composition, not canonical domain rules.
- Too many BFFs can create duplicated logic unless ownership and boundaries are clear.

---

## Deep Dive

### Good Fit

- Mobile and web clients need different response shapes.
- The UI needs aggregation across several services.
- Client-specific authentication, caching, or latency constraints exist.
- Backend services should expose stable domain APIs rather than UI-shaped APIs.

### Be Careful When

- The BFF starts owning source-of-truth decisions.
- Every small UI variant gets its own backend.
- Shared business rules are copied into multiple BFFs.

### Design Guidance

- Keep BFF logic close to presentation and composition concerns.
- Push canonical domain behavior to owning services.
- Use explicit contracts and tests for each client experience.
- Monitor fan-out, partial response behavior, and downstream failures.

## Related Concepts

- [[API Gateway Pattern]]
- [[Service Composition]]
- [[Areas/Domains and Specialisms/Web Development/_Index]]
- [[Microservices]]
- [[Service Communication]]

## Review Schedule

- [ ] Review in 3 months
