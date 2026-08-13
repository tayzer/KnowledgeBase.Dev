# Event Sourcing
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #event-sourcing #cqrs #data-architecture

## TL;DR / Quick Reference

**Definition:** Event Sourcing stores the history of state changes as an append-only sequence of events, then derives current state by replaying or projecting those events.

**When to use:**
- Domains where history, auditability, temporal queries, or replay are central requirements.
- Systems where events are the natural source of truth and read models can be projected from them.

**Key Takeaways:**
- Event Sourcing is not just publishing events after database writes; the event log is the source of truth.
- It pairs well with CQRS, but CQRS does not require Event Sourcing.
- Event design, versioning, snapshots, replay, and projection rebuilds become first-class concerns.

---

## Deep Dive

### Good Fit

- Audit-heavy domains.
- Workflows where business events matter more than final row state.
- Systems needing rebuildable projections or historical investigation.
- Complex domains where state transitions need clear intent.

### Be Careful When

- The domain is simple CRUD.
- The team does not need historical state or replay.
- Event schema evolution is not understood.
- Sensitive data retention requirements conflict with immutable event history.

### Design Guidance

- Name events as facts that already happened, such as `OrderPlaced`.
- Keep command validation separate from event application.
- Version events deliberately and support old event formats during replay.
- Build read models as disposable projections.
- Plan snapshotting only after replay cost is understood.

## Related Concepts

- [[CQRS]]
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]
- [[Materialized Read Model]]
- [[Message-Driven Architecture]]
- [[Schema Migrations]]

## Review Schedule

- [ ] Review in 3 months
