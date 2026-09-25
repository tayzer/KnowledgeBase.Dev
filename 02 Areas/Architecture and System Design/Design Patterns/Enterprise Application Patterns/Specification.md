---
date: 2026-06-13
status: Current
tags:
  - design-patterns
  - architecture
  - specification
  - domain-driven-design
  - ocp

---

# Specification

## Quick Reference

**Definition:** A pattern that represents a predicate or business rule as an explicit object or expression, allowing callers to test and sometimes compose rules.

**When to use:**
- You have reusable filters or business rules that should be composed rather than hard-coded.
- Query logic or validation logic is growing into many named cases.

**Key Takeaways:**
- Put each rule in its own class or expression.
- A reusable evaluator can reduce repeated rule logic; adding specifications may still require changes to composition and query translation.
- Specifications work well with repositories, query handlers, and in-memory validation.
- Caution: A specification should stay focused on one rule or a clear composite of rules.

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
- Caution: Do not stuff every bit of query composition into one giant specification.
- Caution: If a rule is truly one-off, a named spec may be unnecessary ceremony.

---

## Deep Dive

### Conceptual Foundation
Specifications give a name and a home to business rules that would otherwise live as scattered predicates. That makes them easier to test, reuse, and combine. The evaluator or repository stays stable while new business rules are introduced as new spec classes or expressions.

### Common Uses
- Query filtering in repositories.
- Domain rule composition, such as eligibility or policy checks.
- Validation and search criteria that need to be reused across application layers.

### Relationship to Other Patterns
- **Repository** often evaluates specifications when retrieving data.
- **Plugin Pattern** can host a set of specifications when the system needs pluggable rules.
- Composition can reuse and combine rules; it does not automatically satisfy the Open-Closed Principle or make every rule worth extracting.

### Design Guidance
- Name the specification after the business rule it represents.
- Keep the evaluator generic and the rule logic encapsulated.
- Prefer composable specs over giant boolean expressions.

### Combining specifications

For an in-memory example, `Eligible = Active.And(HasCredit)` evaluates both predicates; `Not()` and `Or()` compose further policies. For persistence, translating the expression to a query is an implementation choice and should be tested against the actual provider. A specification can encapsulate a domain rule, but it does not automatically make every rule open for extension or replace validation at the domain boundary. [Evans and Fowler's original paper](https://martinfowler.com/apsupp/spec.pdf) (undated; checked 2026-09-24).

## Related Concepts
- [[Open-Closed Principle]]
- [[Repository Pattern]]
- [[Unit of Work]]

## Resources
- Eric Evans: Domain-Driven Design
- Martin Fowler: Specification
- Ardalis.Specification

## Practice Exercises
1. Extract three repeated predicate expressions into named specifications.
2. Add a new filter without changing the repository or query evaluator.

## Sources

- [Eric Evans and Martin Fowler, Specifications](https://martinfowler.com/apsupp/spec.pdf) — undated author paper; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
