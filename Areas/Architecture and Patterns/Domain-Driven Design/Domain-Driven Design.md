# Domain-Driven Design
Date: 2026-06-16
Status: 🟡 Needs Review
Tags: #ddd #architecture #domain-modeling #engineering-approach

## 🎯 TL;DR / Quick Reference

**Definition:** An architecture and modeling approach that centers software design around core business domains, explicit boundaries, and a shared domain language.

**When to use:**
- When domain complexity is high and terminology drift causes delivery issues.
- When teams need clearer ownership boundaries across services or modules.

**Key Takeaways:**
- ✅ DDD is a broader design and organizational approach, not just a set of tactical patterns.
- ✅ Strategic design (bounded contexts, context maps) should guide tactical design.
- ⚠️ Applying tactical patterns without context boundaries often increases complexity.

---

## 📚 Deep Dive

### Strategic Elements
- Ubiquitous language shared by domain experts and engineers.
- Bounded contexts to separate models with different meanings.
- Context mapping to define integration relationships.

### Tactical Elements
- Aggregates and entities to protect invariants.
- Value objects to model immutable concepts.
- Repositories and unit of work for persistence boundaries where appropriate.

### Practical Use
- Start by identifying core domain versus supporting domains.
- Define context boundaries before choosing service boundaries.
- Use tactical patterns where complexity justifies them.

## 🔗 Related Concepts
- [[Repository]]
- [[RepositoryUnitOfWork]]
- [[Areas/Developer Workflow/Engineering Approaches|Engineering Approaches]]

## 🔄 Review Schedule
- [ ] Review in 2 months
