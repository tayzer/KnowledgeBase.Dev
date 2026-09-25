# Technical Prep Plan

## Technical Signal Summary

Expect fast, practical exercises rather than a long architecture whiteboard. The recruiter explicitly mentioned SQL, C#, frontend languages, and browser coding tools such as JSFiddle and SQLFiddle. Your goal is to show calm problem solving: clarify, state assumptions, write a simple correct version, test edge cases, then explain tradeoffs.

## Must-Know Topics

| Topic | Why it matters for this role | KB link | Prep action |
| --- | --- | --- | --- |
| C# and OOP fundamentals | JD asks for strong object-oriented design and in-depth C#/.NET. | [[CSharp Fundamentals]], [[OOP Fundamentals]], [[SOLID]] | Practise small C# functions/classes out loud. Explain encapsulation, interfaces, composition, null handling, and error paths. |
| LINQ and collections | Live C# tasks often test data shaping. | [[LINQ]], [[CollectionTypes]], [[Dictionary]], [[HashSet]] | Practise grouping, sorting, deduping, filtering, and avoiding premature `ToList()`. |
| Async and cancellation | Enterprise .NET apps often depend on async I/O and resilience. | [[Async]] | Refresh `async`/`await`, exception flow, `Task.WhenAll`, cancellation tokens, and deadlock traps. |
| SQL joins, indexes, and query optimization | JD explicitly names SQL, TSQL, database design, and query optimization. | [[SQL Joins and Indexes]], [[Transactions and Isolation Levels]], [[QueryOptimisations]] | Practise joins, aggregate queries, `GROUP BY`, indexes, CTEs, transactions, and reading query intent. |
| Plain JavaScript | Recruiter mentioned JSFiddle and frontend languages. | [[JavaScript Fundamentals]] | Practise DOM selection, events, arrays, objects, JSON parsing, fetch, and simple rendering. |
| Unit testing and mocking | JD values unit testing and mocking. | [[MSTest]], [[Integration Testing ASP.NET Core]], [[Testing and Quality]] | Prepare to explain unit vs integration tests, mocks vs fakes, and what to test around a service method. |
| AI-assisted development | JD explicitly values AI-assisted development and LLM curiosity. | [[AI-Assisted Development]] | Practise your Azure DevOps REST + LLM workflow story and governance guardrails. |

## Should-Know Topics

| Topic | Why it matters for this role | KB link | Prep action |
| --- | --- | --- | --- |
| ASP.NET Core/MVC and JSON APIs | JD mentions MVC web frameworks and JSON. | [[MVC]], [[API Versioning]], [[Backend for Frontend]] | Refresh request/response flow, validation, DTOs, status codes, and JSON serialization. |
| DDD and service boundaries | Your CV uses DDD and microservices; they may probe it. | [[Domain-Driven Design]], [[Microservices]], [[Distributed Monolith]] | Prepare a pragmatic answer: boundaries from business capabilities, not tiny services by default. |
| SaaS and multi-tenant thinking | "Really stand out" includes SaaS; Dayforce is a cloud HCM platform. | [[Microservices]], [[API Gateway Pattern]] | Talk about tenant-aware data access, configuration, auditability, release safety, and backwards compatibility. |
| Code review and quality standards | Senior developer role expects daily quality influence. | [[Code Review Guidelines]] | Prepare your review checklist: correctness, maintainability, security, tests, observability, performance. |
| Frontend libraries | JD mentions Dojo, React, Angular, Backbone, jQuery. | [[JavaScript Fundamentals]] | Do not bluff Dojo. Use React/TypeScript hobby work and plain JS fundamentals as the bridge. |

## Optional Stretch Topics

| Topic | Why it might matter | KB link | Prep action |
| --- | --- | --- | --- |
| OAuth/OIDC | Employee/payroll systems often care about identity and permissions. | [[Security]] | Refresh high-level authn/authz distinction, scopes/claims, least privilege. |
| Observability | Payroll/tax defects need fast diagnosis. | [[Operations and Reliability]] | Mention logs, correlation IDs, metrics, traces, dashboards, and safe PII handling. |
| Feature flags | Your CV cites them and they are useful for SaaS release safety. | [[Microservices]] | Prepare a short answer on staged rollout, fallback, and cleanup discipline. |

## Mock Technical Questions

| Question | What they are testing | Strong answer shape |
| --- | --- | --- |
| Given a list of employees and departments, return active employees grouped by department and sorted by name. | C#, LINQ, data shaping, edge cases. | Clarify null/empty handling, choose `GroupBy`, sort deterministically, return a simple DTO shape. |
| Find duplicate payroll records by employee and pay period. | SQL grouping and correctness. | Use `GROUP BY employee_id, pay_period HAVING COUNT(*) > 1`, then join back if full rows are needed. |
| Why might this query be slow? | Query optimization. | Check predicate selectivity, indexes, joins, functions on columns, row count, execution plan, and whether the query returns too much data. |
| Build a small UI that filters rows as the user types. | JavaScript/DOM. | Store data array, listen to input event, normalize text, render matching rows, handle empty list. |
| How would you test a service that calculates payroll adjustments? | Unit testing/mocking. | Unit-test pure rules, integration-test persistence, include edge cases, avoid mocking the domain calculation itself if it should be deterministic. |
| How would you use AI safely in this team? | Practical AI judgement. | Use bounded tasks, approved tools, no sensitive data leakage, human review, test validation, and auditability. |

## Live-Coding Or System-Design Drills

### Drill 1: C# Data Shaping

- Timebox: 25 minutes.
- Scenario: You receive a list of timesheet entries with employee id, date, hours, and approved flag.
- Functional requirements:
  - Return total approved hours per employee for a date range.
  - Exclude unapproved entries.
  - Sort by highest total hours, then employee id.
- Non-functional requirements:
  - Handle empty input.
  - Avoid mutating the input.
  - Make the return shape easy to test.
- What good looks like:
  - Clear model/DTO names.
  - Straightforward LINQ or loop solution.
  - Edge cases said out loud before or during coding.
- Follow-up questions:
  - What changes if the data source is EF Core?
  - Where would you put indexes if this were SQL-backed?
  - How would you unit test this?
- KB links: [[LINQ]], [[CollectionTypes]], [[QueryOptimisations]]

### Drill 2: SQL Payroll Anomaly Query

- Timebox: 25 minutes.
- Scenario: Tables: `Employees(Id, DepartmentId, Status)`, `PayRuns(Id, PayDate)`, `PayRunLines(Id, PayRunId, EmployeeId, GrossPay, NetPay, TaxAmount)`.
- Functional requirements:
  - Find employees with more than one pay line in the same pay run.
  - Return employee id, pay run id, duplicate count, and total gross pay.
  - Optionally filter to active employees.
- Non-functional requirements:
  - Explain likely indexes.
  - Explain how you would inspect the execution plan.
- What good looks like:
  - Correct `JOIN`, `GROUP BY`, `HAVING COUNT(*) > 1`.
  - Clear reasoning about composite indexes such as `(PayRunId, EmployeeId)`.
- Follow-up questions:
  - How would you safely fix duplicates?
  - What isolation level or transaction concerns might exist?
- KB links: [[SQL Joins and Indexes]], [[Transactions and Isolation Levels]]

### Drill 3: JSFiddle Filtered List

- Timebox: 30 minutes.
- Scenario: Build a small page with a search box and a list of payroll products/features.
- Functional requirements:
  - Render an array of objects.
  - Filter by name as the user types.
  - Show a friendly empty state.
  - Keep rendering safe and readable.
- Non-functional requirements:
  - Keep data and render logic separate.
  - Avoid unnecessary global mutation.
- What good looks like:
  - `const`/`let`, `addEventListener`, `filter`, `map`, `textContent`, simple CSS.
  - Handles empty query and no results.
- Follow-up questions:
  - What would change in React?
  - How would you avoid rendering too much data?
  - How would you test it?
- KB links: [[JavaScript Fundamentals]], [[MVC]]

### Drill 4: Design Conversation

- Timebox: 20 minutes.
- Scenario: Design a feature that calculates and displays payroll tax warnings before a payroll run is finalized.
- Functional requirements:
  - Validate employee/payroll data.
  - Store warnings with enough audit context.
  - Expose warnings in a web UI.
- Non-functional requirements:
  - Correctness, explainability, auditability, performance, and privacy.
- What good looks like:
  - Start with domain questions.
  - Separate calculation rules from persistence and UI.
  - Mention test strategy, feature flags, observability, and PII-safe logs.
- Follow-up questions:
  - Which checks are synchronous vs asynchronous?
  - How do you version rules?
  - How do you validate results before rollout?
- KB links: [[Domain-Driven Design]], [[API Versioning]], [[Integration Testing ASP.NET Core]], [[AI-Assisted Development]]

## Local Setup Checklist

- [ ] Browser can open JSFiddle, SQLFiddle, SoloLearn, or equivalent.
- [ ] Teams screen sharing works on the intended monitor.
- [ ] Browser zoom set to a readable level for shared-screen coding.
- [ ] A scratch notes file is open with three reminders: clarify, test, explain.
- [ ] Keyboard shortcuts and clipboard are working.
- [ ] Have a fallback editor ready in case a browser editor behaves badly.

## Missing Or Thin KB Notes

- Created [[JavaScript Fundamentals]] for JSFiddle-style frontend refresh.
- Created [[AI-Assisted Development]] for AI tooling and governance framing.
- TSQL-specific interview drills remain a candidate future note; use [[SQL Joins and Indexes]] for now.
