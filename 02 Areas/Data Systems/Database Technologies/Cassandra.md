---
date: 2026-04-30
status: Current
tags:
  - cassandra
  - nosql
  - wide-column
  - distributed

---

# Cassandra

## Quick Reference

**Definition:** A distributed wide-column NoSQL database designed for partitioned distributed storage with configurable replication and consistency.

**When to use:**
- Systems with known partition-key queries and explicit multi-node availability and consistency needs.
- Workloads such as event, telemetry, time-series, or large distributed data sets that are modeled around known query patterns.

**Key Takeaways:**
- **Horizontal scale and availability** are core strengths of Cassandra.
- **Tunable consistency** lets teams choose tradeoffs per workload.
- Caution: **Query-first data modeling is important**: poor partition-key and access-pattern decisions are expensive to fix later.

**Limit:** Hot partitions, repairs, and consistency settings can dominate a distributed deployment.

---

## Deep Dive

### Good Fit
Cassandra is often used for write-heavy operational data, append-heavy event streams, and systems that must tolerate node or regional failures.

### Design Considerations
- Model tables around known queries rather than around a normalized relational schema.
- Choose partition keys carefully to avoid hot partitions and uneven distribution.
- Be explicit about consistency, repair, compaction, and operational complexity.

## Partition and consistency example

For telemetry by device and day, a partition key such as (device_id, day) bounds partitions; event time can be a clustering key. Estimate hot-device write rate. Choose replication factor and read/write consistency levels together, then test replica failures. Repairs, compaction, and tombstones add work.

## Sources

- [Primary documentation](https://cassandra.apache.org/doc/stable/cassandra/architecture/dynamo.html) (accessed 2026-09-24).

## CQL illustration

For a bounded daily telemetry partition, one possible table is:

~~~sql
CREATE TABLE telemetry_by_device_day (
  device_id uuid, day date, event_time timestamp, reading double,
  PRIMARY KEY ((device_id, day), event_time)
) WITH CLUSTERING ORDER BY (event_time DESC);
~~~

Check partition size and hot-key rate on real data. The table supports device/day queries; it is not an arbitrary cross-device analytics schema. [Cassandra CQL data definition](https://cassandra.apache.org/doc/latest/cassandra/developing/cql/ddl.html) (accessed 2026-09-24).

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]

## Review Schedule
- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
