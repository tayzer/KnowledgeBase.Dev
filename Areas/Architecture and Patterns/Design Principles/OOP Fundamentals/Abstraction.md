# Abstraction

Date: 2026-06-13
Status: 🟢 Current
Tags: #oop #abstraction #design #interfaces #csharp

## 🎯 TL;DR / Quick Reference

**Definition:** The process of hiding implementation complexity and exposing only essential details through a simplified interface; allows users to interact with objects at a high level without needing to understand internals.

**Two Mechanisms in C#:**
1. **Abstract Classes** – Share behavior while defining mandatory contracts.
2. **Interfaces** – Pure contracts with no implementation (until C# 8 default members).

**When to use:**
- Simplifying complex systems by exposing only relevant operations.
- Defining contracts between layers (e.g., domain services, data access).
- Enabling [[Polymorphism]] through common interfaces.

**Key Takeaways:**
- ✅ Expose **what**, not **how**; hide implementation details.
- ✅ Use **interfaces as public contracts**; abstract classes for internal reuse.
- ✅ Encourages [[DependencyInjection]] – depend on abstractions, not concretions.
- ⚠️ Over-abstraction creates unnecessary indirection; abstract only when variation or change is anticipated.

**Code Snippet:**
```csharp
// ✅ Abstraction: Hide database complexity
public interface IUserRepository
{
    User GetById(int id);
    void Save(User user);
}

// Concrete implementation (hidden from consumers)
public class SqlUserRepository : IUserRepository
{
    private readonly string _connectionString;
    
    public User GetById(int id) { /* SQL query */ }
    public void Save(User user) { /* SQL insert/update */ }
}

// Consumer depends only on abstraction
public class UserService
{
    private readonly IUserRepository _repo;
    public UserService(IUserRepository repo) => _repo = repo;
    
    public void UpdateUserName(int id, string newName)
    {
        var user = _repo.GetById(id);
        user.Name = newName;
        _repo.Save(user);
    }
}

// Implementation can change (SQL → MongoDB) without touching UserService
```

**Gotchas:**
- ⚠️ **Leaky abstraction:** Exposing too many implementation details defeats the purpose (e.g., SQL exception types bubbling up from a repository).
- ⚠️ **Over-engineering:** Don't abstract single implementations; wait for a second variation.
- ⚠️ **Abstraction mismatch:** Interfaces that don't match actual usage patterns create awkward conversions.

---

## 📚 Deep Dive

### Abstract Classes

Abstract classes define partial contracts with both abstract (required) and concrete (optional) behavior:

```csharp
public abstract class PaymentProcessor
{
    // Concrete behavior (shared)
    public void LogTransaction(decimal amount)
    {
        Console.WriteLine($"Processing: ${amount} at {DateTime.Now}");
    }
    
    // Abstract behavior (each processor must implement)
    public abstract bool Validate(string accountNumber);
    public abstract void Execute(decimal amount);
}

public class CreditCardProcessor : PaymentProcessor
{
    public override bool Validate(string accountNumber)
    {
        return accountNumber.Length == 16;  // Simplified
    }
    
    public override void Execute(decimal amount)
    {
        LogTransaction(amount);
        Console.WriteLine("Charging credit card...");
    }
}
```

### Interfaces: Pure Contracts

Interfaces define contracts without implementation (in pre-C# 8):

```csharp
public interface ILogger
{
    void Log(string message);
    void LogError(Exception ex);
}

public class ConsoleLogger : ILogger
{
    public void Log(string message) => Console.WriteLine(message);
    public void LogError(Exception ex) => Console.WriteLine($"Error: {ex}");
}

public class FileLogger : ILogger
{
    public void Log(string message) => File.AppendAllText("log.txt", message);
    public void LogError(Exception ex) => File.AppendAllText("log.txt", $"Error: {ex}");
}

// Polymorphic usage
public class Application
{
    private readonly ILogger _logger;
    public Application(ILogger logger) => _logger = logger;
    
    public void Run()
    {
        _logger.Log("Starting application");
        // Implementation doesn't care if it's ConsoleLogger or FileLogger
    }
}
```

### Default Interface Implementations (C# 8+)

Interfaces can now provide default implementations, blurring the line with abstract classes:

```csharp
public interface IRepository<T>
{
    T GetById(int id);
    void Save(T entity);
    
    // Default implementation (optional for implementers)
    public void Delete(int id)
    {
        Console.WriteLine($"Deleting entity with id {id}");
    }
}

public class UserRepository : IRepository<User>
{
    public User GetById(int id) { /* ... */ }
    public void Save(User user) { /* ... */ }
    // Inherits Delete() for free if not overridden
}
```

### Abstraction Layers

Layer abstraction hides lower-layer complexity:

```csharp
// Domain Layer (high-level business logic)
public class OrderService
{
    private readonly IOrderRepository _orderRepo;
    private readonly IPaymentService _paymentService;
    
    public OrderService(IOrderRepository repo, IPaymentService payment)
    {
        _orderRepo = repo;
        _paymentService = payment;
    }
    
    public void ProcessOrder(Order order)
    {
        _paymentService.Charge(order.Total);
        _orderRepo.Save(order);
    }
}

// Data Access Layer (hidden from domain)
public interface IOrderRepository
{
    void Save(Order order);
}

public class EfOrderRepository : IOrderRepository
{
    private readonly DbContext _context;
    
    public void Save(Order order)
    {
        _context.Orders.Add(order);
        _context.SaveChanges();  // EF complexity hidden
    }
}

// Payment Gateway Layer (hidden from domain)
public interface IPaymentService
{
    void Charge(decimal amount);
}

public class StripePaymentService : IPaymentService
{
    public void Charge(decimal amount)
    {
        // Stripe API calls; internal complexity hidden
    }
}
```

### Abstraction vs. Implementation Details

Good abstraction exposes minimal, stable interfaces:

```csharp
// ❌ Leaky abstraction: Exposes SQL details
public interface IUserRepository
{
    SqlDataReader ExecuteQuery(string sql);
}

// ✅ Good abstraction: Exposes domain concepts
public interface IUserRepository
{
    User GetById(int id);
    IEnumerable<User> FindByName(string name);
}
```

### When NOT to Abstraction

Don't abstract prematurely. Wait for evidence of variation:

```csharp
// ❌ Over-engineering: Single implementation
public interface IUserNameFormatter
{
    string Format(User user);
}

public class StandardUserNameFormatter : IUserNameFormatter
{
    public string Format(User user) => $"{user.FirstName} {user.LastName}";
}

// ✅ Just use the concrete class until a second formatter appears
public class UserNameFormatter
{
    public string Format(User user) => $"{user.FirstName} {user.LastName}";
}
```

---

## 🔗 Related Concepts

- [[Polymorphism]] – Abstractions enable polymorphic dispatch.
- [[Encapsulation]] – Abstraction hides encapsulated details.
- [[Inheritance]] – Abstract classes and interfaces define inheritance contracts.
- [[DependencyInjection]] – Leverages abstractions to inject implementations.
- [[SOLID|DIP]] – Formalized rule: depend on abstractions, not concretions.

---

## 🔄 Review Schedule

- **Last Reviewed:** 2026-06-13
- **Next Review:** 2026-09-13
- **Frequency:** Quarterly; update if C# 9+ record types or new abstraction mechanisms emerge.
