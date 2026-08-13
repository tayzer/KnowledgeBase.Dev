param([switch]$Check)

$ErrorActionPreference = 'Stop'
$ledger = Get-Content -Raw -LiteralPath 'Resources/KnowledgeBase/Taxonomy Migration Ledger.json' | ConvertFrom-Json
$replacements = [ordered]@{}
foreach ($entry in $ledger) {
    $replacements[$entry.Source.Replace('\\', '/')] = $entry.Destination.Replace('\\', '/') -replace '\.md$', ''
    $replacements[($entry.Source.Replace('\\', '/') -replace '\.md$', '')] = $entry.Destination.Replace('\\', '/') -replace '\.md$', ''
}

$replacements['ServiceCommunication'] = 'Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Service Communication'
$replacements['ServiceLocator'] = 'Areas/Architecture and System Design/Architecture Fundamentals/Service Locator'
$replacements['DependencyInjection'] = 'Areas/Application Development/Backend Engineering/Dependency Injection'
$replacements['RepositoryUnitOfWork'] = 'Areas/Data Systems/Data Access/Unit of Work'
$replacements['Repository'] = 'Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern'
$replacements['ConfigurationOptionsPattern'] = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern'
$replacements['IOptions'] = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern'
$replacements['IntegrationTestingAspNet'] = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing'
$replacements['Integration Testing ASP.NET Core'] = 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing'
$replacements['MsTest'] = 'Areas/Testing and Quality/Test Automation and Tooling/Test Runners/MSTest'
$replacements['ECS'] = 'Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System'
$replacements['Games/ECS'] = 'Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System'
$replacements['Open/Closed Principle'] = 'Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle'
$replacements['Liskov Substitution Principle'] = 'Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle'
$replacements['Liskov Substitution'] = 'Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle'
$replacements['LSP'] = 'Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle'
$replacements['SOLID'] = 'Areas/Engineering Practice/Code Design and Construction/SOLID Principles'
$replacements['Concurrency Patterns'] = 'Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview'
$replacements['Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/_Index'] = 'Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview'
$replacements['ThreadPool'] = 'Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool'
$replacements['CollectionTypes'] = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types'
$replacements['NullableReferenceTypes'] = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types'
$replacements['GenericsConstraints'] = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints'
$replacements['DelegatesEventsActions'] = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Delegates, Events, and Actions'
$replacements['ExpressionBodiedMembers'] = 'Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Expression-Bodied Members'
$replacements['DockerDotNet'] = 'Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers/Docker and .NET'
$replacements['AzureServicesOverview'] = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index'
$replacements['Event Driven'] = 'Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture'
$replacements['MVC'] = 'Areas/Application Development/Frontend and UX Engineering/UI Composition/Model-View-Controller'
$replacements['Web Development Overlay'] = 'Areas/Domains and Specialisms/Web Development/_Index'
$replacements['Architecture and Patterns'] = 'Areas/Architecture and System Design/_Index'
$replacements['Cloud and Delivery'] = 'Areas/Cloud and Platform Engineering/_Index'
$replacements['Data and State'] = 'Areas/Data Systems/_Index'
$replacements['Data Systems'] = 'Areas/Data Systems/_Index'
$replacements['Application State'] = 'Areas/State, Coordination and Workflows/_Index'
$replacements['Developer Workflow'] = 'Areas/Engineering Practice/_Index'
$replacements['Languages and Frameworks'] = 'Areas/Languages, Runtimes and Frameworks/_Index'
$replacements['Operations and Reliability'] = 'Areas/Reliability and Operations/_Index'
$replacements['Security'] = 'Areas/Security and Privacy/_Index'
$replacements['Testing and Quality'] = 'Areas/Testing and Quality/_Index'
$replacements['Areas/Developer Workflow/Test-Driven Development'] = 'Areas/Testing and Quality/Testing Fundamentals/Test-Driven Development'
$replacements['Areas/Developer Workflow/Behavior-Driven Development'] = 'Areas/Testing and Quality/Testing Fundamentals/Behavior-Driven Development'
$replacements['DIP'] = 'Areas/Engineering Practice/Code Design and Construction/Dependency Inversion Principle'
$replacements['OCP'] = 'Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle'
$replacements['ISP'] = 'Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle'
$replacements['SRP'] = 'Areas/Engineering Practice/Code Design and Construction/Single Responsibility Principle'
$replacements['ConstructorInjection'] = 'Areas/Application Development/Backend Engineering/Constructor Injection'
$replacements['PropertyInjection'] = 'Areas/Application Development/Backend Engineering/Property Injection'
$replacements['MethodInjection'] = 'Areas/Application Development/Backend Engineering/Method Injection'
$replacements['SingletonLifetime'] = 'Areas/Application Development/Backend Engineering/Dependency Injection/Singleton Lifetime'
$replacements['ScopedLifetime'] = 'Areas/Application Development/Backend Engineering/Dependency Injection/Scoped Lifetime'
$replacements['TransientLifetime'] = 'Areas/Application Development/Backend Engineering/Dependency Injection/Transient Lifetime'
$replacements['Service Based Architecture'] = 'Areas/Architecture and System Design/Architectural Styles/_Index'
$replacements['Domain-Driven Design'] = 'Areas/Architecture and System Design/Domain-Driven Design/_Index'
$replacements['Replication and Partitioning'] = 'Areas/Data Systems/Replication and Partitioning/_Index'
$replacements['Relational Databases'] = 'Areas/Data Systems/Data Models and Query Languages/_Index'
$replacements['Data Modeling'] = 'Areas/Data Systems/Data Models and Query Languages/_Index'
$replacements['NoSQL Databases'] = 'Areas/Data Systems/Data Models and Query Languages/_Index'
$replacements['Azurite_Cheatsheet'] = 'Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite'
$replacements['Fitness-Function Driven Development'] = 'Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions'
$replacements['Areas/Architecture and Patterns/Architectural Styles/Fitness-Function Driven Development'] = 'Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions'

$files = Get-ChildItem -Recurse -Filter '*.md' | Where-Object { $_.FullName -notlike '*\.git\*' -and $_.FullName -notlike '*\Jobs\*' }
$allNotes = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '*.md')
$changed = 0
foreach ($file in $files) {
    $before = Get-Content -Raw -LiteralPath $file.FullName
    if ($null -eq $before) { continue }
    $after = $before
    foreach ($old in $replacements.Keys) {
        $new = $replacements[$old]
        $escaped = [regex]::Escape($old)
        $after = [regex]::Replace($after, "\[\[$escaped(?=\||\]\])", "[[$new")
    }
    if ($file.Name -eq '_Index.md') {
        $after = [regex]::Replace($after, '\[\[([^\]|#/]+)(\|[^\]]+)?\]\]', {
            param($match)
            $name = $match.Groups[1].Value
            $suffix = $match.Groups[2].Value
            $key = $name.ToLowerInvariant()
            $hits = @($allNotes | Where-Object { $_.BaseName.ToLowerInvariant() -eq $key })
            if ($hits.Count -eq 1) {
                $relative = $hits[0].FullName.Substring((Get-Location).Path.Length + 1).Replace('\\', '/') -replace '\.md$', ''
                if (-not $suffix) { $suffix = '|' + $name }
                return '[[' + $relative + $suffix + ']]'
            }
            return $match.Value
        })
    }
    if ($before -ne $after) {
        $changed++
        if (-not $Check) { [IO.File]::WriteAllText($file.FullName, $after, [Text.UTF8Encoding]::new($false)) }
    }
}

Write-Host "Repaired wikilinks in $changed files."
