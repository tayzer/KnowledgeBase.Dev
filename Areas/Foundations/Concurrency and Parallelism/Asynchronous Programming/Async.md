# Async/Await Patterns
Date: 2026-06-25
Status: Needs Review
Tags: #async #concurrency #dotnet #design-patterns

## TL;DR / Quick Reference

**Definition:** Async/await is a structured way to model asynchronous work as awaitable operations, usually represented by tasks, futures, or promises, without blocking the current thread while the operation is incomplete.

**When to use:**
- I/O-bound work such as database calls, HTTP calls, file I/O, queue operations, or timers.
- UI or server code where blocked threads would reduce responsiveness or scalability.
- Independent operations that can be started together and awaited when their results are needed.

**Key Takeaways:**
- Async is about non-blocking waiting; it is not automatically parallel execution.
- In .NET, `async` enables `await`, but the method runs synchronously until it reaches an incomplete awaitable.
- Prefer `Task`/`Task<T>` for most .NET async APIs; use `ValueTask` only when measurement shows it helps and callers can handle its constraints.
- Avoid `.Result`, `.Wait()`, and long synchronous work inside async flows.
- Use `ConfigureAwait(false)` in general-purpose library code when the continuation does not need the caller's context; app-level code usually does not need it.

---

## Deep Dive

### Async Versus Parallel
Async work lets a thread stop waiting on an incomplete operation and return to useful work. Parallel work uses multiple workers at the same time. A single request can be asynchronous without being parallel, and parallel CPU work can still block worker threads.

Use async for waiting on external resources. Use parallelism for CPU-bound work that benefits from multiple cores.

### Task-Based Async In .NET
The common .NET shape is the Task-based Asynchronous Pattern (TAP):

- `Task` represents an asynchronous operation with no result.
- `Task<T>` represents an asynchronous operation that eventually produces a result.
- `CancellationToken` lets callers request cancellation.
- Exceptions are captured by the task and rethrown when awaited.
- Methods returning awaitable types usually use the `Async` suffix.

### Starting Work Concurrently
A common mistake is awaiting each operation immediately when independent work could be started first.

```csharp
Task<Customer> customerTask = customers.GetAsync(customerId, cancellationToken);
Task<IReadOnlyList<Order>> ordersTask = orders.ListForCustomerAsync(customerId, cancellationToken);
Task<AccountStatus> statusTask = accounts.GetStatusAsync(customerId, cancellationToken);

await Task.WhenAll(customerTask, ordersTask, statusTask);

return new CustomerSummary(
    await customerTask,
    await ordersTask,
    await statusTask);
```

This pattern is useful for independent I/O fan-out, such as read-side service composition. It should still respect timeouts, cancellation, downstream capacity, and partial-failure policy.

### Cancellation And Timeouts
Async APIs should usually accept a `CancellationToken` and pass it to downstream async calls. Cancellation is not a rollback mechanism; it is a cooperative request to stop work that is no longer useful.

For external calls, prefer explicit deadlines or timeout policies instead of allowing a task to wait indefinitely.

### Relationship To Thread Pool
Async I/O does not normally need a thread for the whole wait. CPU-bound work scheduled with `Task.Run` does use thread-pool workers. Wrapping blocking I/O in `Task.Run` can hide the blocking from the caller but still consumes a worker thread.

## Gotchas

- Do not use `async void` except for event handlers; callers cannot await it or observe exceptions normally.
- Do not block on async results in request, UI, or library code.
- Do not assume `Task.WhenAll` gives partial success semantics; decide how failures and cancellations should be handled.
- Do not start unbounded async fan-out against databases, APIs, or queues without throttling.
- Do not add `ConfigureAwait(false)` mechanically to application code that relies on a synchronization context.

## Related Concepts

- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview]]
- [[Future and Promise]]
- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool]]
- [[Producer-Consumer]]
- [[Service Composition]]
- [[Service Communication]]
- [[Actor Model]]

## Resources

- Microsoft Learn: Asynchronous programming with async and await
- Microsoft Learn: Task-based Asynchronous Pattern
- .NET Blog: ConfigureAwait FAQ

## Practice Exercises

1. Refactor three sequential independent HTTP calls into start-then-await fan-out with `Task.WhenAll`.
2. Add `CancellationToken` flow through a repository or service method.
3. Identify one blocking async call in an application and replace it with an awaited equivalent.

## Review Schedule

- [ ] Review in 3 months
