# Strategy
Date: 2026-06-13
Status: Needs Review
Tags: #design-patterns #architecture #strategy #polymorphism #composition

## 🎯 TL;DR / Quick Reference

**Definition:** A pattern that defines a family of interchangeable algorithms behind a common interface and lets the caller choose one at runtime.

**When to use:**
- A single operation can be performed in different ways.
- You want to remove `switch` or `if/else` chains that branch on behavior type.
- The choice of algorithm should be configurable or injected.

**Key Takeaways:**
- ✅ Encapsulate each algorithm behind the same contract.
- ✅ Let the context own the workflow and delegate the variable step.
- ✅ Fits naturally with DI and OCP.
- ⚠️ If the algorithms need very different control flow, Strategy may be the wrong abstraction.

**Code Snippet:**
```csharp
public interface IShippingCalculator
{
	decimal Calculate(decimal orderTotal);
}

public sealed class StandardShipping : IShippingCalculator
{
	public decimal Calculate(decimal orderTotal) => 5m;
}

public sealed class ExpressShipping : IShippingCalculator
{
	public decimal Calculate(decimal orderTotal) => 15m;
}

public sealed class CheckoutService
{
	private readonly IShippingCalculator _shipping;

	public CheckoutService(IShippingCalculator shipping) => _shipping = shipping;

	public decimal GetTotal(decimal orderTotal) => orderTotal + _shipping.Calculate(orderTotal);
}
```

**Gotchas:**
- ⚠️ Don’t use Strategy if the choice is fixed and never varies; a simple method is enough.
- ⚠️ Keep the interface narrow or you’ll recreate ISP problems inside the strategy contract.

---

## 📚 Deep Dive

### Conceptual Foundation
Strategy replaces conditional logic with polymorphism. The context delegates the variable part of the algorithm to an injected implementation.

### Practical Guidance
- Keep the context responsible for the overall workflow.
- Keep each strategy focused on one variation.
- Prefer constructor injection or keyed selection over resolving strategies inside the class.

### Comparison With Alternatives
- Use **[[Decorator]]** to add layers around the same operation.
- Use **[[Plugin]]** when the host may need to run many handlers.
- Use **[[Template Method]]** when the algorithm skeleton is fixed but a few steps vary.

## 🔗 Related Concepts
- [[Polymorphism]]
- [[Decorator]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection]]
- [[Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle]]
- [[Plugin]]

## 📖 Resources
- Refactoring.Guru: Strategy
- GoF: Design Patterns

## 🧪 Practice Exercises
1. Replace a `switch` on shipping type with three strategy implementations.
2. Add a new strategy without changing the checkout flow.

## 🔄 Review Schedule
- [ ] Review in 6 months
