# Caching Strategies
Date: 2025-11-25
Status: 🟢 Current
Tags: #performance #caching #architecture #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** Techniques to store frequently accessed data close to consumers (in-memory, distributed cache) to reduce latency and load.

**When to use:**
- Read-heavy endpoints, expensive computations, or repeated DB queries.

**Key Takeaways:**
- ✅ **Cache locally for latency-sensitive reads** (`MemoryCache`).
- ✅ **Use distributed cache** (Redis) for multi-instance apps.
- ⚡ **Cache invalidation is the hard part**—use TTLs, versioning or event-driven invalidation.

**Code Snippet:**
```csharp
var cached = _cache.GetOrCreate("users", entry => {
    entry.AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(5);
    return _repo.GetActiveUsersAsync().Result;
});
```

**Gotchas:**
- ⚠️ **Stale data:** Be explicit about TTL and invalidation strategy.
- ⚠️ **Cache stampede:** Use locks or request coalescing to avoid thundering herd.

---

## 📚 Deep Dive

### Types of Caching
- **In-memory** (`IMemoryCache`) — low latency, single-instance.
- **Distributed** (Redis, Memcached) — shared across instances.
- **HTTP caching** (ETags, Cache-Control) — client and CDN-level caching.

### Patterns
- **Cache-Aside (Lazy):** App checks cache first, loads from DB on miss and populates cache.
- **Write-Through / Write-Behind:** Cache is updated synchronously/asynchronously on writes.
- **Read-Through:** Cache handles loading itself (often via a caching proxy).

### Mitigations
- Use versioned keys to avoid complex invalidation.
- Implement request coalescing to prevent multiple parallel cache misses.

---

## 🔗 Related Concepts
- [[ServiceCommunication]]
- [[AzureServicesOverview]]

## 📖 Resources
- Microsoft Docs: Caching in .NET
- Redis documentation

## 🧪 Practice Exercises
1. Implement Cache-Aside for an expensive report and measure latency improvement.
2. Simulate cache stampede and implement coalescing.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
