# Constructor Injection
Date: 2026-06-13
Status: 🟢 Current
Tags: #architecture #patterns #dependency-injection #constructor-injection #design

## 🎯 TL;DR / Quick Reference

**Definition:** Required dependencies are provided through a class constructor and stored for use during the object lifetime.

**When to use:**
- Services that cannot function correctly without specific collaborators.
- Most application services and domain services in DI-based architectures.

**Key Takeaways:**
- ✅ Best default for DI because dependencies are explicit and required.
- ✅ Improves testability by making collaborators easy to substitute.
- ✅ Supports immutability of dependencies via `readonly` fields.

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
- ⚠️ Constructor parameter explosion can indicate SRP problems.
- ⚠️ Optional dependencies should not be forced into constructor parameters.

---

## 📚 Deep Dive

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

## 🔗 Related Concepts
- [[DependencyInjection]]
- [[DIP]]
- [[SRP]]
- [[PropertyInjection]]
- [[MethodInjection]]

## 📖 Resources
- Microsoft Docs — Dependency Injection in ASP.NET Core
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## 🧪 Practice Exercises
1. Refactor one service that creates `new` collaborators internally to constructor injection.
2. Write a unit test that uses a fake implementation for one constructor dependency.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
