---
date: 2025-06-12
status: Current
tags:
  - design
  - architecture
  - solid
  - principles
  - ocp

---

# Open/Closed Principle (OCP)

## Quick Reference
**Definition:** At a known variation point, design a module so a new variant can be added with localized changes while its stable policy remains intact. This is the practical intent of being open for extension and closed for modification.

**When to use:**
- Designing a system where new variants, strategies, or features will be added over time.
- When adding a variant repeatedly changes several callers or policy branches. A single small `switch` is not itself evidence that an abstraction is needed.

**Key Takeaways:**
- Put an abstraction at a variation point only when the variants and their contract are stable enough to justify it.
- Extension should localize change; composition, registration, and tests may still need edits.
- [[Strategy]] and [[Decorator]] are examples of extension techniques, not mandatory implementations.
- Keep a simple conditional when variants are few and a dispatch abstraction would add more cost than it saves.

**Code Snippet:**
```csharp
// Avoid: Adding a new discount type requires modifying this class
public class DirectDiscountCalculator
{
    public decimal Calculate(Order order, string discountType)
    {
        if (discountType == "seasonal") return order.Total * 0.9m;
        if (discountType == "loyalty")  return order.Total * 0.85m;
        return order.Total;
    }
}

// Extension point: New strategy types can leave calculator policy unchanged; composition still changes
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
- Caution: **Premature abstraction:** Abstracting before you have two real variants produces unnecessary complexity.
- Caution: **Leaky abstractions:** An interface that exposes implementation details of just one variant is not truly extensible.
- Caution: **OCP ≠ never modify:** Configuration, bug fixes, and genuine redesign all justify modification. OCP governs *feature extension*.

---

## Deep Dive
### Conceptual Foundation
Bertrand Meyer introduced OCP in *Object-Oriented Software Construction* (1988). The modern interpretation — via Robert C. Martin — focuses on **polymorphic OCP**: close a module against a category of change by depending on an abstraction that all future variants will implement.

The useful design step is to identify a recurring axis of variation and protect stable policy from it. A module can be extensible on one axis while still needing ordinary edits for other requirements.

### Common Patterns That Implement OCP
| Pattern                 | How it applies OCP                                     |
| ----------------------- | ------------------------------------------------------ |
| [[Strategy]]            | Swap algorithms without modifying the consumer         |
| [[Decorator]]           | Add behaviour by wrapping, not touching the original   |
| [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Design Patterns/Structural Patterns/Plugin|Plugin Pattern]] | Register new handlers without modifying the dispatcher |
| [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Design Patterns/Enterprise Application Patterns/Specification|Specification Pattern]] | Add new filter rules as new classes                    |

### Relationship to Other Principles
- DIP can help keep stable policy independent of interchangeable implementations; it is not required for every extension.
- SRP can reveal a distinct reason for change worth isolating.
- LSP matters when extension uses a subtype that must meet an existing behavioural contract.

### Measuring Success
- A new variant changes the intended extension point and its composition, without scattering edits through unrelated policy code.
- Compare this benefit with the cost of extra types, registration, and indirection; a local conditional can be clearer for a small stable set.

---

## Related Concepts
- [[SOLID Principles]]
- [[Single Responsibility Principle]]
- [[Liskov Substitution Principle]]
- [[Dependency Inversion Principle]]
- [[Dependency Injection]]

## Resources
- [Robert C. Martin, *The Open Closed Principle* (2014)](https://blog.cleancoder.com/uncle-bob/2014/05/12/TheOpenClosedPrinciple.html) — original-author discussion of Meyer’s principle and extension points; accessed 2026-09-24.
- Bertrand Meyer, *Object-Oriented Software Construction* (1988) — original book context; edition/page not checked.

## Practice Exercises
1. Compare a small local `switch` with a Strategy implementation. Choose the design with clearer change scope for the expected variants.
2. Add one export format; record which policy, composition, and test files changed. Aim to localize edits, not to promise zero edits.

## Review Schedule
- Review when expected variation changes or a concrete extension point is used in production.
