# API Versioning
Date: 2026-08-13
Status: Needs Review
Tags: #api #versioning #compatibility

## TL;DR / Quick Reference

**Definition:** API versioning is a compatibility strategy for evolving public or long-lived interfaces without unexpectedly breaking clients.

**When to use:**
- An API has independent consumers, published contracts, or a deprecation window.

**Key Takeaways:**
- Prefer additive, backward-compatible contract changes where possible.
- Versioning is only one part of compatibility; consumers also need clear deprecation and migration guidance.
- Choose URI, header, media-type, or other mechanisms from client and operational needs, not convention alone.

## Deep Dive

Keep contract tests for supported versions and state a retirement policy before publishing a breaking change. Version behavior, documentation, and observability together so support teams can identify active consumer versions.

## Related Concepts
- [[Areas/Application Development/API Design/_Index|API Design]]
- [[Areas/Software Delivery and Evolution/Versioning, Compatibility and Deprecation/_Index|Versioning, Compatibility and Deprecation]]

## Review Schedule
- [ ] Review before changing public API policy.
