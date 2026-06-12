# Clean Architecture
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #architecture #clean-architecture #design

## 🎯 TL;DR / Quick Reference

**Definition:** An approach to structure applications so that business rules are independent of frameworks and UI, promoting testability and maintainability.

**When to use:**
- Applications requiring clear separation between domain, application, and infrastructure layers.
- Systems where long-term maintainability, testability, and framework independence matter more than minimizing upfront structure.

**Key Takeaways:**
- ✅ **Dependency rule:** Inner layers should not depend on outer layers.
- ✅ **Frameworks and infrastructure stay at the edges** instead of shaping core business rules.
- ⚠️ **Extra structure has a cost**: over-applying it to simple systems can create unnecessary indirection.

---

## 📚 Deep Dive

### Core Idea
Clean Architecture organizes code so the most important business rules sit at the center, while frameworks, databases, and delivery mechanisms remain replaceable details at the edges. The main rule is directional: dependencies point inward.

### Typical Layers
- **Domain or Core:** entities, value objects, and business rules.
- **Application:** use cases, orchestration, and workflow logic.
- **Infrastructure:** persistence, external integrations, messaging, and framework-specific implementations.
- **Presentation:** controllers, APIs, UI, or other delivery mechanisms.

### Benefits
- Business logic becomes easier to test without booting the whole application stack.
- Infrastructure changes have less impact on core behavior.
- Team boundaries and responsibilities become clearer when layers are respected.

### Common Failure Modes
- Treating every simple CRUD app as if it needs the full layering model.
- Letting infrastructure types leak into application or domain code.
- Adding abstractions with no clear boundary or replacement need, which creates ceremony without value.

### Practical Guidance
- Put policies and business decisions in the core, not in controllers or repositories.
- Use interfaces at real architectural seams rather than wrapping everything automatically.
- Keep the composition root and dependency wiring near the application edge.

## 🔗 Related Concepts
- [[SOLID]]
- [[DependencyInjection]]
- [[Repository]]

## 📖 Resources
- Robert C. Martin: Clean Architecture
- Microsoft Docs: Architecture guidance for layered .NET applications

## 🧪 Practice Exercises
1. Take a controller that mixes validation, business rules, and persistence, then separate it into presentation, application, and infrastructure responsibilities.
2. Identify one place in a current project where a framework type leaks into core logic and describe how to move that dependency outward.

## 🔄 Review Schedule
- [ ] Review in 3 months
