# Thread Pool
Date: 2026-06-25
Status: Needs Review
Tags: #concurrency #threadpool #performance #dotnet #design-patterns

## TL;DR / Quick Reference

**Definition:** A thread pool reuses a managed set of worker threads to execute queued work without creating and destroying a dedicated thread for every operation.

**When to use:**
- Short-lived CPU-bound work that can run independently.
- Task Parallel Library work such as `Task.Run`, `Parallel.ForEach`, or scheduler-driven background callbacks.
- Runtime-managed work where ordinary priority, apartment state, and background-thread behavior are acceptable.

**Key Takeaways:**
- Reusing workers reduces thread creation overhead and helps throughput for many small operations.
- Thread-pool threads are shared process resources; blocking them can starve unrelated work.
- In .NET, most `Task` and Task Parallel Library work uses the thread pool by default.
- Let the runtime tune the pool in most cases; changing min/max thread counts is a last resort after measurement.

---

## Deep Dive

### Conceptual Foundation
Creating an operating-system thread is expensive compared with queueing work to an existing worker. A thread pool keeps reusable background workers available, queues additional work when all workers are busy, and adjusts worker counts to optimize throughput.

The pattern is useful when the unit of work is brief, independent, and does not require custom thread identity.

### .NET Thread Pool Behavior
In .NET, the managed thread pool is used for many runtime features, including Task Parallel Library operations, asynchronous I/O completions, timers, registered waits, delegate-based async calls, and some socket work.

There is one managed thread pool per process. When every available worker is busy, additional items wait in a queue until a worker is available or the runtime adds workers.

### Good Fits

- Small CPU-bound calculations that need to run away from the caller.
- Parallel processing over independent items with a bounded degree of parallelism.
- Runtime callbacks, timers, and background continuation work.
- Server-side work that is brief and does not require a dedicated thread.

### Poor Fits

- Long blocking calls, especially synchronous I/O.
- Work requiring a foreground thread.
- Work requiring a specific priority, culture, apartment state, or thread affinity.
- Work that must own a thread for its lifetime, such as some legacy interop or UI-bound operations.

### Relationship To Async/Await
Async I/O often avoids occupying a thread while waiting. By contrast, CPU-bound work scheduled with `Task.Run` uses a thread-pool worker. A useful rule of thumb:

- Await naturally asynchronous I/O.
- Use `Task.Run` sparingly for CPU-bound work that should not run on the caller's thread.
- Avoid wrapping blocking I/O in `Task.Run` as a scalability strategy.

## Code Snippet

```csharp
var options = new ParallelOptions
{
    MaxDegreeOfParallelism = Environment.ProcessorCount,
    CancellationToken = cancellationToken
};

await Parallel.ForEachAsync(items, options, async (item, token) =>
{
    await processor.ProcessAsync(item, token);
});
```

Bounded parallelism keeps the pool from being flooded with unlimited work and makes downstream capacity explicit.

## Gotchas

- Thread-pool starvation can happen when queued work blocks waiting for other queued work.
- Raising minimum thread counts can mask blocking problems and make contention worse.
- Fire-and-forget work can lose errors unless it is supervised and observed.
- Queueing work is not a substitute for backpressure; producers can still overwhelm the system.

## Related Concepts

- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview]]
- [[Async]]
- [[Producer-Consumer]]
- [[Actor Model]]
- [[Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System]]
- [[Immutable and Concurrent Collections]]

## Resources

- Microsoft Learn: The managed thread pool
- Microsoft Learn: Task Parallel Library

## Practice Exercises

1. Find a `Task.Run` call and decide whether the work is truly CPU-bound or just hiding blocking I/O.
2. Add bounded parallelism to a batch processor and compare throughput with unbounded fan-out.
3. Describe what would happen if every worker in a service blocked waiting for work that also needs the pool.

## Review Schedule

- [ ] Review in 3 months
