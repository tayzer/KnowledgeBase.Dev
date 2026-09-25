---
date: 2026-06-16
status: Current
tags:
  - engineering-approach
  - workflow
  - architecture
  - quality

---

# Engineering Approaches

## Quick Reference

**Definition:** A route into cross-cutting methods for deciding how a team learns from tests, domain models, and architectural constraints. Each method has its canonical home elsewhere.

**When to use:**
- When choosing a feedback loop for building software (for example test-first, behavior-first, or architecture-fitness-first).
- When clarifying whether a method belongs to workflow, testing, or architecture.

**Key Takeaways:**
- These approaches are broader than a single testing technique.
- Each approach should have one canonical home, with links to related areas.
- Caution: Avoid duplicating full notes across multiple categories.

---

## Deep Dive

### Approach Routing
- [[Test-Driven Development]] - Workflow-first feedback loop using tests to drive design.
- [[Behavior-Driven Development]] - Shared language and behavior specification across dev, QA, and product.
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Domain-Driven Design/_Index|Domain-Driven Design]] - Domain modeling approach for aligning software with business capabilities.
- [[Architecture Fitness Functions]] - Evolutionary architecture approach with executable architectural constraints.

### Selection Questions

| Need | Start with | Limit to check |
| --- | --- | --- |
| Tight feedback on code behavior and design | [[Test-Driven Development]] | Unit tests alone may miss integration contracts. |
| Shared examples of externally visible behavior | [[Behavior-Driven Development]] | Scenarios need joint domain review; wording alone is not evidence. |
| Model complex business rules and language | [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Domain-Driven Design/_Index|Domain-Driven Design]] | Adds modeling cost where the domain is simple. |
| Detect architecture drift during evolution | [[Architecture Fitness Functions]] | Automated checks cover only chosen constraints. |

Pick the smallest feedback loop that tests the current risk. Combine methods when they address distinct risks rather than applying a full bundle by default.

### Placement Rule
- Put each approach in the strongest primary area.
- Add links from adjacent hubs when the approach is cross-cutting.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Engineering Practice/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Testing and Quality/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/_Index]]

## Review Schedule
- Review when linked method notes or category boundaries change.
