# API Versioning
Date: 2025-11-25
Status: 🟢 Current
Tags: #api #versioning #rest #aspnetcore

## 🎯 TL;DR / Quick Reference

**Definition:** Strategies and tools to evolve APIs without breaking existing clients (URI versioning, header versioning, media-type, query-string).

**When to use:**
- Public APIs with multiple clients or long-lived consumers.

**Key Takeaways:**
- ✅ **Prefer explicit versioning** from day one for public APIs.
- ✅ **Semantic version vs API version** — they serve different purposes.
- ⚡ **Deprecation policy**: communicate and support overlapping versions.

**Code Snippet (ASP.NET Core):**
```csharp
services.AddApiVersioning(options => {
    options.AssumeDefaultVersionWhenUnspecified = true;
    options.DefaultApiVersion = new ApiVersion(1,0);
});
```

**Gotchas:**
- ⚠️ **Model drift**: Keep backward-compatible DTOs or transform between versions.

---

## 📚 Deep Dive

### Versioning Schemes
- **URI path:** `/v1/orders` — simple, cache-friendly but couples URL to version.
- **Header:** `Accept` or custom header — cleaner URLs, harder to test manually.
- **Media type versioning:** version encoded in content type.

### Migration Strategies
- Use adapters or transformers in the API layer to map older DTOs to current models.
- Maintain a compatibility contract and automate contract tests.

### Tooling
- Microsoft.AspNetCore.Mvc.Versioning package supports multiple schemes and reporting.

---

## 🔗 Related Concepts
- [[API Versioning]] (this doc)
- [[CodeReviewGuidelines]]

## 📖 Resources
- Microsoft Docs: API versioning

## 🧪 Practice Exercises
1. Add API versioning to an existing ASP.NET Core app and implement v1 and v2 of a controller.
2. Write a contract test ensuring v1 clients still receive expected fields.

## 📝 Personal Notes

Very important to implement, especially in distributed systems. We dont want to force consumers to adopt new changes to things like behaviour and contracts. 

You can use things like API Managements built in versioning to support versioning.

## 🔄 Review Schedule
- [ ] Review in 6 months
