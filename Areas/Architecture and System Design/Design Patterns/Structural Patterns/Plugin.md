# Plugin
Date: 2026-06-13
Status: Needs Review
Tags: #design-patterns #architecture #plugin #extension #ocp

## 🎯 TL;DR / Quick Reference

**Definition:** A pattern where a stable dispatcher or host loads interchangeable handlers or modules that can be added without modifying the dispatcher itself.

**When to use:**
- You have a known extension point with multiple implementations.
- New capabilities should be added by registration rather than by editing the core flow.

**Key Takeaways:**
- ✅ Keep the host stable and move variation into plug-in implementations.
- ✅ Register implementations at the composition root or discovery boundary.
- ✅ Use the same pattern for handlers, exporters, channels, processors, or rules.
- ⚠️ If every extension needs a different control flow, the dispatcher may be doing too much.

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
- ⚠️ Do not turn the host into a service locator.
- ⚠️ Do not add plug-ins for every tiny variation if a simple strategy parameter would do.

---

## 📚 Deep Dive

### Conceptual Foundation
The plugin pattern is an extension architecture: the host owns the workflow, while plug-ins own the variable behavior. A new implementation should be addable through registration, discovery, or configuration without changing the dispatcher.

### Common Variants
- **Registered handlers:** a host receives `IEnumerable<T>` and runs each implementation.
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

## 🔗 Related Concepts
- [[Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle]]
- [[Areas/Application Development/Backend Engineering/Dependency Injection]]
- [[Strategy]]

## 📖 Resources
- Martin Fowler: Plugin
- ASP.NET Core documentation on dependency injection and service registration

## 🧪 Practice Exercises
1. Refactor a `switch`-based dispatcher into a plug-in host that runs registered handlers.
2. Add a new handler without modifying the dispatcher and verify the old behavior still works.

## 🔄 Review Schedule
- [ ] Review in 6 months
