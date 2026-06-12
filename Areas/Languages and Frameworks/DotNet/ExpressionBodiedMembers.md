# Expression-Bodied Members
Date: 2025-11-25
Status: 🟢 Current
Tags: #csharp #syntax #dotnet #style

## 🎯 TL;DR / Quick Reference

**Definition:** Concise syntax for single-expression members (methods, properties, constructors, finalizers) using `=>`.

**When to use:**
- Small, pure members where a single expression is clearer than a full block.
- Implementing short property getters or trivial methods.

**Key Takeaways:**
- ✅ **Compact readability** for simple members.
- ✅ **Encourages immutability** when combined with `init` and expression-bodied constructors.
- ⚠️ **Don't overuse** for complex logic — prefer full blocks for clarity and debugging.

**Code Snippet:**
```csharp
public string FullName => $"{FirstName} {LastName}";
public override string ToString() => FullName;
```

**Gotchas:**
- ⚠️ **Debugging:** Less room for breakpoints; you may need to expand to a block for debugging.

---

## 📚 Deep Dive

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
- Keep single responsibility: expression-bodied members should not contain side effects.
- Prefer explicit blocks when the expression grows beyond one line or contains multiple operations.

---

## 🔗 Related Concepts
- [[DelegatesEventsActions]]
- [[Linq]] (common to use lambdas)

## 📖 Resources
- Microsoft Docs: Expression-bodied members

## 🧪 Practice Exercises
1. Refactor simple DTOs to use expression-bodied properties where appropriate.
2. Convert tiny helper methods to expression-bodied members and measure readability.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 12 months
