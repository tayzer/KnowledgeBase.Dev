- [ ] Add notes from architecture book, different distributed architectures
- [ ] Document Quanta
- [ ] Distributed System issues: distributed monolith, transient network failures, a study had 12 failures in a month at a data centre, sharks chewing cables. Chaos monkeys sometimes handling this by doing them
- [ ] Add common test models
- [ ] Scientist.net
- [ ] Contract testing
- [ ] Containers, kubernates
- [ ] Modular Monoliths
- [ ] Monorepos
- [ ] Azure aspire
- [ ] BDD, its creator Dan? How he wanted to take away from the word "test"
- [ ] Composition over inheritance
- [ ] Event sourcing, CRUD, Idempotency
- [ ] Categories for Data and State, e.g. relational

Please review the files that are not following this next approach to:

Architecture and Patterns

1. Architectural Styles
- Monolithic Architecture
- Microservices
- Service-Oriented Architecture (SOA)
- Event-Driven Architecture
- Serverless Architecture
- Layered (N-Tier) Architecture
- Hexagonal / Ports & Adapters
- Clean Architecture
- CQRS
- Event Sourcing

2. Design Principles
- SOLID Principles
- DRY, KISS, YAGNI
- Separation of Concerns
- Composition vs Inheritance
- Coupling and Cohesion
- Law of Demeter
- Inversion of Control / Dependency Injection

3. Design Patterns
- Creational (Singleton, Factory, Builder, Prototype, Abstract Factory)
- Structural (Adapter, Decorator, Facade, Proxy, Composite, Bridge)
- Behavioral (Observer, Strategy, Command, State, Iterator, Mediator, Chain of Responsibility)
- Concurrency Patterns (Producer-Consumer, Thread Pool, Future/Promise)

4. Domain-Driven Design
- Bounded Contexts
- Aggregates, Entities, Value Objects
- Domain Events
- Repositories and Anti-Corruption Layers
- Ubiquitous Language

5. API Design
- REST
- GraphQL
- gRPC / RPC
- Webhooks
- API Versioning Strategies

6. Data Architecture
- Database per Service vs Shared Database
- Caching Strategies
- Data Replication and Sharding
- Saga Pattern / Distributed Transactions
- Polyglot Persistence

7. Integration & Messaging
- Message Queues (RabbitMQ, Kafka, SQS)
- Pub/Sub
- API Gateways
- Service Mesh

8. Scalability & Resilience Patterns
- Load Balancing
- Circuit Breaker
- Retry / Backoff
- Bulkhead
- Rate Limiting / Throttling
- Graceful Degradation

9. Frontend Architecture
- Component-Based Architecture
- State Management Patterns (Flux, Redux, MVVM)
- Micro-Frontends
- Server-Side Rendering vs Client-Side Rendering

10. Anti-Patterns
- God Object
- Spaghetti Code
- Big Ball of Mud
- Distributed Monolith
- Premature Optimization

11. Case Studies / Real-World Examples
- Company architecture write-ups
- Personal project architecture decisions (ADRs)


---

Materialized Read Model
Hashset
Pipes and filters
Ephemeral environments