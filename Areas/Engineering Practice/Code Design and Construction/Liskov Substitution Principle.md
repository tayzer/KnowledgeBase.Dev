# Liskov Substitution Principle (LSP)
Date: 2025-06-12
Status: Needs Review
Tags: #design #architecture #solid #principles #lsp

## 🎯 TL;DR / Quick Reference

**Definition:** Objects of a subtype must be substitutable for objects of their supertype without altering the correctness of the program.

**When to use:**
- Designing inheritance hierarchies or interface implementations.
- Validating that a new implementation truly satisfies a contract, not just its syntax.

**Key Takeaways:**
- ✅ Subclasses must honour the **behavioural contract** of the base type, not just compile against its signature.
- ✅ Preconditions cannot be strengthened; postconditions cannot be weakened.
- ✅ `NotImplementedException` in an override is an immediate LSP violation.
- ✅ Prefer composition over inheritance when a subtype cannot fully substitute the base.

**Code Snippet:**
```csharp
// ❌ Violates LSP — subtype strengthens preconditions and throws
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

// ✅ Preserve substitutability by separating capabilities
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
- ⚠️ **Syntactic vs behavioural conformance:** A class can compile as a subtype while violating invariants the base type's callers depend on.
- ⚠️ **Throwing in overrides:** Throwing `NotSupportedException` or `NotImplementedException` in an inherited method is always an LSP violation.
- ⚠️ **Interface bloat causing LSP pressure:** Large interfaces force implementations to fake methods — prefer small interfaces ([[Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle]]).

---

## 📚 Deep Dive

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
| Throws in override | Override throws where base never would |
| Narrowed return range | Returns subset of values the base contract advertises |
| Ignored method | Override does nothing (e.g. `void Save() {}`) |
| Strengthened precondition | Subtype demands more from callers than base |
| Classic Rectangle/Square | Geometry doesn't map to IS-A; mutability breaks invariants |

### Relationship to Other Principles
- LSP makes **OCP** safe — if subtypes aren't substitutable, extending via polymorphism breaks correctness.
- **ISP** prevents LSP violations by keeping interfaces small enough that no implementor needs to fake a method.
- Contract testing (consumer-driven contracts in microservices) is LSP applied at the service boundary level.

### Design Test
Ask: "Can I replace every instance of the base type with this subtype and have the system still behave correctly?" If not, reconsider the inheritance relationship.

---

## 🔗 Related Concepts
- [[Areas/Engineering Practice/Code Design and Construction/SOLID Principles]]
- [[Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle]]
- [[Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle]]
- [[Service Communication]]

## 📖 Resources
- Barbara Liskov — "Data Abstraction and Hierarchy" (1987 OOPSLA keynote)
- Robert C. Martin — *Agile Software Development: Principles, Patterns, and Practices*, Chapter 10

## 🧪 Practice Exercises
1. Find an inheritance hierarchy in your codebase. Write a substitution test: swap the base with each subtype and verify all existing callers still behave correctly.
2. Identify an override that throws `NotImplementedException` and refactor it by splitting the interface or flattening the hierarchy.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
