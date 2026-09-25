---
date: 2025-06-12
status: Current
tags:
  - design
  - architecture
  - solid
  - principles
  - srp

---

# Single Responsibility Principle (SRP)

## Quick Reference

**Definition:** Group code that changes for the same actor or reason, and separate code changed for independent reasons. Apply the boundary to a module or class at the level useful to its callers.

**When to use:**
- Designing a class or module that is changed by unrelated actors or concerns.
- When a class is hard to test because it does too many things.

**Key Takeaways:**
- One class = one cohesive responsibility, not one method.
- "Reason to change" = a stakeholder or actor whose requirements drive that code.
- Related behaviour can coexist in one class as long as it serves the same actor.
- Consider splitting when independent actors cause conflicting changes; change frequency alone is a clue, not proof.

**Code Snippet:**
```csharp
// Avoid: Violates SRP — handles both business logic and persistence
public class MixedOrderService
{
    public void PlaceOrder(Order order) { /* business rules */ }
    public void SaveToDatabase(Order order) { /* SQL */ }
}

// Preferred: Responsibilities separated
public interface IOrderStore
{
    void Save(Order order);
}

public class OrderService
{
    private readonly IOrderStore _store;
    public OrderService(IOrderStore store) => _store = store;
    public void PlaceOrder(Order order) { /* business rules only */ _store.Save(order); }
}

public class SqlOrderStore : IOrderStore
{
    public void Save(Order order) { /* SQL only */ }
}
```

**Gotchas:**
- Caution: **Over-splitting:** Not every method warrants its own class. Group related behaviour that changes together.
- Caution: **Confusing SRP with "one method per class":** SRP is about cohesion around an actor, not method count.
- Caution: **Premature separation:** Split when a second responsibility actually emerges, not speculatively.

---

## Deep Dive

### Conceptual Foundation
Robert C. Martin defines "responsibility" as a reason to change driven by a specific **actor** — a person or group of people that requests changes. `OrderService` that also formats PDF invoices has two actors: the business rules team and the reporting team. When either changes their requirements, the class must change.

A useful diagnostic is to examine recent change requests: did unrelated actors repeatedly edit the same module? A description containing "and" may prompt discussion, but grammar alone does not diagnose SRP.

### Common Violations
| Pattern | Symptom |
|---|---|
| God class | Hundreds of methods, multiple unrelated domains |
| Fat service | Business logic, persistence, and HTTP concerns in one service |
| Mixed abstraction levels | Low-level DB calls inside high-level orchestration |

### Relationship to Other Principles
- A cohesive module can make an OCP extension point easier to identify, but OCP does not mechanically require SRP.
- Separating infrastructure changes from policy can support a useful DIP boundary; mockability alone is not the goal.
- A DDD aggregate or domain service may contain several operations serving one cohesive domain responsibility; DDD does not automatically enforce SRP.

### Measuring Success
- Examine change history for unrelated reasons that repeatedly touch the same module.
- Ask which actor requested each change and whether the module boundary explains that grouping.
- Use test difficulty or change ripple as diagnostic prompts, not guaranteed measurements.

---

## Related Concepts
- [[SOLID Principles]]
- [[Open-Closed Principle]]
- [[Dependency Inversion Principle]]
- [[Clean Architecture]]
- [[Unit of Work]]

## Resources
- [Robert C. Martin, *The Single Responsibility Principle* (2014)](https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html) — original-author explanation of actor and change reasons; accessed 2026-09-24.
- Robert C. Martin, *Clean Code*, Chapter 10 — bibliographic background; edition/page not checked.

## Practice Exercises
1. Find a module touched by two unrelated change requests. Identify each actor and split only if that reduces change interference; run affected tests.
2. Describe one class’s responsibility and compare that description with its recent commits; use mismatches as questions for review.

## Review Schedule
- Review when a module gains a new actor or a cited design interpretation changes.
