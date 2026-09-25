# Gap Log

## Missing Candidate Evidence

| Gap | Why it matters | Question for user | Status |
| --- | --- | --- | --- |
| Concrete mentoring/coaching story | Irek may probe line-manager fit and "tell me about a time when" examples. | Who is someone you helped onboard or improve, and what changed because of your support? | Needs user evidence |
| Conflict/disagreement story | Cultural fit interviews often test disagreement style. | What is a real disagreement you handled with an engineer, QA, product, or stakeholder? | Needs user evidence |
| Failure/mistake story | Senior candidates are often expected to show humility and learning. | What is a mistake you can discuss without breaching confidentiality? | Needs user evidence |
| Career path preference | Irek may ask ideal path. | Do you want senior IC, tech lead, staff/principal, engineering management, or a hybrid? | Needs user evidence |
| Deep frontend performance example | JD mentions high-performing UI controls. | Do you have a specific UI/control performance issue from Blazor, React, or another frontend? | Needs user evidence |
| TSQL-specific depth | JD names TSQL directly. | Have you written SQL Server stored procedures, CTEs, window functions, indexes, or execution-plan tuning recently? | Needs user evidence |

## Missing Or Thin KB Documentation

| Topic | Needed for | Existing note, if any | Action | Status |
| --- | --- | --- | --- | --- |
| JavaScript live-coding fundamentals | JSFiddle/frontend exercise prep. | None found under `Areas/Languages and Frameworks`. | Created `Areas/Languages and Frameworks/JavaScript/JavaScript Fundamentals.md`. | Done |
| AI-assisted development | JD AI-assisted development and LLM interest. | None found as a dedicated note. | Created `Areas/Developer Workflow/AI-Assisted Development.md`. | Done |
| TSQL interview drills | SQLFiddle/TSQL prep. | [[SQL Joins and Indexes]], [[Transactions and Isolation Levels]] | Use existing SQL notes for now; consider a focused TSQL note later. | Open |
| Frontend UI performance | High-performing UI controls. | [[Web Development Overlay]], [[JavaScript Fundamentals]] | Current prep is enough for interview; deeper note can wait. | Open |

## External Research Gaps

| Claim or topic | Why it matters | Source needed | Status |
| --- | --- | --- | --- |
| Dayforce info sheet | Recruiter specifically attached it. | User-supplied attachment or local file. | Missing |
| Interviewer public profiles | Could tailor questions and rapport. | LinkedIn pages supplied by recruiter. | Not inspected |
| Exact role page rendering | Primary job page was dynamic in browser extraction. | User local JD copy, or manual browser if needed. | Local JD available and sufficient |

## Prep Risks

| Risk | Mitigation | Owner | Status |
| --- | --- | --- | --- |
| Live coding nerves | Practise three short drills: C# data shaping, SQL duplicate query, JS filter UI. Narrate assumptions and edge cases. | Taylor | Open |
| Over-talking architecture in short exercises | Start with working code, then explain tradeoffs after. | Taylor | Open |
| Under-preparing frontend | Review [[JavaScript Fundamentals]] and do one JSFiddle-style exercise. | Taylor | Open |
| SQL/TSQL specificity | Practise joins, grouping, indexes, CTEs, transactions, query plans. | Taylor | Open |
| Behaviour answers too generic | Pick one concrete mentoring, conflict, and failure story before the call. | Taylor | Open |
| AI answer sounds too loose | Emphasize governance: approved tools, no sensitive data leakage, review, tests, and human accountability. | Taylor | Open |
