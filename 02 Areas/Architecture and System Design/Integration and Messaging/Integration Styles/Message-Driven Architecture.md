---
date: 2026-06-23
status: Current
tags:
  - architecture
  - messaging
  - distributed-systems
  - integration

---

# Message-Driven Architecture

## Quick Reference

**Definition:** Message-driven architecture coordinates work through messages such as commands, events, and documents sent over queues, topics, streams, or brokers.

**When to use:**
- When producers and consumers should be decoupled in time, availability, or throughput.
- When background processing, retries, buffering, or fan-out is more appropriate than synchronous calls.

**Key Takeaways:**
- Message-driven systems can buffer and decouple work, but asynchronous state propagation may be eventually consistent and adds operational complexity.
- Messages need clear contracts, ownership, idempotency, observability, and failure handling.
- Event-driven architecture is a common form of message-driven architecture, but not every message is an event.

---

## Deep Dive

### Message Types

| Type | Meaning | Example |
| --- | --- | --- |
| Command | Please do this work | `ShipOrder` |
| Event | This thing happened | `OrderShipped` |
| Document/message | Here is data for processing | `MonthlyStatementGenerated` |

### Good Fit

- Long-running or background work.
- Fan-out to multiple consumers.
- Buffering traffic spikes.
- Cross-service workflows where eventual consistency is acceptable.

### Be Careful When

- The caller needs an immediate authoritative answer.
- Message ordering is assumed but not guaranteed.
- Retry behavior can duplicate side effects.
- Message schemas change without versioning.

### Design Guidance

- Keep message payloads small and purposeful.
- Include correlation IDs, causation IDs, and stable identifiers.
- Design handlers to be idempotent.
- Use dead-letter handling and operational dashboards.

### Delivery contract

This note's command/event/document table is a working semantic distinction, not a broker guarantee. Define whether each message is sent to one worker or many subscribers, how the publisher confirms persistence, and how failed handlers retry or dead-letter. If a state change and event publish must stay consistent, a transactional outbox can bridge the database/broker boundary. Consumers must handle duplicates when the transport provides at-least-once delivery; ordering guarantees depend on the broker and partition/session key. [Microsoft integration-event guidance](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/multi-container-microservice-net-applications/integration-event-based-microservice-communications) (checked 2026-09-24).

## Related Concepts

- [[Event-Driven Architecture]]
- [[Service Communication]]
- [[Saga Pattern]]
- [[Consistency Models]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Replication and Partitioning/_Index]]

## Sources

- [Microsoft, Event-driven architecture style](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven) — last updated 2026-03-07; accessed 2026-09-24.
- [Microsoft, Integration event-based microservice communications](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/multi-container-microservice-net-applications/integration-event-based-microservice-communications) — online page, date not shown; accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
