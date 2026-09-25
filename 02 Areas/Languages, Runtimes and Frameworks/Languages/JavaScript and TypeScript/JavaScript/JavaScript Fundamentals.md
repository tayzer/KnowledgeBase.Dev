---
date: 2026-06-24
status: Current
tags:
  - javascript
  - frontend
  - web-development

---

# JavaScript Fundamentals

## Quick Reference

**Definition:** JavaScript is a general-purpose language used in browsers and other host runtimes. In browsers it works with HTML, CSS, DOM APIs, JSON, and HTTP requests.

**When to use:**
- When building client-side interactions, validating inputs, manipulating the DOM, calling APIs, or writing JavaScript in another host runtime.

**Key Takeaways:**
- Know the language basics first: variables, types, arrays, objects, functions, conditionals, loops, and error handling.
- Browser-side JavaScript work often tests DOM selection, events, rendering, JSON parsing, and asynchronous network calls.
- State input assumptions, handle empty/null values, and keep functions small and readable.
- Understand `let`/`const`, equality, array methods, async/await, promises, event handlers, and how data moves between UI and API.

---

## Deep Dive

### Language and browser fundamentals

- **Data shaping:** map, filter, reduce, sort, group, deduplicate.
- **DOM interaction:** select elements, attach event listeners, update text/content/classes, render lists safely.
- **Async work:** call `fetch`, await responses, handle loading/error states, parse JSON.
- **Validation:** check required fields, ranges, formats, and edge cases before mutating state.
- **Debugging:** use console output deliberately, inspect errors, and reduce the problem to the smallest failing example.

### Implementation habits

- Repeat the problem back before coding.
- Start with a simple working version, then improve edge cases.
- Prefer clear names over clever one-liners.
- Test with at least one normal case, one empty case, and one awkward case.

### Common Traps

- Comparing with `==` when `===` is intended.
- Mutating arrays or objects when a copy would make the flow clearer.
- Forgetting that `fetch` only rejects on network failure, not on every HTTP error status.
- Accidentally treating strings, numbers, `null`, and `undefined` as interchangeable.
- Building HTML with untrusted strings without considering escaping or injection risk.

## Resources

- [Primary documentation](https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent) (accessed 2026-09-24; check version at source).


- MDN JavaScript Guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN Dynamic scripting with JavaScript: https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting

## Practice Exercises

- Given an array of employees, return active employees grouped by department and sorted by surname.
- Build a small DOM form that adds items to a list, prevents blank entries, and lets a user remove an item.
- Fetch JSON from a sample endpoint, render rows, and show a readable error if the request fails.

## Review refinements

Use strict equality unless coercion is deliberate. Promise callbacks run after the current synchronous execution. Treat untrusted text as data: prefer textContent for plain text and avoid innerHTML with untrusted strings. Browser DOM APIs are host APIs outside core ECMAScript; Node.js and other hosts differ. Keep interview prompts separate from durable reference guidance.

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Domains and Specialisms/Web Development/_Index]]
- [[Model-View-Controller]]
- [[Backend for Frontend]]
- [[API Versioning]]
- [[JSON]]

## Review Schedule

- [ ] Review 3 months after promotion; use the approval date as the anchor
