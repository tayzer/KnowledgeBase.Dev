# HashSet<T>
Date: 2026-06-14
Status: 🟡 Needs Review
Tags: #csharp #dotnet #collections #hashset #performance

## 🎯 TL;DR / Quick Reference

**Definition:** `HashSet<T>` stores unique values and is optimized for membership checks and set operations.

**When to use:**
- You need uniqueness guarantees.
- You need fast `Contains` checks.
- You perform set-style operations such as union/intersection/difference.

**Key Takeaways:**
- ✅ **Excellent for membership-heavy workloads.**
- ✅ **Built-in set operations simplify many filtering and deduplication tasks.**
- ⚠️ **No index-based access and no stable ordering contract.**
- ⚠️ **Equality semantics drive correctness and performance.**

---

## 📚 Deep Dive

### Internal Model
`HashSet<T>` is hash-based and stores only keys (values without mapped payload).

Like dictionary, behavior depends on:
- Equality comparer quality.
- Hash code quality and stability.

### Performance Characteristics
- Membership checks are typically fast.
- Add/remove operations are typically fast for well-distributed hashes.
- Set operators are often cleaner and faster than list-based alternatives for large datasets.

### Common Set Operations
```csharp
var active = new HashSet<int>(activeUserIds);
active.IntersectWith(paidUserIds);
```

Other common methods:
- `UnionWith`
- `ExceptWith`
- `IsSubsetOf`

### Comparer Example
```csharp
var tags = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
```

Use explicit comparers when case-sensitivity or domain-specific equality matters.

### Common Pitfalls
- Using hash sets when output ordering is required.
- Forgetting comparer alignment across systems (for example case sensitivity mismatches).
- Treating hash sets as a drop-in replacement for all list scenarios.

### API Design Guidance
- Use `ISet<T>` where callers must perform set semantics.
- Use `IReadOnlyCollection<T>` when callers only need enumeration/count.
- Consider returning sorted or list projections if downstream code needs deterministic order.

## 🔗 Related Concepts
- [[CollectionTypes]]
- [[Dictionary]]
- [[List]]
- [[Linq]]

## 📖 Resources
- [Microsoft Docs: HashSet<T>](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1)
- [Microsoft Docs: Set operations](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1)

## 🧪 Practice Exercises
1. Replace list-based deduplication with hash set and compare readability/performance.
2. Implement an allow-list filter using hash set membership checks.
3. Compare `Distinct()` with direct hash-set usage for one data path and capture tradeoffs.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months