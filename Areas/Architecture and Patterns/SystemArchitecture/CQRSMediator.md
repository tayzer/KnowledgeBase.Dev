# CQRS + Mediator
Date: 2025-11-25
Status: 🟡 Needs Review
Tags: #architecture #cqrs #mediatr #patterns #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** CQRS (Command Query Responsibility Segregation) separates read and write models. Mediator (e.g., MediatR) centralizes sending commands/queries to handlers.

**When to use:**
- Complex domains with different read/write optimization needs.
- When you need clear separation for scaling or security.

**Key Takeaways:**
- ✅ **Commands mutate state; Queries return data.**
- ✅ **Handlers** keep business logic isolated per operation.
- ⚡ **MediatR** reduces tight coupling between callers and handlers.

**Code Snippet:**
```csharp
public record CreateOrderCommand(OrderDto Order) : IRequest<int>;
public class CreateOrderHandler : IRequestHandler<CreateOrderCommand,int> { /* handle */ }
```

**Gotchas:**
- ⚠️ **Complexity:** Adds more types and indirection—may be overkill for simple apps.
- ⚠️ **Transactions:** Coordinate transactions across handlers carefully.

---

## 📚 Deep Dive

### Conceptual Foundation
CQRS improves clarity by modeling commands and queries differently. The read model can be denormalized and optimized for queries, while the write model focuses on consistency.

### Implementation Patterns
- Use separate DTOs for commands and queries.
- For read scaling, consider maintaining a read-database (projections) updated via events.

### Mediator Benefits
- Decouples callers from handlers; simplifies cross-cutting concerns (logging, validation) via pipeline behaviors.

---

## 🔗 Related Concepts
- [[CQRSMediator]] (this doc)
- [[RepositoryUnitOfWork]]
- [[ServiceCommunication]]

## 📖 Resources
- MediatR docs
- Microsoft: CQRS guidance

## 🧪 Practice Exercises
1. Implement a `GetOrdersQuery` and a `CreateOrderCommand` using MediatR in a small sample app.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
