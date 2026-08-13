# JSON
Date: 2026-06-24
Status: Needs Review
Tags: #json #data-format #web-development #api-design

## TL;DR / Quick Reference

**Definition:** JSON, JavaScript Object Notation, is a text-based data interchange format for structured values such as objects, arrays, strings, numbers, booleans, and null.

**When to use:**
- When sending structured data between web clients, APIs, services, configuration files, or integration boundaries.

**Key Takeaways:**
- JSON is language-independent in practice, even though its syntax is based on JavaScript object notation.
- Common interview tasks involve parsing JSON, serializing responses, validating shape, and mapping between DTOs and domain objects.
- JSON has no comments, dates, binary type, or native distinction between integer and floating-point numbers.
- Treat external JSON as untrusted input: validate required fields, handle missing/null values, and avoid leaking sensitive data in responses.

---

## Deep Dive

### API Use

- Use stable field names and avoid leaking internal domain or database shapes accidentally.
- Keep response contracts backwards compatible where possible.
- Be explicit about nullable fields and optional fields.
- Prefer consistent error response shapes for validation and unexpected failures.

### JavaScript Use

- `JSON.parse(text)` converts JSON text into JavaScript values.
- `JSON.stringify(value)` converts JavaScript values into JSON text.
- Parsing can throw if the input is invalid, so handle errors at boundaries.

### .NET Use

- ASP.NET Core commonly serializes and deserializes JSON request/response bodies through `System.Text.Json`.
- Use DTOs at API boundaries and validate before passing data into domain logic.
- Be deliberate about casing, enum serialization, nullable reference types, and date/time formats.

## Related Concepts

- [[JavaScript Fundamentals]]
- [[API Versioning]]
- [[Backend for Frontend]]
- [[Areas/Data Systems/Data Models and Query Languages/_Index]]

## Review Schedule

- [ ] Review in 3 months
