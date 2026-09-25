---
date: 2026-08-13
status: Current
tags:
  - data-systems
  - storage
  - storage-engines

---

# Storage Engines

## Quick Reference

**Definition:** A storage engine is the component that persists records and provides the physical access paths used by a database or data store.

**When to use:**
- When reasoning about durability, indexing, write amplification, read cost, or operational trade-offs in a data system.

**Key Takeaways:**
- The logical data model and physical storage layout are separate design concerns.
- Page-oriented and log-structured engines make different read, write, and maintenance trade-offs.
- Product-specific behavior must be checked in the vendor's documentation and on the chosen release.

**Limit:** No engine layout is universally faster; use measured read/write and maintenance costs.


## Deep Dive

Storage engines organise records, indexes, logs, and recovery metadata on durable media. Their design affects latency, throughput, compaction or vacuum work, crash recovery, and operational capacity planning.

## Physical layout comparison

A PostgreSQL B-tree uses page-oriented ordered indexing, while RocksDB uses memtables, SST files, and compaction. Both need durability logging/recovery decisions, but products differ. Compare point/range reads, write amplification, space amplification, memory, and maintenance on a measured workload; the logical schema alone does not determine engine cost.

## Sources

- [Primary documentation](https://github.com/facebook/rocksdb/wiki/RocksDB-Overview) (accessed 2026-09-24).

## Related Concepts
- [[B-Trees|B-Trees]]
- [[LSM Trees|LSM Trees]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Storage and Retrieval/_Index|Storage and Retrieval]]

## Review Schedule
- [ ] Add reviewed product examples before promotion to Current.
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
