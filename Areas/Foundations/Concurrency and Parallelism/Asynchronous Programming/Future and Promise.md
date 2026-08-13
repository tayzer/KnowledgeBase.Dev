# Future and Promise
Date: 2026-06-25
Status: Needs Review
Tags: #concurrency #async #promises #design-patterns

## TL;DR / Quick Reference

**Definition:** A future or promise represents the eventual result of asynchronous work, giving callers a handle they can await, compose, or observe before the result is available.

**When to use:**
- An operation starts now but completes later.
- Callers need to compose multiple async operations.
- A callback-based operation should be represented as a first-class result.
- You need a common vocabulary for .NET `Task<T>`, JavaScript `Promise`, and similar abstractions.

**Key Takeaways:**
- A future is usually the read-side handle for a not-yet-available result.
- A promise is often the write-side/completion mechanism, though terminology varies by language.
- Futures and promises separate starting work from waiting for its result.
- Cancellation, timeout, exception, and ownership semantics differ across runtimes; do not assume every language behaves like .NET or JavaScript.

---

## Deep Dive

### Conceptual Foundation
A synchronous function returns a value or throws an error before the caller continues. An asynchronous function often returns a placeholder immediately. That placeholder can later complete successfully, fail, or be cancelled.

Common examples:

- .NET: `Task`, `Task<T>`, `ValueTask<T>`, `TaskCompletionSource<T>`
- JavaScript: `Promise`
- Java: `Future`, `CompletableFuture`
- C++: `std::future`, `std::promise`

### Future Versus Promise
The names are not used consistently across ecosystems, but the conceptual split is useful:

| Concept | Role | Example |
| --- | --- | --- |
| Future | Read or await the eventual result | `Task<T>`, Java `Future<T>` |
| Promise | Complete or reject the eventual result | JavaScript promise executor, `TaskCompletionSource<T>` |

A caller should usually receive the future-like handle, not the object that can complete it.

### Composition
Futures and promises become powerful when composed:

- Wait for all operations: `.NET Task.WhenAll`, JavaScript `Promise.all`.
- Wait for the first result: `.NET Task.WhenAny`, JavaScript `Promise.race`.
- Chain dependent work after a result completes.
- Convert callback or event completion into an awaitable result.

### .NET Example

```csharp
var completion = new TaskCompletionSource<string>(
    TaskCreationOptions.RunContinuationsAsynchronously);

void OnMessageReceived(string message)
{
    completion.TrySetResult(message);
}

Task<string> messageTask = completion.Task;
```

`TaskCompletionSource<T>` owns completion. Consumers receive the `Task<T>` and can await the result without being able to complete it themselves.

## Gotchas

- Do not expose completion control to callers that should only await the result.
- Always decide how errors and cancellation complete the future.
- Beware of promises or tasks that can never complete; add timeouts when waiting on external events.
- In .NET, use `RunContinuationsAsynchronously` with `TaskCompletionSource<T>` unless inline continuations are deliberately desired.
- In JavaScript, promise callbacks run in the microtask queue; scheduling behavior can matter for UI and test timing.

## Related Concepts

- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview]]
- [[Async]]
- [[Producer-Consumer]]
- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool]]
- [[JavaScript Fundamentals]]

## Resources

- Microsoft Learn: Task-based Asynchronous Pattern
- Microsoft Learn: TaskCompletionSource
- MDN: Promise

## Practice Exercises

1. Wrap a callback-style API in a `TaskCompletionSource<T>` and expose only `Task<T>` to callers.
2. Compare `Task.WhenAll` with JavaScript `Promise.all` for success and failure behavior.
3. Add timeout handling to an awaitable operation that depends on an external event.

## Review Schedule

- [ ] Review in 3 months
