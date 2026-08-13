# Azure Event Grid
Date: 2026-06-26
Status: Needs Review
Tags: #azure #event-grid #events #serverless

## TL;DR / Quick Reference

**Definition:** Azure Event Grid is a managed publish/subscribe event routing service for distributing events from Azure services, custom applications, partner systems, and MQTT clients to interested subscribers.

**When to use:**
- A system needs to react when something happened, such as a blob created, resource changed, or custom domain event published.
- Subscribers should receive filtered events without producers calling each subscriber directly.
- Serverless event handling should trigger Azure Functions, webhooks, Event Hubs, or other Azure services.

**Key Takeaways:**
- Event Grid is for event routing and reactive integration, not for long-running work queues.
- It supports CloudEvents 1.0 and HTTP push/pull delivery patterns.
- Use filtering so subscribers receive only relevant events.
- Use [[Azure Service Bus]] when messages represent durable commands or business workflow steps.
- Use [[Azure Event Hubs]] when the workload is high-throughput streaming.

---

## Deep Dive

### Mental Model

Use Event Grid when the system says: "Something happened; notify whoever cares."

Publishers emit events. Event Grid routes those events to subscribers according to subscriptions and filters. Subscribers may be Azure Functions, webhooks, Event Hubs, Service Bus, or other supported destinations.

### Good Fit

- Trigger a Function when a blob is created.
- Notify downstream systems that an entity changed.
- Connect Azure service events to automation.
- Route custom application events to selected subscribers.
- Push or pull event consumption for reactive workflows.

### Be Careful When

- A consumer must own a durable command queue with long-running retry semantics.
- Consumers need ordered processing of a business workflow.
- The event payload is large or represents the full state transfer.
- You need stream replay and independent offsets; use [[Azure Event Hubs]].

### Design Guidance

- Treat events as facts, not commands.
- Keep event payloads small and include enough identity to fetch more detail if needed.
- Use CloudEvents when interoperability matters.
- Make handlers idempotent because event delivery can be retried.
- Use subject/type filtering to avoid noisy subscribers.
- Include correlation or causation IDs for tracing.

## Related Concepts

- [[Azure Messaging Service Selection]]
- [[Azure Functions]]
- [[Azure Service Bus]]
- [[Azure Event Hubs]]
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]
- [[Serverless Architecture]]
- [[Message-Driven Architecture]]

## Resources

- Microsoft Learn: Azure Event Grid overview
- Microsoft Learn: Event Grid concepts
- Microsoft Learn: Event Grid delivery and retry

## Practice Exercises

1. Design an Event Grid flow for "blob uploaded -> function validates file -> event emitted".
2. Define a custom event schema with subject, type, data version, and correlation ID.
3. Decide whether `OrderSubmitted` should be an Event Grid event, a Service Bus message, or both.

## Review Schedule

- [ ] Review in 3 months
