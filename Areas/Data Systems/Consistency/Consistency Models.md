# Consistency Models
Date: 2026-06-23
Status: Needs Review
Tags: #consistency #distributed-systems #databases #data

## TL;DR / Quick Reference

**Definition:** Consistency models describe what guarantees a data system gives readers after writes occur, especially when data is replicated or distributed.

**When to use:**
- When choosing between strong consistency, eventual consistency, read-your-writes, or relaxed consistency.
- When designing distributed storage, caches, read models, or asynchronous workflows.

**Key Takeaways:**
- Stronger consistency can simplify reasoning but may increase latency or reduce availability under failure.
- Eventual consistency can improve availability and scale, but users and workflows need clear expectations.
- The right model depends on the business consequence of stale, missing, duplicated, or conflicting data.

---

## Deep Dive

### Common Models

| Model | Promise | Example concern |
| --- | --- | --- |
| Strong consistency | Reads observe the latest committed write according to the system's rules | Latency and availability under partitions |
| Eventual consistency | Replicas converge if no new writes occur | Temporary stale reads |
| Read-your-writes | A user can see their own successful writes | Session routing and replica lag |
| Monotonic reads | A user does not go backwards in observed state | Switching replicas |
| Causal consistency | Related events are observed in causal order | Metadata and coordination complexity |

### Design Questions

- Who is harmed if a read is stale?
- How long can inconsistency be tolerated?
- Can the UI show pending, processing, or last-updated state?
- Are conflicts possible, and who resolves them?
- Does the workflow need idempotency, deduplication, or compensation?

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Areas/Data Systems/Replication and Partitioning/_Index]]
- [[Transactions and Isolation Levels]]
- [[Materialized Read Model]]
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]

## Review Schedule

- [ ] Review in 3 months
