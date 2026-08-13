# Service Based Architecture
Date: 2026-04-30
Status: Needs Review
Tags: #architecture #service-based-architecture #distributed #design

## 🎯 TL;DR / Quick Reference

**Definition:** An architectural style that decomposes an application into a small number of coarse-grained services with clearer business boundaries than a monolith, but less operational independence than microservices.

**When to use:**
- Medium-to-large systems that need clearer service boundaries without the full operational overhead of microservices.
- Teams that want modular ownership and separation of concerns while keeping deployment and data management relatively simple.

**Key Takeaways:**
- ✅ **Clearer service boundaries** improve ownership, maintainability, and separation of concerns.
- ✅ **Coarser-grained services** reduce platform and deployment overhead compared with microservices.
- ⚠️ **Shared deployment or shared data** can preserve coupling if service boundaries are not enforced carefully.

---

## 📚 Deep Dive

### Position On The Spectrum
Service-based architecture often sits between a classic monolith and microservices.

- Compared with a monolith, it creates stronger internal service boundaries.
- Compared with microservices, it usually keeps fewer services, coarser responsibilities, and simpler operational requirements.

### Good Fit
- Applications that have multiple business capabilities but are not yet large enough to justify a full microservice platform.
- Teams that want clearer contracts between components.
- Systems where deployment simplicity still matters more than full service independence.

### Common Tradeoffs
- Shared databases can make service boundaries feel cleaner on paper than they are in practice.
- Coordinated releases are often simpler than in microservices, but they reduce independence.
- Service communication still needs explicit contracts, versioning discipline, and failure handling.

## Related Concepts
- [[Monolith]]
- [[Modular Monolith]]
- [[Microservices]]
- [[Service-Oriented Architecture]]
- [[Distributed Monolith]]
## 🔄 Review Schedule
- [ ] Review in 3 months
