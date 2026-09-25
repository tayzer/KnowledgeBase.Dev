---
date: 2026-06-13
status: Current
tags:
  - architecture
  - patterns
  - dependency-injection
  - method-injection
  - design

---

# Method Injection

## Quick Reference

**Definition:** A dependency is passed as a method parameter for a specific operation rather than stored on the class.

**When to use:**
- The collaborator varies per call.
- You want to keep a class free from long-lived dependency state.

**Key Takeaways:**
- Great for per-request or per-operation collaborators.
- Keeps constructor smaller when dependency is not globally required.
- Caution: Overuse can create noisy method signatures.

**Code Snippet:**
```csharp
public interface IDiscountPolicy
{
    decimal CalculateDiscount(Order order, decimal subtotal);
}

public class CheckoutService
{
    public decimal CalculateTotal(Order order, IDiscountPolicy discountPolicy)
    {
        var subtotal = order.Lines.Sum(l => l.UnitPrice * l.Quantity);
        var discountAmount = discountPolicy.CalculateDiscount(order, subtotal);
        if (discountAmount < 0m || discountAmount > subtotal)
            throw new ArgumentOutOfRangeException(nameof(discountPolicy));
        return subtotal - discountAmount;
    }
}
```

**Gotchas:**
- Caution: If every method needs the same dependency, constructor injection is clearer.
- Caution: Passing too many dependencies per call can reduce readability.

---

## Deep Dive

### Typical Scenarios
- Strategy-like behavior selected at runtime.
- Background jobs that accept runtime-specific collaborators.
- Pipelines where each stage receives context-specific services.

### Decision Heuristic
Use method injection when dependency lifetime is naturally scoped to one call and is not part of the object's core identity.

---

### Per-call variation

The same `CheckoutService` can calculate one order with a seasonal discount policy and another with a loyalty policy passed as a parameter. The policy returns a discount amount, bounded by the subtotal; callers should separately decide tax, rounding, and currency rules. This illustrates explicit method-parameter injection, not automatic container wiring. [Fowler's DI article](https://www.martinfowler.com/articles/injection.html) (2004; checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Dependency Inversion Principle]]
- [[Constructor Injection]]
- [[Property Injection]]

## Resources
- *Clean Architecture* — Robert C. Martin
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## Practice Exercises
1. Replace one conditional branch with method-injected strategy behavior.
2. Audit a class and move any per-call dependency from constructor to method parameters.

## Sources

- [Martin Fowler, Inversion of Control Containers and the Dependency Injection pattern](https://www.martinfowler.com/articles/injection.html) — 2004; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
