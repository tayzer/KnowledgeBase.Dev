---
date: "2026-08-13"
status: Current
tags: [taxonomy, backend-engineering]

---

# Backend Engineering

## Quick Reference

This category covers Application Structure, Request Processing, Middleware and Pipelines, Application Services, and more. Published notes and narrower categories are linked below.

## Category Boundary

Use this category for application-service wiring and request processing. Language/runtime-specific container behavior should be clearly scoped to .NET. The planned terms below are plain text until a canonical note is published.

## Published Notes

- [[Constructor Injection|Constructor Injection]] - Required dependencies are provided through a class constructor and stored for use during the object lifetime.
- [[Dependency Injection|Dependency Injection]] - A pattern where dependencies are provided to objects rather than created by them; commonly implemented via constructor injection, property injection, or method injection.
- [[Method Injection|Method Injection]] - A dependency is passed as a method parameter for a specific operation rather than stored on the class.
- [[Property Injection|Property Injection]] - Dependencies are assigned through settable properties after object construction.

## Subcategories

- No approved subcategories at this level.

## Published Leaf Extensions

### Dependency Injection
- [[Scoped Lifetime|Scoped Lifetime]] - One instance is created per scope. In ASP.NET Core, the default scope is one HTTP request.
- [[Singleton Lifetime|Singleton Lifetime]] - The container reuses one instance per service registration within its root provider; building multiple root providers can create multiple instances.
- [[Transient Lifetime|Transient Lifetime]] - A new instance is created every time the dependency is resolved.


## Planned Coverage

- Application Structure
- Request Processing
- Middleware and Pipelines
- Application Services
- Configuration
- Validation
- Error Handling
- File and Batch Processing

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Application Development/_Index|Application Development]]

## Review Schedule

- Review when a topic is published or the category boundary changes.
