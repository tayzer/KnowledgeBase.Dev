---
date: 2026-04-30
status: Current
tags:
  - mapping
  - maintainability
  - architecture
  - clean-code

---

# Mappers

## Quick Reference

**Definition:** Mappers translate data between shapes, such as transport DTOs and application models. This note recommends keeping routine mapping deterministic and leaving domain decisions and side effects at their owning boundary.

**When to use:**
- When crossing boundaries between transport, application, domain, and persistence models.
- When object shapes differ but the transformation itself should remain mechanical and easy to test.

**Key Takeaways:**
- **Prefer explicit mapping:** make field, identifier, null, and collection handling visible and testable.
- **Prefer deterministic mapping:** avoid ambient state and I/O in a mapper when a caller can provide already validated inputs.
- **Keep decisions with their owner:** permission, validation, and workflow rules belong at the application or domain boundary, not hidden in conversion code.

---

## Deep Dive

### What Belongs In A Mapper
1. **Direct property mapping:** Copy values from one object to another where the mapping is explicit and stable.
2. **Basic transformations:** Format strings, convert data types, or provide simple fallback values.
3. **Stateless operations:** Use only the input objects and deterministic transformation logic.

### What Does Not Belong In A Mapper
1. **Business logic:** Decisions, rules, or calculations that depend on domain meaning should live in the application or domain layer.
2. **External dependencies:** HTTP context, user session, service calls, repository access, and other runtime infrastructure should stay outside the mapper.
3. **Conditional logic based on application state:** Authorization checks, feature-flag checks, or workflow-state branches are application concerns.
4. **Side effects:** Database writes, file I/O, network calls, and event publication do not belong in mapping code.

### Example: Nulls, Collections, and Identifiers

The mapper below preserves the source identifier, maps a missing role collection to an empty one, and leaves identifier validity and authorization to the caller. The fallback is an explicit application convention, not a universal mapping rule.

```csharp
public sealed record UserDto(string Id, string? DisplayName, string[]? Roles);
public sealed record UserView(string Id, string Name, IReadOnlyList<string> Roles);

public static UserView Map(UserDto source) => new(
    source.Id,
    source.DisplayName ?? "(unnamed)",
    source.Roles ?? Array.Empty<string>());
```

Rejecting an invalid `Id` belongs in input validation; deciding which roles a caller may see belongs in authorization. A mapper may call a dedicated conversion function if that remains explicit and deterministic.

### Why This Boundary Matters
This is a design convention, not a required library rule. Small deterministic mappings are easier to inspect and unit test. If a mapping requires external context or persistence, keep that dependency visible at its owning boundary rather than hiding it in a conversion helper.

## Related Concepts
- [[Clean Architecture]]
- [[Dependency Injection]]

## Review Schedule
- Review when a model boundary, nullability rule, or mapping-library behavior changes.
