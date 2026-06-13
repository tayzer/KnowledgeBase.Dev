# Specification
Date: 2026-06-13
Status: 🟢 Current
Tags: #design-patterns #architecture #specification #domain-driven-design #ocp

## 🎯 TL;DR / Quick Reference

**Definition:** A pattern that represents a business rule or filter as a separate object so rules can be combined, reused, and extended without changing the query or evaluator.

**When to use:**
- You have reusable filters or business rules that should be composed rather than hard-coded.
- Query logic or validation logic is growing into many named cases.

**Key Takeaways:**
- ✅ Put each rule in its own class or expression.
- ✅ Keep the evaluator stable and add new rules by creating new specifications.
- ✅ Specifications work well with repositories, query handlers, and in-memory validation.
- ⚠️ A specification should stay focused on one rule or a clear composite of rules.

**Code Snippet:**
```csharp
public interface ISpecification<T>
{
    Expression<Func<T, bool>> Criteria { get; }
}

public sealed class ActiveUserSpec : ISpecification<User>
{
    public Expression<Func<User, bool>> Criteria => user => user.IsActive;
}
```

**Gotchas:**
- ⚠️ Do not stuff every bit of query composition into one giant specification.
- ⚠️ If a rule is truly one-off, a named spec may be unnecessary ceremony.

---

## 📚 Deep Dive

### Conceptual Foundation
Specifications give a name and a home to business rules that would otherwise live as scattered predicates. That makes them easier to test, reuse, and combine. The evaluator or repository stays stable while new business rules are introduced as new spec classes or expressions.

### Common Uses
- Query filtering in repositories.
- Domain rule composition, such as eligibility or policy checks.
- Validation and search criteria that need to be reused across application layers.

### Relationship to Other Patterns
- **Repository** often evaluates specifications when retrieving data.
- **Plugin Pattern** can host a set of specifications when the system needs pluggable rules.
- **OCP** is the main design goal: add new rules by adding new specifications.

### Design Guidance
- Name the specification after the business rule it represents.
- Keep the evaluator generic and the rule logic encapsulated.
- Prefer composable specs over giant boolean expressions.

## 🔗 Related Concepts
- [[OCP]]
- [[Repository]]
- [[RepositoryUnitOfWork]]

## 📖 Resources
- Eric Evans: Domain-Driven Design
- Martin Fowler: Specification
- Ardalis.Specification

## 🧪 Practice Exercises
1. Extract three repeated predicate expressions into named specifications.
2. Add a new filter without changing the repository or query evaluator.

## 🔄 Review Schedule
- [ ] Review in 6 months