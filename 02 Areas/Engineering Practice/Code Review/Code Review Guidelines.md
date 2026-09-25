---
date: 2025-11-25
status: Current
tags:
  - code-review
  - practices
  - quality
  - process

---

# Code Review Guidelines

## Quick Reference

**Definition:** A risk-aware review of a proposed change for correctness, maintainability, security, and fit with the intended behavior. Teams should state which findings block merge and which are optional.

**When to use:**
- Before merging a change, especially where tests cannot establish intent, design fit, or operational risk on their own.

**Key Takeaways:**
- **Review for intent first:** Does the change do what the author intended?
- **Keep changes reviewable:** Isolate a coherent change, or split a large change into safe reviewable stages.
- **Automate style and tests:** Use CI to catch formatting and test regressions before review.

**Checklist:**
- Intent and correctness: expected behavior, edge cases, and failure paths.
- Evidence: tests at the right level, deployment or migration checks where needed.
- Risk: permissions, secrets, data handling, concurrency, resource use, and rollback.
- Maintainability: names, boundaries, duplication, and explanatory documentation.
- Compatibility: API, schema, configuration, and downstream consumer changes.

**Gotchas:**
- Caution: **Nitpicking style** wastes time—use linters and formatters instead.
- Caution: **Review fatigue:** Limit review sessions and break large reviews into chunks.

---

## Deep Dive

### Comment Priority and Response

This is a proposed team rubric, not a universal severity scale:

| Label | Meaning | Merge effect |
| --- | --- | --- |
| Blocker | Correctness, security, data loss, or agreed policy failure with evidence | Resolve before merge. |
| Required | Material maintainability or test gap under team policy | Resolve or record an agreed exception. |
| Suggestion | Improvement without merge risk | Author chooses; follow-up may be separate. |
| Question | Reviewer needs context | Clarify before deciding severity. |

Explain why a comment matters. Authors should answer or make the code clearer; reviewers should close resolved threads. Agree team response expectations for time-sensitive reviews rather than assuming one turnaround for every review.

### Review Etiquette
- Be respectful and specific. Ask when intent is unclear; state required changes plainly when risk is established.
- Prefer examples or suggested fixes, and distinguish a blocking concern from an optional improvement.

### Review Depth
- Review deeper when a change touches authorization, payments, data migration, public contracts, concurrency, or incident-prone code. Route specialist concerns to someone qualified.
- For low-risk changes, focus on intent and evidence without repeating checks already enforced by CI.

### Effective PRs
- Prefer one coherent purpose per PR; split only where each stage remains safe and reviewable.
- Provide context in the PR description: motivation, trade-offs, risk, and how to test.
- Include links to design decisions when they explain a non-obvious choice.

### Tools & Automation
- Use branch policies, required reviewers, and CI checks.
- Use code owners to route domain-specific reviews.

---

## Related Concepts
- [[ASP.NET Core Integration Testing]]
- [[MSTest]]

## Resources
- [Google Engineering Practices: What to look for in a review](https://google.github.io/eng-practices/review/reviewer/looking-for.html) and [comment severity](https://google.github.io/eng-practices/review/reviewer/comments.html) — published team guidance; accessed 2026-09-24.
- [GitHub Docs: Reviewing proposed changes](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/reviewing-proposed-changes-in-a-pull-request) — product workflow; accessed 2026-09-24.

## Practice Exercises
1. Review a historical PR and write a short checklist of missed issues.
2. Draft a PR template that requests intent, test evidence, risk, and rollback context without mandating irrelevant fields.

## Review Schedule
- Review when team merge policy, review tooling, or risk profile changes.
