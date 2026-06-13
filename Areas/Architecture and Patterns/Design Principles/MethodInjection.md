# Method Injection
Date: 2026-06-13
Status: 🟢 Current
Tags: #architecture #patterns #dependency-injection #method-injection #design

## 🎯 TL;DR / Quick Reference

**Definition:** A dependency is passed as a method parameter for a specific operation rather than stored on the class.

**When to use:**
- The collaborator varies per call.
- You want to keep a class free from long-lived dependency state.

**Key Takeaways:**
- ✅ Great for per-request or per-operation collaborators.
- ✅ Keeps constructor smaller when dependency is not globally required.
- ⚠️ Overuse can create noisy method signatures.

**Code Snippet:**
```csharp
public interface IDiscountPolicy
{
    decimal Apply(Order order);
}

public class CheckoutService
{
    public decimal CalculateTotal(Order order, IDiscountPolicy discountPolicy)
    {
        var subtotal = order.Lines.Sum(l => l.UnitPrice * l.Quantity);
        return discountPolicy.Apply(order) switch
        {
            var discount => subtotal - discount
        };
    }
}
```

**Gotchas:**
- ⚠️ If every method needs the same dependency, constructor injection is clearer.
- ⚠️ Passing too many dependencies per call can reduce readability.

---

## 📚 Deep Dive

### Typical Scenarios
- Strategy-like behavior selected at runtime.
- Background jobs that accept runtime-specific collaborators.
- Pipelines where each stage receives context-specific services.

### Decision Heuristic
Use method injection when dependency lifetime is naturally scoped to one call and is not part of the object's core identity.

---

## 🔗 Related Concepts
- [[DependencyInjection]]
- [[DIP]]
- [[ConstructorInjection]]
- [[PropertyInjection]]

## 📖 Resources
- *Clean Architecture* — Robert C. Martin
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## 🧪 Practice Exercises
1. Replace one conditional branch with method-injected strategy behavior.
2. Audit a class and move any per-call dependency from constructor to method parameters.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
