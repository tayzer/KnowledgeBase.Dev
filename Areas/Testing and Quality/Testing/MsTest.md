# MSTest (Unit Testing)
Date: 2025-11-25
Status: 🟢 Current
Tags: #testing #dotnet #mstest #unittesting

## 🎯 TL;DR / Quick Reference

**Definition:** MSTest is a unit testing framework for .NET (Microsoft's original test framework). Use attributes like `[TestClass]` and `[TestMethod]` to mark tests.

**When to use:**
- Project teams preferring Microsoft-first tooling or migrating legacy test suites.

**Key Takeaways:**
- ✅ **Attribute-driven** tests with clear structure.
- ✅ **Works in Visual Studio Test Runner and dotnet test**.
- Name like this: MethodName_Scenario_ExpectedBehaviour
- ⚡ **Use data-driven tests** (`[DataTestMethod]`, `[DataRow]`) for parameterized cases.

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
- ⚠️ **Async tests** must return `Task`.
- ⚠️ **Parallelization** behavior differs between frameworks; configure carefully.

---

## 📚 Deep Dive

### Features
- Test initialization/cleanup: `[TestInitialize]`, `[TestCleanup]`, `[ClassInitialize]`.
- Data-driven: `[DataTestMethod]`.
- Test categories and filtering: `[TestCategory("Integration")]`.

### Best Practices
- Keep unit tests fast and isolated (use mocks for dependencies).
- Use `FluentAssertions` or similar for clearer assertions.

---

## 🔗 Related Concepts
- [[IntegrationTestingAspNet]]
- [[Code Review Guidelines]]

## 📖 Resources
- Microsoft Docs: MSTest

## 🧪 Practice Exercises
1. Write unit tests for a service class with mocked repository dependencies.
2. Convert a set of tests to use data-driven `[DataTestMethod]`.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
