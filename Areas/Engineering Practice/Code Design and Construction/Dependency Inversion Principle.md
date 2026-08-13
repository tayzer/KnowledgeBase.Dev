# Dependency Inversion Principle (DIP)
Date: 2025-06-12
Status: Needs Review
Tags: #design #architecture #solid #principles #dip

## 🎯 TL;DR / Quick Reference

**Definition:**
1. High-level modules should not depend on low-level modules. Both should depend on abstractions.
2. Abstractions should not depend on details. Details (implementations) should depend on abstractions.

**When to use:**
- Designing any class that needs a collaborator (DB, logger, HTTP client, clock, etc.).
- Making code unit-testable without spinning up real infrastructure.

**Key Takeaways:**
- ✅ Depend on interfaces/abstractions at all boundaries between layers.
- ✅ Inject dependencies via constructor — prefer constructor injection for required collaborators.
- ✅ Define abstractions in the **consuming** layer, not the providing layer (this is the "inversion").
- ✅ DIP enables the rest of SOLID to function: OCP needs it, ISP supports it, LSP validates it.

**Code Snippet:**
```csharp
// ❌ High-level module (OrderService) depends directly on a low-level detail (SqlDatabase)
public class OrderService
{
    private readonly SqlDatabase _db = new SqlDatabase(); // concrete, untestable
    public void PlaceOrder(Order order) => _db.Save(order);
}

// ✅ Both depend on the abstraction; the abstraction is owned by the domain layer
// Domain layer (high-level)
public interface IOrderWriter            // lives in Domain, NOT in Infrastructure
{
    void Save(Order order);
}

public class OrderService
{
    private readonly IOrderWriter _writer;
    public OrderService(IOrderWriter writer) => _writer = writer;
    public void PlaceOrder(Order order) => _writer.Save(order);
}

// Infrastructure layer (low-level) — depends on the domain abstraction
public class SqlOrderWriter : IOrderWriter
{
    public void Save(Order order) { /* SQL */ }
}
```

**Gotchas:**
- ⚠️ **Service Locator anti-pattern:** Calling a container inside a class to resolve dependencies is DIP in name only — it hides dependencies and hurts testability.
- ⚠️ **Abstraction in the wrong layer:** Placing `IOrderWriter` in the Infrastructure project inverts nothing — Infrastructure still owns the contract.
- ⚠️ **Over-abstracting trivial helpers:** Value objects, `DateTime.UtcNow` wrappers, and pure functions rarely need DI; wrap them only when you need to control them in tests.

---

## 📚 Deep Dive

### Conceptual Foundation
The "inversion" in DIP refers to the direction of **source code dependency** reversing relative to the flow of control. In a traditional layered system, the business layer calls the data layer directly, so the business layer's source code imports the data layer. With DIP:

```
Traditional:   Business → Infrastructure
DIP:           Business → IAbstraction ← Infrastructure
```

The business layer owns and defines the abstraction. Infrastructure depends on Business, not the other way around. This is the architectural foundation of Clean Architecture and Hexagonal Architecture.

### Dependency Injection vs DIP
DIP is the *principle*; Dependency Injection is the most common *mechanism* for satisfying it. A DI container automates constructor injection, but DIP can be achieved without a container (manual composition root, factory methods).

| Mechanism                                         | Notes                                              |
| ------------------------------------------------- | -------------------------------------------------- |
| [[Areas/Application Development/Backend Engineering/Constructor Injection|Constructor injection]]    | Preferred — dependencies are explicit and required |
| [[Areas/Application Development/Backend Engineering/Property Injection|Property injection]]          | Use only for optional dependencies                 |
| [[Areas/Application Development/Backend Engineering/Method Injection|Method injection]]              | Use when dependency varies per-call                |
| [[Areas/Architecture and System Design/Architecture Fundamentals/Service Locator|Service Locator]]                | Anti-pattern — hides dependencies                  |

### Layered Ownership of Abstractions
In Clean Architecture terms:
- `Domain` / `Application` layers define abstractions (`IOrderWriter`, `IEmailSender`).
- `Infrastructure` / `Presentation` layers implement them.
- Dependency arrows always point inward toward the domain.

### Relationship to Other Principles
- DIP is required for **OCP** — you can only extend without modifying if you depend on an abstraction.
- DIP makes **ISP** practical — small interfaces are only useful if they're injected.
- DIP enables full **SRP** separation — low-level concerns are isolated behind their own abstractions.

### Measuring Success
- Every cross-layer collaborator is injected via an interface.
- Unit tests can stub all I/O without any special framework mocking of concrete classes.
- The domain/application project has zero references to infrastructure packages.

---

## 🔗 Related Concepts
- [[Areas/Engineering Practice/Code Design and Construction/SOLID Principles]]
- [[Areas/Engineering Practice/Code Design and Construction/Single Responsibility Principle]]
- [[Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle]]
- [[Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection]]
- [[Areas/Application Development/Backend Engineering/Constructor Injection]]
- [[Areas/Application Development/Backend Engineering/Property Injection]]
- [[Areas/Application Development/Backend Engineering/Method Injection]]
- [[Areas/Architecture and System Design/Architecture Fundamentals/Service Locator]]
- [[Clean Architecture]]

## 📖 Resources
- Robert C. Martin — "The Dependency Inversion Principle" (objectmentor.com)
- *Clean Architecture* — Robert C. Martin, Part IV
- Microsoft Docs — Dependency Injection in ASP.NET Core

## 🧪 Practice Exercises
1. Take a class that instantiates a `new SqlConnection()` or `new HttpClient()` inside a method. Extract an interface, inject it, and write a unit test using a mock/stub.
2. Audit a project: check whether abstractions (`IRepository`, `IService`) live in the domain/application layer or the infrastructure layer. Relocate any that are in the wrong place.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
