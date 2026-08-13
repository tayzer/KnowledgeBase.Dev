# Azure Event Hubs
Date: 2026-06-26
Status: Needs Review
Tags: #azure #event-hubs #streaming #messaging

## TL;DR / Quick Reference

**Definition:** Azure Event Hubs is a managed event streaming platform for high-throughput ingestion, retention, and consumption of event streams such as telemetry, logs, clickstreams, and IoT data.

**When to use:**
- You need to ingest large volumes of events with low latency.
- Consumers need to read from a stream using offsets/checkpoints.
- Multiple consumer groups need independent views of the same event stream.
- You want an Azure-managed Kafka-compatible ingestion layer.

**Key Takeaways:**
- Event Hubs is for streams, not ordinary task queues.
- Partitions scale throughput and preserve order only within a partition.
- Consumer groups let different applications read the same stream independently.
- Use [[Azure Service Bus]] for business messages with broker features and [[Azure Event Grid]] for reactive event routing.

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

## Related Concepts

- [[Azure Messaging Service Selection]]
- [[Azure Event Grid]]
- [[Azure Service Bus]]
- [[Azure Functions]]
- [[Stream Processing Architecture]]
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]
- [[Message-Driven Architecture]]

## Resources

- Microsoft Learn: Azure Event Hubs overview
- Microsoft Learn: Event Hubs features and terminology
- Microsoft Learn: Choose between Azure messaging services

## Practice Exercises

1. Choose a partition key for telemetry from devices and explain the ordering tradeoff.
2. Design two independent consumer groups over the same stream: one for alerts and one for analytics.
3. Decide when to use Capture instead of relying only on Event Hubs retention.

## Review Schedule

- [ ] Review in 3 months
