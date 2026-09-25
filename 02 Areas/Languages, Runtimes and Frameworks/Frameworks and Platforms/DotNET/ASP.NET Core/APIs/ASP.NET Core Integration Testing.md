---
date: 2026-08-13
status: Needs Review
tags:
  - testing
  - aspnet-core
  - integration-testing

---

# ASP.NET Core Integration Testing

## Quick Reference

**Definition:** Integration testing verifies how ASP.NET Core components work together across real application boundaries.

**When to use:**
- When testing routing, middleware, dependency wiring, persistence boundaries, or HTTP behaviour.

**Key Takeaways:**
- Exercise the host through public behaviour, not internal implementation details.
- Keep external dependencies deterministic and isolated for repeatable tests.
- Verify current framework-hosting APIs before adding version-specific examples.

## Deep Dive

Use an application test host with controlled configuration and dependencies. Keep fast unit tests for isolated logic; use integration tests for behaviour that depends on the application composition.

## Review refinements

For ASP.NET Core 10, use Microsoft.AspNetCore.Mvc.Testing at the matching major version and WebApplicationFactory<Program> to send real HTTP requests to the test host. With top-level statements, expose Program as public partial in the app project. Use WithWebHostBuilder and ConfigureTestServices to override external dependencies before client creation. Isolate and seed a relational test database when relational behavior matters, and dispose factory and client.

The example assumes the application maps `/health` and exposes `public partial class Program` for the test project:

```csharp
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.VisualStudio.TestTools.UnitTesting;

[TestClass]
public sealed class HealthTests
{
    [TestMethod]
    public async Task Health_ReturnsSuccess()
    {
        using var factory = new WebApplicationFactory<Program>();
        using var client = factory.CreateClient();
        using var response = await client.GetAsync("/health");
        response.EnsureSuccessStatusCode();
    }
}
```

Replace the route and test framework with those used by the application. Configure test services before `CreateClient()`. The EF Core in-memory provider does not reproduce relational query behavior; use an isolated relational provider when SQL behavior is under test.

## Related Concepts
- [[MSTest|MSTest]]
- [[40 Knowledge/Software Engineering/02 Areas/Testing and Quality/_Index|Testing and Quality]]

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-10.0) (accessed 2026-09-24; check version at source).

## Review Schedule
- [ ] Verify against current Microsoft documentation before promotion to Current.

- [ ] Before setting this note to Current: Run the example in a matching ASP.NET Core 10 test project.
