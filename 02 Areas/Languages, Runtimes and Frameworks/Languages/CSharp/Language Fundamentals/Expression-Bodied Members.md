---
date: 2025-11-25
status: Current
tags:
  - csharp
  - syntax
  - dotnet
  - style

---

# Expression-Bodied Members

## Quick Reference

**Definition:** Concise syntax for single-expression members (methods, properties, constructors, finalizers) using `=>`.

**When to use:**
- Short members where a single expression is clearer than a full block; purity is a separate design choice.
- Implementing short property getters or trivial methods.

**Key Takeaways:**
- **Compact readability** for simple members.
- **Syntax only:** The arrow form does not make a member pure or its containing object immutable.
- Caution: **Don't overuse** for complex logic — prefer full blocks for clarity and debugging.

**Code Snippet:**
```csharp
public string FullName => $"{FirstName} {LastName}";
public override string ToString() => FullName;
```

**Gotchas:**
- Caution: **Debugging:** Less room for breakpoints; you may need to expand to a block for debugging.

---

## Deep Dive

### Evolution
Expression-bodied members expanded over C# versions:
- Methods and read-only properties (C# 6)
- Getters/setters, constructors, finalizers (later versions)

### Examples
- Auto-property with expression-bodied getter:
```csharp
public int Length => _items?.Count ?? 0;
```
- Short method:
```csharp
public bool IsValid() => _value >= 0;
```

### Best Practices
- Keep the expression easy to read; use a block if side effects or control flow would be clearer there.
- Prefer explicit blocks when the expression grows beyond one line or contains multiple operations.

---

## Review refinements

Expression-bodied syntax represents a single expression; it does not make the member pure or the object immutable. Use it when the expression reads more clearly than a block. Expand a block when control flow, instrumentation, or debugging requires it; consult the syntax reference for which member and accessor kinds allow expression bodies.

## Related Concepts
- [[Delegates, Events, and Actions]]
- [[LINQ]] (common to use lambdas)

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: Expression-bodied members](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members)

## Practice Exercises
1. Refactor simple DTOs to use expression-bodied properties where appropriate.
2. Convert tiny helper methods to expression-bodied members and measure readability.

## Review Schedule
- [ ] Review 12 months after promotion; use the approval date as the anchor
