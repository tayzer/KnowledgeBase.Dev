---
date: 2026-06-13
status: Current
tags:
  - architecture
  - patterns
  - dependency-injection
  - property-injection
  - design

---

# Property Injection

## Quick Reference

**Definition:** Dependencies are assigned through settable properties after object construction.

**When to use:**
- Optional dependencies where a sensible default behavior exists.
- Framework scenarios only when that framework explicitly supports property wiring; ordinary property assignment does not imply container injection.

**Key Takeaways:**
- Useful for optional collaborators.
- Caution: Weaker than constructor injection because object validity is not guaranteed at creation.
- Caution: Requires null-safety or default implementations to avoid runtime failures.

**Code Snippet:**
```csharp
public interface IAuditSink
{
    void Write(string message);
}

public class NullAuditSink : IAuditSink
{
    public void Write(string message) { }
}

public class OrderService
{
    // Optional dependency with a safe default.
    public IAuditSink AuditSink { get; set; } = new NullAuditSink();

    public void PlaceOrder(Order order)
    {
        // business logic
        AuditSink.Write($"Order placed: {order.Id}");
    }
}
```

**Gotchas:**
- Caution: Hidden required dependencies cause late runtime null failures.
- Caution: Mutable properties can be changed unexpectedly after construction.

---

## Deep Dive

### Design Guidance
Use property injection only when the dependency is truly optional and the class remains valid without it. For required dependencies, prefer constructor injection.

### Practical Rule
If a class throws or misbehaves when a dependency property is not set, that dependency is required and should move to the constructor.

---

### Mutation after construction

The sample manually assigns an optional property; the built-in .NET DI container does not automatically fill it. Replacing that property while another thread calls `PlaceOrder` can make behavior inconsistent, so configure it before publishing the object or use an immutable alternative. Required dependencies belong in the constructor. [Microsoft DI guidance](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection-guidelines) (checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Dependency Inversion Principle]]
- [[Constructor Injection]]
- [[Method Injection]]

## Resources
- Microsoft Docs — Dependency Injection in ASP.NET Core
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## Practice Exercises
1. Identify one property-injected dependency and decide if it is truly optional.
2. Convert one required property dependency to constructor injection.

## Sources

- [Martin Fowler, Inversion of Control Containers and the Dependency Injection pattern](https://www.martinfowler.com/articles/injection.html) — 2004; accessed 2026-09-24.
- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
