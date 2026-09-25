---
date: 2026-08-13
status: Current
tags:
  - knowledge-base
  - engineering-practice
  - maintainability-and-code-health

---

# Coupling

## Quick Reference
**Definition:** Coupling is the degree to which modules, services, or teams depend on one another to function or change.

**When to use:**
- Use this note when changing a module boundary, service contract, or team ownership model.

**Key Takeaways:**
- Distinguish runtime dependencies from the need to change and release code together.
- Reduce accidental coupling at boundaries; some coupling expresses stable domain relationships.

## Deep Dive

### Coupling Lenses

These are diagnostic lenses for this note, not a universal taxonomy:

| Lens | Example | Question |
| --- | --- | --- |
| Runtime/operational | Checkout synchronously calls inventory | Can checkout function or degrade if inventory is unavailable? |
| Change/developmental | Two modules repeatedly need the same coordinated edit | Is one boundary exposing an unstable implementation detail? |
| Data | Two services write the same table | Who owns the schema and migration order? |
| Temporal | One operation must finish before another can proceed | Is that ordering essential or incidental? |
| Semantic | Two services use “customer” with different meanings | Where is translation or a bounded context needed? |
| Duplicate logic | Two teams implement the same pricing rule separately | Is shared policy or explicit synchronization warranted? |

Some coupling reflects a stable domain rule and should be accepted. The aim is to make dependencies and change costs visible, not eliminate every connection.

### Diagnostic Signals

Slow builds, complex test setup, brittle tests, blocked teams, lockstep releases, and long parameter lists can signal coupling. They are symptoms, not proof: measure joint-change frequency, dependency paths, and failure impact before redesigning.

### Ways to Manage It

- Hide unstable implementation choices behind a boundary with an explicit contract.
- Translate and validate external data where ownership changes; define version and compatibility rules.
- Use events or messages when asynchronous behavior fits the business semantics and consumers can handle delay, duplication, and failure.
- Use CI and focused tests to reveal joint-change costs; test difficulty is evidence to investigate, not an automatic mandate to split.
- Tighten boundaries around stable policy and leave uncertain variation easy to change. Record deliberate coupling when it simplifies a cohesive system.

**Example:** If checkout and inventory share a database table, a schema change and deployment must be coordinated. Moving to an inventory API can separate ownership, but checkout then gains runtime availability and protocol concerns. Choose using failure and change evidence.

## Sources and Scope

- [David Parnas, “On the Criteria To Be Used in Decomposing Systems into Modules”](https://doi.org/10.1145/361598.361623) — original information-hiding rationale; accessed 2026-09-24. The lens labels and examples above are editorial aids, not terms attributed to Parnas.
## Related Concepts
- [[Event-Driven Architecture]]
- [[Modular Monolith]]

## Review Schedule
- Review when a real boundary change tests these diagnostic lenses.
