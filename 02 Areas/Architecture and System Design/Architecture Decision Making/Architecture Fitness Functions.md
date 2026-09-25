---
date: 2026-06-16
status: Current
tags:
  - fitness-functions
  - engineering-approach
  - workflow
  - architecture

---

# Architecture Fitness Functions

## Quick Reference
**Definition:** A development approach that continuously guides implementation using executable architecture checks (fitness functions) for critical quality attributes.

**When to use:**
- When architecture qualities (performance, security, reliability, modularity) must not regress over time.
- When teams need automated guardrails for architecture intent in CI/CD.

**Key Takeaways:**
- FFDD is an engineering approach with architecture as the primary concern area.
- Fitness functions provide fast feedback on non-functional and structural drift.
- Poorly chosen metrics can create false confidence or harmful optimization.

---

## Deep Dive
### What A Fitness Function Is
- An automated, objective check of an architecture characteristic.
- Executed regularly (for example in pipelines or quality gates).
- Used to detect architecture erosion early.

### Common Fitness Function Categories
- Structural: dependency direction, layering violations, coupling thresholds.
- Operational: latency budgets, error-rate bounds, recovery objectives.
- Security: policy compliance, dependency risk gates, secret scanning outcomes.

### Why It Is More Than Testing
- Focus is on architectural intent over system lifetime, not only feature correctness.
- Encourages explicit architecture hypotheses and measurable constraints.
- Integrates architecture governance into normal delivery flow.

### Resources
- https://www.thoughtworks.com/en-gb/insights/articles/fitness-function-driven-development

### Designing a fitness function

Choose an architectural property and a measurable signal: for example, a dependency test rejects imports from `Domain` into `Infrastructure`. Record its owner, threshold, exceptions, and review cadence. Run it in CI, a scheduled audit, or a design review as appropriate. Assess false positives and gaming: a passing dependency test does not prove the running system respects the desired boundary. [Thoughtworks' fitness-function account](https://www.thoughtworks.com/en-au/insights/articles/fitness-function-driven-development) (2019; checked 2026-09-24).

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Architecture Decision Making/_Index|Architecture Decision Making]]
- [[Clean Architecture]]
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/_Index]]
- [[Engineering Approaches]]

## Sources

- [Thoughtworks, Fitness function-driven development](https://www.thoughtworks.com/en-au/insights/articles/fitness-function-driven-development) — 2019; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 2 months
