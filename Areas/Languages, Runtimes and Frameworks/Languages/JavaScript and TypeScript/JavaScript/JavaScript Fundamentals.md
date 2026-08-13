# JavaScript Fundamentals
Date: 2026-06-24
Status: Needs Review
Tags: #javascript #frontend #web-development #interview-prep

## TL;DR / Quick Reference

**Definition:** JavaScript is the browser scripting language used to add behaviour to web pages and web applications, commonly alongside HTML, CSS, browser APIs, JSON, and HTTP requests.

**When to use:**
- When building client-side interactions, validating inputs, manipulating the DOM, calling APIs, or preparing for frontend live-coding exercises.

**Key Takeaways:**
- Know the language basics first: variables, types, arrays, objects, functions, conditionals, loops, and error handling.
- Browser-side JavaScript work often tests DOM selection, events, rendering, JSON parsing, and asynchronous network calls.
- Avoid overcomplicating interview answers. State assumptions, handle empty/null inputs, and keep functions small and readable.
- Be ready to explain `let`/`const`, equality, array methods, async/await, promises, event handlers, and how data moves between UI and API.

---

## Deep Dive

### Interview Core

- **Data shaping:** map, filter, reduce, sort, group, deduplicate.
- **DOM interaction:** select elements, attach event listeners, update text/content/classes, render lists safely.
- **Async work:** call `fetch`, await responses, handle loading/error states, parse JSON.
- **Validation:** check required fields, ranges, formats, and edge cases before mutating state.
- **Debugging:** use console output deliberately, inspect errors, and reduce the problem to the smallest failing example.

### Live-Coding Habits

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

- MDN JavaScript Guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN Dynamic scripting with JavaScript: https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting

## Practice Exercises

- Given an array of employees, return active employees grouped by department and sorted by surname.
- Build a small DOM form that adds items to a list, prevents blank entries, and lets a user remove an item.
- Fetch JSON from a sample endpoint, render rows, and show a readable error if the request fails.

## Related Concepts

- [[Areas/Domains and Specialisms/Web Development/_Index]]
- [[Areas/Application Development/Frontend and UX Engineering/UI Composition/Model-View-Controller]]
- [[Backend for Frontend]]
- [[API Versioning]]
- [[JSON]]

## Review Schedule

- [ ] Review in 3 months
