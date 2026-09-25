---
date: 2026-06-26
status: Current
tags:
  - azure
  - service-bus
  - messaging
  - integration

---

# Azure Service Bus

## Quick Reference
**Definition:** Azure Service Bus is a fully managed enterprise message broker that provides queues, topics, subscriptions, and advanced messaging features for reliable application integration.

**When to use:**
- Business messages need durable queueing, publish/subscribe, dead-lettering, sessions, duplicate detection, scheduled delivery, or transactions.
- Producers and consumers should be decoupled across services, teams, trust boundaries, or network environments.
- You need richer messaging semantics than [[Azure Queue Storage]].

**Key Takeaways:**
- Service Bus queues are for point-to-point work distribution.
- Service Bus topics and subscriptions are for publish/subscribe with independent subscriber copies.
- Use sessions for ordered processing of related messages sharing a `SessionId` on Standard or Premium queues or subscriptions.
- Use dead-letter queues and idempotent handlers as normal parts of the design, not as afterthoughts.

**Limit:** Settlement and duplicate detection do not guarantee exactly-once business side effects.

---

## Deep Dive

### Mental Model

Use Service Bus when the system says: "This business message must be brokered reliably between applications."

The service sits between producers and consumers so they do not need to be available at the same time. It supports competing consumers, pub/sub, message locks, sessions, and dead-letter handling.

### Core Concepts

- **Namespace:** Container for queues and topics.
- **Queue:** One delivery goes to a competing consumer; retries can cause another delivery, so side effects need idempotency.
- **Topic:** Publisher sends once; subscriptions receive independent copies.
- **Subscription:** A filtered durable view of a topic.
- **Dead-letter queue:** Stores messages that cannot be delivered or processed.
- **Session:** Groups related messages with one `SessionId` for ordered processing; it does not impose one global order across all sessions.

### Good Fit

- Cross-service business workflows.
- Reliable commands such as `BillCustomer`, `ShipOrder`, or `CreateCaseDocument`.
- Integration between systems that need retry, delayed processing, or dead-letter inspection.
- Pub/sub fan-out where each subscriber owns its own processing and retry behavior.

### Be Careful When

- You only need a simple work backlog; [[Azure Queue Storage]] may be enough.
- You are ingesting high-volume telemetry; [[Azure Event Hubs]] is usually a better fit.
- You are routing lightweight resource-change events; [[Azure Event Grid]] may be simpler.
- You assume exactly-once side effects. Design for at-least-once delivery and idempotency.

### Design Guidance

- Use small messages with stable IDs and correlation IDs.
- Keep handlers idempotent.
- Decide retry, max delivery count, and dead-letter triage early.
- Use topics for independent subscribers instead of one queue shared by unrelated consumers.
- Use sessions only where ordering is a correctness requirement.
- Prefer managed identity/RBAC where possible.

## Tier and settlement matrix

Basic supports queues but not topics/subscriptions, sessions, duplicate detection, or transactions. Standard and Premium support the advanced broker features relevant here; check current feature and quota tables for exact combinations. PeekLock redelivery can produce repeated processing, so a successful settlement is not an exactly-once business side effect. Sessions order messages with the same SessionId; there is no global order across sessions. Plan lock renewal and dead-letter triage.

## Service Bus tier snapshot

| Feature | Basic | Standard | Premium |
| --- | --- | --- | --- |
| Queues | Yes | Yes | Yes |
| Topics/subscriptions | No | Yes | Yes |
| Sessions, duplicate detection, transactions | No | Yes | Yes |
| Capacity model | Shared | Shared | Dedicated messaging units |

Check [current tier details](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-premium-messaging) and quotas for the chosen region (accessed 2026-09-24).

## Related Concepts

- [[Azure Messaging Service Selection]]
- [[Azure Queue Storage]]
- [[Azure Event Grid]]
- [[Azure Event Hubs]]
- [[Azure Functions]]
- [[Message-Driven Architecture]]
- [[Service Communication]]
- [[Saga Pattern]]

## Resources

- [Service Bus managed identity authentication](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-managed-service-identity) (accessed 2026-09-24).

- [Primary documentation](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-premium-messaging) (accessed 2026-09-24).
- [Service Bus message sessions](https://learn.microsoft.com/en-us/azure/service-bus-messaging/message-sessions) (Microsoft Learn; checked 2026-09-24).

- [Microsoft Learn: Azure Service Bus overview](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview) (accessed 2026-09-24).
- [Microsoft Learn: Service Bus queues, topics, and subscriptions](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-queues-topics-subscriptions) (accessed 2026-09-24).
- [Microsoft Learn: Storage queues and Service Bus queues compared](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted) (accessed 2026-09-24).

## Practice Exercises

1. Model an `InvoicePaid` topic with separate accounting, email, and reporting subscriptions.
2. Decide when a failed message should retry, dead-letter, or be ignored.
3. Add a correlation ID and idempotency key to a Service Bus message contract.

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
