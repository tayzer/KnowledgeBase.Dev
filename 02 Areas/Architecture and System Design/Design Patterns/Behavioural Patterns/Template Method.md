---
date: 2026-06-13
status: Current
tags:
  - design-patterns
  - architecture
  - template-method
  - inheritance
  - polymorphism

---

# Template Method

## Quick Reference

**Definition:** A pattern that defines the skeleton of an algorithm in a base class and lets subclasses override specific steps without changing the overall flow.

**When to use:**
- The workflow is stable, but a few steps vary by subtype.
- You want to share the control flow while customizing parts of the behavior.

**Key Takeaways:**
- The base class owns the algorithm shape.
- Subclasses override only the variable steps.
- Useful when inheritance is a good fit and the shared workflow is real.
- Caution: If the steps start diverging too much, prefer Strategy or composition.

**Code Snippet:**
```csharp
public abstract class DataExporter
{
	public void Export()
	{
        Open();
        try
        {
            WriteHeader();
            WriteBody();
            WriteFooter();
        }
        finally
        {
            Close();
        }
	}

	protected virtual void Open() { }
	protected abstract void WriteHeader();
	protected abstract void WriteBody();
	protected virtual void WriteFooter() { }
	protected virtual void Close() { }
}

public sealed class CsvExporter : DataExporter
{
	protected override void WriteHeader() => Console.WriteLine("name,age");
	protected override void WriteBody() => Console.WriteLine("Alice,42");
}
```

**Gotchas:**
- Caution: Template Method can become rigid if the base class exposes too many hooks.
- Caution: Don’t use it just to avoid repeating two lines of code.

---

## Deep Dive

### Conceptual Foundation
Template Method is inheritance-based reuse. The base class controls the sequence, and the subclass fills in the variable parts.

### Practical Guidance
- Keep the invariant parts in the base class.
- Keep override points small and deliberate.
- Use protected hooks only when subclasses truly need them.

### Comparison With Alternatives
- Use **Strategy** when you want to swap the varying part without inheritance.
- Use **Decorator** when you want to add behavior around an operation.
- Use **Composition Over Inheritance** when the variation does not belong in a base class.

### Variation and cleanup

A second exporter can override `WriteHeader` and `WriteBody` while reusing the same sequence. The sample uses `try/finally` so `Close` runs when a write step throws. Production code should also define what happens if both the write and cleanup fail; `IDisposable` or `IAsyncDisposable` may fit real resources better than empty hooks. Source: [Template Method explainer](https://refactoring.guru/design-patterns/template-method) (secondary; checked 2026-09-24).

## Related Concepts
- [[Polymorphism]]
- [[Inheritance]]
- [[Strategy]]
- [[Decorator]]
- [[Composition Over Inheritance]]

## Resources
- Refactoring.Guru: Template Method
- GoF: Design Patterns

## Practice Exercises
1. Turn a repeated export workflow into a template method with two subclasses.
2. Replace a template method with Strategy and compare the design.

## Sources

- [Refactoring.Guru, Template Method](https://refactoring.guru/design-patterns/template-method) — secondary explainer, undated; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
