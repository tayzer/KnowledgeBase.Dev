# Materialized Read Model
Date: 2026-06-19
Status: 🟡 Needs Review
Tags: #architecture #data-architecture #cqrs #read-model #projection

## 🎯 TL;DR / Quick Reference

**Definition:** A precomputed, read-optimized projection of authoritative data, shaped for a specific query, screen, report, or API response.

**When to use:**
- Read paths are expensive because they require joins, aggregation, cross-service fan-out, or repeated transformation.
- The query shape is different from the transactional write model.
- Slightly stale data is acceptable and can be explained to users or consumers.
- You need a rebuildable read side for CQRS, reporting, dashboards, search, or integration views.

**Key Takeaways:**
- ✅ **Optimizes for the reader:** store data in the shape the consumer needs instead of reconstructing it on every request.
- ✅ **Keeps write concerns separate:** the authoritative model still owns invariants and source-of-truth decisions.
- ✅ **Should be rebuildable:** treat the read model as a projection that can be deleted, replayed, backfilled, or corrected.
- ⚠️ **Freshness is part of the contract:** define acceptable lag, expose timestamps when useful, and monitor projection delay.
- ⚠️ **Not a business authority:** do not let the read model become the place where command-side rules secretly live.

---

## 📚 Deep Dive

### Core Idea
A materialized read model stores query-ready data ahead of time. Instead of every request joining multiple tables, calling several services, or recalculating derived fields, a projection process maintains a read model that is cheap to query.

The read model can live in the same database as the write model, a separate table, a document store, a search index, a cache-like store, or a reporting database. The important distinction is ownership: the authoritative state remains elsewhere, while the materialized read model is a derived view.

### Typical Flow
1. A source-of-truth model changes.
2. The system emits an event, writes an outbox record, or otherwise marks that a projection must update.
3. A projection handler transforms source data into the read model shape.
4. Query handlers serve consumers from the materialized read model.

The projection may update synchronously inside one transaction for simple systems, but it is often asynchronous in CQRS and event-driven architectures.

### What To Materialize
Good candidates include:
- dashboard summaries and counters
- search documents
- account or customer overview pages
- report rows assembled from several domains
- API responses with expensive derived fields
- lists that need filtering, sorting, or pagination in a shape different from the write model

Avoid materializing every possible query. Start with a concrete read path that has measurable latency, complexity, coupling, or scaling pain.

### Consistency And Freshness
Materialized read models usually trade immediate consistency for query speed and decoupling. That tradeoff should be explicit.

Practical design choices:
- Track `LastProjectedAt`, source event position, or source version where useful.
- Define an acceptable freshness SLA, such as "dashboard data is normally less than 30 seconds behind."
- Decide whether consumers need stale-data warnings, refresh behavior, or optimistic UI updates.
- Monitor projection lag and failed projection retries.

If the user must read their own write immediately, either update the relevant read model synchronously, return the command result directly, or design the UI around pending state.

### Rebuilds And Backfills
A healthy materialized read model can be rebuilt. Rebuilds matter when projection logic changes, historical data is corrected, or a read store is lost.

Useful operational capabilities:
- replay projection from authoritative records or event history
- backfill one tenant, customer, aggregate, or date range
- run projection rebuilds without breaking live reads
- compare old and new projection output before cutover
- make projection handlers idempotent so retries are safe

### Materialized Read Model vs Cache

| Concern | Materialized Read Model | Cache |
|---|---|---|
| Purpose | Stores a deliberate query shape | Speeds up access to data that already has a primary query path |
| Ownership | Derived projection with its own schema | Temporary copy of another result |
| Refresh | Projection pipeline, events, outbox, batch, or rebuild | TTL, invalidation, cache-aside, write-through |
| Rebuild | Expected operational capability | Usually repopulated by normal reads |
| Risk | Stale or incorrect projection logic | Stale entries, stampede, invalidation bugs |

A materialized read model can be stored in cache infrastructure, but the pattern is broader than caching because it owns a designed read schema and projection lifecycle.

### Failure Modes
- Treating the read model as the source of truth and making business decisions from stale derived data.
- Hiding consistency lag from users or downstream consumers.
- Building projections that cannot be replayed or repaired.
- Letting projection handlers contain command-side validation or domain invariants.
- Creating too many highly specialized views before the read-path pain is real.
- Missing observability for projection failures, poison messages, or lag.

### Practical Guidance
- Name read models after the consumer or query they serve, such as `OrdersForDashboard` or `CustomerSearchDocument`.
- Keep projection code deterministic and idempotent.
- Store enough metadata to debug where the projection came from.
- Prefer source events or an outbox over fragile polling when the write side and read side are decoupled.
- Make deletion and correction flows explicit, especially for privacy, compliance, and data-quality fixes.
- Document whether the read model is synchronous, asynchronous, rebuildable, and how stale it may be.

## 🔗 Related Concepts
- [[CQRS]]
- [[EventDriven]]
- [[Service Composition]]
- [[CachingStrategies]]
- [[ServiceCommunication]]

## 📖 Resources
- Microsoft Docs: CQRS pattern
- Martin Fowler: CQRS
- Martin Fowler: Reporting database

## 🧪 Practice Exercises
1. Pick one slow report or dashboard and sketch the read model fields it would need.
2. Define a freshness SLA for that read model and list the metadata you would expose to debug staleness.
3. Describe how you would rebuild the projection after changing one derived-field rule.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
