# Nullable Reference Types
Date: 2025-11-25
Status: Needs Review
Tags: #csharp #dotnet #nullability #safety

## 🎯 TL;DR / Quick Reference

**Definition:** A C# language feature that distinguishes nullable (`string?`) and non-nullable (`string`) reference types at compile time to reduce null-reference bugs.

**When to use:**
- Enable for all projects to catch potential NREs early.
- Use annotations in public APIs for clear contracts.

**Key Takeaways:**
- ✅ **Compiler assistance:** Warnings when nullable values are dereferenced.
- ✅ **Annotate intent:** `?` and `!` (null-forgiving) express intent.
- ⚠️ **Migration:** Annotate nullability gradually; use `#nullable enable` or project setting.

**Code Snippet:**
```csharp
public string? GetDisplayName(User? user)
{
    return user?.DisplayName ?? "(unknown)";
}
```

**Gotchas:**
- ⚠️ **Null-forgiving operator (`!`)** silences warnings but can hide real issues. Use sparingly.
- ⚠️ **Third-party libs** without annotations may require `#nullable restore` or external annotations package.

---

## 📚 Deep Dive

### Conceptual Foundation
Nullability annotations are metadata that the compiler uses to produce warnings. They don't change runtime behavior but improve code contracts and tooling.

### Migration Strategy
- Start with `WarningsAsErrors` disabled.
- Enable `nullable` at project level and fix top priority warnings.
- Use `NullableContextOptions` and `NullablePublicOnly` for incremental rollout.

### Patterns
- Initialize non-nullable fields via constructor.
- Use `Required` or `init` for immutable properties.

### Interop
- For P/Invoke or reflection-heavy code, validate nullability at runtime as annotations aren't enforced at runtime.

---

## 🔗 Related Concepts
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection]] (lifetime injection with nullable services)

## 📖 Resources
- Microsoft Docs: Nullable reference types

## 🧪 Practice Exercises
1. Migrate a small class library to nullable reference types and fix compiler warnings.
2. Create a utility that analyzes public APIs and reports nullable mismatch patterns.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
