# Architecture and Patterns
Date: 2026-06-23
Status: Needs Review
Tags: #taxonomy #architecture #patterns #design

## TL;DR / Quick Reference

**Definition:** Hub for software architecture, distributed-system styles, design patterns, and structural decision-making.

**When to use:**
- When selecting high-level system structure.
- When comparing architecture, integration, data, and pattern tradeoffs.

**Key Takeaways:**
- Start with decision drivers: coupling, scalability, deployability, consistency, resilience, team ownership, and operational maturity.
- Architectural styles are not maturity levels; microservices are not automatically better than monoliths.
- Distributed architectures move complexity into contracts, data ownership, observability, and failure handling.

---

## Deep Dive

### Architectural Styles

- [[Monolith]] - single deployable application, useful when simplicity and transactional consistency matter.
- [[Modular Monolith]] - single deployable with strong internal module boundaries.
- [[Service Based Architecture]] - coarse-grained services with simpler operations than microservices.
- [[Service-Oriented Architecture]] - enterprise service contracts and reuse across systems.
- [[Microservices]] - independently deployable services aligned to business capabilities.
- [[Event Driven]] - services react to facts that have happened.
- [[Message-Driven Architecture]] - systems coordinate through commands, events, queues, topics, or streams.
- [[Serverless Architecture]] - managed cloud services and event-driven compute.
- [[CQRS]] - separate command and query models.
- [[Actor Model]] - state-owning actors communicate by messages.
- [[Stream Processing Architecture]] - continuous processing of event streams.
- [[Space-Based Architecture]] - distributed processing and state to reduce central bottlenecks.
- [[Cell-Based Architecture]] - isolated cells reduce blast radius at large scale.

### Integration And Distributed Workflow Patterns

- [[ServiceCommunication]] - synchronous and asynchronous service interaction choices.
- [[Service Composition]] - read-side aggregation across service boundaries.
- [[API Gateway Pattern]] - edge routing and cross-cutting API concerns.
- [[Backend for Frontend]] - client-specific backend APIs.
- [[Service Mesh]] - service-to-service traffic policy, security, and telemetry infrastructure.
- [[Saga Pattern]] - long-running distributed workflow using local transactions and compensation.
- [[Event Sourcing]] - store state changes as an event history.

### Data And State Links

- [[Data and State]] - data storage, consistency, replication, query, and persistence tradeoffs.
- [[Consistency Models]] - read/write visibility guarantees in distributed systems.
- [[Replication and Partitioning]] - copied and split data across nodes or regions.
- [[Materialized Read Model]] - query-ready read models and projections.

### Current Migration Sources

- `Areas/Patterns/`

## Related Concepts

- [[Languages and Frameworks]]
- [[Data and State]]
- [[Operations and Reliability]]
- [[Cloud and Delivery]]
- [[Testing and Quality]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## Review Schedule

- [ ] Review in 3 months