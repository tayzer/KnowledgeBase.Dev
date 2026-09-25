---
date: 2026-06-13
status: Current
tags:
  - architecture
  - patterns
  - dependency-injection
  - lifetimes
  - scoped
  - dotnet

---

# Scoped Lifetime

## Quick Reference

**Definition:** One instance is created per scope. In ASP.NET Core, the default scope is one HTTP request.

**When to use:**
- Services that coordinate request-specific work.
- Components using `DbContext` or unit-of-work style persistence.
- Logic that depends on user, tenant, or request metadata.

**Do not use when:**
- You need one global instance across the whole app.
- The service is tiny, stateless, and created many times per request with no shared request context.

**Key Takeaways:**
- A useful lifetime for services that must share state within one request or explicit scope.
- Aligns naturally with transactional boundaries (`DbContext`).
- Caution: Directly capturing a scoped service in a singleton is invalid; create a scope at an explicit operation boundary when needed.
- Caution: Do not cache scoped instances beyond the request.

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
- Caution: **Captive dependency:** Singleton -> Scoped dependency creates invalid lifetime flow.
- Caution: **Scope leaks:** Storing scoped services in static fields breaks request isolation.
- Caution: **Background workers:** Hosted services need explicit scopes via `IServiceScopeFactory`.

---

## Deep Dive

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

### Non-web scope and disposal

A background worker can call `IServiceScopeFactory.CreateScope()` for one job, resolve a scoped unit of work, and dispose the scope when the job ends. Scoped `IDisposable` services are disposed with the scope. ASP.NET Core usually creates a request scope, but arbitrary scopes are possible outside HTTP. A singleton may use a scope factory; it must not retain the scoped instance after disposal. [Microsoft service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) (updated 2026-01-24; checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Singleton Lifetime]]
- [[Transient Lifetime]]
- [[Unit of Work]]

## Resources
- Microsoft Docs — Dependency injection in .NET: Service lifetimes
- EF Core docs — DbContext lifetime, configuration, and initialization

## Practice Exercises
1. Audit one request path and list every scoped service used from controller to persistence.
2. Refactor one singleton that currently consumes a scoped service by introducing a scope factory boundary.

## Sources

- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
