# Entity Framework - Memory Allocations
Date: 2025-11-25
Status: 🟢 Current
Tags: #ef-core #performance #memory #garbage-collection

## 🎯 TL;DR / Quick Reference

**Definition:** Patterns to reduce allocations and GC pressure when using EF Core (avoid unnecessary materialization, projections, and per-row allocations).

**When to use:**
- High-load services where GC pauses are visible.

**Key Takeaways:**
- ✅ **Project to DTOs** to avoid entity tracking allocations (`AsNoTracking()` for reads).
- ✅ **Avoid per-row allocations** inside loops — reuse buffers where appropriate.
- ⚡ **Use `IAsyncEnumerable<T>`** to stream large results instead of materializing full lists.

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
- ⚠️ **ToList()** creates a full list in memory.
- ⚠️ **Projection to anonymous types** may still allocate per result — consider value tuples or structs carefully.

---

## 📚 Deep Dive

### Sources of Allocation
- Entity tracking (`ChangeTracker`) stores metadata per entity.
- LINQ deferred execution capturing allocations (closures, delegates).
- Materialization (`ToList`, `ToArray`) allocates container and elements.

### Mitigations
- `AsNoTracking()` for read-only paths.
- `Select` to lightweight DTOs; avoid `Include()` when unnecessary.
- Use `AsAsyncEnumerable()` to stream large queries with `await foreach`.
- For extreme scenarios, use `ValueTask`, `struct` DTOs, or Span-backed parsing, but measure carefully.

### Measurement
- Use dotnet-trace / dotMemory to find high-allocation hotspots.
- Compare `ToQueryString()` and examine server-side vs client-side computation to minimize fetched data.

---

## 🔗 Related Concepts
- [[QueryOptimisations]]
- [[Linq]]

## 📖 Resources
- EF Core docs: performance and memory
- .NET GC and diagnostics docs

## 🧪 Practice Exercises
1. Replace `ToList()` with streaming for a report generator and measure memory usage.
2. Add `AsNoTracking()` to read-only endpoints and measure allocation improvements.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
