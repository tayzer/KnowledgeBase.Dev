---
date: 2026-06-25
status: Current
tags:
  - concurrency
  - design-patterns
  - architecture
  - performance

---

# Concurrency Patterns

## Quick Reference

**Definition:** Concurrency patterns are recurring ways to coordinate work that may overlap in time, including asynchronous waiting, worker reuse, message queues, and result placeholders.

**When to use:**
- You need to improve responsiveness, throughput, or isolation without making shared-state bugs worse.
- Work can be decomposed into independent operations, queued jobs, message handlers, or awaitable results.
- You need vocabulary for comparing async, parallelism, queues, thread pools, and futures/promises.

**Key Takeaways:**
- Concurrency is about managing overlapping work; parallelism is only one way concurrency can execute.
- Prefer explicit ownership, queues, immutable data, or message passing over casual shared mutable state.
- Add backpressure, cancellation, idempotency, and observability before scaling out concurrency.
- The right pattern depends on whether the bottleneck is waiting, CPU, coordination, or throughput smoothing.

---

## Deep Dive

### Pattern Map

| Pattern | Primary problem | Use when |
| --- | --- | --- |
| [[Async]] | Waiting without blocking | I/O-bound work, UI responsiveness, server scalability |
| [[Thread Pool]] | Reusing worker threads | Many short independent units of CPU or callback work |
| [[Producer-Consumer]] | Decoupling production from processing | Bursty input, background processing, pipelines |
| [[Future and Promise]] | Representing a result that is not ready yet | Composing async APIs, callbacks, task results |
| [[Actor Model]] | Isolating mutable state behind messages | Many independent state-owning entities |
| [[Message-Driven Architecture]] | Cross-process coordination by messages | Distributed background workflows, fan-out, buffering |

### Choosing A Pattern

Ask what you are trying to protect:

- Protect a caller thread from waiting: use async/await.
- Protect worker creation cost: use a thread pool.
- Protect downstream systems from bursts: use a bounded producer-consumer queue.
- Protect shared mutable state: use actors, locks, immutable snapshots, or concurrent collections.
- Protect distributed services from tight coupling: use message-driven architecture.

### Design Pressure Points

Important concurrency risks are easier to review when these pressures are explicit:

- **Backpressure:** What happens when producers are faster than consumers?
- **Cancellation:** Who can stop work that is no longer useful?
- **Ordering:** Does correctness depend on processing order?
- **Idempotency:** Can retries or duplicate messages cause harmful side effects?
- **Failure observation:** Where do background errors go?
- **Capacity:** Which dependency becomes the real bottleneck?

## Review refinements

An in-process channel coordinates work in one process; it does not make queued work durable across a crash. Select and configure a broker when durable acceptance is required, then document acknowledgment, retry, duplicate handling, and ordering guarantees.

## Related Concepts

- [[Async]]
- [[Thread Pool]]
- [[Producer-Consumer]]
- [[Future and Promise]]
- [[Actor Model]]
- [[Message-Driven Architecture]]
- [[Immutable and Concurrent Collections]]
- [[Service Communication]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/core/extensions/channels) (accessed 2026-09-24).
- [Microsoft Learn: Asynchronous programming with async and await](https://learn.microsoft.com/en-us/dotnet/csharp/asynchronous-programming/)
- [Microsoft Learn: The managed thread pool](https://learn.microsoft.com/en-us/dotnet/standard/threading/the-managed-thread-pool)
- [Microsoft Learn: Thread-safe collections](https://learn.microsoft.com/en-us/dotnet/standard/collections/thread-safe/)

## Practice Exercises

1. Classify a background import job as async, thread-pool, producer-consumer, or message-driven, and explain why.
2. Design backpressure for a queue where producers can outrun consumers.
3. Identify one shared mutable state problem and replace it with clearer ownership or message passing.

## Review Schedule

- [ ] Review 3 months after promotion; use the approval date as the anchor
