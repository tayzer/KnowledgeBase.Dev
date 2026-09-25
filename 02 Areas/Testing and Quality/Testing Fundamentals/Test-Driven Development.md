---
date: 2026-06-16
status: Current
tags:
  - tdd
  - engineering-approach
  - workflow
  - design
  - testing

---

# Test-Driven Development

## Quick Reference

**Definition:** An iterative development approach where you write a failing test first, implement the smallest code change to pass it, then refactor.

**When to use:**
- When design quality, fast feedback, and safe refactoring are priorities.
- When evolving code with confidence in regression protection.

**Key Takeaways:**
- TDD is a design loop, not only a testing activity.
- The red-green-refactor cycle encourages small, composable changes.
- Caution: Weak test design can lock in brittle implementations.

---

## Deep Dive

### Core Loop
1. Red: write a test that fails for the next behavior.
2. Green: add minimal production code to make the test pass.
3. Refactor: improve code structure while keeping tests green.

### Why It Is More Than Testing
- Tests act as executable design constraints.
- API shape and object boundaries often emerge from the test seams.
- Refactoring is a first-class activity in the cycle.

### Comparison With BDD
- TDD focuses on implementation-facing test feedback.
- BDD focuses on behavior language shared with stakeholders.

## Review refinements

Red: write a failing test that negative quantity is rejected. Green: implement the smallest behavior that passes. Refactor: remove duplication while keeping tests green. TDD can support design and regression feedback, but benefit depends on test quality and speed. Legacy code may need characterization tests; distributed behavior still needs integration tests.

## Related Concepts
- [[Behavior-Driven Development]]
- [[40 Knowledge/Software Engineering/02 Areas/Testing and Quality/_Index]]
- [[Engineering Approaches]]

## Sources

- [Primary documentation](https://martinfowler.com/bliki/TestDrivenDevelopment.html) (accessed 2026-09-24; check version at source).

## Review Schedule
- [ ] Review 2 months after promotion; use the approval date as the anchor
