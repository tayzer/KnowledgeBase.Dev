---
date: 2025-11-25
status: Current
tags:
  - csharp
  - dotnet
  - dependency-injection
  - architecture
  - patterns

---

# Dependency Injection (DI)

## Quick Reference

**Definition:** A pattern where dependencies are provided to objects rather than created by them; commonly implemented via constructor injection, property injection, or method injection.

**When to use:**
- Decoupling components for testability and modularity.
- Managing service lifetimes in frameworks (ASP.NET Core DI container).

**Key Takeaways:**
- **Constructor injection** is preferred for required dependencies.
- **Avoid service locator** pattern; prefer explicit injection.
- Tip: **Lifetimes matter:** [[Singleton Lifetime|Singleton]], [[Scoped Lifetime|Scoped]], [[Transient Lifetime|Transient]] and choose correctly.

**Code Snippet:**
```csharp
public class OrderService
{
    private readonly IRepository<Order> _repo;
    public OrderService(IRepository<Order> repo) => _repo = repo;
}
// Registration
services.AddScoped<IRepository<Order>, EfOrderRepository>();
```

**Gotchas:**
- Caution: **Captive dependency:** Injecting a `Scoped` service into a `Singleton` leads to captured state problems.
- Caution: **Over-injection:** Classes with many dependencies may indicate SRP violation.

---

## Deep Dive

### Conceptual Foundation
DI separates the construction of an object from its behavior. The composition root (app startup) wires concrete implementations.

### Patterns and Best Practices
- Prefer constructor injection for required dependencies, properties for optional.
- Use an interface where it represents a useful contract; concrete registrations are also valid.
- Keep the DI container usage minimal to maintain testability.

### Lifetime Implications
- [[Singleton Lifetime|Singleton]] and one instance for app lifetime. Use for stateless or thread-safe caches.
- [[Scoped Lifetime|Scoped]] and one instance per logical scope (HTTP request in ASP.NET Core).
- [[Transient Lifetime|Transient]] and new instance each resolution (good for lightweight stateless services).

### Advanced Topics
- Factories and `Func<T>` registrations let a class ask for a dependency only when it needs one, rather than receiving it up front. Use them when creation should be delayed until runtime, or when only some code paths need the object. Keep the factory itself injected so the dependency stays explicit; do not use the container directly from the class.
- `IServiceProvider` can be used for late binding but use sparingly.
- Use third-party containers (Autofac) when you need advanced features.

---

### Generic pattern and .NET container

DI means a caller receives collaborators from outside rather than constructing them inside. In the built-in .NET container, register services in `Program.cs` and choose transient, scoped, or singleton lifetimes deliberately. Constructor injection supports required dependencies; property assignment is optional wiring and the built-in container does not automatically inject arbitrary properties. Inject factories for runtime selection only when their construction and disposal behavior are explicit. Avoid resolving from `IServiceProvider` inside ordinary business methods. [Microsoft DI guidance](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection-guidelines) (checked 2026-09-24).

## Related Concepts
- [[ASP.NET Core Options Pattern]]
- [[Unit of Work]]
- [[Constructor Injection]]
- [[Property Injection]]
- [[Method Injection]]
- [[Service Locator]]
- [[Singleton Lifetime]]
- [[Scoped Lifetime]]
- [[Transient Lifetime]]

## Resources
- Microsoft Docs: Dependency injection in .NET
- Mark Seemann: Dependency Injection book

## Practice Exercises
1. Replace direct `new` calls in a service with constructor injection and register services in `Program.cs` for a current ASP.NET Core minimal-hosting application; older `Startup`-based applications register services in `Startup.ConfigureServices`.
2. Create a `Scoped` repository and verify distinct instances across request scopes; test data access against the actual provider.

## Sources

- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
