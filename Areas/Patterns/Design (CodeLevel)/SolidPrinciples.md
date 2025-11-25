# SOLID Principles
Date: 2025-11-25
Status: 🟢 Current
Tags: #design #architecture #csharp #solid #principles

## 🎯 TL;DR / Quick Reference

**Definition:** A set of five principles for object-oriented design to improve maintainability and extensibility: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion.

**When to use:**
- Designing classes and APIs for medium-to-large systems.

**Key Takeaways:**
- ✅ **SRP:** A class should have one reason to change.
- ✅ **OCP:** Extend behavior via abstractions, not modifications.
- ✅ **LSP:** Subtypes must be substitutable for base types.
- ✅ **ISP:** Prefer many specific interfaces over one large interface.
- ✅ **DIP:** High-level modules should not depend on low-level modules directly.

**Code Snippet (DIP example):**
```csharp
public interface ILogger { void Log(string msg); }
public class OrderService { private readonly ILogger _log; public OrderService(ILogger log) => _log = log; }
```

**Gotchas:**
- ⚠️ **Over-engineering:** Following SOLID blindly leads to unnecessary abstractions.
- ⚠️ **Premature Interfaces:** Create interfaces when they solve a real problem (testing, replacement).

---

## 📚 Deep Dive

### Conceptual Foundation
SOLID principles aim to reduce coupling and increase cohesion. They work well together but should be applied pragmatically.

### Practical Patterns
- Use aggregate roots and domain services in DDD to observe SRP.
- Favor composition over inheritance (relates to OCP and LSP).
- Keep interfaces small and focused — `IWriteRepository<T>` vs `IRepository<T>`.

### Measuring Success
- Easier to test, smaller classes, fewer regressions when requirements change.
- Code review focus: identify classes doing multiple responsibilities.

---

## 🔗 Related Concepts
- [[RepositoryUnitOfWork]]
- [[CleanArchitecture]]

## 📖 Resources
- Uncle Bob: SOLID Principles
- Microsoft .NET guidance

## 🧪 Practice Exercises
1. Identify a class with multiple responsibilities and refactor into SRP-compliant pieces.
2. Replace a concrete dependency with an interface to apply DIP and add a unit test.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
