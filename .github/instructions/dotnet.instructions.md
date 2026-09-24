---
description: Apply when changing C#, .NET projects, ASP.NET Core endpoints, or .NET configuration.
applyTo: "**/*.cs,**/*.csproj,**/*.fsproj,**/Directory.Build.*,**/Directory.Packages.props,**/global.json,**/appsettings*.json"
---

# .NET and ASP.NET Core

- Check `global.json`, target frameworks, SDK, package policy, and existing project conventions. Use supported runtime and C# features appropriate to the target; do not pin this guidance to one version.
- Keep nullable reference types meaningful. Validate external input at the boundary; avoid null suppression that hides uncertain contracts.
- Use async APIs end to end; avoid sync-over-async. Propagate `CancellationToken` through I/O and distinguish cancellation from failure. Do not create unobserved tasks.
- Respect DI lifetimes; never capture scoped services in singletons. Dispose owned `IDisposable` and `IAsyncDisposable` resources correctly. Reuse HTTP connections with the existing `IHttpClientFactory` or proven equivalent; set practical timeouts.
- Preserve serialization names, required fields, defaults, and compatibility for public APIs and messages. Make exception boundaries deliberate; return appropriate ASP.NET Core status and problem details without leaking internals.
- Use structured logging with stable fields and no secrets or sensitive payloads. Validate configuration and options at startup where failure would otherwise appear later. Add health checks and OpenTelemetry traces/metrics where the service's existing observability approach warrants them.
- Review thread safety for shared state, concurrency, and retries. Prefer immutable values where they clarify ownership. Use records and value objects for real domain semantics, not by default. Keep LINQ readable; measure hot paths before optimizing allocations or changing algorithms.
- Keep packages current under repository policy and justify new dependencies. Use existing ASP.NET Core middleware, authentication, and authorization conventions.
- Do not mandate Clean Architecture, repositories, MediatR, CQRS, DDD, Result types, or interfaces for every class. Justify any such choice using concrete boundaries, existing architecture, and change needs.
