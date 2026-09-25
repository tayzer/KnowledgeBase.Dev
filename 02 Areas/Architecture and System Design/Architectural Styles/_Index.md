---
date: "2026-08-13"
status: Current
tags: [taxonomy, architectural-styles]

---

# Architectural Styles

## Quick Reference

This category covers Layered Architectures, Modular Monoliths, Ports and Adapters, Clean Architecture, and more. Published notes and narrower categories are linked below.

## Category Boundary

Compare whole-system organization and dependency direction here. “Monolith” describes deployment shape, while layering describes internal organization; these can coexist. The planned terms below are plain text until a canonical note is published.

## Published Notes

- [[Cell-Based Architecture|Cell-Based Architecture]] - Cell-based architecture partitions a system into isolated cells, where each cell owns enough compute and data for an assigned slice of traffic; shared control-plane and global dependencies can remain.
- [[Clean Architecture|Clean Architecture]] - An approach to structure applications so that source-code dependencies point inward toward business policies, keeping frameworks and UI at the edge. This can improve testability and maintainability when the boundaries are enforced.
- [[Microservices|Microservices]] - An architectural style that organizes an application as independently deployable services around business capabilities.
- [[Modular Monolith|Modular Monolith]] - A modular monolith is a single deployable application with strong internal module boundaries, usually organized around business capabilities or bounded contexts.
- [[Space-Based Architecture|Space-Based Architecture]] - Space-based architecture places processing and state in partitioned processing units, often backed by an in-memory data grid. A measured central-database bottleneck is one reason to consider it; performance gains depend on workload and persistence design.

## Subcategories

- No approved subcategories at this level.

## Published Leaf Extensions

### Layered Architectures
- [[Monolith|Monolith]] - A software architecture where the application is built as a single, unified unit.

### Service-Oriented Architecture
- [[Service-Based Architecture|Service-Based Architecture]] - In this note, a service-based architecture organizes a system into a modest number of business services with explicit contracts. The exact number, deployment autonomy, and data ownership are design choices, not defining thresholds.
- [[Service-Oriented Architecture|Service-Oriented Architecture]] - Service-Oriented Architecture (SOA) organizes distributed capabilities as services exposed through descriptions and contracts. Enterprise reuse and governance are common design choices, not defining requirements.


## Planned Coverage

- Layered Architectures
- Ports and Adapters
- Data-Centric Architectures

## Related Concepts

- [[Event-Driven Architecture|Event-Driven Architecture]] — published in its canonical category.

- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/_Index|Architecture and System Design]]

## Review Schedule

- Review when a topic is published or the category boundary changes.
