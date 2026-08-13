# Azure Service Bus
Date: 2026-06-26
Status: Needs Review
Tags: #azure #service-bus #messaging #integration

## TL;DR / Quick Reference

**Definition:** Azure Service Bus is a fully managed enterprise message broker that provides queues, topics, subscriptions, and advanced messaging features for reliable application integration.

**When to use:**
- Business messages need durable queueing, publish/subscribe, dead-lettering, sessions, duplicate detection, scheduled delivery, or transactions.
- Producers and consumers should be decoupled across services, teams, trust boundaries, or network environments.
- You need richer messaging semantics than [[Azure Queue Storage]].

**Key Takeaways:**
- Service Bus queues are for point-to-point work distribution.
- Service Bus topics and subscriptions are for publish/subscribe with independent subscriber copies.
- Use sessions when strict ordered processing is required for a message stream.
- Use dead-letter queues and idempotent handlers as normal parts of the design, not as afterthoughts.

---

## Deep Dive

### Mental Model

Use Service Bus when the system says: "This business message must be brokered reliably between applications."

The service sits between producers and consumers so they do not need to be available at the same time. It supports competing consumers, pub/sub, message locks, sessions, and dead-letter handling.

### Core Concepts

- **Namespace:** Container for queues and topics.
- **Queue:** One message is processed by one competing consumer.
- **Topic:** Publisher sends once; subscriptions receive independent copies.
- **Subscription:** A filtered durable view of a topic.
- **Dead-letter queue:** Stores messages that cannot be delivered or processed.
- **Session:** Groups related messages for ordered processing.

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

- Microsoft Learn: Azure Service Bus overview
- Microsoft Learn: Service Bus queues, topics, and subscriptions
- Microsoft Learn: Storage queues and Service Bus queues compared

## Practice Exercises

1. Model an `InvoicePaid` topic with separate accounting, email, and reporting subscriptions.
2. Decide when a failed message should retry, dead-letter, or be ignored.
3. Add a correlation ID and idempotency key to a Service Bus message contract.

## Review Schedule

- [ ] Review in 3 months
