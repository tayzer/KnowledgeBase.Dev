# Integration Testing ASP.NET Core
Date: 2025-11-25
Status: 🟢 Current
Tags: #testing #integration #aspnetcore #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** Integration tests exercise multiple components (controllers, middleware, filters, EF Core) together, typically using `WebApplicationFactory<TEntryPoint>` in ASP.NET Core.

**When to use:**
- Verify real request/response behavior, routing, filters, serialization, and DB interactions.

**Key Takeaways:**
- ✅ **Use `WebApplicationFactory`** for in-memory server tests.
- ✅ **Use `InMemory` or SQLite in-memory** for EF Core tests, but beware differences from production DB.
- ⚠️ **Avoid brittle tests** by focusing on behavior, not implementation details.

**Code Snippet:**
```csharp
using var factory = new WebApplicationFactory<Program>();
var client = factory.CreateClient();
var resp = await client.GetAsync("/api/orders");
resp.EnsureSuccessStatusCode();
```

**Gotchas:**
- ⚠️ **Database parity:** InMemory provider behaves differently (no relational constraints); use SQLite in-memory for closer behavior.
- ⚠️ **Test isolation:** Ensure each test uses a fresh DB or resets state.

---

## 📚 Deep Dive

### Approaches
- **In-memory host (`TestServer`)**: fast and isolated.
- **Real HTTP server**: slower but closer to production.
- **Database options**: InMemory, SQLite (in-memory), TestContainers with a real DB.

### Best Practices
- Use test doubles for external services (mocking or test harnesses).
- Seed deterministic test data and clean up after tests.

---

## 🔗 Related Concepts
- [[MsTest]]
- [[DockerDotNet]] (TestContainers)

## 📖 Resources
- Microsoft Docs: integration testing in ASP.NET Core

## 🧪 Practice Exercises
1. Create an integration test that posts an order and verifies it persisted in the DB.
2. Run the same tests against a TestContainer PostgreSQL and compare behavior.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
