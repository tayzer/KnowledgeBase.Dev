---
date: 2025-11-25
status: Current
tags:
  - redis
  - cache
  - inmemory
  - nosql

---

# Redis

## Quick Reference

**Definition:** An in-memory data structure store used as a cache, database, and message broker.

**When to use:**
- Low-latency caching, leaderboards, pub/sub, and simple key-value storage.

**Key Takeaways:**
- **In-memory access** and rich data structures (lists, sets, sorted sets, hashes).
- Tip: **Persistence options:** RDB and AOF for durability trade-offs.

**Limit:** Pub/Sub is at most once and persistence modes have loss windows; do not infer durable delivery.

---

## Deep Dive

### Patterns
- Use Redis for Cache-Aside, distributed locks (with caution), and pub/sub patterns.

---

## Role and durability limits

Set persistence, eviction, and failure expectations for Redis as cache, datastore, or messaging component. RDB and AOF have different loss windows. Pub/Sub is at most once, so disconnected subscribers miss messages. Correctness-critical locks need a documented ownership, expiry, and failure model.

## Related Concepts
- [[Caching Strategies]]

## Resources

- [Primary documentation](https://redis.io/docs/latest/develop/pubsub/) (accessed 2026-09-24).
- [Redis docs](https://redis.io/docs/latest/) (accessed 2026-09-24).

## Practice Exercises
1. Implement a cache-aside pattern using Redis and measure hit rate.

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
