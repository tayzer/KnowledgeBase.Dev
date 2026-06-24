# Saga Pattern
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #saga #distributed-transactions #messaging

## TL;DR / Quick Reference

**Definition:** A saga coordinates a long-running business transaction across multiple services using a sequence of local transactions and compensating actions instead of one distributed database transaction.

**When to use:**
- When a workflow spans multiple service boundaries and each service owns its own data.
- When eventual consistency is acceptable but failures need explicit recovery behavior.

**Key Takeaways:**
- Sagas replace atomic cross-service transactions with explicit workflow state and compensation.
- Orchestration centralizes the workflow; choreography lets services react to events.
- Compensation is business logic, not a simple technical rollback.

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

## Related Concepts

- [[Message-Driven Architecture]]
- [[Event Driven]]
- [[ServiceCommunication]]
- [[Consistency Models]]
- [[Transactions and Isolation Levels]]

## Review Schedule

- [ ] Review in 3 months