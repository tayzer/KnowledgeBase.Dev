---
date: 2026-06-23
status: Current
tags:
  - architecture
  - event-sourcing
  - cqrs
  - data-architecture

---

# Event Sourcing

## Quick Reference

**Definition:** Event Sourcing stores the history of state changes as a retained sequence of domain events, usually append-only under the chosen correction and retention policy, then derives current state by replaying or projecting those events.

**When to use:**
- Domains where history, auditability, temporal queries, or replay are central requirements.
- Systems where events are the natural source of truth and read models can be projected from them.

**Key Takeaways:**
- Event Sourcing is not just publishing events after database writes; the event log is the source of truth.
- It pairs well with CQRS, but CQRS does not require Event Sourcing.
- Event design, versioning, snapshots, replay, and projection rebuilds become first-class concerns.

**Limit:** Event history needs evolution and erasure policies before sensitive data is stored.

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

## Event evolution and erasure example

When a CustomerRenamed event schema adds a field, version handlers or upcasters so old events still replay. A correction can append a compensating event rather than rewrite history. Privacy deletion may conflict with immutable personal payloads; design minimization, tokenization, encryption-key erasure, or retention/erasure policy before storing sensitive events. Event sourcing and CQRS are separate design choices.

## Sources

- [Primary documentation](https://martinfowler.com/eaaDev/EventSourcing.html) (accessed 2026-09-24).

## Related Concepts

- [[CQRS]]
- [[Event-Driven Architecture]]
- [[Materialized Read Model]]
- [[Message-Driven Architecture]]
- [[Schema Migrations]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
