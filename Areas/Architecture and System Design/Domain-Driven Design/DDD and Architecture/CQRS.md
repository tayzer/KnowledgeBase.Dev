# CQRS (Command Query Responsibility Segregation)
Date: 2026-06-14
Status: Needs Review
Tags: #cqrs #architecture #patterns

## 🎯 TL;DR / Quick Reference

**Definition:** Separates read and write models to optimize each for its concerns (reads optimized for queries, writes for consistency).

**When to use:**
- Complex domains where re[[Service Communication]]verge significantly.
- Workloads with many more reads than writes, where query performance or shape differs from transactional writes.
- Systems where task-based commands and intent-based domain behavior are more important than CRUD-style updates.

**Key Takeaways:**
- ✅ **Separation of concerns** can improve scalability.
- ✅ **Independent optimization** lets write-side models enforce invariants and read-side models serve tailored views.
- ⚠️ **Added complexity**: consistency, operations, and debugging get harder.
- ⚠️ **Not mandatory for every app**: simple CRUD systems usually do better with a simpler architecture.

---

## 📚 Deep Dive

### Core Idea
CQRS splits the model used to change state (commands) from the model used to read state (queries). Instead of one shared data model trying to satisfy both goals, each side is designed for its own job.

- **Command side (write model):** validates intent, enforces business invariants, and changes state.
- **Query side (read model):** serves read-optimized projections for UI/reporting/search use cases.

This separation can exist in-process within one service, or across multiple services and data stores.

### Command Side
Typical characteristics:
- Uses task-oriented operations (for example, `ApproveOrder`, `CancelSubscription`) rather than generic row updates.
- Prioritizes correctness and business rules over query convenience.
- Usually writes to an authoritative transactional store.

Common command pipeline concerns:
- Validation and authorization.
- Domain invariants and consistency rules.
- Idempotency for retries in distributed environments.
- Auditing and domain events emitted after successful state change.

### Query Side
Typical characteristics:
- Uses denormalized or precomputed views shaped for specific screens or API responses.
- Prioritizes read throughput, low latency, and flexible filtering.
- Can use a different storage model than the write side (for example, document/read cache/search index).

Read models are usually disposable and rebuildable from authoritative state or event streams.

### Consistency Model
CQRS often introduces eventual consistency between write and read sides.

- After a command succeeds, read models may lag briefly.
- Systems should define acceptable lag and user experience expectations.
- UIs may need patterns like optimistic updates, progress indicators, or "refresh to see latest state" messaging.

### CQRS vs CRUD
- **CRUD model:** one model for create/read/update/delete; simpler and often sufficient.
- **CQRS model:** separate command/query models; more flexible and scalable in complex domains, but with more moving parts.

Use CQRS for a clear domain or scaling reason, not because it is fashionable.

### Relationship to Event Sourcing
CQRS and Event Sourcing are related but independent.

- CQRS can be implemented without Event Sourcing.
- Event Sourcing can exist without full CQRS.
- They are often paired: commands append events, and read projections are built from those events.

### Implementation Patterns
1. **In-process CQRS (modular monolith):** separate handlers and models in one codebase/database. Lowest operational overhead.
2. **Split read store:** write model in transactional DB, read model in projection-optimized store.
3. **Distributed CQRS:** command and query responsibilities in separate deployables/services.

Start with the smallest version that solves the problem, then evolve.

### Benefits
- Better alignment with business intent through task-based commands.
- Independent scaling/tuning for read-heavy workloads.
- Cleaner separation between transactional consistency rules and presentation query needs.
- Easier evolution of read views without destabilizing write logic.

### Costs and Failure Modes
- More code paths, infrastructure, and observability requirements.
- Eventual consistency surprises if stakeholders expect immediate read-after-write.
- Duplicate logic risk if validation/business rules leak into query side.
- Over-engineering when applied to simple domains.

### Practical Guidance
- Keep commands intention-revealing and coarse enough to model business actions.
- Treat read models as projections, not as the source of truth.
- Make projection rebuild and backfill a first-class operational capability.
- Define explicit SLAs for projection freshness.
- Add correlation IDs and tracing so command-to-projection flow is debuggable.

## 🧩 Minimal Flow Example

1. Client sends `PlaceOrder` command.
2. Command handler validates business rules and writes order state.
3. System emits `OrderPlaced` event.
4. Projection handler updates `OrdersForDashboard` read model.
5. Dashboard query reads from projection.

During step 3 to 4, dashboard data may be briefly stale.

## 🧪 Practice Exercises
1. Pick a workflow in your current system and split it into one command model and one query model. Document what changed.
2. Design one read projection for a dashboard screen and list exactly which fields are denormalized and why.
3. Define an acceptable freshness SLA for one projection (for example, 1 to 5 seconds) and describe how you would monitor it.

## Related Concepts
- [[Clean Architecture]]
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]
- [[Event Sourcing]]
- [[Materialized Read Model]]
- [[Message-Driven Architecture]]
- [[Monolith]]
- [[Microservices]]
- [[Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern]]
- [[Service Communication]]
## 📖 Resources
- Martin Fowler: CQRS
- Microsoft Docs: CQRS pattern
- Greg Young: Task-based UIs and CQRS talks

## 🔄 Review Schedule
- [ ] Review in 3 months
