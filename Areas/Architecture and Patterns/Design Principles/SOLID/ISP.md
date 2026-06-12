# Interface Segregation Principle (ISP)
Date: 2025-06-12
Status: 🟢 Current
Tags: #design #architecture #solid #principles #isp

## 🎯 TL;DR / Quick Reference

**Definition:** Clients should not be forced to depend on methods they do not use. Prefer many small, specific interfaces over one large, general-purpose one.

**When to use:**
- Designing interfaces that will be implemented by multiple classes with different needs.
- When an interface implementor must leave methods empty or throw `NotImplementedException`.

**Key Takeaways:**
- ✅ Split interfaces along **client usage boundaries**, not implementation convenience.
- ✅ A fat interface forces unrelated clients to recompile / redeploy when unrelated methods change.
- ✅ Small interfaces compose well: `IReadRepository<T>` + `IWriteRepository<T>` = `IRepository<T>`.
- ✅ ISP applies equally to abstract classes, delegates, and REST/gRPC contracts.

**Code Snippet:**
```csharp
// ❌ Fat interface — read-only clients are forced to depend on write methods
public interface IOrderRepository
{
    Order GetById(int id);
    IEnumerable<Order> GetAll();
    void Save(Order order);
    void Delete(int id);
}

// ✅ Segregated — clients depend only on what they use
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
public class SqlOrderRepository : IOrderReader, IOrderWriter { /* ... */ }

// Query handlers only need IOrderReader
public class GetOrderQueryHandler
{
    private readonly IOrderReader _reader;
    public GetOrderQueryHandler(IOrderReader reader) => _reader = reader;
}
```

**Gotchas:**
- ⚠️ **Over-segregation:** One interface per method is impractical and produces dependency noise.
- ⚠️ **ISP ≠ small classes:** It governs *interface* surface area, not the implementing class size.
- ⚠️ **Role interfaces vs header interfaces:** ISP favours role interfaces (defined by what the client needs) over header interfaces (a direct mirroring of a class's public surface).

---

## 📚 Deep Dive

### Conceptual Foundation
Robert C. Martin introduced ISP in the context of statically typed languages where a change to an interface forces recompilation of all clients. Even in dynamically typed systems, ISP matters for cognitive load: a client that takes a 20-method dependency is harder to understand and test than one that takes a 2-method dependency.

The discipline is to define interfaces **from the client's point of view**, asking "what does the caller actually need?" rather than "what does the implementor provide?"

### Common Fat Interface Signals
| Signal | Implication |
|---|---|
| Implementation throws `NotImplementedException` | Client forces behaviour the impl doesn't support |
| Interface in two unrelated DI registrations | Split into role interfaces |
| Interface has 10+ methods | Audit for multiple actor groups |
| Adding a method forces 5+ implementations to change | Interface is too coarse |

### Relationship to Other Principles
- ISP prevents the **LSP** violations caused by fat interfaces forcing stub overrides.
- Small interfaces are necessary for **DIP** to be practical — a 20-method abstraction is harder to substitute in tests.
- Aligns with CQRS: segregating `IOrderReader` from `IOrderWriter` mirrors the command/query split.

### Composition Pattern
```
IReadRepository<T>  + IWriteRepository<T>  = IRepository<T>
IOrderReader        + IOrderWriter          = IOrderRepository (full)
```
Consumers take the narrowest interface they need; the full interface exists only where both are required.

---

## 🔗 Related Concepts
- [[SOLID]]
- [[LSP]]
- [[DIP]]
- [[RepositoryUnitOfWork]]
- [[CQRS]]

## 📖 Resources
- Robert C. Martin — "The Interface Segregation Principle" (objectmentor.com)
- *Agile Software Development: Principles, Patterns, and Practices*, Chapter 12

## 🧪 Practice Exercises
1. Audit an existing repository interface. Split it into a read interface and a write interface; update all consumers to take the narrower dependency.
2. Find a class that implements an interface but leaves one or more methods as `throw new NotImplementedException()`. Refactor using ISP.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
