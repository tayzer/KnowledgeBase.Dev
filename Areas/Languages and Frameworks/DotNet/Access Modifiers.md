# Access Modifiers
Date: 2026-06-14
Status: 🟡 Needs Review
Tags: #csharp #dotnet #access-modifiers #api-design #encapsulation

## 🎯 TL;DR / Quick Reference

**Definition:** Access modifiers in C# control where types and members can be used, shaping encapsulation and API boundaries.

**When to use:**
- Designing class, struct, interface, and member visibility.
- Defining clear library boundaries between public API and internal implementation.

**Key Takeaways:**
- ✅ **Default to least visibility** (`private` for members) and expand only when needed.
- ✅ **Use `internal` to keep implementation details inside an assembly.**
- ✅ **Treat visibility as contract design**, not just syntax.
- ⚠️ **Overexposed members increase coupling** and make refactoring harder.

---

## 📚 Deep Dive

### C# Access Modifiers at a Glance

| Modifier | Applies To | Accessible From | Typical Use |
|---|---|---|---|
| `public` | Types and members | Anywhere | External API surface |
| `private` | Members | Containing type only | Internal implementation details |
| `protected` | Members | Containing type + derived types | Inheritance customization points |
| `internal` | Types and members | Same assembly | Internal collaboration within a library |
| `protected internal` | Members | Same assembly OR derived types in other assemblies | Rare broad inheritance/internal scenarios |
| `private protected` | Members | Derived types in same assembly only | Tight inheritance boundaries |
| `file` | Types (C# 11+) | Same source file | Limit helper types to one file |

### Practical Rules
- Start from `private` and move outward only when requirements demand it.
- Prefer `internal` over `public` for non-API framework glue.
- Use `protected` only for intentional inheritance points; do not expose by habit.
- Keep public surface small and stable.

### API Design Guidance
- **Public members are compatibility commitments** for consumers.
- **Internal members are refactoring-friendly** because callers are controlled.
- Combine with interfaces to expose behavior without leaking implementation detail.

### Common Pitfalls
- Promoting members to `public` to "fix" access issues instead of designing a better abstraction.
- Overusing `protected` in classes that were never meant for inheritance.
- Forgetting that nested type visibility and top-level type visibility follow different defaults/rules.
- Exposing mutable state publicly instead of controlled methods/properties.

### Example
```csharp
public class UserService
{
    private readonly IUserRepository _repo;

    internal UserService(IUserRepository repo) // assembly-local composition
    {
        _repo = repo;
    }

    public Task<User?> GetByIdAsync(int id) => _repo.GetByIdAsync(id);

    private static bool IsValidId(int id) => id > 0;
}
```

### Choosing Between `internal` and `public`
- Use `public` when third-party or cross-assembly callers must depend on it.
- Use `internal` when only your assembly should call it.
- If uncertain, start with `internal` and promote later if needed.

## 🔗 Related Concepts
- [[Encapsulation]]
- [[CSharp Fundamentals]]
- [[NullableReferenceTypes]]
- [[GenericsConstraints]]

## 📖 Resources
- [Microsoft Docs: Access Modifiers](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers)
- [Microsoft Docs: file Modifier](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/file)

## 🧪 Practice Exercises
1. Audit one class and reduce visibility of members that do not need to be public.
2. Find one `protected` member and decide whether it is truly an inheritance extension point.
3. Convert one helper type to `file` scope and verify no external callers break.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months