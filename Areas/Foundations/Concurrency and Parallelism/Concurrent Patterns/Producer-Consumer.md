# Producer-Consumer
Date: 2026-06-25
Status: Needs Review
Tags: #concurrency #design-patterns #queues #backpressure

## TL;DR / Quick Reference

**Definition:** Producer-consumer separates code that creates work from code that processes work, usually through a queue, buffer, channel, or broker.

**When to use:**
- Producers and consumers run at different speeds.
- Work should continue in the background after being accepted.
- Bursts should be buffered without forcing every producer to wait for full processing.
- Processing can be scaled by changing the number of consumers.

**Key Takeaways:**
- The queue is a coordination boundary, not just a data structure.
- Prefer bounded queues when overload is possible; unbounded queues can turn latency into memory pressure.
- Decide ordering, retry, cancellation, and failure handling before relying on the pattern in production.
- Consumers should be idempotent when retries, duplicates, or partial failure are possible.

---

## Deep Dive

### Conceptual Foundation
A producer creates work items and puts them into a buffer. A consumer takes work items from that buffer and processes them. This decouples the rate of acceptance from the rate of processing.

The pattern appears at several scales:

- In-process queues such as channels, blocking collections, or concurrent queues.
- Background workers inside a service.
- Message queues such as RabbitMQ, Azure Queue Storage, SQS, or Kafka topics.
- Pipelines where each stage consumes from one queue and produces to the next.

### Bounded Versus Unbounded
A bounded queue forces an overload decision when producers outrun consumers. The system can wait, reject, shed low-priority work, or route work elsewhere.

An unbounded queue is simpler but risky: the system may accept work faster than it can finish, hiding overload until memory, latency, or downstream failures become severe.

### In-Process Example

```csharp
var channel = Channel.CreateBounded<WorkItem>(new BoundedChannelOptions(100)
{
    FullMode = BoundedChannelFullMode.Wait
});

async Task ProduceAsync(WorkItem item, CancellationToken token)
{
    await channel.Writer.WriteAsync(item, token);
}

async Task ConsumeAsync(CancellationToken token)
{
    await foreach (WorkItem item in channel.Reader.ReadAllAsync(token))
    {
        await handler.HandleAsync(item, token);
    }
}
```

A bounded channel makes backpressure explicit: once capacity is reached, producers must wait or follow the configured full-mode behavior.

### Failure Handling

- Store enough metadata to retry safely.
- Make handlers idempotent where duplicates can occur.
- Use dead-letter or poison-message handling for repeatedly failing work.
- Log correlation IDs so a work item can be traced from production to consumption.
- Decide whether ordering matters globally, per key, or not at all.

## Gotchas

- A queue does not make work free; it moves the wait and changes where failure appears.
- Too many consumers can overload the database, API, or file system they call.
- In-process queues lose work on process crash unless paired with persistence or acceptable loss semantics.
- A single slow item can block ordered processing if the queue requires strict ordering.

## Related Concepts

- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview]]
- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool]]
- [[Async]]
- [[Message-Driven Architecture]]
- [[Service Communication]]
- [[Immutable and Concurrent Collections]]

## Resources

- Microsoft Learn: System.Threading.Channels
- Microsoft Learn: Thread-safe collections
- Enterprise Integration Patterns: Competing Consumers

## Practice Exercises

1. Design a bounded queue for email sending and choose what happens when the queue is full.
2. Convert a synchronous import endpoint into producer-consumer processing and define the response contract.
3. Add poison-message handling to a consumer that may fail repeatedly on malformed input.

## Review Schedule

- [ ] Review in 3 months
