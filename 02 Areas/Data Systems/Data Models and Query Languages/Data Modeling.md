---
date: 2026-06-23
status: Current
tags:
  - data-modeling
  - databases
  - domain-modeling
  - persistence

---

# Data Modeling

## Quick Reference

**Definition:** The practice of shaping data structures, relationships, constraints, and access paths so a system can store and retrieve information safely and usefully.

**When to use:**
- When designing a new database, storage model, API contract, or integration boundary.
- When deciding whether data should be normalized, denormalized, aggregate-shaped, event-shaped, or analytical.

**Key Takeaways:**
- Model around the questions the system must answer and the invariants it must protect.
- Relational models emphasize integrity, relationships, and flexible querying; document and key-value models may emphasize aggregate or key-based access; NoSQL products differ.
- Good data modeling is iterative: start with domain language, validate with queries and lifecycle, then refine for performance and operations.

**Limit:** A model that fits one query can complicate another or weaken invariants; test actual access patterns.

---

## Deep Dive

### Modeling Questions

- What are the core business concepts and relationships?
- Which invariants must always hold?
- What are the dominant reads and writes?
- What data changes together transactionally?
- What history, auditability, retention, and privacy requirements exist?
- Which data is operational, analytical, cached, derived, or externally owned?

### Common Shapes

| Shape | Useful when | Tradeoff |
| --- | --- | --- |
| Normalized relational model | Integrity and flexible querying matter | More joins and schema discipline |
| Denormalized read model | Reads need to be fast and predictable | Duplication and update complexity |
| Document aggregate | Data is naturally nested and loaded together | Cross-document queries can be harder |
| Key-value lookup | Access is almost always by key | Limited querying and relationship modeling |
| Analytical model | Reporting and trend analysis matter | Ingestion and freshness complexity |

### Practical Workflow

1. Name the domain concepts in business language.
2. Sketch core entities, aggregates, or documents.
3. List the top reads, writes, and invariants.
4. Choose storage based on those access patterns.
5. Add indexes, constraints, and migration strategy.
6. Revisit the model when real usage disproves assumptions.

## Worked model choice

An order and its lines can use relational tables, foreign keys, and a transaction. A document design may embed bounded order lines for one aggregate read, but must handle customer changes and growth. Choose from real queries, invariants, and migration needs.

## Sources

- [Primary documentation](https://www.mongodb.com/docs/manual/data-modeling/) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Data Warehouses]]
- [[Schema Migrations]]
- [[Materialized Read Model]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
