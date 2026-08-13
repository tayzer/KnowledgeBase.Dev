# Transient Lifetime
Date: 2026-06-13
Status: Needs Review
Tags: #architecture #patterns #dependency-injection #lifetimes #transient #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** A new instance is created every time the dependency is resolved.

**When to use:**
- Lightweight, stateless services with no shared state.
- Short-lived strategy implementations selected frequently.
- Helpers where object reuse is unnecessary.

**Do not use when:**
- The object is expensive to create and can be safely reused.
- You need per-request consistency across multiple collaborators.

**Key Takeaways:**
- ✅ Good for pure, cheap, stateless behavior.
- ✅ Avoids cross-request state sharing by design.
- ⚠️ Excessive transient chains can increase allocation and GC pressure.
- ⚠️ Disposable transients can leak resources if resolved from root scope incorrectly.

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
- ⚠️ **Allocation churn:** Excessive transient object graphs can hurt hot paths.
- ⚠️ **Disposable transient misuse:** Avoid resolving disposable transients from application root.
- ⚠️ **Implicit state:** A transient with mutable static/shared dependencies can still behave statefully.

---

## 📚 Deep Dive

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

## 🔗 Related Concepts
- [[Areas/Application Development/Backend Engineering/Dependency Injection]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection/Singleton Lifetime]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection/Scoped Lifetime]]

## 📖 Resources
- Microsoft Docs — Dependency injection in .NET: Service lifetimes
- ASP.NET Core performance docs

## 🧪 Practice Exercises
1. Identify one transient service with high allocation volume and measure whether scoped or singleton reuse is safe.
2. Add a benchmark for a hot path that resolves a transient graph repeatedly.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
