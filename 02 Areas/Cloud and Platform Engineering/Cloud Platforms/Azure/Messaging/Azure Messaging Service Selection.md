---
date: 2026-06-26
status: Current
tags:
  - azure
  - messaging
  - cloud
  - architecture

---

# Azure Messaging Service Selection

## Quick Reference

**Definition:** Azure messaging service selection is the decision process for choosing between Azure Queue Storage, Azure Service Bus, Azure Event Grid, and Azure Event Hubs based on message shape, delivery model, throughput, and reliability needs.

**When to use:**
- You need to choose an Azure messaging primitive for background work, events, integration, or streaming.
- You are deciding whether the workload is a queue, brokered message, event notification, or event stream.

**Key Takeaways:**
- Use [[Azure Queue Storage]] for simple storage-backed async work backlogs; compare current costs for the workload.
- Use [[Azure Service Bus]] for enterprise messaging, queues/topics, dead-lettering, sessions, transactions, and richer delivery semantics.
- Use [[Azure Event Grid]] when publishers announce state changes and subscribers react through event routing.
- Use [[Azure Event Hubs]] for high-throughput telemetry, logs, clickstreams, and stream-processing ingestion.
- Do not choose based only on the word "event"; choose based on delivery semantics and consumer behavior.

**Limit:** Delivery, ordering, quota, and current cost decide service fit; product names alone do not.

---

## Deep Dive

### Quick Decision Table

| Need | Prefer | Why |
|---|---|---|
| Simple background work queue | [[Azure Queue Storage]] | Cheap, storage-backed queue for async backlog processing |
| Enterprise queue with dead-lettering, sessions, duplicate detection, or transactions | [[Azure Service Bus]] | Broker features for reliable app-to-app messaging |
| Publish/subscribe commands or business messages | [[Azure Service Bus]] topics | Durable subscriptions and filtering |
| React to Azure resource changes or app events | [[Azure Event Grid]] | Push or pull event routing with filtering |
| High-volume telemetry or logs | [[Azure Event Hubs]] | Partitioned stream ingestion and multiple consumer groups |
| Kafka-compatible Azure ingestion | [[Azure Event Hubs]] | Supports Kafka protocol for many Kafka workloads |

### Service Mental Models

- **Queue Storage:** "Put this work somewhere until a worker can process it."
- **Service Bus:** "Coordinate business messages reliably across applications."
- **Event Grid:** "Tell interested subscribers that something happened."
- **Event Hubs:** "Ingest and replay a large stream of events."

### Questions To Ask

- Is each message a command to do work, a fact that happened, or telemetry in a stream?
- Does one consumer process each message, or do many subscribers need independent copies?
- Do you need ordering, sessions, duplicate detection, transactions, or dead-letter queues?
- Is the consumer pull-based, push-based, or stream-processing from offsets?
- How large are messages and how much throughput do you need?
- What happens when processing fails repeatedly?

## Decision factors beyond service name

Queue Storage is a storage-backed backlog; compare its request/storage costs with the workload. Service Bus adds broker features, with tier restrictions. Event Grid routes events and supports push or namespace pull. Event Hubs retains partitioned streams for independent readers. Check delivery guarantee, ordering scope, dead-letter/retry behavior, quota, cost, and consumer ownership before selection.

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]
- [[Azure Queue Storage]]
- [[Azure Service Bus]]
- [[Azure Event Grid]]
- [[Azure Event Hubs]]
- [[Azure Functions]]
- [[Service Communication]]
- [[Message-Driven Architecture]]
- [[Producer-Consumer]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted) (accessed 2026-09-24).

- [Microsoft Learn: Choose between Azure messaging services](https://learn.microsoft.com/en-us/azure/service-bus-messaging/compare-messaging-services) (accessed 2026-09-24).
- [Microsoft Learn: Storage queues and Service Bus queues compared](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted) (accessed 2026-09-24).
- [Microsoft Learn: Azure Event Hubs overview](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-about) (accessed 2026-09-24).
- [Microsoft Learn: Azure Event Grid overview](https://learn.microsoft.com/en-us/azure/event-grid/overview) (accessed 2026-09-24).

## Practice Exercises

1. Choose an Azure messaging service for sending order-confirmation emails asynchronously.
2. Choose an Azure messaging service for notifying three downstream systems that an invoice was paid.
3. Choose an Azure messaging service for ingesting telemetry from thousands of devices.

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
