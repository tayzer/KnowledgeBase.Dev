---
date: 2026-06-23
status: Current
tags:
  - architecture
  - service-mesh
  - microservices
  - platform-engineering

---

# Service Mesh

## Quick Reference

**Definition:** A service mesh moves service-to-service networking concerns such as traffic policy, mutual TLS, retries, telemetry, and routing into a dedicated infrastructure layer, often through sidecars or node-level proxies.

**When to use:**
- When a microservice platform needs consistent service-to-service security, traffic control, and observability.
- When these concerns are too important or duplicated to leave inside every service codebase.

**Key Takeaways:**
- A service mesh is platform infrastructure, not an architecture cure-all.
- It can standardize cross-cutting networking concerns but adds operational complexity.
- Teams should understand the underlying failure modes, not hide all networking behind mesh configuration.

**Limit:** Mesh retries can duplicate side effects; the control plane and proxies add operational cost.

---

## Deep Dive

### Common Capabilities

- Mutual TLS between services.
- Traffic splitting, routing, retries, and timeouts.
- Service-to-service metrics, traces, and logs.
- Policy enforcement and identity-aware communication.

### Good Fit

- Many services with common networking and security requirements.
- Mature platform teams operating Kubernetes or similar orchestration.
- Need for consistent telemetry and traffic policy across services.

### Be Careful When

- The estate is small enough that simpler platform defaults are enough.
- The team lacks operational ownership for the mesh control plane.
- Retry and timeout policies are applied without understanding application semantics.

## Mesh fit and failure cost

A mesh can standardize mTLS, routing, and telemetry, but exact support depends on control plane, data plane, and deployment mode. Sidecars add per-pod resource and upgrade cost; ambient or node-level designs have different tradeoffs. Retrying a non-idempotent request can duplicate side effects. Define timeout, retry budget, certificate lifecycle, and bypass/failure behavior before adoption.

## Sources

- [Primary documentation](https://istio.io/latest/docs/overview/what-is-istio/) (accessed 2026-09-24).

## Related Concepts

- [[Microservices]]
- [[Service Communication]]
- [[API Gateway Pattern]]
- [[40 Knowledge/Software Engineering/02 Areas/Reliability and Operations/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/_Index]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
