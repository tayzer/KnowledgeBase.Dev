# Repository + Unit of Work
Date: 2025-11-25
Status: 🟢 Current
Tags: #architecture #data-access #patterns #csharp

## 🎯 TL;DR / Quick Reference

**Definition:** Repository provides collection-like access to entities; Unit of Work groups operations into a single transaction boundary.

**When to use:**
- Managing multiple related repository operations that must succeed or fail together.

**Key Takeaways:**
- ✅ **UnitOfWork.SaveChanges()** commits changes across repositories in one transaction.
- ✅ **Repositories** expose domain-friendly operations; UoW handles persistence transactions.
- ⚠️ **Don't leak DbContext** across layers; keep it at infrastructure boundary.

**Code Snippet:**
```csharp
public interface IUnitOfWork { Task<int> SaveChangesAsync(); }
public class Service
{
  public async Task Do() { _orderRepo.Add(o); await _unitOfWork.SaveChangesAsync(); }
}
```

**Gotchas:**
- ⚠️ **Over-abstraction:** For small projects, DbContext alone may be sufficient.

---

## 📚 Deep Dive

### Patterns
- Repositories operate against the UoW's context.
- UoW owns transactions; repositories register changes.

### Testing
- Mock repositories for unit tests; use integration tests with in-memory providers for behavior testing.

---

## 🔗 Related Concepts
- [[Repository]]
- [[EntityFramework/QueryOptimisations]]

## 📖 Resources
- Patterns & Practices articles

## 🧪 Practice Exercises
1. Implement a `UnitOfWork` that wraps `AppDbContext` and ensures `SaveChangesAsync` uses an explicit transaction.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
