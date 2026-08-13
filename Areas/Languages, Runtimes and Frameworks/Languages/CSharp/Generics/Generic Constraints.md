# Generics & Constraints
Date: 2025-11-25
Status: Needs Review
Tags: #csharp #dotnet #generics #typesafety #design

## 🎯 TL;DR / Quick Reference

**Definition:** Generics provide type-safe reusable code. Constraints limit allowable type parameters (e.g., `where T : class`, `struct`, `new()`, base types, interfaces).

**When to use:**
- Reusable collections, services, and algorithms that should work for multiple types.

**Key Takeaways:**
- ✅ **Type safety without boxing.**
- ✅ **Constraints express intent** (e.g., require parameterless constructor: `where T : new()`).
- ⚡ **Avoid over-constraining** — keep APIs flexible.

**Code Snippet:**
```csharp
public interface IRepository<T> where T : IEntity, new()
{
    Task<T> GetAsync(int id);
    void Add(T entity);
}
```

**Gotchas:**
- ⚠️ **`struct` constraint includes nullable structs (`int?`) in older compilers; prefer `unmanaged` or specific constraints when needed.**
- ⚠️ **No covariance for classes; use `out`/`in` on interfaces and delegates when safe.**

---

## 📚 Deep Dive

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
- Use `unmanaged` to ensure `T` is blittable for unsafe/interop.
- Use covariance (`out`) in read-only interfaces and contravariance (`in`) in write-only.

### Performance
Generics avoid boxing for value types and reduce allocations. JIT generates specialized code per value-type parameter.

---

## 🔗 Related Concepts
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection]] (generic registrations)

## 📖 Resources
- Microsoft Docs: Generics in C#

## 🧪 Practice Exercises
1. Build a `Cache<T>` that requires `T : notnull` and supports `GetOrAdd`.
2. Create an `IValidator<in T>` (contravariant) and demonstrate usage.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
