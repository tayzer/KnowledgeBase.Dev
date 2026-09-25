---
date: 2025-11-25
status: Current
tags:
  - testing
  - dotnet
  - mstest
  - unittesting

---

# MSTest

## Quick Reference

**Definition:** MSTest is Microsoft's .NET test framework for unit and integration tests. Use attributes like `[TestClass]` and `[TestMethod]` to mark tests.

**When to use:**
- Project teams preferring Microsoft-first tooling or migrating legacy test suites.

**Key Takeaways:**
- **Attribute-driven** tests with clear structure.
- **Works in Visual Studio Test Runner and dotnet test**.
- Name like this: MethodName_Scenario_ExpectedBehaviour
- Tip: **Use data-driven tests:** `[TestMethod]` with `[DataRow]` handles inline cases; `[DynamicData]` supports generated cases.

**Code Snippet:**
```csharp
[TestClass]
public class CalculatorTests
{
    [TestMethod]
    public void Add_ReturnsSum()
    {
        var calc = new Calculator();
        Assert.AreEqual(4, calc.Add(2,2));
    }
}
```

**Gotchas:**
- Caution: **Async tests** should return `Task` or, with MSTest v3.3+, `ValueTask`; avoid `async void`.
- Caution: **Parallelization** behavior differs between frameworks; configure carefully.

---

## Deep Dive

### Features
- Test initialization/cleanup: `[TestInitialize]`, `[TestCleanup]`, `[ClassInitialize]`.
- Data-driven: `[TestMethod]` with `[DataRow]` or `[DynamicData]`; `[DataTestMethod]` remains supported.
- Test categories and filtering: `[TestCategory("Integration")]`.

### Best Practices
- Keep unit tests fast and isolated (use mocks for dependencies).
- Use `FluentAssertions` or similar for clearer assertions.

---

## Review refinements

Select MSTest packages and runner for the project version, then run dotnet test. Async tests should return Task or a ValueTask form supported by that MSTest version, never async void. Current MSTest supports TestMethod with DataRow for parameterized cases; DataTestMethod remains for compatibility. Configure parallel runs deliberately and isolate shared fixtures.

## Related Concepts
- [[ASP.NET Core Integration Testing]]
- [[Code Review Guidelines]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-mstest-intro) (accessed 2026-09-24; check version at source).

- [Microsoft Docs: MSTest](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-mstest-intro)

## Practice Exercises
1. Write unit tests for a service class with mocked repository dependencies.
2. Convert repeated tests to one `[TestMethod]` with several `[DataRow]` inputs.

## Review Schedule
- [ ] Review 6 months after promotion; use the approval date as the anchor
