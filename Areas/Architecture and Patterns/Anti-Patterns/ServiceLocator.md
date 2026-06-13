# Service Locator
Date: 2026-06-13
Status: 🟢 Current
Tags: #architecture #anti-patterns #dependency-injection #service-locator #design

## 🎯 TL;DR / Quick Reference

**Definition:** A pattern where classes pull dependencies from a global or ambient container (`Resolve<T>()`) instead of receiving them explicitly.

**When to avoid:**
- Nearly always in application and domain code.
- Any codebase where testability and explicit dependencies matter.

**Key Takeaways:**
- ❌ Hides true dependencies from constructors and APIs.
- ❌ Makes unit tests harder because hidden collaborators must be configured globally.
- ❌ Breaks DIP in practice by coupling call sites to a service lookup mechanism.

**Code Snippet:**
```csharp
// ❌ Service Locator hides dependencies
public class OrderService
{
    public void PlaceOrder(Order order)
    {
        var writer = ServiceLocator.Resolve<IOrderWriter>();
        writer.Save(order);
    }
}

// ✅ Prefer constructor injection
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
- ⚠️ Runtime failures appear late when registrations are missing.
- ⚠️ Refactoring safety drops because usage is hidden from signatures.

---

## 📚 Deep Dive

### Why It Hurts Design
With service locator, a class can look dependency-free while secretly relying on multiple services. This obscures architecture boundaries and makes contracts implicit.

### Narrow Exception
In composition root or framework glue code, direct container access can be acceptable. Keep this at the edge, never in domain or application logic.

---

## 🔗 Related Concepts
- [[DependencyInjection]]
- [[DIP]]
- [[ConstructorInjection]]
- [[ISP]]

## 📖 Resources
- Mark Seemann — "Service Locator is an Anti-Pattern"
- Microsoft Docs — Dependency Injection in ASP.NET Core

## 🧪 Practice Exercises
1. Find one class using `IServiceProvider` or `Resolve<T>()` in business logic; convert it to constructor injection.
2. Add a unit test that verifies dependencies are explicit through constructor parameters.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
