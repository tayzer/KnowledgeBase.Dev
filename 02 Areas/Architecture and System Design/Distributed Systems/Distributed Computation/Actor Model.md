---
date: 2026-06-23
status: Current
tags:
  - architecture
  - actor-model
  - concurrency
  - distributed-systems

---

# Actor Model

## Quick Reference

**Definition:** The actor model structures a system as independent actors that own state, process messages one at a time, and communicate by sending messages to other actors.

**When to use:**
- Highly concurrent systems where isolated state ownership and message passing simplify reasoning.
- Distributed workloads with many independent entities, sessions, devices, games, simulations, or workflows.

**Key Takeaways:**
- Actors reduce shared-memory concurrency problems by making state ownership explicit.
- Message ordering, supervision, placement, persistence, and backpressure still need careful design.
- Actor systems are powerful when the domain naturally decomposes into many independent agents of behavior.

---

## Deep Dive

### Good Fit

- Chat, collaboration, IoT, game, simulation, and workflow systems.
- Per-entity state machines where each entity can process messages serially.
- Systems that need location transparency or distribution across nodes.

### Be Careful When

- Most work is simple request/response CRUD.
- The team is unfamiliar with actor lifecycle and supervision.
- Querying global state across many actors becomes the dominant workload.

### Design Guidance

- Keep actor state small and owned by one actor.
- Model messages as explicit contracts.
- Design supervision and failure behavior deliberately.
- Avoid blocking calls inside actors.
- Use projections or query models for cross-actor reads.

### Guarantees versus runtime features

An actor processes its own mailbox sequentially under the usual model; the model alone does not guarantee durable mailboxes, global ordering, or delivery after failure. Configure mailbox capacity or demand control to avoid unbounded growth. For an Akka Typed deployment, check ordering and delivery guarantees for the specific transport and topology rather than assuming at-least-once delivery for all actors. [Akka Typed actor guide](https://doc.akka.io/libraries/akka-core/current/typed/guide/actors-intro.html) (current guide; checked 2026-09-24).

## Related Concepts

- [[Message-Driven Architecture]]
- [[Event-Driven Architecture]]
- [[Consistency Models]]
- [[Async]]
- [[Thread Pool]]

## Sources

- [Akka, How the Actor Model Meets Modern Distributed Systems](https://doc.akka.io/libraries/akka-core/current/typed/guide/actors-intro.html) — current documentation accessed 2026-09-24.

## Review Schedule

- [ ] Review in 3 months
