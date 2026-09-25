---
date: 2026-08-13
status: Needs Review
tags:
  - dotnet
  - aspnet-core
  - configuration
  - options

---

# ASP.NET Core Options Pattern

## Quick Reference

**Definition:** The options pattern binds configuration to typed .NET objects and injects those objects into application services.

**When to use:**
- When configuration has a stable named shape and consumers benefit from typed access.

**Key Takeaways:**
- Bind and validate options at the application boundary.
- Choose the options interface that matches the required lifetime and reload semantics.
- Confirm current ASP.NET Core guidance before relying on version-specific APIs or defaults.

## Deep Dive

Register a configuration section with Configure<TOptions> and inject the appropriate options abstraction into the consumer. Keep configuration types focused on the external configuration contract; avoid passing raw configuration access throughout the application.

## Review refinements

Bind a focused options type with AddOptions<T>().Bind(section).Validate(...).ValidateOnStart() when startup validation is wanted. IOptions<T> provides a stable value; IOptionsSnapshot<T> is scoped and cannot be injected into a singleton; IOptionsMonitor<T> supports singleton consumers and change notifications. Reload depends on the configuration provider. Without ValidateOnStart, validation may happen on first access. Named options need name-aware registration.

For ASP.NET Core 10, a typed startup-validated registration can be written as:

```csharp
public sealed class PaymentOptions
{
    public string Endpoint { get; set; } = string.Empty;
}

builder.Services.AddOptions<PaymentOptions>()
    .Bind(builder.Configuration.GetSection("Payments"))
    .Validate(o => !string.IsNullOrWhiteSpace(o.Endpoint), "Endpoint is required")
    .ValidateOnStart();
```

Choose the injected interface from lifetime and reload needs. Add validation for every required field; binding alone does not prove a valid configuration value.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/_Index|ASP.NET Core]]
- [[Dependency Injection|Dependency Injection]]

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/options?view=aspnetcore-10.0) (accessed 2026-09-24; check version at source).

## Review Schedule
- [ ] Verify against current Microsoft documentation before promotion to Current.

- [ ] Before setting this note to Current: Run the example in a matching ASP.NET Core 10 project.
