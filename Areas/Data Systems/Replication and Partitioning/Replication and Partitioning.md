# Replication and Partitioning
Date: 2026-06-23
Status: Needs Review
Tags: #replication #partitioning #distributed-data #databases

## TL;DR / Quick Reference

**Definition:** Replication copies data across nodes or regions, while partitioning splits data across units so storage and workload can scale.

**When to use:**
- When designing databases or data systems that need scale, availability, locality, or fault tolerance.
- When evaluating tradeoffs in NoSQL systems, distributed SQL, caches, queues, and analytical platforms.

**Key Takeaways:**
- Replication improves read scale and resilience but introduces lag, failover, and consistency questions.
- Partitioning improves scale but makes key choice, hot partitions, cross-partition queries, and rebalancing important.
- Most distributed data problems are really about access patterns, failure modes, and operational ownership.

---

## Deep Dive

### Replication Questions

- Is replication synchronous or asynchronous?
- What happens when the primary node fails?
- Can reads go to replicas, and how stale can they be?
- How are conflicts detected and resolved?
- What recovery point and recovery time are acceptable?

### Partitioning Questions

- What key distributes writes and reads evenly?
- Which queries must stay within one partition?
- What creates hot partitions?
- How does the system rebalance data?
- What happens when a partition grows beyond expectations?

### Common Tradeoffs

| Decision | Benefit | Cost |
| --- | --- | --- |
| Read replicas | Scale reads and improve locality | Replica lag and stale reads |
| Sharding by tenant | Clear ownership and isolation | Uneven tenant sizes and cross-tenant queries |
| Hash partitioning | Even distribution | Harder range queries |
| Range partitioning | Efficient range scans | Hot ranges and rebalancing concerns |

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Consistency Models]]
- [[Cassandra]]
- [[Data Warehouses]]

## Review Schedule

- [ ] Review in 3 months
