---
date: 2025-11-25
status: Current
tags:
  - csharp
  - dotnet
  - delegates
  - events
  - patterns

---

# Delegates, Events & Actions

## Quick Reference

**Definition:** Delegates are type-safe function pointers; `Action` and `Func` are common delegate types; events are a publisher/subscriber pattern built on delegates.

**When to use:**
- Callback patterns (e.g., completion handlers).
- Decoupling components — publish/subscribe.
- Passing behavior as parameters (higher-order functions).

**Key Takeaways:**
- **Type safety:** Delegates are checked at compile time.
- **Use `event` for encapsulation:** Exposes subscription but not invocation.
- Tip: **Multicast:** Delegates can hold invocation lists (multiple subscribers).
- **Concurrent events:** Capture the handler before invocation; a subscription change can still race with a call in progress.

**Code Snippet:**
```csharp
public class Timer
{
    public event Action? Elapsed; // subscribers can't invoke

    protected virtual void OnElapsed() => Elapsed?.Invoke();
}
```

**Gotchas:**
- Caution: **Null checks:** Always use the `?.Invoke()` pattern or copy to local var before invoking.
- Caution: **Memory leaks:** Unsubscribe events to avoid capturing objects longer than intended.

---

## Deep Dive

### Conceptual Foundation
Delegates wrap method references with a signature. They enable passing behavior, building DSLs, or implementing observer patterns through events.

### Implementation Details
- `Action<T1,T2>` — returns void.
- `Func<T1,TResult>` — returns TResult.
- `Predicate<T>` — a named delegate type taking `T` and returning `bool`.

Event raising pattern (thread-safe):
```csharp
var handler = Elapsed;
handler?.Invoke();
```
Concurrent unsubscription can race with invocation; coordinate explicitly if that matters to the application.

### When to prefer what
- Use delegates/Actions for internal callbacks.
- Use `event` when exposing a subscription surface to external callers.
- Consider `IObservable<T>` / Reactive Extensions for complex streaming scenarios.

### Performance & Safety
- Delegate invocation has a small overhead compared to direct calls.
- Avoid long-running work on event handlers; they execute on caller’s thread unless explicitly dispatched.

---

## Review refinements

Predicate<T> is a delegate type accepting T and returning bool, not obsolete shorthand for Func<T,bool>. An event publisher holds subscriber delegate references until unsubscribe or publisher collection. Copying a delegate locally or using conditional invocation handles null but does not guarantee a handler remains subscribed during concurrent changes. Synchronous handler exceptions propagate unless handled.

## Related Concepts
- [[LINQ]]
- [[Expression-Bodied Members]]
- [[Dependency Injection]] (delegates for factory registration)

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/events/) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: Delegates, Events and Lambdas](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/delegates/)
- Jon Skeet: events and delegates articles — precise article URL still needs identification; this label is not evidence for the claims above.

## Practice Exercises
1. Implement a `Button` class with a `Clicked` event and write a unit test that verifies subscription/unsubscription.
2. Replace a `Strategy` interface with `Func<T>` delegates in a small app.

## Review Schedule
- [ ] Review 6 months after promotion; use the approval date as the anchor
