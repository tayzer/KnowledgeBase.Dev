---
date: 2026-09-24
status: Current
tags:
  - performance
  - caching
  - architecture
  - dotnet

---

# Caching Strategies - Review Draft

**State:** Awaiting human review. This is a proposed replacement for [[Caching Strategies|Caching Strategies]], not a published note.

**Proposed home:** Keep the existing `Caching and Ephemeral State` location. The concept covers application state and coordination; Redis and HTTP examples are linked from here. See [[Needs Review Assessment|Needs Review Assessment]].

**Promotion step after approval:** Merge the approved sections from `Quick Reference` through `Review Schedule` into the target note, keeping sound original wording and its existing `date` and `tags`. Set `status: Current` only if the resulting whole note is supportable. Update its category index and review inventory as needed. No promotion has happened.

## Quick Reference

**Definition:** Caching keeps a disposable copy of data or a computed result near a reader so repeated reads can avoid some source work.

**When to use:** Repeated reads are expensive enough to justify the extra storage and invalidation work, and the reader can tolerate a defined freshness window. Measure the workload before and after adding a cache.

**Key points:**

- Choose the cache layer for the reader: per-process memory for local reuse, a shared external cache for reads across application instances, or HTTP response caching for suitable responses. These layers have different keys, failure modes, and consistency rules.
- Define the cache key, maximum acceptable age, invalidation on writes, capacity limit, and fallback when the entry or cache is unavailable. Include tenant, user, locale, authorization, or version scope in keys when results depend on them.
- Treat the source of truth as authoritative. Expiration ends an entry's eligibility to be served; physical removal from `IMemoryCache` may happen later. Expiration does not make a copy immediately fresh after a source update.
- A cache miss can add work and latency. Concurrent misses for the same key can multiply source load unless the chosen cache or application explicitly coalesces them.

**Limit:** Do not use a shared cache key for data with different visibility rules. Do not depend on cached data as the only copy of durable state. Cache benefit and safe staleness depend on the actual workload and business requirement.

## Choosing a Cache Layer

| Layer | Useful when | Main limit |
| --- | --- | --- |
| Per-process memory, such as .NET `IMemoryCache` | Reuse within one application instance | Each instance has its own entries; bound key growth and memory use. |
| Shared external cache, such as Redis or Memcached | Multiple instances need access to the same cached entries | Adds network and service dependency; shared entries can still be stale relative to the primary source. |
| HTTP response caching | A response is safe to reuse under its HTTP or server policy | Response eligibility, personalization, and invalidation differ from application-data caching. |

The `IDistributedCache` interface alone does not make its in-memory implementation distributed. Select an external provider for cross-instance sharing. [Microsoft's distributed-cache guide](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/distributed?view=aspnetcore-10.0) describes this distinction. [Memcached's project documentation](https://memcached.org/about) describes it as a shared memory-object cache; it is one alternative to Redis, with its own client and deployment choices. For HTTP caching, `Cache-Control` governs cache behavior and `ETag` supports validation; these belong to HTTP response semantics, not the application-data key/value example below. See [RFC 9111](https://httpwg.org/specs/rfc9111.html) and [RFC 9110](https://www.rfc-editor.org/rfc/rfc9110.html).

## Common Data-Cache Patterns

| Pattern | Read or write path | Main tradeoff |
| --- | --- | --- |
| Cache-aside | Application checks cache, reads primary source on miss, then populates cache. | First miss is slower; writes need invalidation or refresh. |
| Read-through | Cache layer loads from primary source on miss. | Loading and failure behavior depend on that cache implementation. |
| Write-through | Primary write is followed by a cache update. | Both operations must succeed or have a recovery rule; infrequently read data may occupy cache. |
| Write-behind | Write enters cache first; primary persistence happens later. | Cache failure before persistence can lose or delay data. Use only with an explicit durability design. |

Cache-aside and write-through definitions follow [AWS's caching patterns](https://docs.aws.amazon.com/whitepapers/latest/database-caching-strategies-using-redis/caching-patterns.html). [Redis's cache-aside guidance](https://redis.io/tutorials/howtos/solutions/microservices/caching/) distinguishes application-managed loading from read-through. [Redis's cache-layer guide](https://redis.io/blog/cache-layer-architecture-guide/) describes the write-behind durability tradeoff. These are options, not a ranking that fits every workload.

## Async Cache-Aside Example

Illustrative .NET code inside an async method with injected `IMemoryCache` and repository. `catalog:featured` represents the same public result for every caller. Five minutes is an example policy, not a recommended default.

```csharp
var products = await _cache.GetOrCreateAsync(
    "catalog:featured",
    async entry =>
    {
        entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(5);
        return await _repo.GetFeaturedProductsAsync(cancellationToken);
    });
```

Use `await` throughout this path; the original note's `.Result` blocks on an asynchronous repository call. `GetOrCreateAsync` does **not** guarantee that only one caller runs the factory for a missing key. If a popular key is expensive to rebuild, add deliberate per-key coalescing or choose a cache facility that provides it. [Microsoft's memory-cache guide](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/memory?view=aspnetcore-10.0) documents both `GetOrCreateAsync` and concurrent repopulation. [Microsoft's async guidance](https://learn.microsoft.com/en-us/dotnet/csharp/asynchronous-programming/async-scenarios) recommends awaiting instead of blocking on `.Result` or `.Wait()`.

## Freshness, Capacity, and Failure

- Set expiration from a stated freshness requirement. If updates must appear sooner, invalidate or refresh relevant keys after a successful primary write. This reduces the stale window but does not guarantee immediate freshness when a concurrent read repopulates a key during a write; strict freshness needs a coordinated design. Versioned keys can simplify a cutover, but old entries still need expiry and key-space control.
- Include every data-visibility dimension in the key, or keep sensitive and personalized data out of a shared cache. Do not form an unbounded key space directly from arbitrary user input.
- Limit memory-cache growth; ASP.NET Core does not automatically impose a cache size limit under memory pressure. Plan eviction and measure hit rate, miss cost, memory use, and source load.
- Define what happens when the cache is unavailable. A fallback to the primary source preserves correctness only if that source can handle the extra load. Cache failures should not silently return an invalid or unauthorized value.
- Separate generic data-cache miss handling from HTTP output-cache locking. ASP.NET Core output caching has resource locking to reduce stampedes; `IMemoryCache` factory calls can still race on a miss.

These limits follow [Microsoft's in-memory caching guidance](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/memory?view=aspnetcore-10.0) and [output-cache guidance](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/output?view=aspnetcore-10.0).

## Related Concepts

- [[Redis|Redis]]
- [[Materialized Read Model|Materialized Read Model]]
- [[Async|Async/Await Patterns]]
- [[Service Communication|Service Communication]]

## Sources

- [Microsoft: Cache in-memory in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/memory?view=aspnetcore-10.0) — ASP.NET Core 10 documentation; updated 2026-05-06; accessed 2026-09-24.
- [Microsoft: Distributed caching in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/distributed?view=aspnetcore-10.0) — ASP.NET Core 10 documentation; updated 2026-05-06; accessed 2026-09-24.
- [Microsoft: Output caching middleware](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/output?view=aspnetcore-10.0) — ASP.NET Core 10 documentation; updated 2026-06-11; accessed 2026-09-24.
- [Microsoft: Asynchronous programming scenarios](https://learn.microsoft.com/en-us/dotnet/csharp/asynchronous-programming/async-scenarios) — live C# guidance; accessed 2026-09-24.
- [AWS: Database caching patterns](https://docs.aws.amazon.com/whitepapers/latest/database-caching-strategies-using-redis/caching-patterns.html) — publication date not shown on checked page; accessed 2026-09-24.
- [Redis: Cache-aside guide](https://redis.io/tutorials/howtos/solutions/microservices/caching/) and [cache-layer architecture guide](https://redis.io/blog/cache-layer-architecture-guide/) — vendor guidance; accessed 2026-09-24.
- [Memcached: About](https://memcached.org/about) — official project description; accessed 2026-09-24.
- [RFC 9111: HTTP Caching](https://httpwg.org/specs/rfc9111.html) and [RFC 9110: HTTP Semantics](https://www.rfc-editor.org/rfc/rfc9110.html) — published June 2022; accessed 2026-09-24.

## Practice Exercises

1. Add cache-aside to a repeated expensive read. Measure whether hit rate, latency, and source load improve; record miss cost.
2. Expire one popular key under concurrent requests. Observe duplicate loads, then add and test per-key coalescing.
3. Update the primary value while a cached copy remains. Verify the documented freshness and invalidation behavior.

## Review Schedule

- Review when the caching library or runtime changes, the workload scales to multiple instances, or the acceptable freshness or data-visibility rules change.
