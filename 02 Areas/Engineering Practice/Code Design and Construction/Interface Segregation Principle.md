---
date: 2025-06-12
status: Current
tags:
  - design
  - architecture
  - solid
  - principles
  - isp

---

# Interface Segregation Principle (ISP)

## Quick Reference

**Definition:** Clients should not be forced to depend on methods they do not use. Prefer many small, specific interfaces over one large, general-purpose one.

**When to use:**
- Designing interfaces that will be implemented by multiple classes with different needs.
- When an interface implementor must leave methods empty or throw `NotImplementedException`.

**Key Takeaways:**
- Split interfaces along **client usage boundaries**, not implementation convenience.
- A broad interface can couple unrelated clients to a change; rebuild or deployment effects depend on language, package boundaries, and tooling.
- Small interfaces compose well: `IReadRepository<T>` + `IWriteRepository<T>` = `IRepository<T>`.
- Apply the same client-focused question to abstract classes and service contracts as an analogy; their compatibility rules differ from language interfaces.

**Code Snippet:**
```csharp
// Avoid: Fat interface — read-only clients are forced to depend on write methods
public interface IOrderRepository
{
    Order GetById(int id);
    IEnumerable<Order> GetAll();
    void Save(Order order);
    void Delete(int id);
}

// Preferred: Segregated — clients depend only on what they use
public interface IOrderReader
{
    Order GetById(int id);
    IEnumerable<Order> GetAll();
}

public interface IOrderWriter
{
    void Save(Order order);
    void Delete(int id);
}

// Implementations can implement both
// One concrete repository may implement both roles; implementation omitted.

// Query handlers only need IOrderReader
public class GetOrderQueryHandler
{
    private readonly IOrderReader _reader;
    public GetOrderQueryHandler(IOrderReader reader) => _reader = reader;
}
```

**Gotchas:**
- Caution: **Over-segregation:** One interface per method is impractical and produces dependency noise.
- Caution: **ISP ≠ small classes:** It governs *interface* surface area, not the implementing class size.
- Caution: **Role interfaces vs header interfaces:** ISP favours role interfaces (defined by what the client needs) over header interfaces (a direct mirroring of a class's public surface).

---

## Deep Dive

### Conceptual Foundation
Robert C. Martin framed ISP around clients depending only on methods they use. In statically typed systems, broad interfaces can also spread rebuild pressure; the exact effect depends on the build and compatibility model. The design question still helps in dynamic systems, but method counts alone do not prove harm.

The discipline is to define interfaces **from the client's point of view**, asking "what does the caller actually need?" rather than "what does the implementor provide?"

### Common Fat Interface Signals
| Signal | Implication |
|---|---|
| Implementation throws `NotImplementedException` | Client forces behaviour the impl doesn't support |
| Separate clients use disjoint method groups | Consider client-specific role interfaces |
| Interface grows for unrelated actors | Audit whose changes drive each method |
| New methods repeatedly force unrelated implementations to change | Consider splitting the contract |

### Relationship to Other Principles
- ISP can reduce pressure to create unsupported stub methods, but it does not guarantee behavioural substitutability under LSP.
- Focused interfaces can make a DIP boundary easier for a client to use and test; DIP does not require a specific interface size.
- Read/write role interfaces resemble one CQRS separation, but CQRS is an architectural decision, not a consequence of ISP.

### Composition Pattern
```
IReadRepository<T>  + IWriteRepository<T>  = IRepository<T>
IOrderReader        + IOrderWriter          = IOrderRepository (full)
```
Consumers take the narrowest interface they need; the full interface exists only where both are required.

---

## Related Concepts
- [[SOLID Principles]]
- [[Liskov Substitution Principle]]
- [[Dependency Inversion Principle]]
- [[Unit of Work]]
- [[CQRS]]

## Resources
- [Robert C. Martin, *SOLID Relevance* (2020)](https://blog.cleancoder.com/uncle-bob/2020/10/18/Solid-Relevance.html) — original-author summary of ISP; accessed 2026-09-24.
- Robert C. Martin, *Agile Software Development: Principles, Patterns, and Practices*, Chapter 12 — bibliographic background; edition/page not checked.

## Practice Exercises
1. Audit an existing repository interface. Split it into a read interface and a write interface; update all consumers to take the narrower dependency.
2. Find a class that implements an interface but leaves one or more methods as `throw new NotImplementedException()`. Refactor using ISP.

## Review Schedule
- Review when an interface change affects new clients or when source guidance changes.
