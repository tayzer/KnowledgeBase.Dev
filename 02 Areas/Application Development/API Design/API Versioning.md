---
date: 2026-08-13
status: Current
tags:
  - api
  - versioning
  - compatibility

---

# API Versioning

## Quick Reference

**Definition:** API versioning is a compatibility strategy for evolving public or long-lived interfaces without unexpectedly breaking clients.

**When to use:**
- An API has independent consumers, published contracts, or a deprecation window.

**Key Takeaways:**
- Prefer additive, backward-compatible contract changes where possible.
- Versioning is only one part of compatibility; consumers also need clear deprecation and migration guidance.
- Choose URI, header, media-type, or other mechanisms from client and operational needs, not convention alone.

## Deep Dive

Keep contract tests for supported versions and state a retirement policy before publishing a breaking change. Version behavior, documentation, and observability together so support teams can identify active consumer versions.

### Change and retirement example

Adding an optional response field is usually compatible with clients that ignore unknown fields; renaming a required field or changing its meaning can break them. Test the actual published contract against supported clients because serialization and generated SDKs can narrow compatibility. For a breaking change, document the new contract, announce a support window, expose deprecation/sunset policy, observe consumer use, and remove the old version only after the agreed window. URI, header, or media type selection is operational rather than a universal rule. [Microsoft API design guidance](https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design) (checked 2026-09-24).

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Application Development/API Design/_Index|API Design]]
- [[40 Knowledge/Software Engineering/02 Areas/Software Delivery and Evolution/Versioning, Compatibility and Deprecation/_Index|Versioning, Compatibility and Deprecation]]

## Sources

- [Microsoft, Web API design best practices](https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design) — online page, date not shown; accessed 2026-09-24.

## Review Schedule
- [ ] Review before changing public API policy.
