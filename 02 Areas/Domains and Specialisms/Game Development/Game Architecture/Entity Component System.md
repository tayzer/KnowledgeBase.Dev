---
date: 2025-11-25
status: Current
tags:
  - architecture
  - gamedev
  - design-patterns
  - performance
  - unity
  - dots

---

# Entity Component System (ECS)

## Quick Reference

**Definition:** Entity Component System (ECS) organizes game state as entities identified by IDs, components that hold data, and systems that process entities matching component queries. Exact storage and scheduling depend on the implementation.

**When to use:** Consider ECS when many entities need similar transformations, composition and data access patterns matter, or an existing engine's ECS tools fit the project's authoring workflow. Prototype and profile against a simpler object-based design before adopting it for performance alone.

**Actionable points:**
- Model a component around data a system needs; keep ownership and lifetime explicit.
- Query only the required components. Document read/write dependencies between systems.
- Decide when entities are created, destroyed, or have components added or removed; these structural changes can be costly.
- Measure frame time, memory use, and authoring/debugging effort with representative workloads.

**Limit:** ECS does not automatically improve cache locality, parallelism, networking, or maintainability. Results depend on layout, access patterns, scheduling, engine implementation, and workload.

## Deep Dive

### Model and data layout

An entity is an identity associated with a set of components. A movement system might query entities with `Position` and `Velocity`, then update positions. Components are usually data-oriented, though the exact rules vary by framework. This is composition of state rather than an inheritance hierarchy of entity types.

Some ECS implementations group entities with the same component types into archetypes and store their component data in chunks. Iterating a matching chunk can reduce indirection. Sparse access, frequent structural changes, or small workloads can erase that advantage. “Objects are scattered” and “ECS is contiguous” are not universal descriptions of all object-based or ECS layouts.

### Scheduling and communication

Independent jobs may run in parallel when their read/write component access does not conflict and the scheduler supports it. A write conflict or required order creates a dependency. Use explicit ordering, command buffers, events, or components according to the framework; “systems never know about each other” is too absolute.

### Unity Entities example

Unity's Entities package is one concrete ECS. Its APIs are versioned, so check the installed package documentation before copying snippets. The source note's `ISystem`/`SystemAPI.Query` example is useful as a version-specific illustration, but it is omitted here until compiled against the project's actual Entities version. Unity 6.0 documentation lists Entities 1.4.8 as released and 1.5.0-exp.1 as compatible, as checked 2026-09-24; other Unity Editor versions can differ.

### Choosing between approaches

Use a conventional object or component model when the entity count is modest, behavior is heterogeneous, or its tooling makes the work simpler. Consider ECS when profiling identifies repeated data transforms over many similar entities and the team's tooling supports queries and debugging. There is no credible object-count threshold that makes one model universally faster.

For an RTS movement workload, compare implementations with the same logic and entity count. Measure update time, memory, structural-change cost, and visibility of state. Do not assume vectorization or a fixed speedup without inspecting generated code or profiling.

## Related Concepts

- [[Game AI|Game AI]] - one possible consumer of entity state.
- [[Unity Resources|Unity Resources]] - Unity-specific APIs and tooling.
- [[Thread Pool|Thread Pool]] - general scheduling concepts, distinct from an ECS job scheduler.

## Resources

- [Unity Entities 1.4 manual](https://docs.unity3d.com/Packages/com.unity.entities@1.4/manual/index.html) - implementation and API details; package version 1.4.
- [Unity 6.0 Entities package status](https://docs.unity3d.com/6000.0/Documentation/Manual/com.unity.entities.html) - version compatibility; checked 2026-09-24.
- [Data-Oriented Design](https://dataorienteddesign.com/dod/) - background on data access patterns.

## Practice Exercises

1. Implement movement of `Position` and `Velocity` entities in a small ECS, then measure it against a simple object loop using the same data.
2. Add and remove a `Paused` tag; inspect whether that changes an archetype and measure its cost.
3. Add damage and death systems; define their order and how removals are deferred safely.

## Review Schedule

- [ ] Recheck Unity package compatibility and example APIs when the target Unity version changes; review performance claims against a measured workload.
