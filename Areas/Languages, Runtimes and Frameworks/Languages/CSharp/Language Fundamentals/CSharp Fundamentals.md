# C# Fundamentals
Date: 2026-06-14
Status: Needs Review
Tags: #csharp #dotnet #fundamentals

## 🎯 TL;DR / Quick Reference

**Definition:** Hub page for foundational C# and .NET concepts that show up repeatedly in everyday application code.

**When to use:**
- You want a guided starting point for core language and runtime topics.
- You need a quick map of the most important C# notes in this vault.

**Key Takeaways:**
- ✅ Start with language fundamentals that affect correctness and API design.
- ✅ Learn collection and LINQ tradeoffs early because they shape day-to-day implementation quality.
- ⚠️ Treat this page as a map, not as a replacement for the deeper topic notes.

---

## 📚 Deep Dive

### Recommended Learning Path
1. **Types and contracts**: understand nullability and generics first.
2. **Behavior as data**: learn delegates, `Func<>`, and events.
3. **Data manipulation**: learn collection choices before building heavy LINQ habits.
4. **Querying and transformation**: use LINQ once you understand source collection behavior and execution models.

### Core Foundations
- [[Access Modifiers]] - Visibility boundaries for maintainable APIs and encapsulation.
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types]] - Null-safety contracts, annotations, and migration guidance.
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints]] - Type-safe reuse, constraints, and variance basics.
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Delegates, Events, and Actions]] - Passing behavior, callbacks, and event-driven design at the language level.
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types]] - Choosing the right in-memory data structure and API contract.
- [[Immutable and Concurrent Collections]] - When read-only is not enough and shared state needs stronger guarantees.
- [[Linq]] - Declarative querying, projection, deferred execution, and provider translation.

### How These Topics Connect
- Nullability and generics shape safe API surfaces.
- Delegates power LINQ and many framework callback patterns.
- Collection choice influences LINQ performance, allocation, and semantics.
- Immutable and concurrent collections are specialized responses to ownership and threading concerns.

### Practical Study Order
- If you write application code daily, start with [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types]] and [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types]].
- If you build reusable APIs or libraries, prioritize [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints]] and [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Delegates, Events, and Actions]].
- If you work heavily with data access or transformation, study [[Linq]] after collection fundamentals.

## 🔗 Related Concepts
- [[Areas/Languages, Runtimes and Frameworks/_Index]]
- [[Access Modifiers]]
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types]]
- [[Linq]]
- [[Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern]]

## 🧪 Practice Exercises
1. Pick one production class and identify which of these fundamentals most affects its design: nullability, generics, delegates, collections, or LINQ.
2. Build a tiny sample that combines `List<T>`, `Func<T, bool>`, and LINQ, then refactor the public API to use better abstractions.
3. Review one API surface and decide whether it should expose mutable collections, read-only interfaces, or immutable data.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
