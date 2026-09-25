# Behaviour Story Bank

## Behaviour Criteria

- Communicates clearly with distributed and cross-functional teams.
- Drives quality and coding practices without being dogmatic.
- Works pragmatically across backend, database, frontend, QA, product, and operations.
- Shows curiosity and judgement around AI-assisted development.
- Cares about user value, not just technical elegance.
- Can describe career direction and collaboration style with a prospective line manager.

## Story Inventory

| Story | Best-fit behaviours | Evidence source | Confidence | Gaps |
| --- | --- | --- | --- | --- |
| Monolith to domain-aligned .NET services | Technical leadership, architecture, delivery improvement, tradeoff awareness | CV, TransUnion | High | Need vivid domain details if asked. |
| CI/CD and trunk-based development improvements | Change leadership, quality, developer productivity | CV, TransUnion and CallCredit | High | Need who you influenced and how you handled resistance. |
| Blazor A/B comparison tooling | User focus, QA collaboration, full-stack, privacy-aware tooling | CV, TransUnion | High | Need exact before/after workflow detail if possible. |
| AI tech debt workflow | Innovation, practical AI, automation, developer experience | CV, TransUnion | High | Need guardrails and review process detail. |
| .NET Aspire local distributed-system setup | Developer productivity, problem solving, ownership | CV, TransUnion | High | Need measurable impact if known. |
| Mentoring and onboarding two teams | Coaching, collaboration, culture fit | CV, TransUnion | Medium | Needs a named situation and outcome from memory. |
| TFVC to Git migration | Change leadership, source control, delivery maturity | CV, CallCredit | High | Need stakeholder/team adoption detail. |
| Out-of-hours SQL Server migrations and releases | Reliability, accountability, calm under pressure | CV, TransUnion | Medium | Need an incident or release example if asked. |

## STAR Stories

### Story: Monolith To Domain-Aligned Services

- Situation: At TransUnion, release cadence and change safety were constrained by a large C++/VB.NET/C# monolith.
- Task: Help move parts of the system into clearer, domain-aligned .NET services while improving delivery confidence.
- Action: Worked on service boundaries, .NET microservices in Service Fabric, automated integration testing, API versioning, feature flags, and supporting teams through the operational consequences.
- Result: Release cadence improved from quarterly toward weekly, and teams had clearer ownership and better release confidence.
- Reflection: Microservices were not "free". The improvement only worked because testing, versioning, deployment, and local development practices improved with the architecture.
- Tradeoff: More services created more operational complexity.
- Follow-up risks: Be ready to explain how you avoided a distributed monolith and how you decided boundaries were good enough.

### Story: CI/CD And Trunk-Based Development

- Situation: Feedback loops and integration risk were slowing teams down.
- Task: Improve release confidence and reduce the cost of integration.
- Action: Championed PR-gated CI/CD, trunk-based development practices, and pipeline redesign; earlier at CallCredit, helped move from TFVC to Git.
- Result: Pipeline runtime reduced by about 50%, feedback loops shortened, and downstream breaking-change issues reduced.
- Reflection: Quality gates only work when developers trust them. Fast, reliable checks change behaviour.
- Tradeoff: Gates need tuning so they catch meaningful risks without becoming theatre or slowing every change.
- Follow-up risks: Prepare one example of a check you removed, optimized, or moved to a better stage.

### Story: Blazor A/B Comparison Tooling

- Situation: QA comparison work around releases was slow and involved a legacy tool.
- Task: Improve comparison speed, usability, and data handling.
- Action: Replaced the legacy tool with CLI tools and a bundled Blazor report, including accepted difference handling, ignore rules, and PII data masking.
- Result: Cut comparison runtime by about 30 minutes and reduced validation effort by several hours per release.
- Reflection: Internal tools still need product thinking. The goal was not just faster code, but a workflow QA could trust.
- Tradeoff: Tooling adds maintenance responsibility, so the rules and output needed to be understandable.
- Follow-up risks: Be ready to describe how the report helped users make decisions.

### Story: AI-Assisted Tech Debt Workflow

- Situation: Technical debt items existed in Azure DevOps but turning them into actionable implementation work took effort.
- Task: Automate part of the workflow while keeping it structured and reviewable.
- Action: Used the Azure DevOps REST API to extract tech debt items, transform them into structured LLM prompts, and execute autonomous resolution through a custom background CLI tool.
- Result: CV confirms the workflow was engineered; do not claim a specific productivity metric unless you have one.
- Reflection: AI works best when the task has structure, context, and a verification path.
- Tradeoff: AI-generated changes need review, tests, and scope control. Sensitive data and secrets should not be casually put into prompts.
- Follow-up risks: If they ask "was it safe?", talk about boundaries, review, tests, and using AI as an accelerator rather than an authority.

### Story: Mentoring And Onboarding Teams

- Situation: Cross-functional and global teams needed support to work effectively in the codebase and delivery model.
- Task: Help engineers ramp up and keep implementation aligned with product and operational stakeholders.
- Action: Mentored engineers, onboarded two cross-functional teams including global teams, acted as tech lead for a month, contributed to hiring interviews, and aligned technical implementation with stakeholders.
- Result: CV confirms the mentoring/onboarding/tech lead activity. Add a concrete example from memory before the interview.
- Reflection: Senior engineering is partly creating clarity for others: conventions, context, tradeoffs, and feedback.
- Tradeoff: Supporting others takes time away from individual delivery, so the best support is reusable and empowering.
- Follow-up risks: Needs a real example of feedback, conflict, or growth. Do not invent one.

## Story-To-Question Map

| Likely question | Best story | Opening line | Follow-up angle |
| --- | --- | --- | --- |
| Tell me about yourself. | Opening pitch plus monolith/CI/CD evidence. | "My strongest fit is senior .NET engineering plus improving complex delivery systems." | Bridge to Dayforce payroll/tax quality. |
| Tell me about a time you led technical change. | Monolith to services or TFVC to Git. | "The change was not just technical; the team had to absorb new ownership and release practices." | Tradeoffs and stakeholder alignment. |
| Tell me about improving quality. | CI/CD and trunk-based development. | "I try to make the safer path the easier path." | Trusted gates, faster feedback, reduced breakage. |
| Tell me about building something for users. | Blazor A/B comparison tooling. | "The users were QA and release stakeholders, and the goal was to reduce validation effort." | PII masking and report usability. |
| Tell me about AI or emerging tech. | AI tech debt workflow. | "I used AI in a bounded developer-workflow context where output could be reviewed." | Governance and validation. |
| Tell me about mentoring. | Mentoring/onboarding teams. | "My strongest people evidence is mentoring, onboarding, tech lead cover, and hiring." | Needs one concrete person/team example. |
| Tell me about pressure or production responsibility. | SQL migrations/live releases. | "I have supported out-of-hours live releases, including SQL Server migrations and new product releases." | Calm communication, rollback, verification. |
| What is your ideal career path? | Career direction answer. | "I want to stay close enough to the code to make good technical decisions while growing my influence through technical leadership and mentoring." | Senior/staff/lead path; line management openness. |

## Gaps Requiring User Evidence

- A conflict/disagreement story with a teammate, QA, product, or stakeholder.
- A mistake/failure story with a clear learning loop.
- A mentoring story where someone improved because of your support.
- A customer/user empathy story outside internal QA tooling.
- A career-direction preference: senior IC, tech lead, staff/principal, engineering manager, or hybrid.

## Practice Prompts

- Give a 90-second version of the monolith modernization story.
- Give a 90-second version of the CI/CD improvement story.
- Explain the Blazor comparison tool to a non-technical manager.
- Explain your AI workflow without sounding reckless or gimmicky.
- Answer: "What do you want from your next manager?"
- Answer: "How do you like to receive feedback?"
- Answer: "What would your teammates say you are like to work with?"
