# Taxonomy Hub Source Archive
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #taxonomy #migration #archive

## TL;DR / Quick Reference

**Definition:** Historical hub text retained as migration evidence after the clean taxonomy cutover.

**When to use:**
- Use only to recover context while reviewing or improving a canonical note.

**Key Takeaways:**
- This is not live navigation and must not receive new links.
- Canonical navigation lives in [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]].

## Historical Source Material

## Areas\Architecture and System Design\_Index.md

<!-- preserved-source: Areas/Architecture and Patterns/Architecture and Patterns.md -->

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

- [[Areas\Architecture and System Design\Architectural Styles\Layered Architectures\Monolith|Monolith]] - single deployable application, useful when simplicity and transactional consistency matter.
- [[Areas\Architecture and System Design\Architectural Styles\Modular Monolith|Modular Monolith]] - single deployable with strong internal module boundaries.
- [[Areas/Architecture and System Design/Architectural Styles/_Index]] - coarse-grained services with simpler operations than microservices.
- [[Areas\Architecture and System Design\Architectural Styles\Service-Oriented Architecture\Service-Oriented Architecture|Service-Oriented Architecture]] - enterprise service contracts and reuse across systems.
- [[Areas\Architecture and System Design\Architectural Styles\Microservices|Microservices]] - independently deployable services aligned to business capabilities.
- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]] - services react to facts that have happened.
- [[Areas\Architecture and System Design\Integration and Messaging\Integration Styles\Message-Driven Architecture|Message-Driven Architecture]] - systems coordinate through commands, events, queues, topics, or streams.
- [[Areas\Cloud and Platform Engineering\Serverless\Serverless Architecture|Serverless Architecture]] - managed cloud services and event-driven compute.
- [[Areas\Architecture and System Design\Domain-Driven Design\DDD and Architecture\CQRS|CQRS]] - separate command and query models.
- [[Areas\Architecture and System Design\Distributed Systems\Distributed Computation\Actor Model|Actor Model]] - state-owning actors communicate by messages.
- [[Areas\Architecture and System Design\Architectural Styles\Space-Based Architecture|Space-Based Architecture]] - distributed processing and state to reduce central bottlenecks.
- [[Areas\Architecture and System Design\Architectural Styles\Cell-Based Architecture|Cell-Based Architecture]] - isolated cells reduce blast radius at large scale.

### Design Patterns

- [[Areas\Architecture and System Design\Design Patterns\Behavioural Patterns\Strategy|Strategy]] - interchangeable algorithms behind a common contract.
- [[Areas\Architecture and System Design\Design Patterns\Structural Patterns\Decorator|Decorator]] - add behavior by wrapping an implementation on the same contract.
- [[Areas\Architecture and System Design\Design Patterns\Behavioural Patterns\Template Method|Template Method]] - fixed algorithm skeleton with overridable steps.
- [[Areas\Architecture and System Design\Design Patterns\Structural Patterns\Plugin|Plugin]] - stable host with registered or discovered extension implementations.
- [[Areas\Architecture and System Design\Design Patterns\Enterprise Application Patterns\Specification|Specification]] - reusable business rule or query predicate objects.
- [[Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview]] - async, thread pools, producer-consumer, and future/promise coordination patterns.

### Integration And Distributed Workflow Patterns

- [[Areas\Architecture and System Design\Integration and Messaging\Integration Styles\Service Communication|Service Communication]] - synchronous and asynchronous service interaction choices.
- [[Areas\Architecture and System Design\System Design\Component Design\Service Composition|Service Composition]] - read-side aggregation across service boundaries.
- [[Areas\Architecture and System Design\Integration and Messaging\Integration Styles\API Gateway Pattern|API Gateway Pattern]] - edge routing and cross-cutting API concerns.
- [[Areas\Architecture and System Design\Integration and Messaging\Integration Styles\Backend for Frontend|Backend for Frontend]] - client-specific backend APIs.
- [[Areas\Cloud and Platform Engineering\Platform Engineering\Service Mesh|Service Mesh]] - service-to-service traffic policy, security, and telemetry infrastructure.
- [[Areas\State, Coordination and Workflows\Workflow and Long-Running Processes\Sagas\Saga Pattern|Saga Pattern]] - long-running distributed workflow using local transactions and compensation.

### Data Systems Links

- [[Areas/Data Systems/_Index]] - DDIA-shaped data models, storage, persistence, distribution, and derived data.
- [[Areas/State, Coordination and Workflows/_Index]] - runtime, session, workflow, and application-owned state.
- [[Areas\Data Systems\Consistency\Consistency Models|Consistency Models]] - read/write visibility guarantees in distributed systems.
- [[Areas/Data Systems/Replication and Partitioning/_Index]] - copied and split data across nodes or regions.
- [[Areas\Data Systems\Streaming and Derived Data\Materialized Read Model|Materialized Read Model]] - query-ready read models and projections; canonical note lives in [[Areas/Data Systems/_Index]].

### Current Migration Sources

- `Areas/Patterns/`

## Related Concepts

- [[Areas/Languages, Runtimes and Frameworks/_Index]]
- [[Areas/Data Systems/_Index]]
- [[Areas/Reliability and Operations/_Index]]
- [[Areas/Cloud and Platform Engineering/_Index]]
- [[Areas/Testing and Quality/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## Review Schedule

- [ ] Review in 3 months


---

## Areas\Architecture and System Design\Domain-Driven Design\_Index.md

<!-- preserved-source: Areas/Architecture and Patterns/Domain-Driven Design/Domain-Driven Design.md -->

# Domain-Driven Design
Date: 2026-06-16
Status: Needs Review
Tags: #ddd #architecture #domain-modeling #engineering-approach

## 🎯 TL;DR / Quick Reference

**Definition:** An architecture and modeling approach that centers software design around core business domains, explicit boundaries, and a shared domain language.

**When to use:**
- When domain complexity is high and terminology drift causes delivery issues.
- When teams need clearer ownership boundaries across services or modules.

**Key Takeaways:**
- ✅ DDD is a broader design and organizational approach, not just a set of tactical patterns.
- ✅ Strategic design (bounded contexts, context maps) should guide tactical design.
- ⚠️ Applying tactical patterns without context boundaries often increases complexity.

---

## 📚 Deep Dive

### Strategic Elements
- Ubiquitous language shared by domain experts and engineers.
- Bounded contexts to separate models with different meanings.
- Context mapping to define integration relationships.

### Tactical Elements
- Aggregates and entities to protect invariants.
- Value objects to model immutable concepts.
- Repositories and unit of work for persistence boundaries where appropriate.

### Practical Use
- Start by identifying core domain versus supporting domains.
- Define context boundaries before choosing service boundaries.
- Use tactical patterns where complexity justifies them.

## 🔗 Related Concepts
- [[Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern]]
- [[Areas/Data Systems/Data Access/Unit of Work]]
- [[Areas/Engineering Practice/Engineering Process/Engineering Approaches|Engineering Approaches]]

## 🔄 Review Schedule
- [ ] Review in 2 months


---

## Areas\Cloud and Platform Engineering\_Index.md

<!-- preserved-source: Areas/Cloud and Delivery/Cloud and Delivery.md -->

# Cloud and Delivery
Date: 2026-06-26
Status: Needs Review
Tags: #taxonomy #cloud #delivery #devops

## TL;DR / Quick Reference

**Definition:** Hub for cloud platform usage, infrastructure provisioning, and software delivery workflows.

**When to use:**
- When defining CI/CD, infrastructure as code, or deployment processes.
- When selecting cloud services for delivery pipelines and managed runtime platforms.

**Key Takeaways:**
- This category owns build-and-change concerns.
- Runtime health and incident handling belong in Operations and Reliability.
- Azure service selection starts at [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]] and branches into compute, storage, messaging, and local development notes.

---

## Deep Dive

### What This Category Covers

- Cloud services for application hosting, CI/CD, IaC, container delivery, release automation, and managed platform choices.

### Azure Notes

- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]] - high-level Azure service map.
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Compute\Azure Functions|Azure Functions]] - event-driven serverless compute.
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Messaging Service Selection|Azure Messaging Service Selection]] - chooser for Queue Storage, Service Bus, Event Grid, and Event Hubs.
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Queue Storage|Azure Queue Storage]] - simple async work queues.
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Service Bus|Azure Service Bus]] - enterprise queues, topics, subscriptions, and broker features.
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Event Grid|Azure Event Grid]] - event routing for reactive/serverless workflows.
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Event Hubs|Azure Event Hubs]] - high-throughput event streaming.
- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite]] - local Azure Storage emulator for Blob, Queue, and Table Storage.

### How To Choose Within This Category

- Optimize for repeatable deployments, traceability, and safe rollback.
- Link operations guidance instead of duplicating production run practices.
- Prefer managed services when they reduce operational load without hiding critical reliability requirements.

### Current Migration Sources

- `Areas/DevOps/` (delivery-focused content)

## Related Concepts

- [[Areas/Reliability and Operations/_Index]]
- [[Areas/Engineering Practice/_Index]]
- [[Areas/Architecture and System Design/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## Review Schedule

- [ ] Review in 1 month


---

## Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\_Index.md

<!-- preserved-source: Areas/Cloud and Delivery/AzureServicesOverview.md -->

# Azure Services Overview
Date: 2026-06-26
Status: Needs Review
Tags: #azure #cloud #services #architecture

## TL;DR / Quick Reference

**Definition:** High-level overview of common Azure services useful for .NET applications: App Service, Functions, AKS, Storage, Service Bus, Event Grid, Event Hubs, Cosmos DB, Redis, Key Vault, and observability.

**When to use:**
- Selecting cloud primitives for application needs: compute, storage, messaging, integration, security, and operations.
- Comparing Azure service options before creating a more detailed architecture note.

**Key Takeaways:**
- **Serverless ([[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Compute\Azure Functions|Azure Functions]])** fits event-driven, low-maintenance workloads.
- **AKS** fits container orchestration at scale when Kubernetes control is worth the complexity.
- **Managed PaaS (App Service)** fits straightforward web app/API hosting.
- **Key Vault** should hold secrets, keys, and certificates.
- Use [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Messaging Service Selection|Azure Messaging Service Selection]] when choosing between queues, brokered messages, event routing, and streams.

**Gotchas:**
- **Cost model:** Each service has different billing; design for scale and cost.
- **Consistency models:** Cosmos DB offers tunable consistency; choose carefully.
- **Messaging semantics:** Queue Storage, Service Bus, Event Grid, and Event Hubs solve different problems despite overlapping vocabulary.

---

## Deep Dive

### Compute Options

- **App Service:** Managed web/API hosting with easy CI/CD.
- **[[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Compute\Azure Functions|Azure Functions]]:** Event-driven serverless compute for HTTP, queue, timer, blob, Event Grid, Service Bus, and Event Hubs triggers.
- **AKS:** Kubernetes for containers; full control and operational complexity.
- **Container Apps:** Managed container hosting for microservices, jobs, and event-driven containers.

### Data And Storage

- **[[Areas\Data Systems\Storage and Retrieval\Azure Blob Storage|Azure Blob Storage]]:** Object storage for files and large binary content.
- **Cosmos DB:** Globally distributed NoSQL database with tunable consistency.
- **Azure SQL / Managed Instance:** Relational database options.
- **Azure Cache for Redis:** Managed cache for low-latency reads and shared transient state.

### Messaging And Integration

- **[[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Queue Storage|Azure Queue Storage]]:** Simple async work queues backed by Azure Storage.
- **[[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Service Bus|Azure Service Bus]]:** Enterprise messaging with queues, topics, subscriptions, dead-lettering, sessions, and transactions.
- **[[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Event Grid|Azure Event Grid]]:** Event routing for serverless and reactive architectures.
- **[[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Event Hubs|Azure Event Hubs]]:** High-throughput event streaming for telemetry, logs, clickstreams, and IoT.
- **[[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Messaging Service Selection|Azure Messaging Service Selection]]:** Quick chooser for Azure Queue Storage, Service Bus, Event Grid, and Event Hubs.

### Security And Management

- **Key Vault:** Secrets, keys, and certificate management.
- **Managed Identity:** Passwordless identity for Azure resource access.
- **Azure Monitor / Application Insights:** Metrics, logs, traces, alerts, and application diagnostics.

## Related Concepts

- [[Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers/Docker and .NET]]
- [[Areas/Cloud and Platform Engineering/_Index]]
- [[Areas\Architecture and System Design\Integration and Messaging\Integration Styles\Service Communication|Service Communication]]
- [[Areas\Cloud and Platform Engineering\Serverless\Serverless Architecture|Serverless Architecture]]
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Messaging Service Selection|Azure Messaging Service Selection]]
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Compute\Azure Functions|Azure Functions]]
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Queue Storage|Azure Queue Storage]]
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Service Bus|Azure Service Bus]]
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Event Grid|Azure Event Grid]]
- [[Areas\Cloud and Platform Engineering\Cloud Platforms\Azure\Messaging\Azure Event Hubs|Azure Event Hubs]]

## Resources

- Microsoft Learn: Azure Functions overview
- Microsoft Learn: Azure Queue Storage overview
- Microsoft Learn: Azure Service Bus overview
- Microsoft Learn: Azure Event Grid overview
- Microsoft Learn: Azure Event Hubs overview
- Microsoft Learn: Choose between Azure messaging services

## Practice Exercises

1. Deploy a simple Web API to App Service and connect it to Azure SQL.
2. Create a Function triggered by Blob Storage and forward messages to Service Bus.
3. Choose between Queue Storage, Service Bus, Event Grid, and Event Hubs for three different async scenarios.

## Review Schedule

- [ ] Review in 3 months


---

## Areas\Data Systems\_Index.md

<!-- preserved-source: Areas/Data Systems/Data Systems.md -->

# Data Systems
Date: 2026-08-09
Status: Needs Review
Tags: #taxonomy #data-systems #databases #data-intensive

## TL;DR / Quick Reference

**Definition:** Hub for designing, storing, querying, distributing, evolving, and processing data-intensive systems.

**When to use:**
- When choosing a data model, storage engine, database, consistency model, or processing approach.
- When reasoning about reliability, scale, latency, durability, and derived data.

**Key Takeaways:**
- Start with workload and access patterns, then choose data model and storage technology.
- Separate conceptual data-system concerns from vendor-specific service notes.
- Treat consistency, failure handling, evolution, and operational cost as design constraints.

## Deep Dive

### DDIA-Shaped Navigation

- [[Areas/Data Systems/Data Models and Query Languages/_Index]] - entities, aggregates, access patterns, and data shape.
- [[Areas/Data Systems/Data Models and Query Languages/_Index]] - relational models, constraints, and SQL.
- [[Areas/Data Systems/Data Models and Query Languages/_Index]] - document, key-value, wide-column, and specialized models.
- [[Storage Engines]] - how databases persist, index, and retrieve records.
- [[B-Trees]] - page-oriented indexes and update-in-place storage.
- [[LSM Trees]] - append-oriented storage, SSTables, and compaction.
- [[Areas\Data Systems\Encoding, Schemas and Evolution\JSON|JSON]] - data encoding used across APIs and application boundaries.
- [[Areas\Data Systems\Encoding, Schemas and Evolution\Schema Migrations|Schema Migrations]] - safe evolution of stored data and schemas.
- [[Areas\Data Systems\Transactions and Concurrency\Transactions and Isolation Levels|Transactions and Isolation Levels]] - atomicity and concurrent writes.
- [[Areas\Data Systems\Consistency\Consistency Models|Consistency Models]] - visibility guarantees across replicas and systems.
- [[Areas/Data Systems/Replication and Partitioning/_Index]] - copying and splitting data for resilience and scale.
- [[Areas\Architecture and System Design\Distributed Systems\Fundamentals\Distributed Systems and Consensus|Distributed Systems and Consensus]] - coordination, failure, and agreement topics.
- [[Areas\Data Systems\Streaming and Derived Data\Data Warehouses|Data Warehouses]] - analytical workloads and historical query systems.
- [[Areas\Data Systems\Streaming and Derived Data\Data Lakes|Data Lakes]] - raw, semi-processed, and curated analytical data.
- [[Areas\Data Systems\Streaming and Derived Data\Event Sourcing|Event Sourcing]] - authoritative event histories and rebuildable state.
- [[Areas\Data Systems\Streaming and Derived Data\Materialized Read Model|Materialized Read Model]] - query-ready derived state.
- [[Areas\Data Systems\Streaming and Derived Data\Stream Processing Architecture|Stream Processing Architecture]] - continuous event and data processing.
- [[Data Access]] - application-facing persistence and query access.

### Technology Notes

- Relational systems: [[Areas\Data Systems\Database Technologies\MySQL|MySQL]], [[Areas\Data Systems\Database Technologies\PostgreSQL|PostgreSQL]], [[Areas\Data Systems\Database Technologies\Oracle|Oracle]].
- Non-relational systems: [[Areas\Data Systems\Database Technologies\MongoDB|MongoDB]], [[Areas\Data Systems\Database Technologies\Cassandra|Cassandra]], [[Areas\Data Systems\Database Technologies\Redis|Redis]].
- Object storage: [[Areas\Data Systems\Storage and Retrieval\Cloud Storage Services|Cloud Storage Services]], [[Areas\Data Systems\Storage and Retrieval\Amazon S3|Amazon S3]], [[Areas\Data Systems\Storage and Retrieval\Azure Blob Storage|Azure Blob Storage]], [[Areas\Data Systems\Storage and Retrieval\Google Cloud Storage|Google Cloud Storage]].
- Analytical platforms: [[Areas\Data Systems\Analytics and Data Processing\Amazon Redshift|Amazon Redshift]], [[Areas\Data Systems\Analytics and Data Processing\Google BigQuery|Google BigQuery]], [[Areas\Data Systems\Analytics and Data Processing\Snowflake|Snowflake]].

## Related Concepts

- [[Areas/State, Coordination and Workflows/_Index]]
- [[Areas/Architecture and System Design/_Index]]
- [[Areas/Cloud and Platform Engineering/_Index]]
- [[Areas/Reliability and Operations/_Index]]
- [[Areas/Testing and Quality/_Index]]

## Review Schedule

- [ ] Review in 3 months


---

## Areas\Domains and Specialisms\Game Development\_Index.md

<!-- preserved-source: Areas/Domain Overlays/Game Development Overlay.md -->

# Game Development Overlay
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #overlay #gamedev #domain

## ?? TL;DR / Quick Reference

**Definition:** Domain overlay hub for game development that routes to core horizontal categories and captures game-specific deltas.

**When to use:**
- When exploring game-development topics that span architecture, performance, tooling, and content systems.
- When deciding whether a concept should live in a horizontal category or remain game-specific.

**Key Takeaways:**
- ? Keep shared engineering concepts in horizontal categories.
- ? Keep domain-specific interpretation and examples here.
- ?? Avoid duplicating full copies of general notes under game-specific paths.

---

## ?? Deep Dive

### Horizontal Category Routing
- Language and framework specifics: [[Areas/Languages, Runtimes and Frameworks/_Index]]
- Architecture and patterns: [[Areas/Architecture and System Design/_Index]]
- Data and state: [[Areas/Data Systems/_Index]]
- Cloud and delivery: [[Areas/Cloud and Platform Engineering/_Index]]
- Testing and quality: [[Areas/Testing and Quality/_Index]]
- Security: [[Areas/Security and Privacy/_Index]]
- Operations and reliability: [[Areas/Reliability and Operations/_Index]]
- Developer workflow: [[Areas/Engineering Practice/_Index]]

### Existing Domain-Specific Notes
- [[Areas/Domains and Specialisms/Game Development/Game AI|AI Index]]
- [[Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/Game Frameworks/Unity Resources|Unity Resources]]
- [[Areas/Architecture and Patterns/SystemArchitecture/Games/ECS|ECS]]

### What Stays In The Overlay
- Game-loop and simulation concerns.
- Engine-specific constraints and workflows.
- Domain-specific examples attached to shared concepts.

## ?? Related Concepts
- [[Areas/Domains and Specialisms/Web Development/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## ?? Review Schedule
- [ ] Review in 1 month


---

## Areas\Domains and Specialisms\Web Development\_Index.md

<!-- preserved-source: Areas/Domain Overlays/Web Development Overlay.md -->

# Web Development Overlay
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #overlay #webdev #domain

## ?? TL;DR / Quick Reference

**Definition:** Domain overlay hub for web development that routes to core horizontal categories and keeps web-specific interpretation in one place.

**When to use:**
- When navigating frontend/backend/API topics that span multiple horizontal categories.
- When deciding where new web-focused notes should live.

**Key Takeaways:**
- ? Put general engineering knowledge in horizontal categories.
- ? Use this overlay for web-specific deltas and cross-category navigation.
- ?? Do not create a separate primary taxonomy tree for web unless coverage grows enough to justify it.

---

## ?? Deep Dive

### Horizontal Category Routing
- Language and framework specifics: [[Areas/Languages, Runtimes and Frameworks/_Index]]
- Architecture and patterns: [[Areas/Architecture and System Design/_Index]]
- Data and state: [[Areas/Data Systems/_Index]]
- Cloud and delivery: [[Areas/Cloud and Platform Engineering/_Index]]
- Testing and quality: [[Areas/Testing and Quality/_Index]]
- Security: [[Areas/Security and Privacy/_Index]]
- Operations and reliability: [[Areas/Reliability and Operations/_Index]]
- Developer workflow: [[Areas/Engineering Practice/_Index]]

### Candidate Web-Specific Delta Topics
- Browser rendering and frontend performance constraints.
- API boundary design for HTTP and realtime communication.
- Accessibility and UX quality signals.

### Initial Seeding Guidance
1. Start this overlay as a navigator and decision guide.
2. Add links to web-relevant notes as they are authored or migrated.
3. Promote repeated web deltas into focused reference notes when needed.

## ?? Related Concepts
- [[Game Development Overlay]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## ?? Review Schedule
- [ ] Review in 1 month


---

## Areas\Engineering Practice\_Index.md

<!-- preserved-source: Areas/Developer Workflow/Developer Workflow.md -->

# Developer Workflow
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #developer-workflow #engineering-practices #source-control

## ?? TL;DR / Quick Reference

**Definition:** Hub for day-to-day engineering workflow practices that improve consistency and maintainability.

**When to use:**
- When defining version control, review, and local engineering workflows.
- When improving team-level development habits.

**Key Takeaways:**
- ? Centralize source control and process-oriented coding practices here.
- ?? Keep framework specifics, architecture, and testing depth in their own categories.

---

## ?? Deep Dive

### What This Category Covers
- Source control workflows, code review guidance, coding conventions, documentation process, local automation.

### How To Choose Within This Category
- Prefer habits and workflows that are language-agnostic.
- Link out to specialized categories for technical depth.

### Current Migration Sources
- `Areas/SourceControl/`
- `Areas/CodingPractices/` (non-testing content)

### Cross-Cutting Approaches
- [[Areas\Engineering Practice\Engineering Process\Engineering Approaches|Engineering Approaches]]
- [[Interview Preparation Workflow]]
- [[Areas\Testing and Quality\Testing Fundamentals\Test-Driven Development|Test-Driven Development]]
- [[Areas\Testing and Quality\Testing Fundamentals\Behavior-Driven Development|Behavior-Driven Development]]
- [[Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions]]

## ?? Related Concepts
- [[Areas/Testing and Quality/_Index]]
- [[Areas/Languages, Runtimes and Frameworks/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## ?? Review Schedule
- [ ] Review in 1 month


---

## Areas\Languages, Runtimes and Frameworks\_Index.md

<!-- preserved-source: Areas/Languages and Frameworks/Languages and Frameworks.md -->

# Languages and Frameworks
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #languages #frameworks #platforms

## ?? TL;DR / Quick Reference

**Definition:** Hub for programming languages, runtimes, and framework-specific guidance.

**When to use:**
- When choosing language or framework capabilities for implementation.
- When looking up platform-specific behavior and APIs.

**Key Takeaways:**
- ? Keep language/framework specifics here.
- ?? Keep architecture and quality concerns in their dedicated categories.

---

## ?? Deep Dive

### What This Category Covers
- Language features, runtime behavior, framework APIs, and platform conventions.

### How To Choose Within This Category
- Prefer notes that explain practical implementation tradeoffs.
- Link architecture patterns instead of duplicating them.

### Platform Hubs
- [[Areas\Languages, Runtimes and Frameworks\Languages\CSharp\Language Fundamentals\CSharp Fundamentals|CSharp Fundamentals]] - Starting point for core C# and .NET language/runtime topics.

### Current Migration Sources
- `Areas/Languages and Frameworks/DotNet/`

## ?? Related Concepts
- [[Areas/Architecture and System Design/_Index]]
- [[Areas/Engineering Practice/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## ?? Review Schedule
- [ ] Review in 1 month


---

## Areas\Reliability and Operations\_Index.md

<!-- preserved-source: Areas/Operations and Reliability/Operations and Reliability.md -->

# Operations and Reliability
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #operations #reliability #observability

## ?? TL;DR / Quick Reference

**Definition:** Hub for runtime health, observability, incident response, and reliability engineering.

**When to use:**
- When defining production monitoring and response workflows.
- When improving system reliability and service objectives.

**Key Takeaways:**
- ? This category owns run-and-stability concerns.
- ?? Build and deployment mechanics belong in Cloud and Delivery.

---

## ?? Deep Dive

### What This Category Covers
- Metrics, logs, traces, alerting, incident management, runbooks, SLO/SLA practices.

### How To Choose Within This Category
- Prioritize user-impacting reliability signals.
- Keep incident learning linked back into architecture and delivery notes.

### Current Migration Sources
- `Areas/DevOps/` (runtime and reliability-focused content)

## ?? Related Concepts
- [[Areas/Cloud and Platform Engineering/_Index]]
- [[Areas/Security and Privacy/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## ?? Review Schedule
- [ ] Review in 1 month


---

## Areas\Security and Privacy\_Index.md

<!-- preserved-source: Areas/Security/Security.md -->

# Security
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #security #secure-engineering

## ?? TL;DR / Quick Reference

**Definition:** Hub for secure design, implementation hardening, and risk reduction practices.

**When to use:**
- When making authentication, authorization, and secrets-handling decisions.
- When assessing software and dependency risk.

**Key Takeaways:**
- ? Keep security decision-making explicit and discoverable.
- ?? Avoid scattering security guidance as side notes in unrelated areas.

---

## ?? Deep Dive

### What This Category Covers
- Secure architecture, secure coding, identity and access, secrets, dependency and supply-chain risks.

### How To Choose Within This Category
- Start with threat model and trust boundaries.
- Link to architecture and operations notes for implementation context.

### Current Migration Sources
- New category; absorb security notes incrementally as they are authored.

## ?? Related Concepts
- [[Areas/Architecture and System Design/_Index]]
- [[Areas/Reliability and Operations/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## ?? Review Schedule
- [ ] Review in 1 month


---

## Areas\State, Coordination and Workflows\_Index.md

<!-- preserved-source: Areas/Application State/Application State.md -->

# Application State
Date: 2026-08-09
Status: Needs Review
Tags: #taxonomy #application-state #state-management

## TL;DR / Quick Reference

**Definition:** Hub for runtime, session, workflow, UI, and other application-owned state that is distinct from durable data-system design.

**When to use:**
- When deciding where temporary or user-session state belongs.
- When separating in-memory, workflow, cache, and durable state responsibilities.

**Key Takeaways:**
- State lifetime and ownership matter: process, session, workflow, device, or durable store.
- Durable shared data belongs in [[Areas/Data Systems/_Index]].
- State transitions should have explicit recovery and persistence rules when they cross process boundaries.

## Deep Dive

### Initial Boundary

- Runtime and in-memory state belongs here when it is owned by application execution.
- Session and workflow state belongs here when it represents active progress rather than a general-purpose data system.
- Durable storage, query, replication, and processing concerns belong in [[Areas/Data Systems/_Index]].

No existing notes are migrated here in this pass. Add future state-management notes only when they have a clear application-state boundary.

## Related Concepts

- [[Areas/Data Systems/_Index]]
- [[Areas/Architecture and System Design/_Index]]
- [[Areas\Data Systems\Streaming and Derived Data\Caching Strategies|Caching Strategies]]
- [[Areas\Data Systems\Transactions and Concurrency\Transactions and Isolation Levels|Transactions and Isolation Levels]]

## Review Schedule

- [ ] Review in 3 months


---

## Areas\Testing and Quality\_Index.md

<!-- preserved-source: Areas/Testing and Quality/Testing and Quality.md -->

# Testing and Quality
Date: 2026-06-12
Status: Needs Review
Tags: #taxonomy #testing #quality #verification

## 🎯 TL;DR / Quick Reference

**Definition:** Hub for testing strategies, quality gates, and verification practices.

**When to use:**
- When deciding unit, integration, and end-to-end testing approaches.
- When designing quality controls in delivery workflows.

**Key Takeaways:**
- ✅ Centralize all verification guidance here.
- ⚠️ Keep code-style and workflow process guidance in Developer Workflow.

---

## 📚 Deep Dive

### What This Category Covers
- Test types, automation strategy, quality criteria, and regression prevention.

### How To Choose Within This Category
- Match test depth to risk and system boundary.
- Prefer practical examples tied to failure modes.

### Current Migration Sources
- `Areas/CodingPractices/Testing/`

### Cross-Cutting Approaches
- [[Areas/Testing and Quality/Testing Fundamentals/Test-Driven Development|Test-Driven Development]]
- [[Areas/Testing and Quality/Testing Fundamentals/Behavior-Driven Development|Behavior-Driven Development]]

## 🔗 Related Concepts
- [[Areas/Engineering Practice/_Index]]
- [[Areas/Cloud and Platform Engineering/_Index]]
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]

## 🔄 Review Schedule
- [ ] Review in 1 month


## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]

## Review Schedule
- [ ] Retain until all merged hub material has been reviewed into canonical notes.