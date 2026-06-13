# Polymorphism

Date: 2026-06-13
Status: 🟢 Current
Tags: #oop #polymorphism #design #patterns #csharp

## 🎯 TL;DR / Quick Reference

**Definition:** The ability for objects of different types to be treated through a common interface; enables writing code that works with abstractions instead of concrete types.

**Three Forms:**
1. **Compile-time (Static):** Method overloading, generics.
2. **Runtime (Dynamic):** Method overriding, interface implementation.
3. **Duck Typing:** Type checking at runtime (less common in statically typed languages).

**When to use:**
- Designing systems where behavior varies by type (e.g., different payment methods, shapes, database providers).
- Reducing coupling by programming against interfaces.
- Implementing design patterns like [[Strategy]], [[Decorator]], [[Template Method]].

**Key Takeaways:**
- ✅ Prefer **interface-based polymorphism** (contracts) over inheritance hierarchies.
- ✅ Enables the [[Open/Closed Principle|OCP]] – add new types without modifying existing code.
- ✅ [[Liskov Substitution Principle|LSP]] guarantees that derived types can safely substitute base types.
- ⚠️ Over-abstracting causes unnecessary indirection; use polymorphism when variation is known or anticipated.

**Code Snippet:**
```csharp
// ✅ Interface-based polymorphism
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
- ⚠️ **Circular dependencies:** Deep inheritance hierarchies can create tight coupling; prefer composition.
- ⚠️ **Unexpected behavior:** Derived classes that violate the contract (LSP violation) break polymorphic assumptions.
- ⚠️ **Performance:** Virtual method calls have minimal overhead in modern runtimes, but avoid polymorphism in tight loops if profiling shows issues.

---

## 📚 Deep Dive

### Interface vs. Abstract Base Class

**Interfaces** define contracts without implementation:
- Multiple interface inheritance (a class implements many interfaces).
- Explicit contract; no default behavior.
- Preferred for defining external contracts and cross-cutting concerns.

**Abstract Base Classes** define contracts with optional shared implementation:
- Single inheritance (a class extends one abstract base).
- Can provide default or shared behavior.
- Preferred for related types with common functionality.

In modern C# with default interface implementations, the distinction blurs; prefer interfaces unless shared implementation is the primary goal.

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

Polymorphism is the backbone of DI:

```csharp
// Service depends on an abstraction, not a concrete type
public class OrderProcessor
{
    private readonly ILogger _logger;
    private readonly IPaymentService _paymentService;
    
    public OrderProcessor(ILogger logger, IPaymentService paymentService)
    {
        _logger = logger;
        _paymentService = paymentService;
    }
    
    public void Process(Order order)
    {
        _logger.Log($"Processing order {order.Id}");
        _paymentService.Charge(order.Total);
    }
}

// Different implementations can be injected at runtime
services.AddScoped<ILogger, ConsoleLogger>();
services.AddScoped<IPaymentService, StripePaymentService>();
```

### Pitfall: Violating Liskov Substitution Principle (LSP)

A derived type that breaks the contract violates LSP and breaks polymorphic assumptions:

```csharp
// ❌ LSP Violation
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

// ✅ Better design: Extract flying behavior
public interface IFlyer { void Fly(); }
public class Eagle : IFlyer { public void Fly() => Console.WriteLine("Flying"); }
public class Penguin { }  // No flying contract
```

---

## 🔗 Related Concepts

- [[Abstraction]] – Hides complexity; polymorphism exposes a common interface.
- [[Inheritance]] – Enables runtime polymorphism through method overriding.
- [[Encapsulation]] – Protects internal state; polymorphism allows type substitution.
- [[SOLID]] – Polymorphism enables OCP, LSP, and DIP.
- [[DependencyInjection]] – Leverages polymorphism to inject different implementations.
- [[Strategy]], [[Decorator]], [[Template Method]] – Design patterns built on polymorphism.

---

## 🔄 Review Schedule

- **Last Reviewed:** 2026-06-13
- **Next Review:** 2026-09-13
- **Frequency:** Quarterly; update if language features (default interface members, records) evolve.
