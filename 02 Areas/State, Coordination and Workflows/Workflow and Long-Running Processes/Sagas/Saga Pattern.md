---
date: 2026-06-23
status: Current
tags:
  - architecture
  - saga
  - distributed-transactions
  - messaging

---

# Saga Pattern

## Quick Reference

**Definition:** A saga coordinates a long-running business transaction across multiple services using a sequence of local transactions and compensating actions instead of one distributed database transaction.

**When to use:**
- When a workflow spans multiple service boundaries and each service owns its own data.
- When eventual consistency is acceptable but failures need explicit recovery behavior.

**Key Takeaways:**
- Sagas coordinate local transactions with explicit workflow state and compensation when a cross-service atomic transaction is unsuitable; the whole workflow is not atomic.
- Orchestration centralizes the workflow; choreography lets services react to events.
- Compensation is business logic, not a simple technical rollback.

**Limit:** Compensation is a new business action, not an atomic rollback of the whole workflow.

---

## Deep Dive

### Orchestration vs Choreography

| Style | How it works | Good fit | Risk |
| --- | --- | --- | --- |
| Orchestration | A coordinator tells participants what to do next | Complex workflows needing visibility and control | Coordinator can become a god service |
| Choreography | Services react to events and publish their own events | Simple, loosely coupled flows | Workflow becomes hard to see and debug |

### Design Guidance

- Model the saga state explicitly.
- Make each step idempotent.
- Define compensation for business failures, not only technical failures.
- Add correlation IDs across all messages.
- Decide what happens when compensation also fails.

### Avoid When

- A single local transaction can solve the problem.
- The workflow requires immediate global consistency.
- The business cannot define safe compensating actions.

## Failure flow and irreversible step

For an order workflow: reserve inventory, authorize payment, then arrange shipment. If payment fails, release inventory; if shipment fails after capture, issue a refund or manual reconciliation rather than pretending the transaction rolled back. Put irreversible actions after a pivot where possible. Persist state and use idempotent commands, retries, and an outbox or equivalent atomic publication boundary. Sagas do not make the whole cross-service workflow atomic.

## Sources

- [Azure transactional outbox pattern](https://learn.microsoft.com/en-us/azure/architecture/databases/guide/transactional-out-box-cosmos) (accessed 2026-09-24).

- [Primary documentation](https://learn.microsoft.com/en-us/azure/architecture/patterns/saga) (accessed 2026-09-24).

## Related Concepts

- [[Message-Driven Architecture]]
- [[Event-Driven Architecture]]
- [[Service Communication]]
- [[Consistency Models]]
- [[Transactions and Isolation Levels]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
