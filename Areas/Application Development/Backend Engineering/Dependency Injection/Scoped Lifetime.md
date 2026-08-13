# Scoped Lifetime
Date: 2026-06-13
Status: Needs Review
Tags: #architecture #patterns #dependency-injection #lifetimes #scoped #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** One instance is created per scope. In ASP.NET Core, the default scope is one HTTP request.

**When to use:**
- Services that coordinate request-specific work.
- Components using `DbContext` or unit-of-work style persistence.
- Logic that depends on user, tenant, or request metadata.

**Do not use when:**
- You need one global instance across the whole app.
- The service is tiny, stateless, and created many times per request with no shared request context.

**Key Takeaways:**
- ✅ Best default for request-bound application services.
- ✅ Aligns naturally with transactional boundaries (`DbContext`).
- ⚠️ Never inject scoped services into singletons.
- ⚠️ Do not cache scoped instances beyond the request.

**Code Snippet:**
```csharp
public interface IOrderUnitOfWork
{
    Task SaveChangesAsync(CancellationToken ct);
}

public sealed class EfOrderUnitOfWork : IOrderUnitOfWork
{
    private readonly AppDbContext _db;
    public EfOrderUnitOfWork(AppDbContext db) => _db = db;

    public Task SaveChangesAsync(CancellationToken ct) => _db.SaveChangesAsync(ct);
}

// Program.cs
services.AddDbContext<AppDbContext>();
services.AddScoped<IOrderUnitOfWork, EfOrderUnitOfWork>();
```

**Gotchas:**
- ⚠️ **Captive dependency:** Singleton -> Scoped dependency creates invalid lifetime flow.
- ⚠️ **Scope leaks:** Storing scoped services in static fields breaks request isolation.
- ⚠️ **Background workers:** Hosted services need explicit scopes via `IServiceScopeFactory`.

---

## 📚 Deep Dive

### Mental Model
A scoped service represents contextual state for one unit of work. In web apps, that unit is usually a request.

### Decision Checklist
- Does this service need request/user/tenant context?
- Should all components in a request share the same instance?
- Is it coordinating a transactional operation?

If yes, `Scoped` is likely right.

### Typical Good Candidates
- EF Core `DbContext` and unit-of-work wrappers
- Request-level business orchestrators
- Per-request domain context providers

---

## 🔗 Related Concepts
- [[Areas/Application Development/Backend Engineering/Dependency Injection]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection/Singleton Lifetime]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection/Transient Lifetime]]
- [[Areas/Data Systems/Data Access/Unit of Work]]

## 📖 Resources
- Microsoft Docs — Dependency injection in .NET: Service lifetimes
- EF Core docs — DbContext lifetime, configuration, and initialization

## 🧪 Practice Exercises
1. Audit one request path and list every scoped service used from controller to persistence.
2. Refactor one singleton that currently consumes a scoped service by introducing a scope factory boundary.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
