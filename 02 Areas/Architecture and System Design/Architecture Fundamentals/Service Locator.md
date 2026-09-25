---
date: 2026-06-13
status: Current
tags:
  - architecture
  - anti-patterns
  - dependency-injection
  - service-locator
  - design

---

# Service Locator

## Quick Reference

**Definition:** A pattern where classes pull dependencies from a global or ambient container (`Resolve<T>()`) instead of receiving them explicitly.

**When to avoid:**
- Nearly always in application and domain code.
- Any codebase where testability and explicit dependencies matter.

**Key Takeaways:**
- Avoid: Hides true dependencies from constructors and APIs.
- Avoid: Makes unit tests harder because hidden collaborators must be configured globally.
- Avoid in application/domain methods: runtime lookup hides dependencies and couples call sites to a service-provider API; use explicit injection at those boundaries.

**Code Snippet:**
```csharp
// Avoid: Service Locator hides dependencies
public class OrderService
{
    public void PlaceOrder(Order order)
    {
        var writer = ServiceLocator.Resolve<IOrderWriter>();
        writer.Save(order);
    }
}

// Preferred: Prefer constructor injection
public class BetterOrderService
{
    private readonly IOrderWriter _writer;

    public BetterOrderService(IOrderWriter writer)
    {
        _writer = writer;
    }

    public void PlaceOrder(Order order) => _writer.Save(order);
}
```

**Gotchas:**
- Caution: Runtime failures appear late when registrations are missing.
- Caution: Refactoring safety drops because usage is hidden from signatures.

---

## Deep Dive

### Why It Hurts Design
With service locator, a class can look dependency-free while secretly relying on multiple services. This obscures architecture boundaries and makes contracts implicit.

### Narrow Exception
In composition root or framework glue code, direct container access can be acceptable. Keep this at the edge, never in domain or application logic.

---

### Scope of the warning

Avoid resolving application/domain dependencies from `IServiceProvider` inside business methods: required collaborators become hard to inspect and test. At the composition root or framework boundary, the provider can legitimately build an object graph or select a runtime implementation. Service location does not automatically violate dependency inversion; the concern is hidden runtime coupling. [Fowler's DI article](https://www.martinfowler.com/articles/injection.html) (2004) and [Microsoft DI guidance](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection-guidelines) (checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Dependency Inversion Principle]]
- [[Constructor Injection]]
- [[Interface Segregation Principle]]

## Resources
- Mark Seemann — "Service Locator is an Anti-Pattern"
- Microsoft Docs — Dependency Injection in ASP.NET Core

## Practice Exercises
1. Find one class using `IServiceProvider` or `Resolve<T>()` in business logic; convert it to constructor injection.
2. Add a unit test that verifies dependencies are explicit through constructor parameters.

## Sources

- [Martin Fowler, Inversion of Control Containers and the Dependency Injection pattern](https://www.martinfowler.com/articles/injection.html) — 2004; accessed 2026-09-24.
- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
