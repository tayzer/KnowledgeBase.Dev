---
date: 2026-06-23
status: Current
tags:
  - architecture
  - api-gateway
  - integration
  - distributed-systems

---

# API Gateway Pattern

## Quick Reference

**Definition:** An API gateway is an edge component that provides a single entry point to backend services, often handling routing, authentication, rate limiting, protocol translation, or cross-cutting API concerns.

**When to use:**
- When clients need a stable entry point in front of multiple backend services.
- When cross-cutting edge concerns should be centralized without duplicating them in every service.

**Key Takeaways:**
- API gateways are useful at the edge, but they should not become a hidden business-logic layer.
- Keep domain rules in owning services; keep routing, auth, throttling, and protocol concerns at the gateway.
- For client-specific response shaping, a Backend for Frontend may be a better fit.

---

## Deep Dive

### Common Responsibilities

- Routing and load balancing to backend services.
- Authentication and authorization enforcement at the edge.
- Rate limiting, request validation, and request size controls.
- TLS termination, header normalization, and protocol translation.
- API version routing and observability.

### Be Careful When

- Business rules move into gateway policies or scripts.
- The gateway becomes a single point of failure or deployment bottleneck.
- All clients are forced through one generic contract despite very different needs.

### Design Guidance

- Keep gateway behavior observable and testable.
- Prefer simple routing and cross-cutting policy over domain orchestration.
- Version gateway contracts deliberately.
- Pair with BFFs when client experiences need different contracts.

### Trust boundary and aggregation

A gateway can terminate TLS, authenticate callers, route requests, and apply coarse policy. Backend services still enforce authorization for their own resources and trust only validated identity context. Aggregation is optional: if a gateway fans out to several services, set an overall deadline and choose a partial-response policy. A BFF may perform similar aggregation but owns a client-specific contract; the gateway is not automatically the BFF. [Microsoft API gateway guidance](https://learn.microsoft.com/en-us/azure/architecture/microservices/design/gateway) and [Gateway Aggregation](https://learn.microsoft.com/en-us/azure/architecture/patterns/gateway-aggregation) (checked 2026-09-24).

## Related Concepts

- [[Backend for Frontend]]
- [[Service Communication]]
- [[Service Composition]]
- [[API Versioning]]
- [[Microservices]]

## Sources

- [Microsoft, API gateways](https://learn.microsoft.com/en-us/azure/architecture/microservices/design/gateway) — online page, date not shown; accessed 2026-09-24.
- [Microsoft, Gateway Aggregation pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/gateway-aggregation) — last updated 2026-06-03; accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
