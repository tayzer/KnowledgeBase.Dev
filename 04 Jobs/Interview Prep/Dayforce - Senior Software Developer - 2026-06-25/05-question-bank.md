# Question Bank

## Likely Technical Questions

| Question | What they are testing | Best answer frame | KB links |
| --- | --- | --- | --- |
| How would you solve this C# data transformation problem? | C# fluency, naming, edge cases, LINQ vs loops. | Clarify inputs, write simple version, test empty/null/duplicate cases, explain complexity. | [[CSharp Fundamentals]], [[LINQ]], [[CollectionTypes]] |
| Explain the difference between an interface and an abstract class. | OOP fundamentals. | Interface defines capability/contract; abstract class shares base behaviour/state. Prefer composition and small interfaces unless shared base behaviour is real. | [[OOP Fundamentals]], [[Composition Over Inheritance]] |
| How do you design a service method so it is testable? | Design and testing. | Keep business rules isolated, inject boundaries, avoid hidden static dependencies, return meaningful results, test pure logic separately from I/O. | [[DependencyInjection]], [[MSTest]] |
| Write a SQL query to find duplicates or aggregates. | SQL joins/grouping. | Use `GROUP BY` and `HAVING`; join back to get details; discuss indexes and uniqueness constraints. | [[SQL Joins and Indexes]] |
| How do you optimize a slow query? | Performance diagnosis. | Reproduce, inspect execution plan, check indexes/selectivity, avoid functions on indexed columns, reduce returned rows, verify with measurements. | [[SQL Joins and Indexes]], [[QueryOptimisations]] |
| How would you build a JS UI that filters rows? | Browser JavaScript, DOM, events. | Data array, input event, normalize filter, render safely, empty state, keep logic small. | [[JavaScript Fundamentals]] |
| What is your approach to unit testing and mocking? | Quality judgement. | Unit-test business rules; mock external boundaries; use integration tests for database/framework behaviour; avoid over-mocking the design. | [[MSTest]], [[Integration Testing ASP.NET Core]] |
| How have you used AI in development? | Practical AI use and judgement. | Use Azure DevOps REST + structured LLM prompts + CLI workflow; emphasize review, testing, and bounded scope. | [[AI-Assisted Development]] |
| How do you prevent breaking changes in a distributed system? | Senior engineering judgement. | API versioning, contract tests, integration tests, feature flags, observability, staged rollout, backwards-compatible schema changes. | [[API Versioning]], [[Microservices]] |

## Likely Leadership Or Behaviour Questions

| Question | What they are testing | Best story | Notes |
| --- | --- | --- | --- |
| Tell me about a time you improved a process. | Initiative and delivery impact. | CI/CD and trunk-based development. | Mention about 50% pipeline runtime reduction. |
| Tell me about a time you led a technical change. | Influence and tradeoffs. | Monolith to .NET services or TFVC to Git. | Do not sell microservices as universally good. |
| Tell me about a time you worked with a distributed team. | Communication and collaboration. | Onboarding two cross-functional/global teams. | Needs one concrete example from memory. |
| Tell me about a time you mentored someone. | Coaching and line-manager fit. | Mentoring/onboarding story. | Prepare real details. |
| Tell me about a difficult stakeholder or disagreement. | Conflict handling. | Needs user evidence. | Use facts, tradeoffs, alignment, and follow-up. |
| Tell me about a mistake or failure. | Humility and learning. | Needs user evidence. | Choose something safe but real. |
| What kind of culture do you thrive in? | Fit with Dayforce values. | Use transparency, shared ambition, agility, customer focus. | Tie to clear communication and practical quality. |
| What is your ideal career path? | Retention, motivation, line-manager fit. | Career direction answer. | Be honest about IC/lead/manager appetite. |

## Likely Company Or Motivation Questions

| Question | Answer angle | Source or evidence |
| --- | --- | --- |
| Why Dayforce? | The role combines enterprise .NET, payroll/tax correctness, full-stack product work, quality ownership, and AI-assisted development. | JD; Dayforce suite/technology/AI pages. |
| What interests you about payroll/tax software? | It is correctness-heavy, data-heavy, compliance-sensitive software where engineering quality has visible user and business impact. | JD; Dayforce product context. |
| What does "make work life better" mean to you as an engineer? | Build software that is reliable, understandable, privacy-aware, and efficient for the people using or supporting it. | Dayforce story. |
| How do you view AI in enterprise software? | Useful for automation and assistance when governed; not a replacement for domain understanding, testing, or accountable decisions. | JD; Dayforce AI page; GitHub responsible use docs. |
| How do you work with QA and product? | Bring them early into examples, acceptance criteria, test strategy, release risk, and internal tooling. | CV: QA comparison tooling, stakeholder alignment. |

## Questions To Ask Them

| Question | Why it is worth asking | Who to ask |
| --- | --- | --- |
| What kind of technical problems usually make payroll/tax software hardest to evolve? | Shows domain curiosity and seniority. | David/Philip/Irek |
| Where does the team most want a senior developer to raise the bar: SQL performance, UI controls, test strategy, architecture, or release safety? | Helps them picture your impact. | Irek |
| What does success look like for this role after six months? | Line-manager alignment. | Irek |
| How does the team currently use or govern AI-assisted development? | Directly relevant to JD and your CV. | Irek/David/Philip |
| How is the codebase split across backend, database, frontend, and shared platform concerns? | Calibrates full-stack expectations. | David/Philip |
| What is the team culture around code review and technical decisions? | Lets you discuss your quality style. | David/Philip |
| Has the Thoma Bravo acquisition changed product or engineering priorities since February 2026? | Current, informed, but neutral. | Irek |

## Questions To Avoid Or Handle Carefully

- Do not ask basic company facts that are on the Dayforce website.
- Do not lead with compensation or benefits in the final stage unless they raise it.
- Do not over-focus on Thoma Bravo as a concern. Ask neutrally about priorities and investment.
- Do not claim payroll/tax domain expertise you do not have. Frame it as an area you are ready to learn with care.
- Do not claim deep Dojo/Angular/Backbone experience unless you have it. Bridge through plain JavaScript, React/TypeScript hobby work, and fast learning.
