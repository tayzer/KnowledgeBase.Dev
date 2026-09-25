---
date: 2026-06-26
status: Current
tags:
  - azure
  - event-hubs
  - streaming
  - messaging

---

# Azure Event Hubs

## Quick Reference
**Definition:** Azure Event Hubs is a managed event streaming platform for high-throughput ingestion, retention, and consumption of event streams such as telemetry, logs, clickstreams, and IoT data.

**When to use:**
- You need high-throughput event ingestion and have measured the latency target on the selected tier.
- Consumers need to read from a stream using offsets/checkpoints.
- Multiple consumer groups need independent views of the same event stream.
- You want Kafka-protocol clients on an Event Hubs tier/configuration that supports the required features.

**Key Takeaways:**
- Event Hubs is for streams, not ordinary task queues.
- Partitions scale throughput and preserve order only within a partition.
- Increasing the partition count on Premium or Dedicated can remap partition keys, so verify ordering assumptions before doing so.
- Consumer groups let different applications read the same stream independently.
- Use [[Azure Service Bus]] for business messages with broker features and [[Azure Event Grid]] for reactive event routing.

**Limit:** Ordering is partition-scoped; retention, Kafka support, and quotas depend on tier.

---

## Deep Dive

### Mental Model

Use Event Hubs when the system says: "Ingest this continuous stream and let consumers process it at their own pace."

Producers append events to a partitioned stream. Consumers read from partitions and store checkpoints so they can resume. Event Hubs keeps events for a retention period rather than removing each event as soon as one consumer processes it.

### Core Concepts

- **Event hub:** Append-only event stream inside a namespace.
- **Partition:** Ordered lane of events used to scale throughput.
- **Partition key:** Keeps related events in the same partition when ordering matters for that key.
- **Consumer group:** Independent reader view over the same stream.
- **Checkpoint:** Stored offset that tracks consumer progress.
- **Capture:** Optional capture of stream data to Blob Storage or Data Lake for analytics.

### Good Fit

- IoT telemetry ingestion.
- Application log aggregation.
- Clickstream analytics.
- Stream processing with Azure Stream Analytics, Functions, Spark, Flink, or Azure Data Explorer.
- Kafka-compatible workloads where Azure should manage the broker layer.

### Be Careful When

- Each message is a command that must be completed by one worker.
- You need dead-letter queues, duplicate detection, or transactional message settlement.
- Ordering is needed globally across all events.
- Consumers need simple push notifications rather than stream reads.

### Design Guidance

- Choose partition keys around the ordering boundary, not randomly.
- Monitor consumer lag, throttling, ingress, egress, and processing errors.
- Keep event payloads compact and versioned.
- Use Capture when raw stream retention beyond Event Hubs retention is needed.
- Treat consumers as replayable processors; make writes idempotent.

## Partition, retention, and tier boundary

Order is scoped to a partition. Consumer groups read independently and own checkpoints in their application/storage configuration. Changing partition count in Premium or Dedicated can remap keys; test ordering assumptions. Retention and Capture support vary by tier and configuration. Kafka protocol support does not mean every Kafka broker feature is equivalent. Benchmark latency and throughput on the selected tier.

## Retention and checkpoint ownership

Event Hubs retains events for a configured period or other supported retention policy; a consumer's checkpoint is application state, not deletion from the shared stream. Different consumer groups can replay independently while retained data exists. Check the [current quotas and limits](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-quotas) for the chosen tier and region rather than copying a fixed retention or partition limit into the design (accessed 2026-09-24).

## Related Concepts

- [[Azure Messaging Service Selection]]
- [[Azure Event Grid]]
- [[Azure Service Bus]]
- [[Azure Functions]]
- [[Stream Processing Architecture]]
- [[Event-Driven Architecture]]
- [[Message-Driven Architecture]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-scalability) (accessed 2026-09-24).
- [Event Hubs scalability guide](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-scalability) (Microsoft Learn; checked 2026-09-24).

- [Microsoft Learn: Azure Event Hubs overview](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-about) (accessed 2026-09-24).
- [Microsoft Learn: Event Hubs features and terminology](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-features) (accessed 2026-09-24).
- [Microsoft Learn: Choose between Azure messaging services](https://learn.microsoft.com/en-us/azure/service-bus-messaging/compare-messaging-services) (accessed 2026-09-24).

## Practice Exercises

1. Choose a partition key for telemetry from devices and explain the ordering tradeoff.
2. Design two independent consumer groups over the same stream: one for alerts and one for analytics.
3. Decide when to use Capture instead of relying only on Event Hubs retention.

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
