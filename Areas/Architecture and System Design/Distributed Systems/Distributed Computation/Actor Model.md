# Actor Model
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #actor-model #concurrency #distributed-systems

## TL;DR / Quick Reference

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

## Related Concepts

- [[Message-Driven Architecture]]
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]
- [[Consistency Models]]
- [[Async]]
- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool]]

## Review Schedule

- [ ] Review in 3 months
