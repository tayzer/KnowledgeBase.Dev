# LSM Trees
Date: 2026-08-13
Status: Needs Review
Tags: #data-systems #storage #indexing #lsm-trees

## TL;DR / Quick Reference

**Definition:** An LSM tree is a log-structured storage design that batches writes into sorted immutable files and reorganises them through compaction.

**When to use:**
- When comparing write-heavy storage designs with page-oriented indexes.

**Key Takeaways:**
- Buffered writes and sequential file creation can favour high write throughput.
- Reads may consult multiple structures until compaction consolidates data.
- Compaction policy controls important latency, space, and write-amplification trade-offs.

## Deep Dive

Writes are commonly accepted into an in-memory sorted structure and a durability log, then flushed to immutable sorted tables. Background compaction merges tables and discards superseded values. Read paths use indexes, filters, and table metadata to limit the files examined.

## Related Concepts
- [[Areas/Data Systems/Storage and Retrieval/Storage Engines|Storage Engines]]
- [[Areas/Data Systems/Storage and Retrieval/B-Trees|B-Trees]]
- [[Areas/Data Systems/Storage and Retrieval/_Index|Storage and Retrieval]]

## Review Schedule
- [ ] Add reviewed implementation examples before promotion to Current.
