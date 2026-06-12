# Open/Closed Principle (OCP)
Date: 2025-06-12
Status: 🟢 Current
Tags: #design #architecture #solid #principles #ocp

## 🎯 TL;DR / Quick Reference

**Definition:** Software entities should be **open for extension** but **closed for modification** — add new behaviour by adding new code, not by changing existing code.

**When to use:**
- Designing a system where new variants, strategies, or features will be added over time.
- When adding a new case requires touching a `switch` statement or `if/else` chain across multiple places.

**Key Takeaways:**
- ✅ Express variation through abstractions (interfaces, base classes, delegates).
- ✅ Existing, tested code stays untouched when requirements grow.
- ✅ The Strategy and Decorator patterns are direct implementations of OCP.
- ✅ OCP is only meaningful once variation is identified — don't abstract speculatively.

**Code Snippet:**
```csharp
// ❌ Adding a new discount type requires modifying this class
public class DiscountCalculator
{
    public decimal Calculate(Order order, string discountType)
    {
        if (discountType == "seasonal") return order.Total * 0.9m;
        if (discountType == "loyalty")  return order.Total * 0.85m;
        return order.Total;
    }
}

// ✅ New discount types are added without modifying existing code
public interface IDiscountStrategy
{
    decimal Apply(decimal total);
}

public class SeasonalDiscount : IDiscountStrategy
{
    public decimal Apply(decimal total) => total * 0.9m;
}

public class LoyaltyDiscount : IDiscountStrategy
{
    public decimal Apply(decimal total) => total * 0.85m;
}

public class DiscountCalculator
{
    private readonly IDiscountStrategy _strategy;
    public DiscountCalculator(IDiscountStrategy strategy) => _strategy = strategy;
    public decimal Calculate(Order order) => _strategy.Apply(order.Total);
}
```

**Gotchas:**
- ⚠️ **Premature abstraction:** Abstracting before you have two real variants produces unnecessary complexity.
- ⚠️ **Leaky abstractions:** An interface that exposes implementation details of just one variant is not truly extensible.
- ⚠️ **OCP ≠ never modify:** Configuration, bug fixes, and genuine redesign all justify modification. OCP governs *feature extension*.

---

## 📚 Deep Dive

### Conceptual Foundation
Bertrand Meyer introduced OCP in *Object-Oriented Software Construction* (1988). The modern interpretation — via Robert C. Martin — focuses on **polymorphic OCP**: close a module against a category of change by depending on an abstraction that all future variants will implement.

The key insight is that you predict *axes of change* and protect against them with abstractions. A module can be open on one axis and closed on another.

### Common Patterns That Implement OCP
| Pattern | How it applies OCP |
|---|---|
| Strategy | Swap algorithms without modifying the consumer |
| Decorator | Add behaviour by wrapping, not touching the original |
| Plugin / Provider model | Register new handlers without modifying the dispatcher |
| Specification | Add new filter rules as new classes |

### Relationship to Other Principles
- OCP depends on **DIP** — you can only close a module against change if it depends on abstractions, not concretions.
- Properly applied **SRP** makes it easier to identify which axis of change to protect.
- **LSP** ensures that extensions (subclasses / implementations) are genuinely interchangeable, making OCP safe.

### Measuring Success
- Adding a new variant (discount type, payment provider, export format) involves zero changes to existing classes.
- `switch`/`if-else` chains that enumerate types exist only at composition root (factory / DI registration), not in business logic.

---

## 🔗 Related Concepts
- [[SOLID]]
- [[SRP]]
- [[LSP]]
- [[DIP]]
- [[DependencyInjection]]

## 📖 Resources
- Bertrand Meyer — *Object-Oriented Software Construction*
- Robert C. Martin — *Agile Software Development: Principles, Patterns, and Practices*

## 🧪 Practice Exercises
1. Find a `switch` statement that dispatches on a type string. Replace it with an interface and Strategy pattern.
2. Add a new export format (e.g. CSV) to an existing reporting feature without touching any existing class.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
