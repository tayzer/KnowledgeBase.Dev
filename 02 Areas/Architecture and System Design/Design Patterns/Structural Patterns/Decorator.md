---
date: 2026-06-13
status: Current
tags:
  - design-patterns
  - architecture
  - decorator
  - wrapping
  - composition

---

# Decorator

## Quick Reference

**Definition:** A pattern that adds behavior to an object by wrapping it with another object that implements the same interface.

**When to use:**
- You need to add optional or layered behavior without changing the core implementation.
- You want to compose cross-cutting concerns like logging, caching, retry, or metrics.

**Key Takeaways:**
- Keep the wrapped object and the decorator on the same contract.
- Use decorators to layer behavior, not to select between unrelated algorithms.
- Works well with DI because decorators can be registered around the core implementation.
- Caution: Too many decorators can make the call chain hard to follow.

**Code Snippet:**
```csharp
public interface IMessageSender
{
	Task SendAsync(string message);
}

public sealed class EmailSender : IMessageSender
{
	public Task SendAsync(string message) => Task.CompletedTask;
}

public sealed class LoggingMessageSender : IMessageSender
{
	private readonly IMessageSender _inner;

	public LoggingMessageSender(IMessageSender inner) => _inner = inner;

	public async Task SendAsync(string message)
	{
		Console.WriteLine($"Sending: {message}");
		await _inner.SendAsync(message);
	}
}
```

**Gotchas:**
- Caution: Decorators should preserve the contract; if they change the meaning of the operation, the abstraction is too loose.
- Caution: Avoid decorating everything when a simple helper method would do.

---

## Deep Dive

### Conceptual Foundation
Decorator is composition-based extension. The wrapper delegates to the wrapped object and adds behavior before or after the call.

### Practical Guidance
- Prefer decorators when behavior is orthogonal to the core responsibility.
- Keep decorators small and single-purpose.
- Register the core service first, then layer decorators at the composition root or container level.

### Comparison With Alternatives
- Use **Strategy** when you need one of several algorithms, not layered behavior.
- Use **Plugin** when the host should run multiple interchangeable handlers.
- Use inheritance only when the extra behavior is truly part of the type's core identity.

### Order and failure behavior

`new LoggingDecorator(new RetryDecorator(inner))` logs once around the whole retry; reversing the wrappers can log each attempt. If retry is involved, define idempotency, maximum attempts, and cancellation; avoid retrying side effects blindly. Log operation metadata rather than sensitive message bodies. A decorator can also wrap a versioned adapter while clients migrate contracts, but it does not itself perform version migration. [Decorator pattern explanation](https://refactoring.guru/design-patterns/decorator) (secondary; checked 2026-09-24).

## Related Concepts
- [[Polymorphism]]
- [[Strategy]]
- [[Dependency Injection]]
- [[Open-Closed Principle]]
- [[Plugin]]

## Resources
- Refactoring.Guru: Decorator
- GoF: Design Patterns

## Practice Exercises
1. Wrap an existing sender with logging, then add retry as a second decorator.
2. Refactor a class with `if` flags for optional behavior into a decorator chain.

## Personal Notes

- **Practitioner observation, retained from the source:** A versioned adapter can wrap an existing implementation while consumers migrate to a new interface; test that the wrapper preserves old behavior and states which version it presents.

## Sources

- [Refactoring.Guru, Decorator](https://refactoring.guru/design-patterns/decorator) — secondary explainer, undated; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
