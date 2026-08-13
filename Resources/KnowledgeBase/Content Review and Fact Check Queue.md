# Content Review and Fact Check Queue
Date: 2026-08-13
Status: Current
Tags: #knowledge-base #review #fact-checking #backlog

## TL;DR / Quick Reference

**Definition:** Review queue created during the taxonomy cutover.

**When to use:**
- Before changing a `Needs Review` note to `Current`.

**Key Takeaways:**
- Taxonomy normalization does not establish technical correctness.
- All published `Areas/` notes remain `Needs Review` until their own claims are checked.
- Prioritize provider, framework, package, security, performance, and version-specific guidance.

## Review Method

1. Confirm the canonical home and related links.
2. Check time-sensitive claims against primary documentation, release notes, standards, or advisories.
3. Replace stale examples and add dated source links where they materially support guidance.
4. Change status to `Current` only when the whole note is supportable.

## Priority Order

1. Security and privacy material.
2. Cloud platforms, .NET/ASP.NET Core, tooling, and database products.
3. Operational, performance, and resilience recommendations.
4. Stable foundations, architecture, and design guidance.

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Taxonomy Leaf Extension Register|Taxonomy Leaf Extension Register]]

## Review Schedule
- [ ] Recalculate the queue after each review batch.
