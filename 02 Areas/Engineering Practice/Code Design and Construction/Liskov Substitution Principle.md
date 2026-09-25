---
date: 2025-06-12
status: Current
tags:
  - design
  - architecture
  - solid
  - principles
  - lsp

---

# Liskov Substitution Principle (LSP)

## Quick Reference

**Definition:** Objects of a subtype must be substitutable for objects of their supertype without altering the correctness of the program.

**When to use:**
- Designing inheritance hierarchies or interface implementations.
- Validating that a new implementation truly satisfies a contract, not just its syntax.

**Key Takeaways:**
- Subclasses must honour the **behavioural contract** of the base type, not just compile against its signature.
- Preconditions cannot be strengthened; postconditions cannot be weakened.
- Throwing from an override violates substitutability when the base contract promised the operation would succeed for that input; exceptions allowed by the base contract are different.
- Prefer composition over inheritance when a subtype cannot fully substitute the base.

**Code Snippet:**
```csharp
// Avoid: Violates LSP — subtype strengthens preconditions and throws
public interface IFileWriter
{
    // Contract: append text to an existing or new file.
    void Write(string path, string content);
}

public class LocalFileWriter : IFileWriter
{
    public void Write(string path, string content)
        => System.IO.File.AppendAllText(path, content);
}

public class ReadOnlyFileWriter : IFileWriter
{
    public void Write(string path, string content)
        => throw new NotSupportedException("Read-only mode.");
}

// Any caller that works with IFileWriter will break when substituted with ReadOnlyFileWriter.

// Preferred: Preserve substitutability by separating capabilities
public interface IFileReader
{
    string Read(string path);
}

public interface IWritableFileStore : IFileReader
{
    void Write(string path, string content);
}

public sealed class LocalFileStore : IWritableFileStore
{
    public string Read(string path) => System.IO.File.ReadAllText(path);
    public void Write(string path, string content)
        => System.IO.File.AppendAllText(path, content);
}

public sealed class ReadOnlyFileStore : IFileReader
{
    public string Read(string path) => System.IO.File.ReadAllText(path);
}

// Callers that need writes depend on IWritableFileStore.
// Callers that only read depend on IFileReader.
```

**Gotchas:**
- Caution: **Syntactic vs behavioural conformance:** A class can compile as a subtype while violating invariants the base type's callers depend on.
- Caution: **Throwing in overrides:** An exception violates LSP when it breaks a guarantee the base contract gave to callers. Some contracts explicitly permit unsupported operations or documented errors.
- Caution: **Interface bloat causing LSP pressure:** Large interfaces force implementations to fake methods — prefer small interfaces ([[Interface Segregation Principle]]).

---

## Deep Dive

### Conceptual Foundation
Barbara Liskov introduced this principle in her 1987 keynote. The formal definition involves **behavioural subtyping**: a type `S` is a subtype of `T` if every property provable about `T` objects is also provable about `S` objects.

In practice, this means:
- **Invariants** established by the base type must be preserved.
- **Preconditions** (what callers must guarantee) cannot be made stricter in the subtype.
- **Postconditions** (what the method guarantees to callers) cannot be weakened.
- **History constraint:** subtype methods must not introduce side effects the base type would prohibit.

### Common Violations
| Violation | Description |
|---|---|
| Unexpected exception | Override throws for an input the base contract accepts |
| Weakened result guarantee | Returns a value outside the base contract or omits a promised effect |
| Ignored method | Override does nothing (e.g. `void Save() {}`) |
| Strengthened precondition | Subtype demands more from callers than base |
| Classic Rectangle/Square | Geometry doesn't map to IS-A; mutability breaks invariants |

### Relationship to Other Principles
- LSP supports **OCP** when polymorphic extensions preserve the contracts clients depend on; other design and testing concerns still matter.
- **ISP** can reduce pressure for implementations to fake unsupported methods; it does not guarantee LSP.
- Consumer contract tests can check analogous substitutability expectations at a service boundary, but service compatibility has additional protocol and deployment concerns.

### Design Test
Ask: "Can I replace every instance of the base type with this subtype and have the system still behave correctly?" If not, reconsider the inheritance relationship.

---

## Related Concepts
- [[SOLID Principles]]
- [[Open-Closed Principle]]
- [[Interface Segregation Principle]]
- [[Service Communication]]

## Resources
- [Barbara Liskov, *Data Abstraction and Hierarchy* (1987)](https://www.cs.tufts.edu/~nr/cs257/archive/barbara-liskov/data-abstraction-and-hierarchy.pdf) — author paper hosted by Tufts; accessed 2026-09-24.
- [ACM publication record](https://doi.org/10.1145/62138.62141) — 1987 keynote provenance; accessed 2026-09-24.
- Robert C. Martin, *Agile Software Development: Principles, Patterns, and Practices*, Chapter 10 — bibliographic background; edition/page not checked.

## Practice Exercises
1. Find an inheritance hierarchy in your codebase. Write a substitution test: swap the base with each subtype and verify all existing callers still behave correctly.
2. Identify an override that throws `NotImplementedException` and refactor it by splitting the interface or flattening the hierarchy.

## Review Schedule
- Review when a base contract changes or when an example is used to guide production code.
