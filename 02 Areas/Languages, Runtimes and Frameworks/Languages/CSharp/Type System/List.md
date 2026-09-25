---
date: 2026-06-14
status: Needs Review
tags:
  - csharp
  - dotnet
  - collections
  - list
  - performance

---

# List<T>

## Quick Reference

**Definition:** `List<T>` is a growable, ordered collection backed by an array and optimized for indexed access and append-heavy workloads.

**When to use:**
- You need mutable, ordered in-memory data.
- You need fast indexed reads and frequent appends.

**Key Takeaways:**
- **Default mutable sequence** in most application code.
- **Great locality and indexing** because it is array-backed.
- Caution: **Insert/remove in the middle or front is expensive** due to element shifting.
- Caution: **Growth triggers allocations and copies** when capacity is exceeded.

---

## Deep Dive

### Internal Model
`List<T>` stores elements in a backing array. As items are added and capacity is exceeded, a larger array is allocated and existing elements are copied.

This design gives strong read/index performance and predictable append behavior, but has resizing costs during growth.

### Performance Characteristics
- Indexed access by position is fast.
- Appending is usually fast, with occasional resize spikes.
- Inserting or removing near index 0 can be costly for large lists.
- Enumerating is efficient because of contiguous storage.

### Pro Tip: Pre-Size for Large Known Workloads
If you already know approximate item count, set capacity up front to avoid repeated reallocations and copies.

```csharp
var users = new List<User>(10_000);

foreach (var row in rows)
{
    users.Add(Map(row));
}
```

You can also increase capacity on an existing list:

```csharp
users.EnsureCapacity(10_000);
```

### Common Pitfalls
- Calling `Add` in tight loops without pre-sizing when expected volume is large.
- Using `List<T>` when membership checks dominate workload (consider `HashSet<T>`).
- Returning `List<T>` from public APIs when callers should not mutate data.

### API Design Guidance
- Accept `IEnumerable<T>` when you only need to iterate.
- Return `IReadOnlyList<T>` when callers need index access but should not mutate.
- Use `List<T>` in API signatures only when mutation is intentionally part of the contract.

## Review refinements

List<T> is array-backed and offers indexed access, but mid-list insertion shifts following elements. Pre-size only when a trustworthy count justifies the reserved memory; avoid large capacities derived from untrusted input. IReadOnlyList<T> does not make a mutable backing list immutable; copy or use an immutable collection for stable snapshots.

## Related Concepts
- [[Collection Types]]
- [[HashSet]]
- [[LINQ]]
- [[Immutable and Concurrent Collections]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: List<T>](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1)
- [Microsoft Docs: List<T>.EnsureCapacity](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.ensurecapacity)

## Practice Exercises
1. Refactor one batch operation to pre-size a list and compare allocations.
2. Replace a list-based contains check in a hot path with a hash set and compare behavior.
3. Audit one public method returning `List<T>` and decide if `IReadOnlyList<T>` is safer.

## Review Schedule
- [ ] Review 3 months after promotion; use the approval date as the anchor

- [ ] Before setting this note to Current: Verify the cited API and performance examples against the target .NET version.
