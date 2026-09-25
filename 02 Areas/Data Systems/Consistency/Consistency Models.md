---
date: 2026-06-23
status: Current
tags:
  - consistency
  - distributed-systems
  - databases
  - data

---

# Consistency Models

## Quick Reference

**Definition:** Consistency models describe what guarantees a data system gives readers after writes occur, especially when data is replicated or distributed.

**When to use:**
- When choosing between strong consistency, eventual consistency, read-your-writes, or relaxed consistency.
- When designing distributed storage, caches, read models, or asynchronous workflows.

**Key Takeaways:**
- Stronger guarantees can simplify reasoning; latency and availability effects depend on the system and fault model.
- Eventual consistency permits replicas to converge after updates stop; availability and scale depend on system design.
- The right model depends on the business consequence of stale, missing, duplicated, or conflicting data.

**Limit:** Consistency guarantees do not determine transaction isolation or a fixed convergence time.

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

## Model boundaries and example

Linearizability orders an operation between invocation and response. Causal consistency preserves causal order; session guarantees such as read-your-writes describe one client's view. Eventual consistency does not promise a fixed delay. A user might require read-your-writes after editing a profile even while another region catches up. Transaction isolation is a separate question.

## Sources

- [Primary documentation](https://jepsen.io/consistency/models) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Replication and Partitioning/_Index]]
- [[Transactions and Isolation Levels]]
- [[Materialized Read Model]]
- [[Event-Driven Architecture]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
