# Message-Driven Architecture
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #messaging #distributed-systems #integration

## TL;DR / Quick Reference

**Definition:** Message-driven architecture coordinates work through messages such as commands, events, and documents sent over queues, topics, streams, or brokers.

**When to use:**
- When producers and consumers should be decoupled in time, availability, or throughput.
- When background processing, retries, buffering, or fan-out is more appropriate than synchronous calls.

**Key Takeaways:**
- Message-driven systems can improve resilience and flow control, but they introduce eventual consistency and operational complexity.
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

## Related Concepts

- [[Event Driven]]
- [[ServiceCommunication]]
- [[Saga Pattern]]
- [[Consistency Models]]
- [[Replication and Partitioning]]

## Review Schedule

- [ ] Review in 3 months