# Test-Driven Development
Date: 2026-06-16
Status: 🟡 Needs Review
Tags: #tdd #engineering-approach #workflow #design #testing

## 🎯 TL;DR / Quick Reference

**Definition:** An iterative development approach where you write a failing test first, implement the smallest code change to pass it, then refactor.

**When to use:**
- When design quality, fast feedback, and safe refactoring are priorities.
- When evolving code with confidence in regression protection.

**Key Takeaways:**
- ✅ TDD is a design loop, not only a testing activity.
- ✅ The red-green-refactor cycle encourages small, composable changes.
- ⚠️ Weak test design can lock in brittle implementations.

---

## 📚 Deep Dive

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

## 🔗 Related Concepts
- [[Behavior-Driven Development]]
- [[Testing and Quality]]
- [[Engineering Approaches]]

## 🔄 Review Schedule
- [ ] Review in 2 months
