---
date: 2026-06-13
status: Current
tags:
  - oop
  - inheritance
  - design
  - hierarchy
  - csharp

---

# Inheritance

## Quick Reference

**Definition:** A mechanism where a derived class inherits behavior and state from a base class, enabling code reuse and establishing hierarchical relationships between types.

**Two Forms:**
1. **Implementation Inheritance:** Derived class reuses base class implementation.
2. **Interface implementation:** A class implements a contract; interface inheritance means one interface derives from another.

**When to use:**
- Modeling "is-a" relationships (a Dog is-an Animal).
- Sharing common behavior across related types.
- Enabling [[Polymorphism]] through method overriding.

**Key Takeaways:**
- Prefer **composition over inheritance** when possible (see gotchas).
- Use **abstract base classes** for shared behavior; **interfaces** for contracts.
- Deep hierarchies become hard to maintain; keep inheritance shallow.
- Caution: C# enforces **single inheritance** (one base class); implement multiple interfaces for broader composition.

**Code Snippet:**
```csharp
// Preferred: Shallow, justified hierarchy
public abstract class Vehicle
{
    public string Model { get; set; }
    public abstract void Start();
}

public class Car : Vehicle
{
    public override void Start() => Console.WriteLine("Car engine starts");
}

public class Bike : Vehicle
{
    public override void Start() => Console.WriteLine("Bike engine starts");
}

// Avoid: Avoid: Deep, fragile hierarchy
// Animal -> Mammal -> Carnivore -> FelineCarnivore -> Lion
```

**Gotchas:**
- Caution: **Fragile base class problem:** Changes to base class break derived classes.
- Caution: **Deep hierarchies:** Hard to understand and maintain; review complexity and substitutability without a fixed depth rule.
- Caution: **Liskov Substitution violation:** Derived class that breaks the base contract breaks polymorphism.

---

## Deep Dive

### Implementation Inheritance

Implementation inheritance reuses code from a base class:

```csharp
public class Animal
{
    protected string _name;
    
    public Animal(string name) => _name = name;
    
    public void Sleep() => Console.WriteLine($"{_name} is sleeping");
    public virtual void Speak() => Console.WriteLine($"{_name} makes a sound");
}

public class Dog : Animal
{
    public Dog(string name) : base(name) { }
    
    public override void Speak() => Console.WriteLine($"{_name} barks");
}

var dog = new Dog("Rex");
dog.Sleep();   // Inherited from Animal
dog.Speak();   // Overridden in Dog
```

### Abstract Base Classes

Abstract base classes define partial contracts with optional shared behavior:

```csharp
public abstract class Shape
{
    public string Color { get; set; }
    
    // Shared behavior
    public void DisplayInfo() => Console.WriteLine($"Shape: {Color}");
    
    // Abstract contract (must override)
    public abstract decimal Area();
    public abstract void Draw();
}

public class Circle : Shape
{
    public decimal Radius { get; set; }
    
    public override decimal Area() => 3.14159m * Radius * Radius;
    public override void Draw() => Console.WriteLine("Drawing circle");
}
```

### Implementing interfaces (contract-based)

Interfaces define contracts and can include default implementations in modern C#:

```csharp
public interface IDrawable
{
    void Draw();
}

public interface IResizable
{
    void Resize(decimal factor);
}

public class Rectangle : IDrawable, IResizable
{
    public void Draw() => Console.WriteLine("Drawing rectangle");
    public void Resize(decimal factor) => Console.WriteLine($"Resizing by {factor}");
}
```

### Composition Over Inheritance

Composition often provides more flexibility than inheritance:

```csharp
public interface IFlyer { void Fly(); }

public sealed class WingFlight : IFlyer
{
    public void Fly() => Console.WriteLine("Flying");
}

public sealed class FlyingBird
{
    private readonly IFlyer _flight;
    public FlyingBird(IFlyer flight) => _flight = flight;
    public void Fly() => _flight.Fly();
}

public sealed class Penguin
{
    public void Swim() => Console.WriteLine("Swimming");
}
```

### The Fragile Base Class Problem

Changes to a base class can unexpectedly break derived classes:

```csharp
// Assume AddRange was added to the base class after callers had extended Add.
public class ItemCollection
{
    public virtual void Add(object item) { /* ... */ }

    public void AddRange(IEnumerable<object> items)
    {
        foreach (var item in items)
            Add(item); // Dispatches to a derived override.
    }
}

public class LoggedCollection : ItemCollection
{
    public override void Add(object item)
    {
        Console.WriteLine("Adding with logging");
        base.Add(item);
    }
}

// A new AddRange call now invokes the derived Add for each item.
```

### Sealed Classes

Prevent further derivation when the class is not designed for inheritance:

```csharp
public sealed class FinalClass { }
// A class cannot derive from FinalClass; such a declaration would not compile.
```

### Virtual Methods and Overriding

`virtual` allows derived classes to override behavior; `override` implements the override:

```csharp
public class Base
{
    public virtual void Method() => Console.WriteLine("Base");
}

public class Derived : Base
{
    public override void Method() => Console.WriteLine("Derived");
}

Base b = new Derived();
b.Method();  // Outputs "Derived" (runtime polymorphism)
```

---

## Review refinements

A class implementing an interface is interface implementation; interface inheritance means one interface derives from another. There is no universal safe number of hierarchy levels. The composition example now gives a flying bird an IFlyer collaborator while Penguin has no flying contract. Compile it with the other examples before promotion.

## Related Concepts

- [[Polymorphism]] – Enables runtime dispatch through inheritance hierarchies.
- [[Abstraction]] – Abstract classes define inheritance contracts.
- [[Encapsulation]] – `protected` keyword controls inheritance access.
- [[Liskov Substitution Principle|LSP]] – Formalized rules for safe inheritance contracts.
- Composition (see [[Strategy]], [[Decorator]]) – Often preferred alternative to inheritance.

---

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/object-oriented/inheritance) (accessed 2026-09-24).

## Review Schedule

- Review after human approval and then quarterly; this proposal is not a completed canonical review.
