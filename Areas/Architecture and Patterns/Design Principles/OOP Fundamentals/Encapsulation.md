# Encapsulation

Date: 2026-06-13
Status: 🟢 Current
Tags: #oop #encapsulation #design #access-control #csharp

## 🎯 TL;DR / Quick Reference

**Definition:** Bundling data (state) and behavior (methods) together, and hiding internal implementation details behind a public interface; controlled access through visibility modifiers.

**Core Principle:** Object's internal state should only be modified through its own methods, preventing external code from corrupting invariants.

**When to use:**
- Always. Encapsulation is foundational to all OOP design.
- Protecting internal state from invalid modifications.
- Decoupling external consumers from implementation details.

**Key Takeaways:**
- ✅ Use **`private` by default**; expose only what is necessary (`public`, `internal`).
- ✅ Provide **properties or methods** to control how state is accessed and modified.
- ✅ Enables [[Polymorphism]] – internal implementation can change without affecting external interface.
- ⚠️ Over-encapsulation (exposing everything as private) defeats the purpose; strike a balance.

**Code Snippet:**
```csharp
// ✅ Proper encapsulation
public class BankAccount
{
    private decimal _balance;  // Hidden internal state
    
    public decimal Balance => _balance;  // Read-only access
    
    public void Deposit(decimal amount)
    {
        if (amount <= 0) throw new ArgumentException("Amount must be positive");
        _balance += amount;
    }
    
    public bool Withdraw(decimal amount)
    {
        if (amount > _balance) return false;  // Invariant: balance never negative
        _balance -= amount;
        return true;
    }
}

// ❌ Poor encapsulation (exposes internal state)
public class BadBankAccount
{
    public decimal Balance;  // Anyone can set this to any value
}
```

**Gotchas:**
- ⚠️ **Public fields:** Never expose mutable fields directly; use properties instead for future flexibility.
- ⚠️ **Over-accessors:** Providing getters/setters for everything nullifies encapsulation benefits.
- ⚠️ **Leaky abstractions:** Returning mutable reference types can allow external modification (return copies or immutable collections).

---

## 📚 Deep Dive

### Access Modifiers in C#

| Modifier | Scope | Use Case |
|----------|-------|----------|
| `public` | Anywhere | External API surface; what consumers should depend on. |
| `internal` | Same assembly | Shared within a library; hidden from external consumers. |
| `protected` | This class + derived classes | Allows inheritance-based customization. |
| `private` | This class only | Default choice; most restrictive. |
| `private protected` | Same class or derived in same assembly | Rarely used; highly specialized. |

**Best Practice:** Default to `private`; promote to higher visibility only when justified.

### Properties and Validation

Properties allow controlled access with validation logic:

```csharp
public class Employee
{
    private DateTime _hireDate;
    
    public DateTime HireDate
    {
        get => _hireDate;
        set
        {
            if (value > DateTime.Today)
                throw new ArgumentException("Hire date cannot be in the future");
            _hireDate = value;
        }
    }
    
    // Auto-property (no custom logic needed)
    public string Name { get; set; }
    
    // Read-only property
    public int YearsOfService => (DateTime.Today - _hireDate).Days / 365;
}
```

### Protecting Collections

Returning mutable collections exposes internal state to external modification:

```csharp
// ❌ Leaky abstraction
public class Team
{
    private List<Employee> _members = new();
    public List<Employee> Members => _members;  // External code can call .Clear()!
}

// ✅ Proper encapsulation
public class Team
{
    private List<Employee> _members = new();
    public IReadOnlyList<Employee> Members => _members.AsReadOnly();
    
    public void AddMember(Employee employee) { _members.Add(employee); }
    public void RemoveMember(Employee employee) { _members.Remove(employee); }
}
```

### Invariants and Class Contracts

Encapsulation enforces class invariants (guarantees about object state):

```csharp
public class Rectangle
{
    private decimal _width, _height;
    
    // Invariant: width and height must always be positive
    public decimal Width
    {
        get => _width;
        set => _width = value > 0 ? value : throw new ArgumentException("Width must be positive");
    }
    
    public decimal Height
    {
        get => _height;
        set => _height = value > 0 ? value : throw new ArgumentException("Height must be positive");
    }
    
    // Invariant is maintained; no Rectangle can have invalid dimensions
}
```

### Encapsulation and Inheritance

Derived classes need controlled access to base class state:

```csharp
public class Animal
{
    protected int _age;  // Accessible to derived classes, not external code
    private string _species;  // Only Animal can access
    
    public int Age => _age;
}

public class Dog : Animal
{
    public void GrowOlder() => _age++;  // Can modify protected state
}
```

---

## 🔗 Related Concepts

- [[Abstraction]] – Hides complexity; encapsulation hides internals.
- [[Access Modifiers]] - C# visibility rules that enforce encapsulation boundaries.
- [[Inheritance]] – Uses `protected` for controlled base class access.
- [[Polymorphism]] – Relies on encapsulation to allow safe substitution.
- [[SOLID|DIP]] – Encapsulation supports depending on abstractions, not implementations.

---

## 🔄 Review Schedule

- **Last Reviewed:** 2026-06-13
- **Next Review:** 2026-09-13
- **Frequency:** Quarterly; update if C# record types or new access modifiers change best practices.
