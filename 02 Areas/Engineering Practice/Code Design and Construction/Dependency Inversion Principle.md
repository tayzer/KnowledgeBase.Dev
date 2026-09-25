---
date: 2025-06-12
status: Current
tags:
  - design
  - architecture
  - solid
  - principles
  - dip

---

# Dependency Inversion Principle (DIP)

## Quick Reference

**Definition:** At a boundary where high-level policy must remain independent of a replaceable low-level detail, both sides depend on a stable abstraction and the implementation depends on that abstraction.

**When to use:**
- Keeping application policy independent of database, network, or other replaceable infrastructure.
- Making policy testable without constructing the production integration. A local concrete collaborator needs no interface merely because it is a collaborator.

**Key Takeaways:**
- Put abstractions at boundaries that protect policy from volatile details; do not require an interface for every class.
- Constructor injection makes required collaborators explicit, but dependency injection is one way to implement DIP, not the principle itself.
- Place a boundary abstraction with the policy or a stable shared contract when appropriate; avoid making the policy import the infrastructure implementation.
- OCP, ISP, and LSP address related design concerns; none is a mechanical prerequisite for every use of DIP.

**Code Snippet:** Illustrative boundary sketch; `Order` and `SqlDatabase` are application types, and SQL persistence is omitted.
```csharp
// Avoid: High-level module (OrderService) depends directly on a low-level detail (SqlDatabase)
public class DirectOrderService
{
    private readonly SqlDatabase _db = new SqlDatabase(); // concrete database dependency
    public void PlaceOrder(Order order) => _db.Save(order);
}

// Boundary variant: Policy and adapter depend on a contract owned by the policy layer
// Application policy
public interface IOrderWriter            // application-owned boundary
{
    void Save(Order order);
}

public class OrderService
{
    private readonly IOrderWriter _writer;
    public OrderService(IOrderWriter writer) => _writer = writer;
    public void PlaceOrder(Order order) => _writer.Save(order);
}

// Infrastructure adapter depends on the application boundary
public class SqlOrderWriter : IOrderWriter
{
    public void Save(Order order) { /* SQL */ }
}
```

**Gotchas:**
- Caution: **Service locator:** Calling a container from policy code hides required collaborators, even if some registrations use interfaces.
- Caution: **Contract ownership:** If application policy imports an infrastructure-owned contract that changes with the adapter, the boundary may fail to protect policy. A stable shared-contract assembly can also be valid.
- Caution: **Over-abstraction:** Pure functions and value objects rarely need interfaces. A clock abstraction can be useful when time affects deterministic tests.

---

## Deep Dive

### Conceptual Foundation
The "inversion" in DIP refers to the direction of **source code dependency** reversing relative to the flow of control. In a traditional layered system, the business layer calls the data layer directly, so the business layer's source code imports the data layer. With DIP:

```
Traditional:   Business → Infrastructure
DIP:           Business → IAbstraction ← Infrastructure
```

In the illustrated layered design, the application policy owns the abstraction and infrastructure implements it. Other arrangements can keep the same dependency direction. Clean Architecture describes this inward source-dependency rule.

### Dependency Injection vs DIP
DIP is the *principle*; Dependency Injection is the most common *mechanism* for satisfying it. A DI container automates constructor injection, but DIP can be achieved without a container (manual composition root, factory methods).

| Mechanism                                         | Notes                                              |
| ------------------------------------------------- | -------------------------------------------------- |
| [[40 Knowledge/Software Engineering/02 Areas/Application Development/Backend Engineering/Constructor Injection|Constructor injection]]    | Preferred — dependencies are explicit and required |
| [[40 Knowledge/Software Engineering/02 Areas/Application Development/Backend Engineering/Property Injection|Property injection]]          | Use only for optional dependencies                 |
| [[40 Knowledge/Software Engineering/02 Areas/Application Development/Backend Engineering/Method Injection|Method injection]]              | Use when dependency varies per-call                |
| [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Architecture Fundamentals/Service Locator|Service Locator]]                | Hides dependencies when used inside application code; a composition root may legitimately resolve services. |

### Layered Ownership of Abstractions
In Clean Architecture terms:
- Application policy defines a needed port, or uses a stable contract shared with its adapter.
- Infrastructure implements that port.
- In Clean Architecture, source dependencies across these boundaries point toward inner policy; runtime calls can travel outward.

### Relationship to Other Principles
- DIP can support an OCP extension point when implementations vary. OCP does not require every dependency to become an interface.
- ISP can keep a boundary contract focused on what its client needs.
- SRP can keep separate reasons for change apart; DIP helps where one reason is an infrastructure choice.

### Measuring Success
- Check whether policy code imports concrete infrastructure packages or types it need not know.
- Test the policy with a simple adapter or fake, then test the real adapter separately.
- Prefer a direct concrete dependency when an abstraction adds no useful boundary.

---

## Related Concepts
- [[SOLID Principles]]
- [[Single Responsibility Principle]]
- [[Open-Closed Principle]]
- [[Interface Segregation Principle]]
- [[Dependency Injection]]
- [[Constructor Injection]]
- [[Property Injection]]
- [[Method Injection]]
- [[Service Locator]]
- [[Clean Architecture]]

## Resources
- [Robert C. Martin, *The Clean Architecture* (2012)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) — source-dependency rule and DIP example; accessed 2026-09-24.
- [Microsoft, Dependency injection in .NET](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection) — mechanism and composition guidance; accessed 2026-09-24.
- Robert C. Martin, *Clean Architecture*, Part IV — bibliographic background; edition/page not checked.

## Practice Exercises
1. Find a policy method tied to a concrete external adapter. Introduce a focused boundary only if independent testing or replacement has value; compare complexity before and after.
2. Audit one dependency path from policy to infrastructure. Decide whether its contract belongs with policy or in a stable shared assembly; do not relocate types solely from a folder rule.

## Review Schedule
- Review when a boundary changes or when the cited .NET dependency-injection guidance changes.
