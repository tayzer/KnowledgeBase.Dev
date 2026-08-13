# Fitness-Function Driven Development
Date: 2026-06-16
Status: Needs Review
Tags: #fitness-functions #engineering-approach #workflow #architecture

## 🎯 TL;DR / Quick Reference

**Definition:** A development approach that continuously guides implementation using executable architecture checks (fitness functions) for critical quality attributes.

**When to use:**
- When architecture qualities (performance, security, reliability, modularity) must not regress over time.
- When teams need automated guardrails for architecture intent in CI/CD.

**Key Takeaways:**
- ✅ FFDD is an engineering approach with architecture as the primary concern area.
- ✅ Fitness functions provide fast feedback on non-functional and structural drift.
- ⚠️ Poorly chosen metrics can create false confidence or harmful optimization.

---

## 📚 Deep Dive

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
## 🔗 Related Concepts
- [[Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions|Architecture Navigation Stub]]
- [[Clean Architecture]]
- [[Areas/Cloud and Platform Engineering/_Index]]
- [[Engineering Approaches]]

## 🔄 Review Schedule
- [ ] Review in 2 months
