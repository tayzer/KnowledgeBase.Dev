# Inheritance

Date: 2026-06-13
Status: Needs Review
Tags: #oop #inheritance #design #hierarchy #csharp

## 🎯 TL;DR / Quick Reference

**Definition:** A mechanism where a derived class inherits behavior and state from a base class, enabling code reuse and establishing hierarchical relationships between types.

**Two Forms:**
1. **Implementation Inheritance:** Derived class reuses base class implementation.
2. **Interface Inheritance:** Derived class implements a contract without reusing code.

**When to use:**
- Modeling "is-a" relationships (a Dog is-an Animal).
- Sharing common behavior across related types.
- Enabling [[Polymorphism]] through method overriding.

**Key Takeaways:**
- ✅ Prefer **composition over inheritance** when possible (see gotchas).
- ✅ Use **abstract base classes** for shared behavior; **interfaces** for contracts.
- ✅ Deep hierarchies become hard to maintain; keep inheritance shallow.
- ⚠️ C# enforces **single inheritance** (one base class); implement multiple interfaces for broader composition.

**Code Snippet:**
```csharp
// ✅ Shallow, justified hierarchy
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

// ❌ Avoid: Deep, fragile hierarchy
// Animal -> Mammal -> Carnivore -> FelineCarnivore -> Lion
```

**Gotchas:**
- ⚠️ **Fragile base class problem:** Changes to base class break derived classes.
- ⚠️ **Deep hierarchies:** Hard to understand and maintain; restrict to 2-3 levels.
- ⚠️ **Liskov Substitution violation:** Derived class that breaks the base contract breaks polymorphism.

---

## 📚 Deep Dive

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

### Interface Inheritance (Contract-based)

Interfaces define contracts without implementation (though C# allows default implementations):

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
// ❌ Inheritance hierarchy (fragile)
public class Bird { }
public class FlyingBird : Bird { }
public class Penguin : FlyingBird { }  // But penguins don't fly!

// ✅ Composition (flexible)
public class Bird
{
    public IFlyer Flyer { get; set; }
}

public interface IFlyer { void Fly(); }
public class StandardFlyer : IFlyer { }
public class NonFlyer : IFlyer { }  // Penguins use this

public class Penguin
{
    private readonly IFlyer _flyer = new NonFlyer();
}
```

### The Fragile Base Class Problem

Changes to a base class can unexpectedly break derived classes:

```csharp
// Base class (year 1)
public class List
{
    public virtual void Add(object item) { /* ... */ }
}

// Derived class
public class MyList : List
{
    public override void Add(object item) 
    { 
        Console.WriteLine("Adding with logging");
        base.Add(item);
    }
}

// Base class changes (year 2): adds AddRange
public class List
{
    public virtual void Add(object item) { /* ... */ }
    
    public virtual void AddRange(IEnumerable items)
    {
        foreach (var item in items)
            Add(item);  // Calls virtual Add
    }
}

// MyList.Add now logs for every call in AddRange – unintended behavior!
```

### Sealed Classes

Prevent further derivation when the class is not designed for inheritance:

```csharp
public sealed class FinalClass { }

// ❌ Compilation error
public class DerivedClass : FinalClass { }
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

## 🔗 Related Concepts

- [[Polymorphism]] – Enables runtime dispatch through inheritance hierarchies.
- [[Abstraction]] – Abstract classes define inheritance contracts.
- [[Encapsulation]] – `protected` keyword controls inheritance access.
- [[Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle|LSP]] – Formalized rules for safe inheritance contracts.
- Composition (see [[Strategy]], [[Decorator]]) – Often preferred alternative to inheritance.

---

## 🔄 Review Schedule

- **Last Reviewed:** 2026-06-13
- **Next Review:** 2026-09-13
- **Frequency:** Quarterly; update if C# records or new inheritance patterns emerge.
