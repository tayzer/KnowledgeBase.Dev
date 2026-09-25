---
date: 2026-06-13
status: Current
tags:
  - design
  - architecture
  - oop
  - composition
  - inheritance

---

# Composition Over Inheritance

## Quick Reference

**Definition:** Prefer building behavior by combining smaller objects over extending base classes when inheritance would create tight coupling or fragile hierarchies.

**When to use:**
- A subtype would not fully satisfy the base class contract.
- You want to reuse behavior without inheriting implementation details.
- You need more flexibility than a class hierarchy can provide.

**Key Takeaways:**
- Composition keeps behavior explicit and easier to test.
- Smaller collaborating objects are usually easier to replace than base classes.
- Works especially well with interfaces, DI, and small focused services.
- Caution: Inheritance is still valid when the relationship is truly stable and substitutable.

**Code Snippet:**
```csharp
public interface IFlyBehavior
{
    void Fly();
}

public sealed class WingedFlight : IFlyBehavior
{
    public void Fly() => Console.WriteLine("Flying");
}

public sealed class NoFlight : IFlyBehavior
{
    public void Fly() => throw new NotSupportedException();
}

public class Bird
{
    private readonly IFlyBehavior _flyBehavior;

    public Bird(IFlyBehavior flyBehavior) => _flyBehavior = flyBehavior;

    public void Fly() => _flyBehavior.Fly();
}
```

**Gotchas:**
- Caution: Don’t replace inheritance with a pile of tiny objects if the design gets harder to follow.
- Caution: If an object is only forwarding everything, the abstraction may be unnecessary.

---

## Deep Dive

### Conceptual Foundation
Inheritance couples a subtype to a base class contract and implementation. Composition keeps the owning type in control and delegates the variable part to a collaborator.

### Practical Guidance
- Prefer interfaces for interchangeable collaborators.
- Use composition when behavior can vary independently of the host type.
- Keep the owner object focused on orchestration, not implementation detail.

### Comparison With Alternatives
- Use **Inheritance** when the subtype is genuinely substitutable for the base type.
- Use **Template Method** when the shared control flow belongs in a base class.
- Use **Strategy** when you want to swap one algorithm or behavior at runtime.
- Use **Decorator** when you want to layer additional behavior around an existing object.

## Review refinements

Choose inheritance when each subtype satisfies a stable base contract. Choose composition when behavior varies independently of its host or a base implementation would couple unrelated changes. Verify substitutability with behavior tests; neither strategy is a universal default.

## Related Concepts
- [[Inheritance]]
- [[Polymorphism]]
- [[Strategy]]
- [[Decorator]]
- [[Template Method]]
- [[Dependency Injection]]
- [[Liskov Substitution Principle]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/object-oriented/inheritance) (accessed 2026-09-24).

- [Gamma et al., Design Patterns (publisher record)](https://www.pearson.com/en-us/subject-catalog/p/design-patterns-elements-of-reusable-object-oriented-software/P200000009480/9780201633610) — historical source for the composition preference.
- Robert C. Martin: principles on favoring composition over inheritance — exact original passage still needs identification before this is used as evidence.

## Practice Exercises
1. Find a class hierarchy that exists mainly for code reuse and replace one level with composition.
2. Identify a subtype that breaks LSP and redesign it with collaborators instead.

## Review Schedule
- [ ] Review 6 months after promotion; use the approval date as the anchor
