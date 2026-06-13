# Property Injection
Date: 2026-06-13
Status: 🟢 Current
Tags: #architecture #patterns #dependency-injection #property-injection #design

## 🎯 TL;DR / Quick Reference

**Definition:** Dependencies are assigned through settable properties after object construction.

**When to use:**
- Optional dependencies where a sensible default behavior exists.
- Framework scenarios that manage object lifecycle and perform property wiring.

**Key Takeaways:**
- ✅ Useful for optional collaborators.
- ⚠️ Weaker than constructor injection because object validity is not guaranteed at creation.
- ⚠️ Requires null-safety or default implementations to avoid runtime failures.

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
- ⚠️ Hidden required dependencies cause late runtime null failures.
- ⚠️ Mutable properties can be changed unexpectedly after construction.

---

## 📚 Deep Dive

### Design Guidance
Use property injection only when the dependency is truly optional and the class remains valid without it. For required dependencies, prefer constructor injection.

### Practical Rule
If a class throws or misbehaves when a dependency property is not set, that dependency is required and should move to the constructor.

---

## 🔗 Related Concepts
- [[DependencyInjection]]
- [[DIP]]
- [[ConstructorInjection]]
- [[MethodInjection]]

## 📖 Resources
- Microsoft Docs — Dependency Injection in ASP.NET Core
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## 🧪 Practice Exercises
1. Identify one property-injected dependency and decide if it is truly optional.
2. Convert one required property dependency to constructor injection.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
