# Single Responsibility Principle (SRP)
Date: 2025-06-12
Status: 🟢 Current
Tags: #design #architecture #solid #principles #srp

## 🎯 TL;DR / Quick Reference

**Definition:** A class should have only one reason to change — it should have a single, well-defined responsibility.

**When to use:**
- Designing any class, service, or module that risks becoming a "god object."
- When a class is hard to test because it does too many things.

**Key Takeaways:**
- ✅ One class = one cohesive responsibility, not one method.
- ✅ "Reason to change" = a stakeholder or actor whose requirements drive that code.
- ✅ Related behaviour can coexist in one class as long as it serves the same actor.
- ✅ Splitting is warranted when two responsibilities change at different rates or for different people.

**Code Snippet:**
```csharp
// ❌ Violates SRP — handles both business logic and persistence
public class OrderService
{
    public void PlaceOrder(Order order) { /* business rules */ }
    public void SaveToDatabase(Order order) { /* SQL */ }
}

// ✅ Responsibilities separated
public class OrderService
{
    private readonly IOrderRepository _repo;
    public OrderService(IOrderRepository repo) => _repo = repo;
    public void PlaceOrder(Order order) { /* business rules only */ _repo.Save(order); }
}

public class SqlOrderRepository : IOrderRepository
{
    public void Save(Order order) { /* SQL only */ }
}
```

**Gotchas:**
- ⚠️ **Over-splitting:** Not every method warrants its own class. Group related behaviour that changes together.
- ⚠️ **Confusing SRP with "one method per class":** SRP is about cohesion around an actor, not method count.
- ⚠️ **Premature separation:** Split when a second responsibility actually emerges, not speculatively.

---

## 📚 Deep Dive

### Conceptual Foundation
Robert C. Martin defines "responsibility" as a reason to change driven by a specific **actor** — a person or group of people that requests changes. `OrderService` that also formats PDF invoices has two actors: the business rules team and the reporting team. When either changes their requirements, the class must change.

A useful heuristic: if you describe a class and need to use the word "and", it probably violates SRP.

### Common Violations
| Pattern | Symptom |
|---|---|
| God class | Hundreds of methods, multiple unrelated domains |
| Fat service | Business logic, persistence, and HTTP concerns in one service |
| Mixed abstraction levels | Low-level DB calls inside high-level orchestration |

### Relationship to Other Principles
- SRP is a prerequisite for **OCP**: you can only extend a stable behaviour without modifying if that behaviour is isolated.
- Classes with a single responsibility are easier to mock in tests, supporting **DIP**.
- Domain-Driven Design's aggregate roots and domain services naturally enforce SRP by grouping behaviour around a bounded concept.

### Measuring Success
- Each class has a one-sentence description without "and."
- Unit tests are small and focused — a test failure points clearly to one cause.
- Refactoring one feature doesn't ripple across unrelated classes.

---

## 🔗 Related Concepts
- [[SOLID]]
- [[OCP]]
- [[DIP]]
- [[CleanArchitecture]]
- [[RepositoryUnitOfWork]]

## 📖 Resources
- Robert C. Martin — *Clean Code*, Chapter 10
- Uncle Bob: "The Single Responsibility Principle" (blog.cleancoder.com)

## 🧪 Practice Exercises
1. Find a class in your codebase with more than two public responsibilities. Separate them and verify existing tests still pass.
2. Write a one-sentence description for each class in a feature. Flag any that require "and."

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
