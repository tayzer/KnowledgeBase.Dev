---
date: 2026-06-13
status: Current
tags:
  - oop
  - design
  - architecture
  - fundamentals
  - principles

---

# Object-Oriented Programming Overview

## Quick Reference

**Definition:** Object-oriented programming organizes state and behavior into objects; its mechanisms have tradeoffs, not guaranteed maintainability.

**When to use:** Consider objects when identity, changing state, and related behavior need a clear owner. For a stateless transformation or immutable value, a function or record may be simpler.

**The Four Pillars:**
1. **[[Encapsulation]]** – Hide internal state; control access through public interfaces.
2. **[[Inheritance]]** – Reuse behavior by extending base classes or implementing interfaces.
3. **[[Polymorphism]]** – Use objects interchangeably through common interfaces or base types.
4. **[[Abstraction]]** – Simplify complexity by exposing only essential details.

**Key Takeaways:**
- These mechanisms interact; assess SOLID guidance separately in concrete designs.
- Polymorphism dispatches behavior through a contract; encapsulation protects selected invariants; inheritance defines subtype relationships; abstraction shapes a contract.
- **Limit:** An object model can add indirection and mutable-state complexity. Prefer composition where it keeps responsibilities clearer; use inheritance when the subtype contract is sound (see [[Polymorphism]]).

---

## Review refinements

Objects combine state and behavior and may have identity. Encapsulation protects selected invariants; abstraction shapes a contract; inheritance defines subtype relationships; polymorphism dispatches through a shared contract. For example, Circle and Rectangle can each implement an Area contract without sharing a base class. Immutable records or functions may be clearer when object identity is unnecessary.

## Related Concepts

- [[SOLID Principles]] – Design principles built on OOP fundamentals.
- [[Dependency Injection]] – Leverages abstraction and polymorphism to decouple components.
- [[Strategy]], [[Decorator]] – Design patterns that rely on polymorphism and abstraction.
- [[Liskov Substitution Principle|LSP]] – Formalizes substitutability in polymorphic code.

---

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/tutorials/oop) (accessed 2026-09-24).

## Review Schedule

- Review after human approval and then quarterly; this proposal is not a completed canonical review.
