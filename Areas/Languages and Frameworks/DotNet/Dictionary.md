# Dictionary<TKey, TValue>
Date: 2026-06-14
Status: 🟡 Needs Review
Tags: #csharp #dotnet #collections #dictionary #performance

## 🎯 TL;DR / Quick Reference

**Definition:** `Dictionary<TKey, TValue>` stores key-value pairs for fast lookup by key.

**When to use:**
- You need fast access by identifier or key.
- You need to map one value to another (for example, id to entity, code to metadata).

**Key Takeaways:**
- ✅ **Best general-purpose key lookup structure** for in-memory data.
- ✅ **Supports custom comparers** for case-insensitive or domain-specific equality.
- ⚠️ **Bad key equality/hashing hurts performance and correctness.**
- ⚠️ **Do not assume enumeration order is a business contract.**

---

## 📚 Deep Dive

### Internal Model
`Dictionary<TKey, TValue>` is hash-based. Keys are hashed to determine storage buckets.

Performance and correctness rely heavily on:
- Consistent equality semantics.
- Stable and well-distributed hash codes.

### Performance Characteristics
- Key lookup is typically fast.
- Insert/update is typically fast for well-behaved key distributions.
- Enumeration is efficient but should not be used as an ordering guarantee.

### Comparers Matter
Use explicit comparers when domain rules require them.

```csharp
var usersByEmail = new Dictionary<string, User>(StringComparer.OrdinalIgnoreCase);
```

Without a proper comparer, behavior can be technically correct but wrong for business expectations.

### Capacity and Resizing
Like many hash-based structures, growth can trigger internal reallocation/rehashing.

If expected size is known, set capacity up front:

```csharp
var byId = new Dictionary<int, User>(10_000);
```

### Common Pitfalls
- Using mutable objects as keys where key fields can change after insertion.
- Repeated `ContainsKey` then index access patterns when a single lookup pattern is clearer.
- Treating dictionary iteration as if it were sorted output.

### API Design Guidance
- Return `IReadOnlyDictionary<TKey, TValue>` when mutation should be restricted.
- Use dictionary internally for lookup-heavy logic, but expose domain-specific methods where possible.
- Keep key semantics explicit in naming (for example, `usersByEmail`, `ordersById`).

## 🔗 Related Concepts
- [[CollectionTypes]]
- [[HashSet]]
- [[List]]
- [[Immutable and Concurrent Collections]]

## 📖 Resources
- [Microsoft Docs: Dictionary<TKey, TValue>](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2)
- [Microsoft Docs: Equality Comparers](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.iequalitycomparer-1)

## 🧪 Practice Exercises
1. Refactor one linear search over a list into dictionary lookup and measure impact.
2. Introduce a case-insensitive string-key dictionary and validate behavior with test cases.
3. Review one dictionary usage and verify key immutability assumptions.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months