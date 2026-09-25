---
date: 2025-06-12
status: Current
tags:
  - design
  - architecture
  - csharp
  - solid
  - principles

---

# SOLID Principles

## Quick Reference

**Definition:** SOLID groups five object-oriented design principles used to reason about cohesion, extension, behavioural contracts, client-specific interfaces, and dependency direction. They are review tools, not guaranteed measures of maintainability.

- [[Single Responsibility Principle|SRP]]: group code that changes for the same actor or reason.
- [[Open-Closed Principle|OCP]]: localize predictable variation at a deliberate extension point.
- [[Liskov Substitution Principle|LSP]]: ensure subtypes meet the base behavioural contract.
- [[Interface Segregation Principle|ISP]]: depend on contracts shaped around client needs.
- [[Dependency Inversion Principle|DIP]]: protect high-level policy from replaceable low-level details through stable abstractions.

**When to use:** During design or code review when a concrete change exposes coupled responsibilities, scattered variant logic, a broken subtype contract, unused interface members, or policy coupled to infrastructure.

**Limit:** Do not introduce an interface, subclass, or service solely to satisfy an acronym. Small, stable, local code may be clearer without an extra abstraction.

## How the Principles Relate

The principles can reinforce each other without forming a required sequence. For example, ISP may help keep a DIP boundary focused on a client; LSP matters when an OCP extension uses subtype polymorphism. Neither relationship guarantees correctness or demands that every collaborator be injected.

Use the dedicated notes above for definitions and examples. This overview is a route into those notes, not a second full treatment.

### Review Example

A new export format requires editing three unrelated services. First identify the scattered reason for change (SRP). Then consider a focused export strategy (OCP) whose implementations honour a shared result/error contract (LSP). Keep that strategy interface limited to what its caller needs (ISP), and put the contract where stable policy need not import a concrete exporter (DIP). If one local `switch` would be simpler, keep it and record why.

### Review Questions

- Which actor or requirement caused the change?
- Where will the next variant be added, and how many existing policy sites change?
- Do alternate implementations preserve the caller’s promised behaviour?
- Does the client depend on unused methods or infrastructure details?
- Did the abstraction reduce change cost enough to justify its maintenance cost?

## Related Concepts
- [[Single Responsibility Principle|SRP]]
- [[Open-Closed Principle|OCP]]
- [[Liskov Substitution Principle|LSP]]
- [[Interface Segregation Principle|ISP]]
- [[Dependency Inversion Principle|DIP]]
- [[Unit of Work]]
- [[Clean Architecture]]
- [[Dependency Injection]]

## Resources
- [Robert C. Martin, *SOLID Relevance* (2020)](https://blog.cleancoder.com/uncle-bob/2020/10/18/Solid-Relevance.html) — original-author survey; accessed 2026-09-24.
- Robert C. Martin, *Agile Software Development: Principles, Patterns, and Practices* and *Clean Architecture* — background books; editions/pages not checked.

## Practice Exercises
1. Pick one recent change and use the five review questions to identify a concrete maintenance cost. Refactor only if the new design lowers that cost.
2. Compare a small conditional with a polymorphic extension point; record the future variation that would justify the latter.

## Review Schedule
- Review after the linked principle notes change or a new design example tests these relationships.
