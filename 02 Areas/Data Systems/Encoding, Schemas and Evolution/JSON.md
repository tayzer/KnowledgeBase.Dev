---
date: 2026-06-24
status: Current
tags:
  - json
  - data-format
  - web-development
  - api-design

---

# JSON

## Quick Reference

**Definition:** JSON, JavaScript Object Notation, is a text-based data interchange format for structured values such as objects, arrays, strings, numbers, booleans, and null.

**When to use:**
- When sending structured data between web clients, APIs, services, configuration files, or integration boundaries.

**Key Takeaways:**
- JSON is language-independent in practice, even though its syntax is based on JavaScript object notation.
- Common interview tasks involve parsing JSON, serializing responses, validating shape, and mapping between DTOs and domain objects.
- RFC 8259 JSON has no comments, date or binary type, and one number grammar; applications define numeric/date/binary conventions.
- Treat external JSON as untrusted input: validate required fields, handle missing/null values, and avoid leaking sensitive data in responses.

**Limit:** JSON needs application conventions for dates, binary values, numeric precision, and schema validation.

---

## Deep Dive

### API Use

- Use stable field names and avoid leaking internal domain or database shapes accidentally.
- Keep response contracts backwards compatible where possible.
- Be explicit about nullable fields and optional fields.
- Prefer consistent error response shapes for validation and unexpected failures.

### JavaScript Use

- `JSON.parse(text)` converts JSON text into JavaScript values.
- JSON.stringify attempts to serialize supported JavaScript values; it can return undefined or throw for BigInt and cyclic references without custom handling.
- Parsing can throw if the input is invalid, so handle errors at boundaries.

### .NET Use

- ASP.NET Core commonly serializes and deserializes JSON request/response bodies through `System.Text.Json`.
- Use DTOs at API boundaries and validate before passing data into domain logic.
- Be deliberate about casing, enum serialization, nullable reference types, and date/time formats.

## Interoperability and parser limits

RFC 8259 defines JSON values and grammar. It has no standard date or binary value; applications need a convention such as ISO 8601 strings or an explicit encoding. JSON numbers do not distinguish integer from floating-point syntax at the data-model level, and downstream numeric precision varies. JSON.stringify throws on BigInt values without custom handling and does not encode cyclic object graphs by default. Validate untrusted input and cap payload size.

## Sources

- [RFC 8259 JSON](https://www.rfc-editor.org/rfc/rfc8259) (accessed 2026-09-24).
- [ECMAScript JSON.stringify specification](https://tc39.es/ecma262/#sec-json.stringify) (accessed 2026-09-24).

## Related Concepts

- [[JavaScript Fundamentals]]
- [[API Versioning]]
- [[Backend for Frontend]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
