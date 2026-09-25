---
date: 2026-06-13
status: Current
tags:
  - architecture
  - patterns
  - dependency-injection
  - constructor-injection
  - design

---

# Constructor Injection

## Quick Reference

**Definition:** Required dependencies are provided through a class constructor and stored for use during the object lifetime.

**When to use:**
- Services that cannot function correctly without specific collaborators.
- Most application services and domain services in DI-based architectures.

**Key Takeaways:**
- Best default for DI because dependencies are explicit and required.
- Improves testability by making collaborators easy to substitute.
- Supports immutability of dependencies via `readonly` fields.

**Code Snippet:**
```csharp
public interface IOrderWriter
{
    void Save(Order order);
}

public class OrderService
{
    private readonly IOrderWriter _writer;

    public OrderService(IOrderWriter writer)
    {
        _writer = writer;
    }

    public void PlaceOrder(Order order) => _writer.Save(order);
}
```

**Gotchas:**
- Caution: Constructor parameter explosion can indicate SRP problems.
- Caution: Optional dependencies should not be forced into constructor parameters.

---

## Deep Dive

### Why It Is Preferred
Constructor injection enforces object validity at creation time. If a required collaborator is missing, object creation fails immediately rather than producing a partially configured object.

### Good Fit
- Application services with required infrastructure collaborators.
- Handlers, orchestrators, and use-case classes.
- Components where deterministic behavior and testability are priorities.

### Less Suitable
- Rare optional integrations that are used conditionally.
- Per-call collaborators that vary for each method invocation.

---

### Constructor contract

Use constructor parameters for collaborators required to create a valid instance. Validate non-null references at the boundary when nullable annotations or callers do not prove the invariant. Inject a concrete class when it is a stable appropriate dependency; an interface is helpful when it represents a meaningful boundary, not mandatory for every collaborator. An application service's constructor need not own every domain rule. [Fowler DI article](https://www.martinfowler.com/articles/injection.html) and [.NET DI guidance](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection) (checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Dependency Inversion Principle]]
- [[Single Responsibility Principle]]
- [[Property Injection]]
- [[Method Injection]]

## Resources
- Microsoft Docs — Dependency Injection in ASP.NET Core
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## Practice Exercises
1. Refactor one service that creates `new` collaborators internally to constructor injection.
2. Write a unit test that uses a fake implementation for one constructor dependency.

## Sources

- [Martin Fowler, Inversion of Control Containers and the Dependency Injection pattern](https://www.martinfowler.com/articles/injection.html) — 2004; accessed 2026-09-24.
- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
