---
date: 2026-06-13
status: Current
tags:
  - architecture
  - patterns
  - dependency-injection
  - lifetimes
  - singleton
  - dotnet

---

# Singleton Lifetime

## Quick Reference

**Definition:** The container reuses one instance per service registration within its root provider; building multiple root providers can create multiple instances.

**When to use:**
- Stateless services with expensive setup cost (for example: configuration readers, deterministic mappers).
- Thread-safe shared caches where global reuse is intended.
- Cross-request infrastructure that does not depend on request/user context.

**Do not use when:**
- The service depends on request-scoped data (`HttpContext`, tenant, user, request ID).
- The service stores mutable state that is not concurrency-safe.
- The service directly depends on `Scoped` services (classic captive dependency).

**Key Takeaways:**
- Best for stateless, thread-safe, long-lived services.
- Reduces allocation churn for heavy objects.
- Caution: A singleton must be safe under concurrent access.
- Caution: Avoid dependencies on shorter lifetimes.

**Code Snippet:**
```csharp
public interface IClock
{
    DateTime UtcNow { get; }
}

public sealed class SystemClock : IClock
{
    public DateTime UtcNow => DateTime.UtcNow;
}

// Program.cs
services.AddSingleton<IClock, SystemClock>();
```

**Gotchas:**
- Caution: **Captive dependency:** A singleton that takes a scoped service can hold invalid request state.
- Caution: **Hidden mutable state:** In-memory fields can become race conditions under load.
- Caution: **Startup pinning:** Heavy construction delays first resolution, including startup if the singleton is eagerly resolved; retained state can increase memory use.

---

## Deep Dive

### Mental Model
Singletons are effectively global instances managed by the DI container. Treat them as application-wide shared resources.

### Decision Checklist
- Is behavior deterministic and stateless?
- Is all internal state immutable or fully synchronized?
- Can it safely serve concurrent requests from multiple threads?

If any answer is no, reconsider `Scoped` or `Transient`.

### Typical Good Candidates
- Time providers (`IClock`)
- Pure mapping configuration
- Stateless serialization helpers

---

### Ownership and disposal

The DI container disposes a singleton that it constructs when the root provider shuts down. Do not create extra root providers just to resolve a service; each provider owns its own singleton graph. A factory-registered singleton may be created lazily, so measure initialization rather than assuming startup cost. Thread safety must cover its entire dependency graph. [Microsoft DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) (updated 2026-01-24; checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Scoped Lifetime]]
- [[Transient Lifetime]]
- [[Service Locator]]

## Resources
- Microsoft Docs — Dependency injection in .NET: Service lifetimes
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## Practice Exercises
1. Pick one singleton in your codebase and verify it has no scoped dependencies.
2. Add a concurrency test around one singleton service that maintains internal data.

## Sources

- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
