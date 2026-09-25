---
date: 2026-06-16
status: Current
tags:
  - bdd
  - engineering-approach
  - workflow
  - collaboration
  - testing

---

# Behavior-Driven Development

## Quick Reference

**Definition:** A collaborative development approach that specifies expected system behavior in shared, business-readable language and drives implementation from those examples.

**When to use:**
- When business intent is getting lost between product, QA, and engineering.
- When acceptance criteria need to become executable and traceable.

**Key Takeaways:**
- BDD aligns discovery, specification, and verification around behavior.
- Scenarios can become living documentation when kept focused and stable.
- Caution: Treating BDD as only a test tool often leads to noisy, low-value scenarios.

---

## Deep Dive

### Typical Flow
1. Discover behavior collaboratively (example mapping or similar workshop).
2. Express behavior as concrete scenarios.
3. Automate the scenarios at the right boundary.
4. Implement and refine code to satisfy behavior.

### Why It Is More Than Testing
- It changes requirement conversations before coding starts.
- It reduces ambiguity by anchoring discussion in concrete examples.
- It shapes domain language used in code and product communication.

### Comparison With TDD
- BDD emphasizes shared behavior language and acceptance outcomes.
- TDD emphasizes fast developer feedback and emergent code design.

## Review refinements

BDD begins with a shared discussion of observable behavior. Example: Given an expired session, when the user requests a protected page, then the app asks them to sign in. Automate a scenario when it gives repeatable value at the right test layer; not every discussion must become an executable specification. UI automation and large step libraries impose maintenance cost.

## Related Concepts
- [[Test-Driven Development]]
- [[40 Knowledge/Software Engineering/02 Areas/Testing and Quality/_Index]]
- [[Engineering Approaches]]

## Sources

- [Primary documentation](https://cucumber.io/docs/bdd/) (accessed 2026-09-24; check version at source).

## Review Schedule
- [ ] Review 2 months after promotion; use the approval date as the anchor
