---
date: 2025-11-25
status: Current
tags:
  - ef-core
  - performance
  - memory
  - garbage-collection

---

# Entity Framework - Memory Allocations

## Quick Reference
**Definition:** Patterns to reduce allocations and GC pressure when using EF Core (avoid unnecessary materialization, projections, and per-row allocations).

**When to use:**
- High-load services where GC pauses are visible.

**Key Takeaways:**
- **Project to scalar DTOs** when entity instances are unnecessary. `AsNoTracking()` matters when a query materializes entity instances.
- **Avoid per-row allocations** inside loops — reuse buffers where appropriate.
- **Use `IAsyncEnumerable<T>`** for application-level streaming when suitable; EF Core may still buffer internally for retrying strategies or some split queries.

**Code Snippet:**
```csharp
await foreach (var dto in _context.Users
    .AsNoTracking()
    .Select(u => new UserDto { Id = u.Id, Name = u.Name })
    .AsAsyncEnumerable())
{
    Process(dto);
}
```

**Gotchas:**
- Caution: **ToList()** creates a full list in memory.
- Caution: **Projection to anonymous types** still allocates per result; do not assume value tuples or structs improve a query without checking translation and measurement.

---

## Deep Dive
### Sources of Allocation
- Entity tracking (`ChangeTracker`) stores metadata per entity.
- LINQ deferred execution capturing allocations (closures, delegates).
- Materialization (`ToList`, `ToArray`) allocates container and elements.

### Mitigations
- `AsNoTracking()` for read-only paths.
- `Select` to lightweight DTOs; avoid `Include()` when unnecessary.
- Use `AsAsyncEnumerable()` with `await foreach` to avoid application-level list buffering; measure provider and query behavior because internal buffering can still occur.
- Keep `ValueTask`, struct DTOs, and Span-backed parsing in their own measured code paths; they are not general EF Core query remedies.

### Measurement
- Use dotnet-trace / dotMemory to find high-allocation hotspots.
- Compare `ToQueryString()` and examine server-side vs client-side computation to minimize fetched data.

---

## Review refinements

Measure allocation and elapsed time under representative query volume before changing implementation. Prefer projecting needed columns and limiting results. Anonymous projection still allocates objects; a value tuple is not automatically faster or always translatable. Compare generated SQL and the database query plan. Keep unrelated low-level allocation advice outside this EF Core note.

## Related Concepts
- [[QueryOptimisations]]
- [[LINQ]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/ef/core/performance/efficient-querying) (accessed 2026-09-24; check version at source).

- [Tracking versus no-tracking queries](https://learn.microsoft.com/en-us/ef/core/querying/tracking) (Microsoft Learn; checked 2026-09-24).
- [Efficient querying](https://learn.microsoft.com/en-us/ef/core/performance/efficient-querying) (Microsoft Learn; checked 2026-09-24).
- [.NET allocation diagnostics with dotnet-counters](https://learn.microsoft.com/en-us/dotnet/core/diagnostics/dotnet-counters)

## Practice Exercises
1. Replace `ToList()` with streaming for a report generator and measure memory usage.
2. Add `AsNoTracking()` to read-only endpoints and measure allocation improvements.

## Review Schedule
- [ ] Review 3 months after promotion; use the approval date as the anchor
