# Dependency Injection (DI)
Date: 2025-11-25
Status: 🟢 Current
Tags: #csharp #dotnet #dependency-injection #architecture #patterns

## 🎯 TL;DR / Quick Reference

**Definition:** A pattern where dependencies are provided to objects rather than created by them; commonly implemented via constructor injection, property injection, or method injection.

**When to use:**
- Decoupling components for testability and modularity.
- Managing service lifetimes in frameworks (ASP.NET Core DI container).

**Key Takeaways:**
- ✅ **Constructor injection** is preferred for required dependencies.
- ✅ **Avoid service locator** pattern; prefer explicit injection.
- ⚡ **Lifetimes matter:** [[SingletonLifetime|Singleton]], [[ScopedLifetime|Scoped]], [[TransientLifetime|Transient]] and choose correctly.

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
- ⚠️ **Captive dependency:** Injecting a `Scoped` service into a `Singleton` leads to captured state problems.
- ⚠️ **Over-injection:** Classes with many dependencies may indicate SRP violation.

---

## 📚 Deep Dive

### Conceptual Foundation
DI separates the construction of an object from its behavior. The composition root (app startup) wires concrete implementations.

### Patterns and Best Practices
- Prefer constructor injection for required dependencies, properties for optional.
- Use interfaces for abstractions; keep concrete classes only in the composition root.
- Keep the DI container usage minimal to maintain testability.

### Lifetime Implications
- [[SingletonLifetime|Singleton]] and one instance for app lifetime. Use for stateless or thread-safe caches.
- [[ScopedLifetime|Scoped]] and one instance per logical scope (HTTP request in ASP.NET Core).
- [[TransientLifetime|Transient]] and new instance each resolution (good for lightweight stateless services).

### Advanced Topics
- Factories and `Func<T>` registrations for on-demand creation.
- `IServiceProvider` can be used for late binding but use sparingly.
- Use third-party containers (Autofac) when you need advanced features.

---

## 🔗 Related Concepts
- [[ConfigurationOptionsPattern]]
- [[RepositoryUnitOfWork]]
- [[ConstructorInjection]]
- [[PropertyInjection]]
- [[MethodInjection]]
- [[ServiceLocator]]
- [[SingletonLifetime]]
- [[ScopedLifetime]]
- [[TransientLifetime]]

## 📖 Resources
- Microsoft Docs: Dependency injection in .NET
- Mark Seemann: Dependency Injection book

## 🧪 Practice Exercises
1. Replace direct `new` calls in a service with constructor injection and register services in `Startup`.
2. Create a `Scoped` repository and verify behavior under concurrent requests.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
