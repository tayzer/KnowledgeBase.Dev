---
date: 2025-11-25
status: Current
tags:
  - architecture
  - data-access
  - patterns
  - csharp

---

# Unit of Work

## Quick Reference

**Definition:** Unit of Work coordinates changes in one application operation and defines when they are committed; Repository is a separate entity-access abstraction.

**When to use:**
- Managing multiple related repository operations that must succeed or fail together.

**Key Takeaways:**
- **SaveChangesAsync** commits tracked EF Core changes in one transaction when supported; several saves need an explicit transaction to be atomic.
- **Repositories** expose domain-friendly operations; UoW handles persistence transactions.
- Caution: **Do not leak DbContext** across layers; keep it at infrastructure boundary.

**Code Snippet:**

Illustrative application contract; the concrete repository and Unit of Work implementations must share one transaction context.

```csharp
public sealed record Order(Guid Id);
public interface IOrderRepository { void Add(Order order); }
public interface IUnitOfWork
{
    Task<int> SaveChangesAsync(CancellationToken cancellationToken);
}

public sealed class PlaceOrderService
{
    private readonly IOrderRepository _orders;
    private readonly IUnitOfWork _unitOfWork;

    public PlaceOrderService(IOrderRepository orders, IUnitOfWork unitOfWork)
    {
        _orders = orders;
        _unitOfWork = unitOfWork;
    }

    public async Task PlaceAsync(Order order, CancellationToken cancellationToken)
    {
        _orders.Add(order);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
```

**Gotchas:**
- Caution: **Over-abstraction:** For small projects, DbContext alone may be sufficient.

**Limit:** An added repository/UoW wrapper may duplicate DbContext, and EF InMemory does not model relational behavior.

---

## Deep Dive

### Patterns
- Repositories operate against the UoW's context.
- UoW owns transactions; repositories register changes.

### Testing
- Use test doubles only for isolated application logic; run relational behavior tests against the production database engine.

---

## EF Core boundary and testing

A scoped DbContext tracks changes and coordinates one SaveChangesAsync call. Several saves require an explicit transaction if they must commit atomically. Test relational queries and transactions against the production database engine; EF InMemory is not a relational substitute.

## Related Concepts
- [[Repository Pattern]]
- [[QueryOptimisations]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/ef/core/testing/choosing-a-testing-strategy) (accessed 2026-09-24).
- [Patterns and Practices articles](https://martinfowler.com/eaaCatalog/unitOfWork.html) (accessed 2026-09-24).

## Practice Exercises
1. Implement a `UnitOfWork` that wraps `AppDbContext` and ensures `SaveChangesAsync` uses an explicit transaction.

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
