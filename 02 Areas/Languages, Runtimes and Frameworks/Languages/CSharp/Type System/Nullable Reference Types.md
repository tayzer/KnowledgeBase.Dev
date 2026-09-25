---
date: 2025-11-25
status: Current
tags:
  - csharp
  - dotnet
  - nullability
  - safety

---

# Nullable Reference Types

## Quick Reference

**Definition:** A C# language feature that distinguishes nullable (`string?`) and non-nullable (`string`) reference types at compile time to reduce null-reference bugs.

**When to use:**
- Enable incrementally where warnings and public contracts can be addressed deliberately.
- Use annotations in public APIs for clear contracts.

**Key Takeaways:**
- **Compiler assistance:** Warnings when nullable values are dereferenced.
- **Annotate intent:** `?` and `!` (null-forgiving) express intent.
- Caution: **Migration:** Annotate nullability gradually; use `#nullable enable` or project setting.

**Code Snippet:**
```csharp
public string? GetDisplayName(User? user)
{
    return user?.DisplayName ?? "(unknown)";
}
```

**Gotchas:**
- Caution: **Null-forgiving operator (`!`)** silences warnings but can hide real issues. Use sparingly.
- Caution: **Third-party libraries** without annotations create an oblivious boundary; validate values or add trustworthy annotations.

---

## Deep Dive

### Conceptual Foundation
Nullability annotations are metadata that the compiler uses to produce warnings. They don't change runtime behavior but improve code contracts and tooling.

### Migration Strategy
- Choose a warnings-as-errors policy for the migration stage; keep new nullability regressions visible.
- Enable `nullable` at project level and fix top priority warnings.
- Use project `Nullable` settings or file-level nullable directives for incremental rollout.

### Patterns
- Initialize non-nullable fields via constructor.
- Use `required` members or `init` setters to express construction requirements; validate runtime invariants separately.

### Interop
- For P/Invoke or reflection-heavy code, validate nullability at runtime as annotations aren't enforced at runtime.

---

## Review refinements

Migrate nullable analysis in small scopes; fix public API warnings, then expand. Null-forgiving suppresses a warning but performs no runtime check. Choose warnings-as-errors policy per build stage. Third-party oblivious annotations call for boundary validation or trustworthy annotation, not nullable restore as a repair. Required members request caller initialization but do not prove runtime non-null values.

## Related Concepts
- [[Generic Constraints]]
- [[Dependency Injection]] (lifetime injection with nullable services)

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/null-safety/nullable-reference-types) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: Nullable reference types](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/null-safety/nullable-reference-types)

## Practice Exercises
1. Migrate a small class library to nullable reference types and fix compiler warnings.
2. Create a utility that analyzes public APIs and reports nullable mismatch patterns.

## Review Schedule
- [ ] Review 3 months after promotion; use the approval date as the anchor
