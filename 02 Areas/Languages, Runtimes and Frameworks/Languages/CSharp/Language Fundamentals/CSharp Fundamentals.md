---
date: 2026-06-14
status: Current
tags:
  - csharp
  - dotnet
  - fundamentals

---

# C# Fundamentals

## Quick Reference

**Definition:** Hub page for foundational C# and .NET concepts that show up repeatedly in everyday application code.

**When to use:**
- You want a guided starting point for core language and runtime topics.
- You need a quick map of the most important C# notes in this vault.

**Key Takeaways:**
- Start with language fundamentals that affect correctness and API design.
- Learn collection and LINQ tradeoffs early because they shape day-to-day implementation quality.
- Caution: Treat this page as a map, not as a replacement for the deeper topic notes.

---

## Deep Dive

### Recommended Learning Path
1. **Types and contracts**: understand nullability and generics first.
2. **Behavior as data**: learn delegates, `Func<>`, and events.
3. **Data manipulation**: learn collection choices before building heavy LINQ habits.
4. **Querying and transformation**: use LINQ once you understand source collection behavior and execution models.

### Core Foundations
- [[Access Modifiers]] - Visibility boundaries for maintainable APIs and encapsulation.
- [[Nullable Reference Types]] - Null-safety contracts, annotations, and migration guidance.
- [[Generic Constraints]] - Type-safe reuse, constraints, and variance basics.
- [[Delegates, Events, and Actions]] - Passing behavior, callbacks, and event-driven design at the language level.
- [[Collection Types]] - Choosing the right in-memory data structure and API contract.
- [[Immutable and Concurrent Collections]] - When read-only is not enough and shared state needs stronger guarantees.
- [[LINQ]] - Declarative querying, projection, deferred execution, and provider translation.

### How These Topics Connect
- Nullability and generics shape safe API surfaces.
- Delegates power LINQ and many framework callback patterns.
- Collection choice influences LINQ performance, allocation, and semantics.
- Immutable and concurrent collections are specialized responses to ownership and threading concerns.

### Practical Study Order
- If you write application code daily, start with [[Nullable Reference Types]] and [[Collection Types]].
- If you build reusable APIs or libraries, prioritize [[Generic Constraints]] and [[Delegates, Events, and Actions]].
- If you work heavily with data access or transformation, study [[LINQ]] after collection fundamentals.

## Review refinements

This note is a learning route; the CSharp index is a navigation map. After following it, a reader should be able to declare nullable-aware contracts, choose collections, transform values with LINQ, and explain when a query executes. LINQ-to-Objects execution differs from a database IQueryable provider.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Languages, Runtimes and Frameworks/_Index]]
- [[Access Modifiers]]
- [[Collection Types]]
- [[LINQ]]
- [[ASP.NET Core Options Pattern]]

## Practice Exercises
1. Pick one production class and identify which of these fundamentals most affects its design: nullability, generics, delegates, collections, or LINQ.
2. Build a tiny sample that combines `List<T>`, `Func<T, bool>`, and LINQ, then refactor the public API to use better abstractions.
3. Review one API surface and decide whether it should expose mutable collections, read-only interfaces, or immutable data.

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/linq/get-started/introduction-to-linq-queries) (accessed 2026-09-24; check version at source).

## Review Schedule
- [ ] Review 3 months after promotion; use the approval date as the anchor
