---
date: 2026-06-13
status: Current
tags:
  - design-patterns
  - architecture
  - plugin
  - extension
  - ocp

---

# Plugin

## Quick Reference

**Definition:** A pattern where a stable dispatcher or host loads interchangeable handlers or modules that can be added without modifying the dispatcher itself.

**When to use:**
- You have a known extension point with multiple implementations.
- New capabilities should be added by registration rather than by editing the core flow.

**Key Takeaways:**
- Keep the host stable and move variation into plug-in implementations.
- Register implementations at the composition root or discovery boundary.
- Use the same pattern for handlers, exporters, channels, processors, or rules.
- Caution: If every extension needs a different control flow, the dispatcher may be doing too much.

**Code Snippet:**
```csharp
public interface INotificationChannel
{
    Task SendAsync(Notification notification);
}

public sealed class NotificationService
{
    private readonly IEnumerable<INotificationChannel> _channels;

    public NotificationService(IEnumerable<INotificationChannel> channels) => _channels = channels;

    public Task SendAsync(Notification notification) =>
        Task.WhenAll(_channels.Select(channel => channel.SendAsync(notification)));
}
```

**Gotchas:**
- Caution: Do not turn the host into a service locator.
- Caution: Do not add plug-ins for every tiny variation if a simple strategy parameter would do.

---

## Deep Dive

### Conceptual Foundation
The plugin pattern is an extension architecture: the host owns the workflow, while plug-ins own the variable behavior. A new implementation should be addable through registration, discovery, or configuration without changing the dispatcher.

### Common Variants
- **Registered handlers:** a host may receive `IEnumerable<T>` and dispatch implementations; this is a general extension mechanism, broader than Fowler’s named Plugin pattern.
- **Discovered providers:** the app scans assemblies and loads implementations by convention.
- **Command or processor plug-ins:** each plug-in handles one command, file type, message, or rule.

### Relationship to Other Patterns
- **Strategy** is the simplest plug-in shape when the choice is one implementation at a time.
- **Decorator** can layer plug-ins around a core implementation.
- **Specification** is often a plug-in style for business rules that can be composed or selected independently.

### Design Guidance
- Keep the extension contract narrow and stable.
- Prefer explicit registration over hidden magic when the set of plug-ins is known.
- Put composition, discovery, and wiring at the edge of the application.

### Selection and failure policy

Register plugins by a stable identifier and explicit configuration, then validate each plugin contract before enabling it. If one plugin fails, decide whether the host stops, skips that plugin, or quarantines it; the choice depends on whether the extension is required. The example is an in-process extension architecture and may be broader than Fowler's original Plugin pattern. Strategy varies one algorithm; a plugin host manages discovery, configuration, and lifecycle for extensions. [Fowler's Plugin catalog entry](https://martinfowler.com/eaaCatalog/plugin.html) (2003; checked 2026-09-24).

## Related Concepts
- [[Open-Closed Principle]]
- [[Dependency Injection]]
- [[Strategy]]

## Resources
- Martin Fowler: Plugin
- ASP.NET Core documentation on dependency injection and service registration

## Practice Exercises
1. Refactor a `switch`-based dispatcher into a plug-in host that runs registered handlers.
2. Add a new handler without modifying the dispatcher and verify the old behavior still works.

## Sources

- [Fowler pattern catalog, Plugin](https://martinfowler.com/eaaCatalog/plugin.html) — 2003; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
