---
date: 2026-08-13
status: Current
tags:
  - data-systems
  - storage
  - indexing
  - b-trees

---

# B-Trees

## Quick Reference

**Definition:** A B-tree is a balanced, page-oriented search-tree family commonly used for ordered indexes and storage on block devices.

**When to use:**
- When a workload needs ordered lookup, range scans, or predictable tree height.

**Key Takeaways:**
- Nodes are sized to make effective use of storage pages or blocks.
- Balanced updates keep lookup depth bounded as data grows.
- Real database implementations vary in locking, logging, fill-factor, and maintenance behaviour.

**Limit:** Database B-tree implementations vary in locking, logging, and maintenance.


## Deep Dive

An internal node routes a search to a child range; a leaf node stores keys and either values or references to rows. Inserts and deletes may split, merge, or rebalance nodes. The implementation details determine write amplification and concurrency characteristics.

## Search and update path

In a page-oriented B-tree index, lookup descends from root to leaf; range scans traverse ordered leaf entries. Inserts may split pages, and deletes/updates can create cleanup work. A database's B-tree variant, concurrency control, and logging differ by engine. Compare with LSM designs using read, write, and space amplification rather than a universal speed claim.

## Sources

- [Primary documentation](https://www.postgresql.org/docs/18/btree.html) (accessed 2026-09-24).

## Related Concepts
- [[Storage Engines|Storage Engines]]
- [[LSM Trees|LSM Trees]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Storage and Retrieval/_Index|Storage and Retrieval]]

## Review Schedule
- [ ] Add reviewed implementation examples before promotion to Current.
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
