---
date: 2025-11-25
status: Current
tags:
  - architecture
  - event-driven
  - messaging

---

# Event-Driven Architecture

## Quick Reference
**Definition:** An architecture in which producers publish events about changes and consumers react to those events, often asynchronously.

**When to use:**
- Systems where independent consumers need to react to state changes asynchronously; event sourcing is a separate storage pattern.

**Key Takeaways:**
- **Loose coupling** and improved scalability.
- **Eventual consistency** and operational complexity require explicit handling.

---

### Minimal event flow

After an order transaction commits, publish `OrderPlaced` with an event ID, version, aggregate ID, timestamp, and a clearly owned payload. Inventory and notification consumers handle it independently. If the database write and publish cannot share a transaction, use an outbox or another explicit recovery method; each consumer records processed IDs when duplicate delivery is possible. Specify ordering scope, retry budget, dead-letter handling, and acceptable read lag. The event is a fact, not an instruction to a named worker. [Microsoft event-driven style](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven) (updated 2026-03-07; checked 2026-09-24).

## Related Concepts
- [[Message-Driven Architecture]]
- [[Service Communication]]
- [[Event Sourcing]]
- [[CQRS]]
- [[Saga Pattern]]
- [[Stream Processing Architecture]]

## Sources

- [Microsoft, Event-driven architecture style](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven) — last updated 2026-03-07; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
