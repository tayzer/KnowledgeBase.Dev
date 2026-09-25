---
date: 2026-06-13
status: Current
tags:
  - architecture
  - patterns
  - dependency-injection
  - lifetimes
  - transient
  - dotnet

---

# Transient Lifetime

## Quick Reference

**Definition:** A new instance is created every time the dependency is resolved.

**When to use:**
- Lightweight, stateless services with no shared state.
- Short-lived strategy implementations selected frequently.
- Helpers where object reuse is unnecessary.

**Do not use when:**
- The object is expensive to create and can be safely reused.
- You need per-request consistency across multiple collaborators.

**Key Takeaways:**
- Good for pure, cheap, stateless behavior.
- Each resolution creates a new instance, but the object can still depend on shared or static state.
- Caution: Excessive transient chains can increase allocation and GC pressure.
- Caution: Disposable transients can leak resources if resolved from root scope incorrectly.

**Code Snippet:**
```csharp
public interface ILinePriceCalculator
{
    decimal Calculate(decimal unitPrice, int quantity);
}

public sealed class DefaultLinePriceCalculator : ILinePriceCalculator
{
    public decimal Calculate(decimal unitPrice, int quantity) => unitPrice * quantity;
}

// Program.cs
services.AddTransient<ILinePriceCalculator, DefaultLinePriceCalculator>();
```

**Gotchas:**
- Caution: **Allocation churn:** Excessive transient object graphs can hurt hot paths.
- Caution: **Disposable transient misuse:** Avoid resolving disposable transients from application root.
- Caution: **Implicit state:** A transient with mutable static/shared dependencies can still behave statefully.

---

## Deep Dive

### Mental Model
Transient means "fresh object each resolution." This is useful when instance reuse adds no value.

### Decision Checklist
- Is object construction cheap?
- Is behavior stateless?
- Is sharing instance state undesirable?

If yes, `Transient` is a strong fit.

### Typical Good Candidates
- Pure calculators and formatters
- Stateless validators
- Per-operation strategy objects

---

### Root capture and measurement

A disposable transient resolved from the root provider can be held until that provider shuts down. Resolve it within a scope or use a factory with explicit disposal ownership; measure actual allocation and construction cost before changing lifetime. Two resolutions in one scope are distinct, but a singleton that captures a transient keeps that one instance for the singleton's lifetime. [Microsoft DI disposable guidance](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection-guidelines) and [service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) (checked 2026-09-24).

## Related Concepts
- [[Dependency Injection]]
- [[Singleton Lifetime]]
- [[Scoped Lifetime]]

## Resources
- Microsoft Docs — Dependency injection in .NET: Service lifetimes
- ASP.NET Core performance docs

## Practice Exercises
1. Identify one transient service with high allocation volume and measure whether scoped or singleton reuse is safe.
2. Add a benchmark for a hot path that resolves a transient graph repeatedly.

## Sources

- [Microsoft, .NET DI service lifetimes](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection/service-lifetimes) — last updated 2026-01-24; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
