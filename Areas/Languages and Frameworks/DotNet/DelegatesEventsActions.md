# Delegates, Events & Actions
Date: 2025-11-25
Status: 🟢 Current
Tags: #csharp #dotnet #delegates #events #patterns

## 🎯 TL;DR / Quick Reference

**Definition:** Delegates are type-safe function pointers; `Action` and `Func` are common delegate types; events are a publisher/subscriber pattern built on delegates.

**When to use:**
- Callback patterns (e.g., completion handlers).
- Decoupling components — publish/subscribe.
- Passing behavior as parameters (higher-order functions).

**Key Takeaways:**
- ✅ **Type safety:** Delegates are checked at compile time.
- ✅ **Use `event` for encapsulation:** Exposes subscription but not invocation.
- ⚡ **Multicast:** Delegates can hold invocation lists (multiple subscribers).
- 🔒 **Thread-safety:** Use `Interlocked.CompareExchange` when raising events in multithreaded code.

**Code Snippet:**
```csharp
public class Timer
{
    public event Action? Elapsed; // subscribers can't invoke

    protected virtual void OnElapsed() => Elapsed?.Invoke();
}
```

**Gotchas:**
- ⚠️ **Null checks:** Always use the `?.Invoke()` pattern or copy to local var before invoking.
- ⚠️ **Memory leaks:** Unsubscribe events to avoid capturing objects longer than intended.

---

## 📚 Deep Dive

### Conceptual Foundation
Delegates wrap method references with a signature. They enable passing behavior, building DSLs, or implementing observer patterns through events.

### Implementation Details
- `Action<T1,T2>` — returns void.
- `Func<T1,TResult>` — returns TResult.
- `Predicate<T>` — shorthand for `Func<T,bool>` pre-C# 3.

Event raising pattern (thread-safe):
```csharp
var handler = Elapsed;
handler?.Invoke();
```
Or using `Interlocked` to avoid races when unsubscribing concurrently.

### When to prefer what
- Use delegates/Actions for internal callbacks.
- Use `event` when exposing a subscription surface to external callers.
- Consider `IObservable<T>` / Reactive Extensions for complex streaming scenarios.

### Performance & Safety
- Delegate invocation has a small overhead compared to direct calls.
- Avoid long-running work on event handlers; they execute on caller’s thread unless explicitly dispatched.

---

## 🔗 Related Concepts
- [[Linq]]
- [[ExpressionBodiedMembers]]
- [[DependencyInjection]] (delegates for factory registration)

## 📖 Resources
- Microsoft Docs: Delegates, Events and Lambdas
- Jon Skeet: events and delegates articles

## 🧪 Practice Exercises
1. Implement a `Button` class with a `Clicked` event and write a unit test that verifies subscription/unsubscription.
2. Replace a `Strategy` interface with `Func<T>` delegates in a small app.

## 📝 Personal Notes
<!-- observations -->

## 🔄 Review Schedule
- [ ] Review in 6 months
