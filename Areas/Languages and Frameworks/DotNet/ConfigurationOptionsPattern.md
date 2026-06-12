# Configuration / Options Pattern
Date: 2025-11-25
Status: 🟢 Current
Tags: #csharp #dotnet #configuration #options #aspnetcore

## 🎯 TL;DR / Quick Reference

**Definition:** The Options pattern centralizes configuration by binding sections of configuration (appsettings.json, env vars) to POCO classes, validated and injected via `IOptions<T>` / `IOptionsMonitor<T>`.

**When to use:**
- Centralize configuration for services.
- Support reloading config at runtime (`IOptionsMonitor`).

**Key Takeaways:**
- ✅ **Strongly-typed config** via POCOs improves clarity and testability.
- ✅ **Use `IOptionsMonitor<T>`** when you need change notifications.
- ⚠️ **Validate config** with `services.AddOptions<T>().Bind(config).ValidateDataAnnotations()`.

**Code Snippet:**
```csharp
public class SmtpOptions { public string Host { get; set; } = null!; public int Port { get; set; } }

services.Configure<SmtpOptions>(Configuration.GetSection("Smtp"));
public class Emailer { public Emailer(IOptions<SmtpOptions> options) { var cfg = options.Value; } }
```

**Gotchas:**
- ⚠️ **Nullability:** Ensure required fields are validated or non-nullable in POCOs.
- ⚠️ **Secrets:** Do not commit secrets; combine with user-secrets or secret manager.

---

## 📚 Deep Dive

### Concepts
- `IOptions<T>` — snapshot-ish read (singleton), best for simple scenarios.
- `IOptionsSnapshot<T>` — scoped snapshot, used in scoped services (e.g., per-request in ASP.NET Core).
- `IOptionsMonitor<T>` — supports change notification and live reload.

### Validation
- Use DataAnnotations or `IValidateOptions<T>` for custom validation rules.

### Best Practices
- Keep POCOs small and single-responsibility.
- Store environment-specific values in environment variables or secret stores.

---

## 🔗 Related Concepts
- [[DependencyInjection]]
- [[AzureServicesOverview]] (configuration sources)

## 📖 Resources
- Microsoft Docs: Options pattern in ASP.NET Core

## 🧪 Practice Exercises
1. Bind a `DatabaseOptions` class and validate connection string presence.
2. Use `IOptionsMonitor<T>` to reload SMTP settings when `appsettings.json` changes locally.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
