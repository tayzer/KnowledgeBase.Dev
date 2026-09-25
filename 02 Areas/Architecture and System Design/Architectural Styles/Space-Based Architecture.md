---
date: 2026-06-23
status: Current
tags:
  - architecture
  - space-based-architecture
  - scalability
  - distributed-systems

---

# Space-Based Architecture

## Quick Reference

**Definition:** Space-based architecture places processing and state in partitioned processing units, often backed by an in-memory data grid. A measured central-database bottleneck is one reason to consider it; performance gains depend on workload and persistence design.

**When to use:**
- High-throughput systems where centralized database contention is the primary scaling constraint.
- Workloads that can partition processing and tolerate distributed state-management complexity.

**Key Takeaways:**
- Space-based architecture is a specialized scalability style, not a default web-application architecture.
- It can reduce database pressure but makes consistency, state replication, and operational behavior harder.
- Use it when bottlenecks are proven and the team can operate the distributed runtime.

---

## Deep Dive

### Core Idea

Instead of every request hitting one central database, processing units keep or access data close to computation. A data grid, replicated cache, or tuple-space-like mechanism coordinates state across nodes.

### Good Fit

- Extreme throughput and low-latency workloads.
- Systems with partitionable data and predictable access patterns.
- Scenarios where database writes can be buffered, replicated, or synchronized asynchronously.

### Be Careful When

- Strong transactional consistency is required for every operation.
- The team lacks operational experience with distributed in-memory systems.
- The data model is hard to partition.

### State and recovery example

A processing unit handles accounts assigned by a partition key. A replicated in-memory grid serves reads, while durable writes go to an owned persistent store or log. After a unit fails, replacement units rebuild state from that durable source; recovery time and possible lag depend on the replication/persistence design. Define whether reads can be stale and how conflicting updates resolve. This is a conceptual topology. [GigaSpaces first-party documentation](https://docs.gigaspaces.com/latest/overview/the-in-memory-data-grid.html) (current guide; checked 2026-09-24) describes processing units and partitioned spaces as one implementation of Space-Based Architecture; [its replication guide](https://docs.gigaspaces.com/latest/admin/replication.html) documents consistency tradeoffs. Throughput gains remain workload-specific.

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Replication and Partitioning/_Index]]
- [[Consistency Models]]
- [[Caching Strategies]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Microservices]]

## Sources

- [GigaSpaces, In-Memory Data Grid Layer](https://docs.gigaspaces.com/latest/overview/the-in-memory-data-grid.html) — current first-party guide; accessed 2026-09-24.
- [GigaSpaces, Replication](https://docs.gigaspaces.com/latest/admin/replication.html) — current first-party guide; accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
