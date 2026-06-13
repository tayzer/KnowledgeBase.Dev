# Singleton Lifetime
Date: 2026-06-13
Status: 🟢 Current
Tags: #architecture #patterns #dependency-injection #lifetimes #singleton #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** One instance is created for the entire application lifetime and reused everywhere.

**When to use:**
- Stateless services with expensive setup cost (for example: configuration readers, deterministic mappers).
- Thread-safe shared caches where global reuse is intended.
- Cross-request infrastructure that does not depend on request/user context.

**Do not use when:**
- The service depends on request-scoped data (`HttpContext`, tenant, user, request ID).
- The service stores mutable state that is not concurrency-safe.
- The service directly depends on `Scoped` services (classic captive dependency).

**Key Takeaways:**
- ✅ Best for stateless, thread-safe, long-lived services.
- ✅ Reduces allocation churn for heavy objects.
- ⚠️ A singleton must be safe under concurrent access.
- ⚠️ Avoid dependencies on shorter lifetimes.

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
- ⚠️ **Captive dependency:** A singleton that takes a scoped service can hold invalid request state.
- ⚠️ **Hidden mutable state:** In-memory fields can become race conditions under load.
- ⚠️ **Startup pinning:** Heavy singleton constructors increase startup time and memory footprint.

---

## 📚 Deep Dive

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

## 🔗 Related Concepts
- [[DependencyInjection]]
- [[ScopedLifetime]]
- [[TransientLifetime]]
- [[ServiceLocator]]

## 📖 Resources
- Microsoft Docs — Dependency injection in .NET: Service lifetimes
- Mark Seemann — *Dependency Injection: Principles, Practices, and Patterns*

## 🧪 Practice Exercises
1. Pick one singleton in your codebase and verify it has no scoped dependencies.
2. Add a concurrency test around one singleton service that maintains internal data.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
