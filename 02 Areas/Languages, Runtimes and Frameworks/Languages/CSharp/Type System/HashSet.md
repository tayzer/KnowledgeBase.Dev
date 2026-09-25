---
date: 2026-06-14
status: Needs Review
tags:
  - csharp
  - dotnet
  - collections
  - hashset
  - performance

---

# HashSet<T>

## Quick Reference

**Definition:** `HashSet<T>` stores unique values and is optimized for membership checks and set operations.

**When to use:**
- You need uniqueness guarantees.
- You need fast `Contains` checks.
- You perform set-style operations such as union/intersection/difference.

**Key Takeaways:**
- **Excellent for membership-heavy workloads.**
- **Built-in set operations simplify many filtering and deduplication tasks.**
- Caution: **No index-based access and no stable ordering contract.**
- Caution: **Equality semantics drive correctness and performance.**

---

## Deep Dive

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

## Review refinements

HashSet<T> uses its comparer for membership and set operations; StringComparer can make case behavior explicit. IntersectWith mutates the receiving set, so copy first if the original must remain. Membership cost depends on hashes and workload, and a mutable HashSet is not generally thread-safe.

## Related Concepts
- [[Collection Types]]
- [[Dictionary]]
- [[List]]
- [[LINQ]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: HashSet<T>](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1)
- [Microsoft Docs: Set operations](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1)

## Practice Exercises
1. Replace list-based deduplication with hash set and compare readability/performance.
2. Implement an allow-list filter using hash set membership checks.
3. Compare `Distinct()` with direct hash-set usage for one data path and capture tradeoffs.

## Review Schedule
- [ ] Review 3 months after promotion; use the approval date as the anchor

- [ ] Before setting this note to Current: Verify the cited comparer and performance guidance against the target .NET version.
