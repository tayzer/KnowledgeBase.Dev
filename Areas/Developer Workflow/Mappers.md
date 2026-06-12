# Mappers
Date: 2026-04-30
Status: 🟢 Current
Tags: #mapping #maintainability #architecture #clean-code

## 🎯 TL;DR / Quick Reference

**Definition:** Mappers translate data from one shape to another, such as DTOs to domain models or domain models to view models, without owning business rules or side effects.

**When to use:**
- When crossing boundaries between transport, application, domain, and persistence models.
- When object shapes differ but the transformation itself should remain mechanical and easy to test.

**Key Takeaways:**
- ✅ **Keep mappings mechanical:** direct property assignment and basic transformations belong here.
- ✅ **Keep mappings stateless:** they should depend on the source data, not ambient runtime context.
- ⚠️ **Do not hide business rules inside mappers:** once the mapper makes decisions based on user context, permissions, or application state, it is no longer just a mapper.

---

## 📚 Deep Dive

### What Belongs In A Mapper
1. **Direct property mapping:** Copy values from one object to another where the mapping is explicit and stable.
2. **Basic transformations:** Format strings, convert data types, or provide simple fallback values.
3. **Stateless operations:** Use only the input objects and deterministic transformation logic.

### What Does Not Belong In A Mapper
1. **Business logic:** Decisions, rules, or calculations that depend on domain meaning should live in the application or domain layer.
2. **External dependencies:** HTTP context, user session, service calls, repository access, and other runtime infrastructure should stay outside the mapper.
3. **Conditional logic based on application state:** Authorization checks, feature-flag checks, or workflow-state branches are application concerns.
4. **Side effects:** Database writes, file I/O, network calls, and event publication do not belong in mapping code.

### Why This Boundary Matters
Keeping mappers small and deterministic makes them easier to unit test, easier to review, and less likely to become a dumping ground for logic that should be explicit elsewhere. In layered designs, this boundary also protects the application layer from reaching into infrastructure concerns through “just one small mapping shortcut.”

## 🔗 Related Concepts
- [[CleanArchitecture]]
- [[DependencyInjection]]

## 🔄 Review Schedule
- [ ] Review in 3 months