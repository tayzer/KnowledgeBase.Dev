---
description: Apply to .NET test projects and tests; choose tests by confidence and risk.
applyTo: "**/*Tests/**/*.cs,**/*Test/**/*.cs,**/*.Tests.csproj,**/*.Test.csproj,**/*Tests.cs,**/*Test.cs"
---

# Testing

- Inspect existing test framework, fixtures, naming, and CI commands before adding patterns. Choose the lowest-cost test that gives adequate confidence: unit, component, contract, integration, then end-to-end as needed. No framework is assumed.
- Test observable behavior and contracts rather than implementation detail. Avoid mocking everything; use real small components or fakes at meaningful boundaries. Prefer deterministic clocks, stable data, and isolated resources.
- Cover normal behavior and material risks: boundaries, invalid input, dependency failures, timeouts, retries, concurrency, cancellation, duplicates, serialization and backwards compatibility, permissions, and partial failure. For a bug, add a regression test when practical.
- At service boundaries, consider contract tests before relying only on broad shared-environment integration tests. Document external prerequisites and distinguish skipped tests from passed tests.
- Do not optimize for test count or coverage percentage. Run the relevant tests when possible; report commands, outcomes, and gaps accurately.
