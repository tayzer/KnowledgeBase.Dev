---
date: 2026-08-13
status: Current
tags:
  - data-systems
  - storage
  - indexing
  - lsm-trees

---

# LSM Trees

## Quick Reference

**Definition:** An LSM tree is a log-structured storage design that batches writes into sorted immutable files and reorganises them through compaction.

**When to use:**
- When comparing write-heavy storage designs with page-oriented indexes.

**Key Takeaways:**
- Buffered writes and sequential file creation can favour high write throughput.
- Reads may consult multiple structures until compaction consolidates data.
- Compaction policy controls important latency, space, and write-amplification trade-offs.

**Limit:** Compaction trades read, write, space, and latency costs; a write-heavy fit is workload-dependent.


## Deep Dive

Writes are commonly accepted into an in-memory sorted structure and a durability log, then flushed to immutable sorted tables. Background compaction merges tables and discards superseded values. Read paths use indexes, filters, and table metadata to limit the files examined.

## Write, read, and compaction path

A typical LSM design writes to a log/memtable, flushes sorted SST files, then compacts them. Reads may consult several levels and use Bloom filters or indexes to reduce work. Compaction trades write, read, and space amplification; its latency and throughput depend on workload and policy. RocksDB is an implementation example, not the definition of every LSM tree.

## Sources

- [Primary documentation](https://github.com/facebook/rocksdb/wiki/RocksDB-Overview) (accessed 2026-09-24).

## Related Concepts
- [[Storage Engines|Storage Engines]]
- [[B-Trees|B-Trees]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Storage and Retrieval/_Index|Storage and Retrieval]]

## Review Schedule
- [ ] Add reviewed implementation examples before promotion to Current.
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
