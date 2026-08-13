# Transactions and Isolation Levels
Date: 2026-06-23
Status: Needs Review
Tags: #transactions #isolation-levels #databases #concurrency

## TL;DR / Quick Reference

**Definition:** Transactions group database changes into reliable units of work, while isolation levels define how concurrent transactions can see and affect each other.

**When to use:**
- When preserving invariants across related reads and writes.
- When debugging concurrency anomalies, locking, deadlocks, or inconsistent reads.

**Key Takeaways:**
- Transactions protect correctness, but longer or broader transactions can reduce concurrency.
- Isolation is a tradeoff between stronger consistency and higher contention.
- Know the anomalies you are trying to prevent before increasing isolation.

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

## Related Concepts

- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Schema Migrations]]
- [[Consistency Models]]

## Review Schedule

- [ ] Review in 3 months
