---
date: 2026-06-23
status: Current
tags:
  - transactions
  - isolation-levels
  - databases
  - concurrency

---

# Transactions and Isolation Levels

## Quick Reference

**Definition:** Transactions group database changes into reliable units of work, while isolation levels define how concurrent transactions can see and affect each other.

**When to use:**
- When preserving invariants across related reads and writes.
- When debugging concurrency anomalies, locking, deadlocks, or inconsistent reads.

**Key Takeaways:**
- Transactions protect correctness, but longer or broader transactions can reduce concurrency.
- Isolation choices trade anomaly prevention against engine-specific retry, locking, latency, and throughput costs.
- Know the anomalies you are trying to prevent before increasing isolation.

**Limit:** Isolation behavior is engine-specific and stronger levels may require whole-transaction retries.

---

## Deep Dive

### ACID In Brief

- Atomicity: all changes in the transaction succeed or fail together.
- Consistency: committed data should satisfy database and domain rules.
- Isolation: concurrent transactions should not interfere beyond the chosen level.
- Durability: committed changes survive failures according to the database guarantees.

### Common Isolation Concepts

| Concept | Meaning |
| --- | --- |
| Dirty read | Reading uncommitted data from another transaction |
| Non-repeatable read | Reading the same row twice and seeing different committed values |
| Phantom read | Re-running a query and seeing new or removed rows |
| Lost update | Concurrent writes overwrite each other without detection |
| Serializable behavior | Transactions behave as if they ran one at a time |

### Practical Guidance

- Keep transactions as short as the business operation allows.
- Use optimistic concurrency where conflicts are expected but uncommon.
- Use stronger locks or isolation when an invariant cannot tolerate races.
- Avoid doing slow external calls inside database transactions.
- Log and retry deadlock or transient-concurrency failures only when the operation is safe to retry.

## Isolation matrix and anomaly example

PostgreSQL 18 Read Committed gives each statement a new snapshot and can allow nonrepeatable reads. PostgreSQL Repeatable Read uses a transaction snapshot and rejects some conflicting updates; Serializable aims to make concurrent execution equivalent to a serial order and can require transaction retries. SQL standard names do not fully determine engine behavior. For a doctor-on-call invariant, two concurrent writes can cause write skew under snapshot isolation; test the engine and choose isolation or explicit locking accordingly.

## Sources

- [Primary documentation](https://www.postgresql.org/docs/18/transaction-iso.html) (accessed 2026-09-24).

## PostgreSQL 18 isolation at a glance

| Level | Snapshot | Important consequence |
| --- | --- | --- |
| Read Committed | New snapshot for each statement | Repeated reads may see new committed data. |
| Repeatable Read | Stable transaction snapshot | Concurrent updates may require retry; behavior differs from a generic SQL-standard table. |
| Serializable | Equivalent to some serial execution when transactions succeed | Serialization failures require whole-transaction retry. |

A dirty read is not exposed at PostgreSQL Read Uncommitted, which behaves like Read Committed. Write skew should be tested against the target engine and invariant. [PostgreSQL 18 isolation](https://www.postgresql.org/docs/18/transaction-iso.html) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Schema Migrations]]
- [[Consistency Models]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
