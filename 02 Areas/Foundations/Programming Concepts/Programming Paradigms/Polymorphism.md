---
date: 2026-06-13
status: Current
tags:
  - oop
  - polymorphism
  - design
  - patterns
  - csharp

---

# Polymorphism

## Quick Reference

**Definition:** The ability for objects of different types to be treated through a common interface; enables writing code that works with abstractions instead of concrete types.

**Three Forms:**
1. **Compile-time (static dispatch):** Method overloading, generics.
2. **Runtime (dynamic dispatch):** Method overriding, interface implementation.
3. **Duck typing:** Type compatibility based on available operations; common in dynamic languages and supported in some statically typed languages.

**When to use:**
- Designing systems where behavior varies by type (e.g., different payment methods, shapes, database providers).
- Reducing coupling by programming against interfaces.
- Implementing design patterns like [[Strategy]], [[Decorator]], [[Template Method]].

**Key Takeaways:**
- Choose interface-based polymorphism for independent implementers and inheritance when a shared base contract and behavior are justified.
- Can support the [[Open-Closed Principle|OCP]] when a stable contract lets new implementations be added without changing callers.
- [[Liskov Substitution Principle|LSP]] is a design requirement: derived behavior must preserve the base contract for substitutability.
- Caution: Over-abstracting causes unnecessary indirection; use polymorphism when variation is known or anticipated.

**Code Snippet:**
```csharp
// Preferred: Interface-based polymorphism
public interface IPaymentProcessor
{
    void Process(decimal amount);
}

public class CreditCardProcessor : IPaymentProcessor
{
    public void Process(decimal amount) => Console.WriteLine($"Processing CC: ${amount}");
}

public class PayPalProcessor : IPaymentProcessor
{
    public void Process(decimal amount) => Console.WriteLine($"Processing PayPal: ${amount}");
}

// Polymorphic usage
public class CheckoutService
{
    private readonly IPaymentProcessor _processor;
    public CheckoutService(IPaymentProcessor processor) => _processor = processor;
    
    public void CompleteOrder(decimal total) => _processor.Process(total);
}

// New processor types can be added without modifying CheckoutService
```

**Gotchas:**
- Caution: **Circular dependencies:** Deep inheritance hierarchies can create tight coupling; prefer composition.
- Caution: **Unexpected behavior:** Derived classes that violate the contract (LSP violation) break polymorphic assumptions.
- Caution: **Performance:** Virtual method calls have minimal overhead in modern runtimes, but avoid polymorphism in tight loops if profiling shows issues.

---

## Deep Dive

### Interface vs. Abstract Base Class

**Interfaces** define contracts and can include default members:
- A class can implement multiple interfaces; one interface can inherit from another.
- An interface declares a contract and may include default members.
- Useful when independent types share a contract; shared state and implementation may favor an abstract base class.

**Abstract Base Classes** define contracts with optional shared implementation:
- Single inheritance (a class extends one abstract base).
- Can provide default or shared behavior.
- Preferred for related types with common functionality.

In modern C# with default interface implementations, the distinction blurs; choose based on the required contract, state, shared behavior, and compatibility constraints.

### Method Overloading (Compile-time Polymorphism)

Compile-time polymorphism resolves which method to call based on parameter types at compile time:

```csharp
public class Logger
{
    public void Log(string message) => Console.WriteLine(message);
    public void Log(Exception ex) => Console.WriteLine($"Error: {ex.Message}");
    public void Log(string message, Exception ex) => Console.WriteLine($"{message}: {ex.Message}");
}

Logger logger = new Logger();
logger.Log("Info");           // Calls Log(string)
logger.Log(new Exception());  // Calls Log(Exception)
```

### Method Overriding (Runtime Polymorphism)

Runtime polymorphism invokes the derived type's implementation through a base type reference:

```csharp
public abstract class Shape
{
    public abstract decimal Area();
}

public class Circle : Shape
{
    private readonly decimal _radius;
    public Circle(decimal radius) => _radius = radius;
    public override decimal Area() => 3.14159m * _radius * _radius;
}

public class Rectangle : Shape
{
    private readonly decimal _width, _height;
    public Rectangle(decimal width, decimal height) => (_width, _height) = (width, height);
    public override decimal Area() => _width * _height;
}

// Polymorphic dispatch
Shape shape1 = new Circle(5);
Shape shape2 = new Rectangle(4, 6);

decimal totalArea = shape1.Area() + shape2.Area();  // Calls the correct override
```

### Polymorphism and Dependency Injection

Dependency injection can supply an implementation behind an interface or abstract class. Container registration and resolution rules determine which implementation is supplied:

```csharp
// Service depends on an abstraction, not a concrete type
public class CheckoutService
{
    private readonly IPaymentProcessor _processor;

    public CheckoutService(IPaymentProcessor processor) => _processor = processor;

    public void CompleteOrder(decimal total) => _processor.Process(total);
}

// Composition root (Program.cs)
var services = new ServiceCollection();
services.AddScoped<IPaymentProcessor, StripePaymentService>();
services.AddScoped<CheckoutService>();

// The container injects StripePaymentService when it creates CheckoutService.
```

**Key insight:** `CheckoutService` does not choose the implementation. The composition root registers one, and the container injects that concrete type when it builds the service. If you need multiple implementations, use a separate abstraction, keyed services, or `IEnumerable<IPaymentProcessor>` rather than resolving inside the class.

### Multiple Registrations in .NET

When more than one implementation is registered, the usual options are:

```csharp
// 1. Inject all registered implementations
public class CheckoutService(IEnumerable<IPaymentProcessor> processors)
{
    public void CompleteOrder(decimal total)
    {
        foreach (var processor in processors)
            processor.Process(total);
    }
}

// 2. Ask for one specific implementation by key
public class CheckoutService([FromKeyedServices("stripe")] IPaymentProcessor processor)
{
    public void CompleteOrder(decimal total) => processor.Process(total);
}
```

- Use `IEnumerable<IPaymentProcessor>` when the class should run all registered implementations.
- Use keyed services when the class needs one specific implementation and the choice belongs in composition, not in the class.
- Avoid calling `IServiceProvider.GetRequiredService` inside the class; that turns DI into service locator.

### Pitfall: Violating Liskov Substitution Principle (LSP)

A derived type that breaks the contract violates LSP and breaks polymorphic assumptions:

```csharp
// Avoid: LSP Violation
public class Bird
{
    public virtual void Fly() => Console.WriteLine("Flying");
}

public class Penguin : Bird
{
    public override void Fly() => throw new NotSupportedException("Penguins don't fly");
}

// Client code assumes any Bird can fly
void MakeBirdFly(Bird bird) => bird.Fly();
MakeBirdFly(new Penguin());  // Runtime exception!

// Preferred: Better design: Extract flying behavior
public interface IFlyer { void Fly(); }
public class Eagle : IFlyer { public void Fly() => Console.WriteLine("Flying"); }
public class Penguin { }  // No flying contract
```

---

## Review refinements

Modern C# interfaces may provide default members. Interface-based dispatch and base-class virtual dispatch have different state, inheritance, and versioning tradeoffs. Dependency-injection registration and resolution behavior is a separate framework concern; verify it against the selected container.

## Related Concepts

- [[Abstraction]] – Hides complexity; polymorphism exposes a common interface.
- [[Inheritance]] – Enables runtime polymorphism through method overriding.
- [[Encapsulation]] – Protects internal state; polymorphism allows type substitution.
- [[SOLID Principles]] – Polymorphism enables OCP, LSP, and DIP.
- [[Dependency Injection]] – Leverages polymorphism to inject different implementations.
- [[Strategy]], [[Decorator]], [[Template Method]] – Design patterns built on polymorphism.

---

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/object-oriented/polymorphism) (accessed 2026-09-24).

## Review Schedule

- Review after human approval and then quarterly; this proposal is not a completed canonical review.
