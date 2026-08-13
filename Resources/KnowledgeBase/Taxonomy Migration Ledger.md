# Taxonomy Migration Ledger
Date: 2026-08-13
Status: 🟢 Current
Tags: #knowledge-base #taxonomy #migration

## TL;DR / Quick Reference

**Definition:** Complete source-to-target record for the software-engineering taxonomy cutover.

**When to use:**
- Audit a moved, merged, or renamed note.

**Key Takeaways:**
- 144 baseline Areas notes were accounted for.
- Every destination is a canonical home or documented merge target.

## Deep Dive

### Source-to-Target Ledger

- merged: Areas/Application State/Application State.md -> Areas/State, Coordination and Workflows/_Index.md
- merged: Areas/Architecture and Patterns/Architecture and Patterns.md -> Areas/Architecture and System Design/_Index.md
- moved: Areas/Architecture and Patterns/Anti-Patterns/Distributed Monolith.md -> Areas/Architecture and System Design/Architecture Fundamentals/Distributed Monolith.md
- moved: Areas/Architecture and Patterns/Anti-Patterns/ServiceLocator.md -> Areas/Architecture and System Design/Architecture Fundamentals/Service Locator.md
- moved: Areas/Architecture and Patterns/API Design/API Versioning.md -> Areas/Application Development/API Design/API Versioning.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Actor Model.md -> Areas/Architecture and System Design/Distributed Systems/Distributed Computation/Actor Model.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Cell-Based Architecture.md -> Areas/Architecture and System Design/Architectural Styles/Cell-Based Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Clean Architecture.md -> Areas/Architecture and System Design/Architectural Styles/Clean Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/CQRS.md -> Areas/Architecture and System Design/Domain-Driven Design/DDD and Architecture/CQRS.md
- moved: Areas/Architecture and Patterns/Architectural Styles/ECS.md -> Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Event Driven.md -> Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Message-Driven Architecture.md -> Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Message-Driven Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Microservices.md -> Areas/Architecture and System Design/Architectural Styles/Microservices.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Modular Monolith.md -> Areas/Architecture and System Design/Architectural Styles/Modular Monolith.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Monolith.md -> Areas/Architecture and System Design/Architectural Styles/Layered Architectures/Monolith.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Serverless Architecture.md -> Areas/Cloud and Platform Engineering/Serverless/Serverless Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Service Based Architecture.md -> Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture/Service-Based Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Service-Oriented Architecture.md -> Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture/Service-Oriented Architecture.md
- moved: Areas/Architecture and Patterns/Architectural Styles/Space-Based Architecture.md -> Areas/Architecture and System Design/Architectural Styles/Space-Based Architecture.md
- moved: Areas/Architecture and Patterns/Design Patterns/Decorator.md -> Areas/Architecture and System Design/Design Patterns/Structural Patterns/Decorator.md
- moved: Areas/Architecture and Patterns/Design Patterns/Plugin.md -> Areas/Architecture and System Design/Design Patterns/Structural Patterns/Plugin.md
- moved: Areas/Architecture and Patterns/Design Patterns/Specification.md -> Areas/Architecture and System Design/Design Patterns/Enterprise Application Patterns/Specification.md
- moved: Areas/Architecture and Patterns/Design Patterns/Strategy.md -> Areas/Architecture and System Design/Design Patterns/Behavioural Patterns/Strategy.md
- moved: Areas/Architecture and Patterns/Design Patterns/Template Method.md -> Areas/Architecture and System Design/Design Patterns/Behavioural Patterns/Template Method.md
- moved: Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Async.md -> Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming/Async.md
- moved: Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Concurrency Patterns.md -> Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview.md
- moved: Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Future and Promise.md -> Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming/Future and Promise.md
- moved: Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Producer-Consumer.md -> Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Producer-Consumer.md
- moved: Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/ThreadPool.md -> Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool.md
- moved: Areas/Architecture and Patterns/Design Principles/Composition Over Inheritance.md -> Areas/Foundations/Programming Concepts/Composition and Reuse/Composition Over Inheritance.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/DependencyInjection.md -> Areas/Application Development/Backend Engineering/Dependency Injection.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/Injection Techniques/ConstructorInjection.md -> Areas/Application Development/Backend Engineering/Constructor Injection.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/Injection Techniques/MethodInjection.md -> Areas/Application Development/Backend Engineering/Method Injection.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/Injection Techniques/PropertyInjection.md -> Areas/Application Development/Backend Engineering/Property Injection.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/Lifetimes/ScopedLifetime.md -> Areas/Application Development/Backend Engineering/Dependency Injection/Scoped Lifetime.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/Lifetimes/SingletonLifetime.md -> Areas/Application Development/Backend Engineering/Dependency Injection/Singleton Lifetime.md
- moved: Areas/Architecture and Patterns/Design Principles/Dependency Injection/Lifetimes/TransientLifetime.md -> Areas/Application Development/Backend Engineering/Dependency Injection/Transient Lifetime.md
- moved: Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Abstraction.md -> Areas/Foundations/Programming Concepts/Abstraction and Modularity/Abstraction.md
- moved: Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Encapsulation.md -> Areas/Foundations/Programming Concepts/Abstraction and Modularity/Encapsulation.md
- moved: Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Inheritance.md -> Areas/Foundations/Programming Concepts/Programming Paradigms/Inheritance.md
- moved: Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/OOP Fundamentals.md -> Areas/Foundations/Programming Concepts/Programming Paradigms/Object-Oriented Programming Overview.md
- moved: Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Polymorphism.md -> Areas/Foundations/Programming Concepts/Programming Paradigms/Polymorphism.md
- moved: Areas/Architecture and Patterns/Design Principles/SOLID/DIP.md -> Areas/Engineering Practice/Code Design and Construction/Dependency Inversion Principle.md
- moved: Areas/Architecture and Patterns/Design Principles/SOLID/ISP.md -> Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle.md
- moved: Areas/Architecture and Patterns/Design Principles/SOLID/LSP.md -> Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle.md
- moved: Areas/Architecture and Patterns/Design Principles/SOLID/OCP.md -> Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle.md
- moved: Areas/Architecture and Patterns/Design Principles/SOLID/SOLID.md -> Areas/Engineering Practice/Code Design and Construction/SOLID Principles.md
- moved: Areas/Architecture and Patterns/Design Principles/SOLID/SRP.md -> Areas/Engineering Practice/Code Design and Construction/Single Responsibility Principle.md
- merged: Areas/Architecture and Patterns/Domain-Driven Design/Domain-Driven Design.md -> Areas/Architecture and System Design/Domain-Driven Design/_Index.md
- moved: Areas/Architecture and Patterns/Domain-Driven Design/Repository.md -> Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern.md
- moved: Areas/Architecture and Patterns/Domain-Driven Design/RepositoryUnitOfWork.md -> Areas/Data Systems/Data Access/Unit of Work.md
- moved: Areas/Architecture and Patterns/Frontend Architecture/MVC.md -> Areas/Application Development/Frontend and UX Engineering/UI Composition/Model-View-Controller.md
- moved: Areas/Architecture and Patterns/Integration and Messaging/API Gateway Pattern.md -> Areas/Architecture and System Design/Integration and Messaging/Integration Styles/API Gateway Pattern.md
- moved: Areas/Architecture and Patterns/Integration and Messaging/Backend for Frontend.md -> Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Backend for Frontend.md
- moved: Areas/Architecture and Patterns/Integration and Messaging/Saga Pattern.md -> Areas/State, Coordination and Workflows/Workflow and Long-Running Processes/Sagas/Saga Pattern.md
- moved: Areas/Architecture and Patterns/Integration and Messaging/Service Communication.md -> Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Service Communication.md
- moved: Areas/Architecture and Patterns/Integration and Messaging/Service Composition.md -> Areas/Architecture and System Design/System Design/Component Design/Service Composition.md
- moved: Areas/Architecture and Patterns/Integration and Messaging/Service Mesh.md -> Areas/Cloud and Platform Engineering/Platform Engineering/Service Mesh.md
- merged: Areas/Cloud and Delivery/AzureServicesOverview.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index.md
- merged: Areas/Cloud and Delivery/Cloud and Delivery.md -> Areas/Cloud and Platform Engineering/_Index.md
- moved: Areas/Cloud and Delivery/DockerDotNet.md -> Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers/Docker and .NET.md
- moved: Areas/Cloud and Delivery/Azure Functions/Azure Functions.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Compute/Azure Functions.md
- moved: Areas/Cloud and Delivery/Azure Functions/Azure_Functions_Interview_Cheatsheet.md -> Inbox/Azure Functions Interview Cheat Sheet.md
- moved: Areas/Cloud and Delivery/Azure Functions/Azurite_Cheatsheet.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite.md
- moved: Areas/Cloud and Delivery/Azure Messaging/Azure Event Grid.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Event Grid.md
- moved: Areas/Cloud and Delivery/Azure Messaging/Azure Event Hubs.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Event Hubs.md
- moved: Areas/Cloud and Delivery/Azure Messaging/Azure Messaging Service Selection.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Messaging Service Selection.md
- moved: Areas/Cloud and Delivery/Azure Messaging/Azure Queue Storage.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Queue Storage.md
- moved: Areas/Cloud and Delivery/Azure Messaging/Azure Service Bus.md -> Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Service Bus.md
- moved: Areas/Data and State/Data and State.md -> Resources/KnowledgeBase/Data and State Migration Record.md
- merged: Areas/Data Systems/Data Systems.md -> Areas/Data Systems/_Index.md
- merged: Areas/Data Systems/Data Access/Data Access.md -> Areas/Data Systems/Data Access/Data Access.md
- moved: Areas/Data Systems/Data Access/Entity Framework/MemoryAllocations.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/Performance/MemoryAllocations.md
- moved: Areas/Data Systems/Data Access/Entity Framework/QueryOptimisations.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/Performance/QueryOptimisations.md
- merged: Areas/Data Systems/Data Models and Query Languages/Data Modeling.md -> Areas/Data Systems/Data Models and Query Languages/Data Modeling.md
- merged: Areas/Data Systems/Data Models and Query Languages/NoSQL Databases.md -> Areas/Data Systems/Data Models and Query Languages/NoSQL Databases.md
- merged: Areas/Data Systems/Data Models and Query Languages/Relational Databases.md -> Areas/Data Systems/Data Models and Query Languages/Relational Databases.md
- merged: Areas/Data Systems/Data Models and Query Languages/SQL Joins and Indexes.md -> Areas/Data Systems/Data Models and Query Languages/SQL Joins and Indexes.md
- moved: Areas/Data Systems/Data Models and Query Languages/Non-Relational Systems/Cassandra.md -> Areas/Data Systems/Database Technologies/Cassandra.md
- moved: Areas/Data Systems/Data Models and Query Languages/Non-Relational Systems/MongoDB.md -> Areas/Data Systems/Database Technologies/MongoDB.md
- moved: Areas/Data Systems/Data Models and Query Languages/Non-Relational Systems/Redis.md -> Areas/Data Systems/Database Technologies/Redis.md
- moved: Areas/Data Systems/Data Models and Query Languages/Relational Systems/MySQL.md -> Areas/Data Systems/Database Technologies/MySQL.md
- moved: Areas/Data Systems/Data Models and Query Languages/Relational Systems/Oracle.md -> Areas/Data Systems/Database Technologies/Oracle.md
- moved: Areas/Data Systems/Data Models and Query Languages/Relational Systems/PostgreSQL.md -> Areas/Data Systems/Database Technologies/PostgreSQL.md
- moved: Areas/Data Systems/Derived Data and Analytics/Caching Strategies.md -> Areas/Data Systems/Streaming and Derived Data/Caching Strategies.md
- moved: Areas/Data Systems/Derived Data and Analytics/Data Lakes.md -> Areas/Data Systems/Streaming and Derived Data/Data Lakes.md
- moved: Areas/Data Systems/Derived Data and Analytics/Data Warehouses.md -> Areas/Data Systems/Streaming and Derived Data/Data Warehouses.md
- moved: Areas/Data Systems/Derived Data and Analytics/Event Sourcing.md -> Areas/Data Systems/Streaming and Derived Data/Event Sourcing.md
- moved: Areas/Data Systems/Derived Data and Analytics/Materialized Read Model.md -> Areas/Data Systems/Streaming and Derived Data/Materialized Read Model.md
- moved: Areas/Data Systems/Derived Data and Analytics/Stream Processing Architecture.md -> Areas/Data Systems/Streaming and Derived Data/Stream Processing Architecture.md
- moved: Areas/Data Systems/Derived Data and Analytics/Analytical Platforms/Amazon Redshift.md -> Areas/Data Systems/Analytics and Data Processing/Amazon Redshift.md
- moved: Areas/Data Systems/Derived Data and Analytics/Analytical Platforms/Google BigQuery.md -> Areas/Data Systems/Analytics and Data Processing/Google BigQuery.md
- moved: Areas/Data Systems/Derived Data and Analytics/Analytical Platforms/Snowflake.md -> Areas/Data Systems/Analytics and Data Processing/Snowflake.md
- moved: Areas/Data Systems/Distributed Systems and Consensus/Distributed Systems and Consensus.md -> Areas/Architecture and System Design/Distributed Systems/Fundamentals/Distributed Systems and Consensus.md
- moved: Areas/Data Systems/Encoding and Evolution/JSON.md -> Areas/Data Systems/Encoding, Schemas and Evolution/JSON.md
- moved: Areas/Data Systems/Encoding and Evolution/Schema Migrations.md -> Areas/Data Systems/Encoding, Schemas and Evolution/Schema Migrations.md
- merged: Areas/Data Systems/Replication and Partitioning/Replication and Partitioning.md -> Areas/Data Systems/Replication and Partitioning/Replication and Partitioning.md
- merged: Areas/Data Systems/Storage and Retrieval/B-Trees.md -> Areas/Data Systems/Storage and Retrieval/B-Trees.md
- merged: Areas/Data Systems/Storage and Retrieval/LSM Trees.md -> Areas/Data Systems/Storage and Retrieval/LSM Trees.md
- merged: Areas/Data Systems/Storage and Retrieval/Storage Engines.md -> Areas/Data Systems/Storage and Retrieval/Storage Engines.md
- moved: Areas/Data Systems/Storage and Retrieval/Object Storage/Amazon S3.md -> Areas/Data Systems/Storage and Retrieval/Amazon S3.md
- moved: Areas/Data Systems/Storage and Retrieval/Object Storage/Azure Blob Storage.md -> Areas/Data Systems/Storage and Retrieval/Azure Blob Storage.md
- moved: Areas/Data Systems/Storage and Retrieval/Object Storage/Cloud Storage Services.md -> Areas/Data Systems/Storage and Retrieval/Cloud Storage Services.md
- moved: Areas/Data Systems/Storage and Retrieval/Object Storage/Google Cloud Storage.md -> Areas/Data Systems/Storage and Retrieval/Google Cloud Storage.md
- moved: Areas/Data Systems/Transactions and Consistency/Consistency Models.md -> Areas/Data Systems/Consistency/Consistency Models.md
- moved: Areas/Data Systems/Transactions and Consistency/Transactions and Isolation Levels.md -> Areas/Data Systems/Transactions and Concurrency/Transactions and Isolation Levels.md
- moved: Areas/Developer Workflow/AI-Assisted Development.md -> Areas/Engineering Practice/Developer Tooling/AI-Assisted Development.md
- moved: Areas/Developer Workflow/Code Review Guidelines.md -> Areas/Engineering Practice/Code Review/Code Review Guidelines.md
- moved: Areas/Developer Workflow/Coupling - 5 types.md -> Areas/Engineering Practice/Maintainability and Code Health/Coupling.md
- merged: Areas/Developer Workflow/Developer Workflow.md -> Areas/Engineering Practice/_Index.md
- moved: Areas/Developer Workflow/Engineering Approaches.md -> Areas/Engineering Practice/Engineering Process/Engineering Approaches.md
- moved: Areas/Developer Workflow/Interview Preparation Workflow.md -> Resources/KnowledgeBase/Interview Preparation Workflow.md
- moved: Areas/Developer Workflow/IOptions.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md
- moved: Areas/Developer Workflow/Laws.md -> Areas/Engineering Practice/Professional Practice/Software Engineering Laws.md
- moved: Areas/Developer Workflow/Mappers.md -> Areas/Engineering Practice/Code Design and Construction/Mappers.md
- moved: Areas/Developer Workflow/PowerShellCliEssentials.md -> Areas/Languages, Runtimes and Frameworks/Languages/Shell and Scripting/PowerShell CLI Essentials.md
- moved: Areas/Developer Workflow/Approaches/Behavior-Driven Development.md -> Areas/Testing and Quality/Testing Fundamentals/Behavior-Driven Development.md
- moved: Areas/Developer Workflow/Approaches/Fitness-Function Driven Development.md -> Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions.md
- moved: Areas/Developer Workflow/Approaches/Test-Driven Development.md -> Areas/Testing and Quality/Testing Fundamentals/Test-Driven Development.md
- merged: Areas/Domain Overlays/Game Development Overlay.md -> Areas/Domains and Specialisms/Game Development/_Index.md
- merged: Areas/Domain Overlays/Web Development Overlay.md -> Areas/Domains and Specialisms/Web Development/_Index.md
- moved: Areas/Domain Overlays/Game Development/AI/Index.md -> Areas/Domains and Specialisms/Game Development/Game AI.md
- moved: Areas/Domain Overlays/Game Development/Unity/Resources.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/Game Frameworks/Unity Resources.md
- merged: Areas/Languages and Frameworks/Languages and Frameworks.md -> Areas/Languages, Runtimes and Frameworks/_Index.md
- moved: Areas/Languages and Frameworks/DotNet/Access Modifiers.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Access Modifiers.md
- moved: Areas/Languages and Frameworks/DotNet/CollectionTypes.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types.md
- merged: Areas/Languages and Frameworks/DotNet/ConfigurationOptionsPattern.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md
- moved: Areas/Languages and Frameworks/DotNet/CSharp Fundamentals.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/CSharp Fundamentals.md
- moved: Areas/Languages and Frameworks/DotNet/DelegatesEventsActions.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Delegates, Events, and Actions.md
- moved: Areas/Languages and Frameworks/DotNet/Dictionary.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Dictionary.md
- moved: Areas/Languages and Frameworks/DotNet/ExpressionBodiedMembers.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Expression-Bodied Members.md
- moved: Areas/Languages and Frameworks/DotNet/GenericsConstraints.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints.md
- moved: Areas/Languages and Frameworks/DotNet/HashSet.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/HashSet.md
- moved: Areas/Languages and Frameworks/DotNet/Immutable and Concurrent Collections.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Async and Concurrency/Immutable and Concurrent Collections.md
- moved: Areas/Languages and Frameworks/DotNet/Linq.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/LINQ/LINQ.md
- moved: Areas/Languages and Frameworks/DotNet/List.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/List.md
- moved: Areas/Languages and Frameworks/DotNet/NullableReferenceTypes.md -> Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types.md
- moved: Areas/Languages and Frameworks/JavaScript/JavaScript Fundamentals.md -> Areas/Languages, Runtimes and Frameworks/Languages/JavaScript and TypeScript/JavaScript/JavaScript Fundamentals.md
- merged: Areas/Operations and Reliability/Operations and Reliability.md -> Areas/Reliability and Operations/_Index.md
- merged: Areas/Security/Security.md -> Areas/Security and Privacy/_Index.md
- merged: Areas/Testing and Quality/Testing and Quality.md -> Areas/Testing and Quality/_Index.md
- moved: Areas/Testing and Quality/Testing/Integration Testing ASP.NET Core.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md
- merged: Areas/Testing and Quality/Testing/IntegrationTestingAspNet.md -> Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md
- moved: Areas/Testing and Quality/Testing/MsTest.md -> Areas/Testing and Quality/Test Automation and Tooling/Test Runners/MSTest.md

## Related Concepts
- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]

## Review Schedule
- [ ] Review after major taxonomy change.
