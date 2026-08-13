# API Gateway Pattern
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #api-gateway #integration #distributed-systems

## TL;DR / Quick Reference

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

## Related Concepts

- [[Backend for Frontend]]
- [[Service Communication]]
- [[Service Composition]]
- [[API Versioning]]
- [[Microservices]]

## Review Schedule

- [ ] Review in 3 months
