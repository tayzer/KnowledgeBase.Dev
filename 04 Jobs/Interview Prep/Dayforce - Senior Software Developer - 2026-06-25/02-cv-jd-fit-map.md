# CV To Job Description Fit Map

## Strongest Fit Signals

- 10+ years in software engineering, including Senior Software Engineer since January 2021.
- Deep C#/.NET background across modern .NET, ASP.NET Core, Blazor, APIs, testing, and Azure.
- Enterprise modernization evidence: decomposed a C++/VB.NET/C# monolith into domain-aligned .NET microservices.
- Delivery quality evidence: PR-gated CI/CD, trunk-based development, integration testing, API versioning, feature flags, pipeline runtime reduced by about 50%.
- SQL/data credibility: MySQL, Azure SQL, EF Core patterns, telemetry on slow queries, SQL Server migrations, query/performance awareness.
- Full-stack credibility: Blazor report tooling, React/TypeScript/Tailwind/Next.js hobby projects, HTML/CSS/JavaScript education and projects.
- Practical AI fit: automated AI workflow using Azure DevOps REST APIs, structured LLM prompts, and a custom background CLI tool.
- Team/culture fit: mentoring, onboarding two cross-functional teams, tech lead cover, hiring interviews, stakeholder alignment.

## Role Signal Map

| Job-description signal | What they need to hear | CV evidence | Story or example to use | Gap or risk | KB links |
| --- | --- | --- | --- | --- | --- |
| In-depth C# and .NET | You can write maintainable C# and reason about OOP, async, LINQ, APIs, and .NET application structure. | C# 14, .NET 8/10, ASP.NET Core, Blazor, OpenAPI, Service Fabric. | Monolith to .NET services; Blazor report tooling. | Refresh live-coding fundamentals so you do not over-index on architecture. | [[CSharp Fundamentals]], [[LINQ]], [[CollectionTypes]], [[NullableReferenceTypes]] |
| SQL, TSQL, database design, query optimization | You understand relational modeling, joins, indexes, transactions, migrations, and performance diagnosis. | MySQL, Azure SQL, EF Core patterns, telemetry on slow queries, SQL Server migrations. | Slow-query telemetry; out-of-hours SQL Server migration support. | TSQL specifics are not prominent in CV. Refresh SQL Server syntax and execution-plan vocabulary. | [[SQL Joins and Indexes]], [[Transactions and Isolation Levels]], [[QueryOptimisations]], [[Relational Databases]] |
| Full-stack web development | You can move across backend, UI, APIs, and JSON without friction. | Blazor comparison report; React/TypeScript/Tailwind/Next.js hobby projects; HTML/CSS/JS education. | A/B comparison tooling with bundled Blazor report. | Commercial frontend depth may be weaker than backend depth. Frame honestly as active and credible exposure. | [[JavaScript Fundamentals]], [[MVC]], [[Web Development Overlay]], [[Backend for Frontend]] |
| High-performing UI controls | You think about responsiveness, data size, rendering cost, and user workflows. | Blazor report made QA comparisons easier and cut validation effort by several hours per release. | Comparison report with accepted differences, ignore rules, and PII masking. | Need user evidence if asked for a deep low-level UI performance example. | [[JavaScript Fundamentals]] |
| Object-oriented design and development | You can model behaviour, choose abstractions, and avoid over-engineering. | DDD, Clean Architecture, microservices, service boundaries, C#/.NET. | Domain-aligned service extraction from monolith. | Avoid sounding dogmatic about microservices. | [[OOP Fundamentals]], [[SOLID]], [[Domain-Driven Design]], [[Microservices]] |
| Scalable/high-performing applications | You balance performance, operability, deployment, and data access. | Service Fabric, API Management, Service Bus, App Insights, pipeline optimization, distributed system local dev. | Microservices tradeoff story; .NET Aspire local development story. | Be specific about bottlenecks and measurement when possible. | [[Microservices]], [[Distributed Monolith]], [[API Gateway Pattern]] |
| Unit testing and mocking | You make quality repeatable and know when to use unit vs integration tests. | TDD, BDD, Reqnroll/SpecFlow, MSTest, automated integration testing. | CI/CD + integration testing story; BDD tests across domains. | Refresh mocking terminology and small test examples. | [[MSTest]], [[Integration Testing ASP.NET Core]], [[Testing and Quality]] |
| Agile distributed team | You can collaborate with QA, PMs, writers, global teams, and stakeholders. | Onboarded two cross-functional teams including global teams; stakeholder alignment. | Mentoring/onboarding story. | Prepare one concrete communication or conflict story. | [[Code Review Guidelines]], [[Engineering Approaches]] |
| AI-assisted development | You have practical examples and sensible guardrails. | Azure DevOps REST API to extract tech debt, transform into LLM prompts, execute via CLI tool. | AI workflow story. | Be ready to discuss governance, validation, and avoiding overreliance. | [[AI-Assisted Development]] |
| SaaS products | You understand multi-customer software, reliability, release safety, and operational impact. | Enterprise software at TransUnion/CallCredit; microservices; APIs; CI/CD; production releases. | Release cadence from quarterly to weekly. | CV does not explicitly say SaaS product ownership. Bridge to enterprise platform experience. | [[API Versioning]], [[Microservices]] |

## Opening Pitch

```text
I am a senior software engineer with a strong C# and .NET background, and my best work has been around improving complex enterprise systems while keeping delivery practical. At TransUnion I have worked on decomposing legacy C++/VB.NET/C# systems into clearer .NET services, improving CI/CD and trunk-based development, and tightening quality through integration testing, API versioning, feature flags, and better local development tooling.

What stands out about this Dayforce role is the mix of hands-on product engineering, payroll and tax domain complexity, full-stack work, and modern engineering practices. I can bring strong backend and database experience, enough frontend exposure to work productively across the stack, and a practical view of AI-assisted development because I have already used LLM workflows and automation to tackle technical debt in an enterprise context.
```

## Evidence Bank

| Evidence | Source | Strongest uses | Notes |
| --- | --- | --- | --- |
| Increased release cadence from quarterly to weekly by decomposing a mixed-language monolith into domain-aligned .NET microservices. | CV, TransUnion | Senior ownership, architecture, delivery improvement, scalable systems. | Mention the tradeoff: microservices added operational complexity. |
| PR-gated CI/CD and trunk-based development; pipeline runtime reduced by about 50%. | CV, TransUnion | Quality, agile delivery, developer productivity. | Good for "tell me about improving a process". |
| Automated integration testing, API versioning, feature flags. | CV, TransUnion | Release safety, quality, distributed systems. | Strong payroll/tax bridge because change safety matters. |
| Blazor A/B comparison report with accepted differences, ignore rules, PII masking, 30-minute runtime cut, several hours validation effort saved per release. | CV, TransUnion | Full-stack, UI controls, QA collaboration, user value, privacy. | Strongest frontend/productivity story. |
| AI workflow using Azure DevOps REST API, structured LLM prompts, custom background CLI tool. | CV, TransUnion | AI-assisted development, internal tools, emerging technology. | Strong standout for Dayforce JD. |
| .NET Aspire solution for distributed local development. | CV, TransUnion | Developer experience, distributed systems, pragmatic tooling. | Good for "tools for other developers". |
| Mentored engineers, onboarded two cross-functional teams including global teams, acted as tech lead for one month, contributed to hiring. | CV, TransUnion | Culture fit, communication, line-manager conversation. | Needs specific user memory for a vivid people story. |
| TFVC to Git migration and trunk-based development at CallCredit. | CV, CallCredit | Change leadership, process improvement, team influence. | Strong backup story. |
| OAuth/OpenID Connect rollout contribution. | CV, CallCredit | Security awareness, APIs. | Good if sensitive employee data comes up. |

## Gaps Requiring User Evidence

- A specific "tell me about a time you disagreed with someone" story.
- A specific failure or mistake story with what you changed afterward.
- A formal or informal coaching story where someone improved because of your feedback.
- A product/customer story that shows empathy for end users, not just engineering quality.
- A career-path answer: hands-on senior IC, tech lead, staff/principal track, or line management interest.

## Risk Handling

| Risk | Honest framing | Follow-up prep |
| --- | --- | --- |
| Frontend depth | "My deepest commercial experience is .NET/backend, but I have delivered Blazor UI tooling and kept current with React, TypeScript, Tailwind, Next.js, and plain JavaScript practice." | Practise JSFiddle-style DOM, arrays, events, JSON, and fetch. |
| TSQL depth | "Most of my recent data work has been MySQL/Azure SQL/EF Core plus SQL Server migrations, but the relational fundamentals transfer: modeling, joins, indexing, transactions, query plans, and safe migrations." | Refresh TSQL syntax, CTEs, window functions, indexes, transactions. |
| Payroll/tax domain | "I would expect correctness, auditability, edge cases, and regression safety to be central in payroll/tax. I would lean heavily on domain examples, tests, and careful release controls." | Prepare examples of careful data handling and migration/release support. |
| AI overclaiming | "I have used AI practically for developer workflows; I would still keep review, testing, data controls, and human accountability around it." | Use the Azure DevOps REST + LLM prompt workflow. |
| Line management | "My strongest evidence is mentoring, onboarding, tech lead cover, hiring, and stakeholder alignment. If the role grows into line management, I would bring structure, empathy, and clarity." | Prepare one concrete mentoring/coaching story. |
