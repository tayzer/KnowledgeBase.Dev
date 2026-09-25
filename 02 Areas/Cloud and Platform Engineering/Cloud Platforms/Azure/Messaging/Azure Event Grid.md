---
date: 2026-06-26
status: Current
tags:
  - azure
  - event-grid
  - events
  - serverless

---

# Azure Event Grid

## Quick Reference
**Definition:** Azure Event Grid is a managed publish/subscribe event routing service for distributing events from Azure services, custom applications, partner systems, and MQTT clients to interested subscribers.

**When to use:**
- A system needs to react when something happened, such as a blob created, resource changed, or custom domain event published.
- Subscribers should receive filtered events without producers calling each subscriber directly.
- Serverless event handling should trigger Azure Functions, webhooks, Event Hubs, or other Azure services.

**Key Takeaways:**
- Event Grid primarily routes event notifications; use a brokered queue when long-running command settlement and workflow ownership are required.
- It supports CloudEvents 1.0. Namespace topics support HTTP push and pull delivery; basic topics use push delivery.
- Use filtering so subscribers receive only relevant events.
- Use [[Azure Service Bus]] when messages represent durable commands or business workflow steps.
- Use [[Azure Event Hubs]] when the workload is high-throughput streaming.

**Limit:** Retry, destination, and delivery capabilities differ between Event Grid topic types and tiers.

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
- Push delivery for reactive workflows; use a namespace topic when consumers need pull delivery.

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

## Delivery and schema boundary

Event Grid basic topics use push delivery; namespace topics support HTTP push and pull. CloudEvents is the recommended event format, but supported destinations, retry, dead-letter, MQTT, and filters vary by tier and delivery model. Use a durable command broker when workflow ownership and settlement are required; this is a selection heuristic, not a claim that Event Grid has no retry.

## Related Concepts

- [[Azure Messaging Service Selection]]
- [[Azure Functions]]
- [[Azure Service Bus]]
- [[Azure Event Hubs]]
- [[Event-Driven Architecture]]
- [[Serverless Architecture]]
- [[Message-Driven Architecture]]

## Resources

- [Event Grid schema and CloudEvents](https://learn.microsoft.com/en-us/azure/event-grid/event-schema) (accessed 2026-09-24).

- [Primary documentation](https://learn.microsoft.com/en-us/azure/event-grid/namespace-push-delivery-overview) (accessed 2026-09-24).
- [Event Grid namespace push and pull delivery](https://learn.microsoft.com/en-us/azure/event-grid/namespace-push-delivery-overview) (Microsoft Learn; checked 2026-09-24).

- [Microsoft Learn: Azure Event Grid overview](https://learn.microsoft.com/en-us/azure/event-grid/overview) (accessed 2026-09-24).
- [Microsoft Learn: Event Grid concepts](https://learn.microsoft.com/en-us/azure/event-grid/concepts) (accessed 2026-09-24).
- [Microsoft Learn: Event Grid delivery and retry](https://learn.microsoft.com/en-us/azure/event-grid/delivery-and-retry) (accessed 2026-09-24).

## Practice Exercises

1. Design an Event Grid flow for "blob uploaded -> function validates file -> event emitted".
2. Define a custom event schema with subject, type, data version, and correlation ID.
3. Decide whether `OrderSubmitted` should be an Event Grid event, a Service Bus message, or both.

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
