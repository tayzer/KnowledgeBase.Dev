# SOLID Principles
Date: 2025-06-12
Status: 🟢 Current
Tags: #design #architecture #csharp #solid #principles

## 🎯 TL;DR / Quick Reference

**Definition:** A set of five principles for object-oriented design that reduce coupling, increase cohesion, and improve maintainability and extensibility.

| Principle | One-liner |
|---|---|
| [SRP](SRP.md) — Single Responsibility | A class should have one reason to change |
| [OCP](OCP.md) — Open/Closed | Open for extension, closed for modification |
| [LSP](LSP.md) — Liskov Substitution | Subtypes must be substitutable for their base types |
| [ISP](ISP.md) — Interface Segregation | Prefer many specific interfaces over one large one |
| [DIP](DIP.md) — Dependency Inversion | High-level modules depend on abstractions, not concretions |

**When to use:**
- Designing classes and APIs for medium-to-large systems.
- Code review checklist for spotting common OO design problems.

**Cross-cutting gotchas:**
- ⚠️ **Over-engineering:** Applying SOLID blindly leads to unnecessary abstractions — let real requirements drive splits.
- ⚠️ **Premature interfaces:** Create abstractions when they solve a real problem (testability, replacement, extension).
- ⚠️ **Principles reinforce each other:** DIP requires good ISP; OCP requires LSP; SRP enables all of them.

---

## 📚 How the Principles Relate

The five principles are not independent rules — they form a coherent system:

```
SRP  →  classes are small and focused, making the rest tractable
OCP  →  extend via abstractions (requires DIP)
LSP  →  ensures OCP extensions are safe to substitute
ISP  →  keeps abstractions narrow (prevents LSP violations from fat interfaces)
DIP  →  ties it together: depend on abstractions so all the above are possible
```

A class that violates SRP is usually hard to extend (OCP) because its responsibilities are entangled. Fat interfaces (ISP violation) pressure implementors into LSP violations. Without DIP, OCP cannot function because there are no abstractions to extend through.

### Practical Patterns
- Use aggregate roots and domain services (DDD) to observe SRP.
- Favour composition over inheritance (OCP, LSP).
- Keep interfaces small and role-focused — `IWriteRepository<T>` vs `IRepository<T>` (ISP).
- Place abstractions in the consuming layer, not the providing layer (DIP).

### Measuring Success
- Easier to unit-test: every dependency is injectable and swappable.
- Smaller, focused classes: each has a one-sentence description without "and."
- Fewer regressions: adding a new variant requires no changes to existing code.

---

## 🔗 Related Concepts
- [SRP](SRP.md)
- [OCP](OCP.md)
- [LSP](LSP.md)
- [ISP](ISP.md)
- [DIP](DIP.md)
- [[RepositoryUnitOfWork]]
- [[CleanArchitecture]]
- [[DependencyInjection]]

## 📖 Resources
- Robert C. Martin — *Agile Software Development: Principles, Patterns, and Practices*
- Robert C. Martin — *Clean Architecture*
- Uncle Bob blog: blog.cleancoder.com

## 🧪 Practice Exercises
1. Pick one class in your codebase and evaluate it against all five principles. Document one violation and refactor it.
2. Starting from a fat service class, apply SRP → ISP → DIP in sequence and observe how each step enables the next.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
