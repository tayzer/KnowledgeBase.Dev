param(
    [switch]$Check
)

$ErrorActionPreference = 'Stop'

function Relative([string]$Path) {
    return $Path.Replace((Get-Location).Path + '\', '').Replace('\', '/')
}

function Get-Destination([string]$Source) {
    $source = $Source.Replace('\', '/')
    $name = [IO.Path]::GetFileNameWithoutExtension($source)

    $map = @{
        'Areas/Architecture and Patterns/Architecture and Patterns.md' = 'Areas/Architecture and System Design/_Index.md'
        'Areas/Cloud and Delivery/Cloud and Delivery.md' = 'Areas/Cloud and Platform Engineering/_Index.md'
        'Areas/Data Systems/Data Systems.md' = 'Areas/Data Systems/_Index.md'
        'Areas/Application State/Application State.md' = 'Areas/State, Coordination and Workflows/_Index.md'
        'Areas/Developer Workflow/Developer Workflow.md' = 'Areas/Engineering Practice/_Index.md'
        'Areas/Domain Overlays/Game Development Overlay.md' = 'Areas/Domains and Specialisms/Game Development/_Index.md'
        'Areas/Domain Overlays/Web Development Overlay.md' = 'Areas/Domains and Specialisms/Web Development/_Index.md'
        'Areas/Languages and Frameworks/Languages and Frameworks.md' = 'Areas/Languages, Runtimes and Frameworks/_Index.md'
        'Areas/Operations and Reliability/Operations and Reliability.md' = 'Areas/Reliability and Operations/_Index.md'
        'Areas/Security/Security.md' = 'Areas/Security and Privacy/_Index.md'
        'Areas/Testing and Quality/Testing and Quality.md' = 'Areas/Testing and Quality/_Index.md'
        'Areas/Data and State/Data and State.md' = 'Resources/KnowledgeBase/Retired Data and State Navigation.md'
        'Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Concurrency Patterns.md' = 'Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/_Index.md'
        'Areas/Cloud and Delivery/AzureServicesOverview.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index.md'
        'Areas/Architecture and Patterns/Domain-Driven Design/Domain-Driven Design.md' = 'Areas/Architecture and System Design/Domain-Driven Design/_Index.md'
        'Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/OOP Fundamentals.md' = 'Areas/Foundations/Programming Concepts/Programming Paradigms/_Index.md'
        'Areas/Architecture and Patterns/Design Principles/SOLID/SOLID.md' = 'Areas/Engineering Practice/Code Design and Construction/SOLID Principles.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/DependencyInjection.md' = 'Areas/Application Development/Backend Engineering/Dependency Injection.md'
        'Areas/Architecture and Patterns/Integration and Messaging/Service Communication.md' = 'Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Service Communication.md'
        'Areas/Architecture and Patterns/Integration and Messaging/ServiceCommunication.md' = 'Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Service Communication.md'
        'Areas/Cloud and Delivery/Azure Functions/Azure_Functions_Interview_Cheatsheet.md' = 'Inbox/Azure Functions Interview Cheat Sheet.md'
        'Areas/Developer Workflow/Interview Preparation Workflow.md' = 'Resources/KnowledgeBase/Interview Preparation Workflow.md'
        'Areas/Developer Workflow/IOptions.md' = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md'
        'Areas/Languages and Frameworks/DotNet/ConfigurationOptionsPattern.md' = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md'
        'Areas/Testing and Quality/Testing/Integration Testing ASP.NET Core.md' = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md'
        'Areas/Testing and Quality/Testing/IntegrationTestingAspNet.md' = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md'
        'Areas/Architecture and Patterns/Domain-Driven Design/RepositoryUnitOfWork.md' = 'Areas/Data Systems/Data Access/Unit of Work.md'
        'Areas/Architecture and Patterns/Domain-Driven Design/Repository.md' = 'Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern.md'
        'Areas/Architecture and Patterns/Integration and Messaging/Saga Pattern.md' = 'Areas/State, Coordination and Workflows/Workflow and Long-Running Processes/Sagas/Saga Pattern.md'
        'Areas/Architecture and Patterns/Architectural Styles/CQRS.md' = 'Areas/Architecture and System Design/Domain-Driven Design/DDD and Architecture/CQRS.md'
        'Areas/Architecture and Patterns/Architectural Styles/Actor Model.md' = 'Areas/Architecture and System Design/Distributed Systems/Distributed Computation/Actor Model.md'
        'Areas/Architecture and Patterns/Architectural Styles/Event Driven.md' = 'Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/Message-Driven Architecture.md' = 'Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Message-Driven Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/Serverless Architecture.md' = 'Areas/Cloud and Platform Engineering/Serverless/Serverless Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/ECS.md' = 'Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System.md'
        'Areas/Architecture and Patterns/Architectural Styles/Clean Architecture.md' = 'Areas/Architecture and System Design/Architectural Styles/Clean Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/Cell-Based Architecture.md' = 'Areas/Architecture and System Design/Architectural Styles/Cell-Based Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/Space-Based Architecture.md' = 'Areas/Architecture and System Design/Architectural Styles/Space-Based Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/Microservices.md' = 'Areas/Architecture and System Design/Architectural Styles/Microservices.md'
        'Areas/Architecture and Patterns/Architectural Styles/Modular Monolith.md' = 'Areas/Architecture and System Design/Architectural Styles/Modular Monolith.md'
        'Areas/Architecture and Patterns/Architectural Styles/Monolith.md' = 'Areas/Architecture and System Design/Architectural Styles/Layered Architectures/Monolith.md'
        'Areas/Architecture and Patterns/Architectural Styles/Service Based Architecture.md' = 'Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture/Service-Based Architecture.md'
        'Areas/Architecture and Patterns/Architectural Styles/Service-Oriented Architecture.md' = 'Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture/Service-Oriented Architecture.md'
        'Areas/Architecture and Patterns/Anti-Patterns/Distributed Monolith.md' = 'Areas/Architecture and System Design/Architecture Fundamentals/Distributed Monolith.md'
        'Areas/Architecture and Patterns/Anti-Patterns/ServiceLocator.md' = 'Areas/Architecture and System Design/Architecture Fundamentals/Service Locator.md'
        'Areas/Architecture and Patterns/API Design/API Versioning.md' = 'Areas/Application Development/API Design/API Versioning.md'
        'Areas/Architecture and Patterns/Frontend Architecture/MVC.md' = 'Areas/Application Development/Frontend and UX Engineering/UI Composition/Model-View-Controller.md'
        'Areas/Architecture and Patterns/Integration and Messaging/API Gateway Pattern.md' = 'Areas/Architecture and System Design/Integration and Messaging/Integration Styles/API Gateway Pattern.md'
        'Areas/Architecture and Patterns/Integration and Messaging/Backend for Frontend.md' = 'Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Backend for Frontend.md'
        'Areas/Architecture and Patterns/Integration and Messaging/Service Composition.md' = 'Areas/Architecture and System Design/System Design/Component Design/Service Composition.md'
        'Areas/Architecture and Patterns/Integration and Messaging/Service Mesh.md' = 'Areas/Cloud and Platform Engineering/Platform Engineering/Service Mesh.md'
        'Areas/Architecture and Patterns/Design Patterns/Decorator.md' = 'Areas/Architecture and System Design/Design Patterns/Structural Patterns/Decorator.md'
        'Areas/Architecture and Patterns/Design Patterns/Plugin.md' = 'Areas/Architecture and System Design/Design Patterns/Structural Patterns/Plugin.md'
        'Areas/Architecture and Patterns/Design Patterns/Specification.md' = 'Areas/Architecture and System Design/Design Patterns/Enterprise Application Patterns/Specification.md'
        'Areas/Architecture and Patterns/Design Patterns/Strategy.md' = 'Areas/Architecture and System Design/Design Patterns/Behavioural Patterns/Strategy.md'
        'Areas/Architecture and Patterns/Design Patterns/Template Method.md' = 'Areas/Architecture and System Design/Design Patterns/Behavioural Patterns/Template Method.md'
        'Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Async.md' = 'Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming/Async.md'
        'Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Future and Promise.md' = 'Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming/Future and Promise.md'
        'Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/Producer-Consumer.md' = 'Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Producer-Consumer.md'
        'Areas/Architecture and Patterns/Design Patterns/Concurrency Patterns/ThreadPool.md' = 'Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool.md'
        'Areas/Architecture and Patterns/Design Principles/Composition Over Inheritance.md' = 'Areas/Foundations/Programming Concepts/Composition and Reuse/Composition Over Inheritance.md'
        'Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Abstraction.md' = 'Areas/Foundations/Programming Concepts/Abstraction and Modularity/Abstraction.md'
        'Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Encapsulation.md' = 'Areas/Foundations/Programming Concepts/Abstraction and Modularity/Encapsulation.md'
        'Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Inheritance.md' = 'Areas/Foundations/Programming Concepts/Programming Paradigms/Inheritance.md'
        'Areas/Architecture and Patterns/Design Principles/OOP Fundamentals/Polymorphism.md' = 'Areas/Foundations/Programming Concepts/Programming Paradigms/Polymorphism.md'
        'Areas/Architecture and Patterns/Design Principles/SOLID/DIP.md' = 'Areas/Engineering Practice/Code Design and Construction/Dependency Inversion Principle.md'
        'Areas/Architecture and Patterns/Design Principles/SOLID/ISP.md' = 'Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle.md'
        'Areas/Architecture and Patterns/Design Principles/SOLID/LSP.md' = 'Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle.md'
        'Areas/Architecture and Patterns/Design Principles/SOLID/OCP.md' = 'Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle.md'
        'Areas/Architecture and Patterns/Design Principles/SOLID/SRP.md' = 'Areas/Engineering Practice/Code Design and Construction/Single Responsibility Principle.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/Injection Techniques/ConstructorInjection.md' = 'Areas/Application Development/Backend Engineering/Constructor Injection.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/Injection Techniques/MethodInjection.md' = 'Areas/Application Development/Backend Engineering/Method Injection.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/Injection Techniques/PropertyInjection.md' = 'Areas/Application Development/Backend Engineering/Property Injection.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/Lifetimes/ScopedLifetime.md' = 'Areas/Application Development/Backend Engineering/Dependency Injection/Scoped Lifetime.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/Lifetimes/SingletonLifetime.md' = 'Areas/Application Development/Backend Engineering/Dependency Injection/Singleton Lifetime.md'
        'Areas/Architecture and Patterns/Design Principles/Dependency Injection/Lifetimes/TransientLifetime.md' = 'Areas/Application Development/Backend Engineering/Dependency Injection/Transient Lifetime.md'
        'Areas/Cloud and Delivery/DockerDotNet.md' = 'Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers/Docker and .NET.md'
        'Areas/Cloud and Delivery/Azure Functions/Azure Functions.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Compute/Azure Functions.md'
        'Areas/Cloud and Delivery/Azure Functions/Azurite_Cheatsheet.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite.md'
        'Areas/Cloud and Delivery/Azure Messaging/Azure Event Grid.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Event Grid.md'
        'Areas/Cloud and Delivery/Azure Messaging/Azure Event Hubs.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Event Hubs.md'
        'Areas/Cloud and Delivery/Azure Messaging/Azure Messaging Service Selection.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Messaging Service Selection.md'
        'Areas/Cloud and Delivery/Azure Messaging/Azure Queue Storage.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Queue Storage.md'
        'Areas/Cloud and Delivery/Azure Messaging/Azure Service Bus.md' = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Service Bus.md'
        'Areas/Developer Workflow/AI-Assisted Development.md' = 'Areas/Engineering Practice/Developer Tooling/AI-Assisted Development.md'
        'Areas/Developer Workflow/Approaches/Behavior-Driven Development.md' = 'Areas/Testing and Quality/Testing Fundamentals/Behavior-Driven Development.md'
        'Areas/Developer Workflow/Approaches/Fitness-Function Driven Development.md' = 'Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions.md'
        'Areas/Developer Workflow/Approaches/Test-Driven Development.md' = 'Areas/Testing and Quality/Testing Fundamentals/Test-Driven Development.md'
        'Areas/Developer Workflow/Code Review Guidelines.md' = 'Areas/Engineering Practice/Code Review/Code Review Guidelines.md'
        'Areas/Developer Workflow/Coupling - 5 types.md' = 'Areas/Engineering Practice/Maintainability and Code Health/Coupling.md'
        'Areas/Developer Workflow/Engineering Approaches.md' = 'Areas/Engineering Practice/Engineering Process/Engineering Approaches.md'
        'Areas/Developer Workflow/Laws.md' = 'Areas/Engineering Practice/Professional Practice/Software Engineering Laws.md'
        'Areas/Developer Workflow/Mappers.md' = 'Areas/Engineering Practice/Code Design and Construction/Mappers.md'
        'Areas/Developer Workflow/PowerShellCliEssentials.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/Shell and Scripting/PowerShell CLI Essentials.md'
        'Areas/Domain Overlays/Game Development/AI/Index.md' = 'Areas/Domains and Specialisms/Game Development/Game AI.md'
        'Areas/Domain Overlays/Game Development/Unity/Resources.md' = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/Game Frameworks/Unity Resources.md'
        'Areas/Languages and Frameworks/DotNet/Access Modifiers.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Access Modifiers.md'
        'Areas/Languages and Frameworks/DotNet/CSharp Fundamentals.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/CSharp Fundamentals.md'
        'Areas/Languages and Frameworks/DotNet/CollectionTypes.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types.md'
        'Areas/Languages and Frameworks/DotNet/DelegatesEventsActions.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Delegates, Events, and Actions.md'
        'Areas/Languages and Frameworks/DotNet/Dictionary.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Dictionary.md'
        'Areas/Languages and Frameworks/DotNet/ExpressionBodiedMembers.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Expression-Bodied Members.md'
        'Areas/Languages and Frameworks/DotNet/GenericsConstraints.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints.md'
        'Areas/Languages and Frameworks/DotNet/HashSet.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/HashSet.md'
        'Areas/Languages and Frameworks/DotNet/Immutable and Concurrent Collections.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Async and Concurrency/Immutable and Concurrent Collections.md'
        'Areas/Languages and Frameworks/DotNet/Linq.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/LINQ/LINQ.md'
        'Areas/Languages and Frameworks/DotNet/List.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/List.md'
        'Areas/Languages and Frameworks/DotNet/NullableReferenceTypes.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types.md'
        'Areas/Languages and Frameworks/JavaScript/JavaScript Fundamentals.md' = 'Areas/Languages, Runtimes and Frameworks/Languages/JavaScript and TypeScript/JavaScript/JavaScript Fundamentals.md'
        'Areas/Testing and Quality/Testing/MsTest.md' = 'Areas/Testing and Quality/Test Automation and Tooling/Test Runners/MSTest.md'
    }
    if ($map.ContainsKey($source)) { return $map[$source] }

    if ($source -like 'Areas/Data Systems/Data Models and Query Languages/Non-Relational Systems/*') { return "Areas/Data Systems/Database Technologies/$name.md" }
    if ($source -like 'Areas/Data Systems/Data Models and Query Languages/Relational Systems/*') { return "Areas/Data Systems/Database Technologies/$name.md" }
    if ($source -like 'Areas/Data Systems/Data Models and Query Languages/*') { return "Areas/Data Systems/Data Models and Query Languages/$name.md" }
    if ($source -like 'Areas/Data Systems/Storage and Retrieval/Object Storage/*') { return "Areas/Data Systems/Storage and Retrieval/$name.md" }
    if ($source -like 'Areas/Data Systems/Storage and Retrieval/*') { return "Areas/Data Systems/Storage and Retrieval/$name.md" }
    if ($source -like 'Areas/Data Systems/Derived Data and Analytics/Analytical Platforms/*') { return "Areas/Data Systems/Analytics and Data Processing/$name.md" }
    if ($source -like 'Areas/Data Systems/Derived Data and Analytics/*') { return "Areas/Data Systems/Streaming and Derived Data/$name.md" }
    if ($source -like 'Areas/Data Systems/Encoding and Evolution/*') { return "Areas/Data Systems/Encoding, Schemas and Evolution/$name.md" }
    if ($source -like 'Areas/Data Systems/Replication and Partitioning/*') { return "Areas/Data Systems/Replication and Partitioning/$name.md" }
    if ($source -like 'Areas/Data Systems/Transactions and Consistency/Consistency*') { return "Areas/Data Systems/Consistency/$name.md" }
    if ($source -like 'Areas/Data Systems/Transactions and Consistency/*') { return "Areas/Data Systems/Transactions and Concurrency/$name.md" }
    if ($source -like 'Areas/Data Systems/Data Access/Entity Framework/*') { return "Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/Performance/$name.md" }
    if ($source -like 'Areas/Data Systems/Data Access/*') { return "Areas/Data Systems/Data Access/$name.md" }
    if ($source -like 'Areas/Data Systems/Distributed Systems and Consensus/*') { return "Areas/Architecture and System Design/Distributed Systems/Fundamentals/$name.md" }

    throw "No destination rule for $source"
}

function Merge-Note([string]$SourcePath, [string]$DestinationPath) {
    $sourceText = Get-Content -Raw -LiteralPath $SourcePath
    if (-not (Test-Path -LiteralPath $DestinationPath)) {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $DestinationPath) | Out-Null
        Move-Item -LiteralPath $SourcePath -Destination $DestinationPath
        return 'moved'
    }
    $destinationText = Get-Content -Raw -LiteralPath $DestinationPath
    $stamp = "`n`n<!-- preserved-source: $(Relative $SourcePath) -->`n`n$sourceText"
    if ($destinationText -notlike "*$(Relative $SourcePath)*") {
        Set-Content -LiteralPath $DestinationPath -Value ($destinationText + $stamp) -NoNewline -Encoding utf8
    }
    Remove-Item -LiteralPath $SourcePath
    return 'merged'
}

$preStaged = @(git diff --cached --name-only | ForEach-Object { $_.Replace('\\', '/') })

# After cutover, -Check validates the immutable migration ledger instead of trying
# to remap the already-canonical tree as if it were legacy input.
if ($Check -and (Test-Path -LiteralPath 'Resources/KnowledgeBase/Taxonomy Migration Ledger.json')) {
    $recordedLedger = Get-Content -Raw -LiteralPath 'Resources/KnowledgeBase/Taxonomy Migration Ledger.json' | ConvertFrom-Json
    foreach ($entry in @($recordedLedger)) {
        if (-not (Test-Path -LiteralPath $entry.Destination)) {
            throw "Recorded migration destination is missing: $($entry.Destination)"
        }
    }
    Write-Host "Accounted for $(@($recordedLedger).Count) baseline notes."
    exit 0
}

$baseline = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '*.md' | Where-Object { $_.Name -ne '_Index.md' })
$ledger = [System.Collections.Generic.List[object]]::new()

foreach ($file in $baseline) {
    $source = Relative $file.FullName
    $destination = Get-Destination $source
    $isTracked = @(git ls-files -- $source).Count -gt 0
    $wasStaged = $preStaged -contains $source
    if ($Check) {
        $ledger.Add([pscustomobject]@{ Source = $source; Destination = $destination; Action = 'planned'; PreExistingStaged = $wasStaged })
        continue
    }

    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
    if ($isTracked -and -not (Test-Path -LiteralPath $destination)) {
        & git mv -- $source $destination
        $action = 'moved'
    }
    else {
        $action = Merge-Note -SourcePath $source -DestinationPath $destination
        if ($isTracked) { & git rm --cached -- $source 2>$null }
    }
    $ledger.Add([pscustomobject]@{ Source = $source; Destination = $destination; Action = $action; PreExistingStaged = $wasStaged })
}

if (-not $Check) {
    $ledger | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath 'Resources/KnowledgeBase/Taxonomy Migration Ledger.json' -NoNewline -Encoding utf8
    $lines = @('# Taxonomy Migration Ledger', 'Date: 2026-08-13', 'Status: 🟢 Current', 'Tags: #knowledge-base #taxonomy #migration', '', '## TL;DR / Quick Reference', '', '**Definition:** Complete source-to-target record for the software-engineering taxonomy cutover.', '', '**When to use:**', '- Audit a moved, merged, or renamed note.', '', '**Key Takeaways:**', "- $($ledger.Count) baseline `Areas` notes were accounted for.", '- Every destination is a canonical home or documented merge target.', '', '## Deep Dive', '', '### Source-to-Target Ledger', '')
    foreach ($entry in $ledger) { $lines += ('- {0}: {1} -> {2}' -f $entry.Action, $entry.Source, $entry.Destination) }
    $lines += @('', '## Related Concepts', '- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]', '- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]', '', '## Review Schedule', '- [ ] Review after major taxonomy change.')
    Set-Content -LiteralPath 'Resources/KnowledgeBase/Taxonomy Migration Ledger.md' -Value ($lines -join "`n") -NoNewline -Encoding utf8
}

Write-Host "Accounted for $($ledger.Count) baseline notes."
