# Azure Queue Storage
Date: 2026-06-26
Status: Needs Review
Tags: #azure #queue-storage #messaging #storage

## TL;DR / Quick Reference

**Definition:** Azure Queue Storage is a storage-backed queue service for holding large numbers of small messages that workers process asynchronously.

**When to use:**
- Simple background jobs where a producer can enqueue work and a worker can process it later.
- Load leveling between a web/API tier and background processors.
- Local development or interview exercises using Azurite and `Azure.Storage.Queues`.

**Key Takeaways:**
- Queue Storage is simple, scalable, and cheap for backlog-style async processing.
- A queue message can be up to 64 KB.
- Design consumers to be idempotent because messages can be delivered more than once.
- Use [[Azure Service Bus]] when you need sessions, topics, duplicate detection, transactions, richer dead-letter handling, or broker-style integration.

---

## Deep Dive

### Mental Model

Use Queue Storage when the system says: "Accept this work now, process it later."

Common shapes:

- HTTP endpoint returns `202 Accepted` and enqueues work.
- Worker or Azure Function consumes messages from the queue.
- Failed messages become visible again after the visibility timeout unless deleted.
- Processing status is stored separately in a database, table, or blob.

### Good Fit

- Email sending, image resizing, document processing, cache warming, or import jobs.
- Simple producer-consumer flows.
- Workloads already using Azure Storage and Azurite locally.
- Very large queue backlogs where simple semantics are enough.

### Be Careful When

- Strict FIFO ordering is required.
- Message payloads exceed 64 KB.
- You need publish/subscribe.
- You need automatic duplicate detection or transactions.
- You need a rich dead-letter queue workflow.

### Design Guidance

- Put only a small command or pointer in the message; store large payloads in Blob Storage or a database.
- Include a stable identifier for idempotency.
- Store processing state outside the queue if callers need status.
- Set visibility timeouts to match expected processing time and renew/update when needed.
- Monitor dequeue count, poison messages, queue length, and oldest message age.

## Code Snippet

```csharp
using Azure.Storage.Queues;

builder.Services.AddSingleton(_ =>
    new QueueClient(
        builder.Configuration["Storage:ConnectionString"],
        "case-document-processing"));

await queueClient.CreateIfNotExistsAsync(cancellationToken);
await queueClient.SendMessageAsync(
    BinaryData.FromObjectAsJson(new { documentId }),
    cancellationToken);
```

## Related Concepts

- [[Azure Messaging Service Selection]]
- [[Azure Functions]]
- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite]]
- [[Producer-Consumer]]
- [[Service Communication]]
- [[Message-Driven Architecture]]

## Resources

- Microsoft Learn: What is Azure Queue Storage?
- Microsoft Learn: Storage queues and Service Bus queues compared
- Microsoft Learn: Get started with Queue Storage using .NET

## Practice Exercises

1. Build an HTTP endpoint that enqueues a work item and returns `202 Accepted`.
2. Add idempotency to a queue worker using a message identifier.
3. Move a large queue payload into Blob Storage and put only the blob reference on the queue.

## Review Schedule

- [ ] Review in 3 months
