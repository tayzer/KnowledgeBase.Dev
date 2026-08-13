# Composition Over Inheritance
Date: 2026-06-13
Status: Needs Review
Tags: #design #architecture #oop #composition #inheritance

## 🎯 TL;DR / Quick Reference

**Definition:** Prefer building behavior by combining smaller objects over extending base classes when inheritance would create tight coupling or fragile hierarchies.

**When to use:**
- A subtype would not fully satisfy the base class contract.
- You want to reuse behavior without inheriting implementation details.
- You need more flexibility than a class hierarchy can provide.

**Key Takeaways:**
- ✅ Composition keeps behavior explicit and easier to test.
- ✅ Smaller collaborating objects are usually easier to replace than base classes.
- ✅ Works especially well with interfaces, DI, and small focused services.
- ⚠️ Inheritance is still valid when the relationship is truly stable and substitutable.

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
- ⚠️ Don’t replace inheritance with a pile of tiny objects if the design gets harder to follow.
- ⚠️ If an object is only forwarding everything, the abstraction may be unnecessary.

---

## 📚 Deep Dive

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

## 🔗 Related Concepts
- [[Inheritance]]
- [[Polymorphism]]
- [[Strategy]]
- [[Decorator]]
- [[Template Method]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection]]
- [[Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle]]

## 📖 Resources
- GoF: Design Patterns
- Robert C. Martin: principles on favoring composition over inheritance

## 🧪 Practice Exercises
1. Find a class hierarchy that exists mainly for code reuse and replace one level with composition.
2. Identify a subtype that breaks LSP and redesign it with collaborators instead.

## 🔄 Review Schedule
- [ ] Review in 6 months
