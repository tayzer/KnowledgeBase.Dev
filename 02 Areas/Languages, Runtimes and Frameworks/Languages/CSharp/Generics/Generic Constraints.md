---
date: 2025-11-25
status: Current
tags:
  - csharp
  - dotnet
  - generics
  - typesafety
  - design

---

# Generic Constraints

## Quick Reference

**Definition:** Generics provide type-safe reusable code. Constraints limit allowable type parameters (e.g., `where T : class`, `struct`, `new()`, base types, interfaces).

**When to use:**
- Reusable collections, services, and algorithms that should work for multiple types.

**Key Takeaways:**
- **Type safety:** Generic APIs can avoid boxing for value types; they do not remove every allocation.
- **Constraints express intent** (e.g., require parameterless constructor: `where T : new()`).
- Tip: **Avoid over-constraining** — keep APIs flexible.

**Code Snippet:**
```csharp
public interface IRepository<T> where T : IEntity, new()
{
    Task<T> GetAsync(int id);
    void Add(T entity);
}
```

**Gotchas:**
- Caution: **The `struct` constraint requires a non-nullable value type; `int?` does not satisfy it.**
- Caution: **No covariance for classes; use `out`/`in` on interfaces and delegates when safe.**

---

## Deep Dive

### Conceptual Foundation
Generics allow you to write algorithms once and apply them to many types without sacrificing compile-time checks or performance.

### Common Constraints
- `where T : class` — reference type
- `where T : struct` — non-nullable value type
- `where T : new()` — parameterless constructor
- `where T : BaseType` — must inherit BaseType
- `where T : IInterface` — implement interface

### Advanced Patterns
- Use `notnull` (C# 8+) instead of `class`/`struct` when you only need non-nullability guarantee.
- Use `unmanaged` to exclude managed references; it does not guarantee portable interop layout or marshalling.
- Use covariance (`out`) in read-only interfaces and contravariance (`in`) in write-only.

### Performance
Generics avoid boxing for value types and reduce allocations. JIT generates specialized code per value-type parameter.

---

## Review refinements

A struct constraint requires a non-nullable value type; int? is excluded. An unmanaged constraint excludes managed references but does not promise portable interop layout or marshalling. In a nullable context, class and class? differ. The default constraint has a narrow override/interface-implementation role, and allows ref struct imposes ref-safety obligations. Put new() last among ordinary constraints.

## Related Concepts
- [[Nullable Reference Types]]
- [[Dependency Injection]] (generic registrations)

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/constraints-on-type-parameters) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: Generics in C#](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/generics)

## Practice Exercises
1. Build a `Cache<T>` that requires `T : notnull` and supports `GetOrAdd`.
2. Create an `IValidator<in T>` (contravariant) and demonstrate usage.

## Review Schedule
- [ ] Review 6 months after promotion; use the approval date as the anchor
