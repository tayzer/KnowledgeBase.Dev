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
