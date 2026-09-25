$ErrorActionPreference = 'Stop'
$utf8 = [Text.UTF8Encoding]::new($false)

function Write-Document {
    param([string]$Path, [string]$Content)
    [IO.File]::WriteAllText((Join-Path (Get-Location) $Path), $Content, $utf8)
}

foreach ($path in @(
    'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md',
    'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md'
)) {
    $content = Get-Content -Raw -LiteralPath $path
    $marker = $content.IndexOf('<!-- preserved-source:', [StringComparison]::Ordinal)
    if ($marker -ge 0) {
        [IO.File]::WriteAllText((Join-Path (Get-Location) $path), $content.Substring(0, $marker).TrimEnd() + "`n", $utf8)
    }
}

Write-Document 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md' @"
# ASP.NET Core Options Pattern
Date: 2026-08-13
Status: Needs Review
Tags: #dotnet #aspnet-core #configuration #options

## TL;DR / Quick Reference

**Definition:** The options pattern binds configuration to typed .NET objects and injects those objects into application services.

**When to use:**
- When configuration has a stable named shape and consumers benefit from typed access.

**Key Takeaways:**
- Bind and validate options at the application boundary.
- Choose the options interface that matches the required lifetime and reload semantics.
- Confirm current ASP.NET Core guidance before relying on version-specific APIs or defaults.

## Deep Dive

Register a configuration section with `Configure<TOptions>` and inject the appropriate options abstraction into the consumer. Keep configuration types focused on the external configuration contract; avoid passing raw configuration access throughout the application.

## Related Concepts
- [[Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/_Index|ASP.NET Core]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection|Dependency Injection]]

## Review Schedule
- [ ] Verify against current Microsoft documentation before promotion to Current.
"@

Write-Document 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md' @"
# ASP.NET Core Integration Testing
Date: 2026-08-13
Status: Needs Review
Tags: #testing #aspnet-core #integration-testing

## TL;DR / Quick Reference

**Definition:** Integration testing verifies how ASP.NET Core components work together across real application boundaries.

**When to use:**
- When testing routing, middleware, dependency wiring, persistence boundaries, or HTTP behaviour.

**Key Takeaways:**
- Exercise the host through public behaviour, not internal implementation details.
- Keep external dependencies deterministic and isolated for repeatable tests.
- Verify current framework-hosting APIs before adding version-specific examples.

## Deep Dive

Use an application test host with controlled configuration and dependencies. Keep fast unit tests for isolated logic; use integration tests for behaviour that depends on the application composition.

## Related Concepts
- [[Areas/Testing and Quality/Test Automation and Tooling/Test Runners/MSTest|MSTest]]
- [[Areas/Testing and Quality/_Index|Testing and Quality]]

## Review Schedule
- [ ] Verify against current Microsoft documentation before promotion to Current.
"@

Write-Document 'Resources/KnowledgeBase/Taxonomy Migration History.md' @"
# Taxonomy Migration History
Date: 2026-08-13
Status: Current
Tags: #knowledge-base #taxonomy #migration #history

## TL;DR / Quick Reference

**Definition:** Record of the retired incremental taxonomy approach.

**When to use:**
- Use when interpreting older commits or archived migration material.

**Key Takeaways:**
- The incremental move-on-touch policy ended with the clean 13-area cutover on 2026-08-13.
- Current placement and link rules are authoritative; this file is historical context only.

## Deep Dive

The prior mapping and compatibility-hub policy has been superseded. Canonical homes, category indexes, terminal-topic rules, and documented leaf extensions are defined in [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]. The current tree is [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]].

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Migration Completion Record|Taxonomy Migration Completion Record]]
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]

## Review Schedule
- [ ] Retain as historical context; review only if migration evidence is needed.
"@

Write-Document 'Resources/KnowledgeBase/Taxonomy Migration Completion Record.md' @"
# Taxonomy Migration Completion Record
Date: 2026-08-13
Status: Current
Tags: #knowledge-base #taxonomy #migration #completion

## TL;DR / Quick Reference

**Definition:** Completion record for the clean software-engineering taxonomy cutover.

**When to use:**
- Use when validating migration scope or checking whether a legacy location remains authoritative.

**Key Takeaways:**
- All baseline `Areas/` notes are accounted for in the migration ledger.
- Navigation is provided by category `_Index.md` files; no legacy compatibility hubs remain.
- Notes retain `Needs Review` until their technical content has been individually reviewed.

## Deep Dive

The executable validation and repair tools sit alongside this record. The ledger records a canonical destination and action for each baseline note. Historical merged hub text is retained outside live navigation in [[Resources/KnowledgeBase/Taxonomy Hub Source Archive|Taxonomy Hub Source Archive]].

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]

## Review Schedule
- [ ] Review after the first full content-review cycle.
"@

Write-Document 'Resources/KnowledgeBase/Data and State Migration Record.md' @"
# Data and State Migration Record
Date: 2026-08-13
Status: Current
Tags: #knowledge-base #taxonomy #migration #data #state

## TL;DR / Quick Reference

**Definition:** Historical record of the former combined data-and-state taxonomy.

**When to use:**
- Use only when interpreting older commits or reviewing moved notes.

**Key Takeaways:**
- Durable data concerns now live under [[Areas/Data Systems/_Index|Data Systems]].
- Runtime state, coordination, and workflows now live under [[Areas/State, Coordination and Workflows/_Index|State, Coordination and Workflows]].
- This record is not a compatibility hub and is not part of live navigation.

## Deep Dive

The split is complete. Use the taxonomy rules and ledger instead of recreating a combined area or leaving redirect notes.

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]

## Review Schedule
- [ ] Review only when historical migration evidence is required.
"@

Write-Host 'Finalized governance documents and removed merged-source duplicates.'
