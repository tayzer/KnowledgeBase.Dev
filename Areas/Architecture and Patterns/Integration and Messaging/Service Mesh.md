# Service Mesh
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #service-mesh #microservices #platform-engineering

## TL;DR / Quick Reference

**Definition:** A service mesh moves service-to-service networking concerns such as traffic policy, mutual TLS, retries, telemetry, and routing into a dedicated infrastructure layer, often through sidecars or node-level proxies.

**When to use:**
- When a microservice platform needs consistent service-to-service security, traffic control, and observability.
- When these concerns are too important or duplicated to leave inside every service codebase.

**Key Takeaways:**
- A service mesh is platform infrastructure, not an architecture cure-all.
- It can standardize cross-cutting networking concerns but adds operational complexity.
- Teams should understand the underlying failure modes, not hide all networking behind mesh configuration.

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

## Related Concepts

- [[Microservices]]
- [[ServiceCommunication]]
- [[API Gateway Pattern]]
- [[Operations and Reliability]]
- [[Cloud and Delivery]]

## Review Schedule

- [ ] Review in 3 months