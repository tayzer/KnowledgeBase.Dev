# Storage Engines
Date: 2026-08-13
Status: Needs Review
Tags: #data-systems #storage #storage-engines

## TL;DR / Quick Reference

**Definition:** A storage engine is the component that persists records and provides the physical access paths used by a database or data store.

**When to use:**
- When reasoning about durability, indexing, write amplification, read cost, or operational trade-offs in a data system.

**Key Takeaways:**
- The logical data model and physical storage layout are separate design concerns.
- Page-oriented and log-structured engines make different read, write, and maintenance trade-offs.
- Product-specific behaviour needs vendor-documentation review before this note becomes Current.

## Deep Dive

Storage engines organise records, indexes, logs, and recovery metadata on durable media. Their design affects latency, throughput, compaction or vacuum work, crash recovery, and operational capacity planning.

## Related Concepts
- [[Areas/Data Systems/Storage and Retrieval/B-Trees|B-Trees]]
- [[Areas/Data Systems/Storage and Retrieval/LSM Trees|LSM Trees]]
- [[Areas/Data Systems/Storage and Retrieval/_Index|Storage and Retrieval]]

## Review Schedule
- [ ] Add reviewed product examples before promotion to Current.
