# CPS Lead Developer Technical Interview Prep

Interview date: Wednesday 17 June 2026

## What the documents imply

The hands-on challenge is a live, screen-shared build exercise. They will give a specific requirement, expect a small software solution within a time limit, and assess more than whether the code "works".

They explicitly mention:

- General development skills
- Architecture approach
- Code structure
- Algorithms
- Data patterns
- Use of out-of-the-box software/framework modules
- Functional and non-functional requirements
- Communication and interaction during the challenge

The role spec points to a Lead Developer who can write strong C#/.NET code, make sensible architecture decisions, mentor others, uphold engineering standards, and operate in Azure/cloud-native delivery.

## Local readiness check

Already present:

- Visual Studio Professional 2022
- Visual Studio Web Development workload
- Visual Studio Azure/Cloud Development workload
- .NET SDK 8.0.415
- Node.js v22.16.0
- npm via `npm.cmd` v10.9.2

Needs attention:

- `azurite` is not currently available on PATH.
- Azure Functions Core Tools command `func` is not currently available on PATH.
- PowerShell blocks `npm.ps1`; use `npm.cmd` instead.

Recommended setup before the interview:

```powershell
npm.cmd install -g azurite
azurite --version
azurite --location C:\tmp\azurite --silent
```

Azure Functions Core Tools may be useful if the challenge asks for a Function App rather than a Web API. Visual Studio can create Function projects through the Azure workload, but the CLI is still useful:

```powershell
npm.cmd install -g azure-functions-core-tools@4 --unsafe-perm true
func --version
```

## Highest-value prep tonight

### 1. Practise one vertical slice in .NET 8

Do one timed rehearsal: 75 to 90 minutes.

Build a small API from scratch in Visual Studio or the CLI:

- `POST /cases`
- `GET /cases/{id}`
- `GET /cases?status=open`
- Store data in memory first, then swap to Azure Table Storage or a simple repository abstraction.
- Add validation, async methods, logging, and tests.

Keep the architecture modest. For a short challenge, a clean folder structure can be better than four projects:

```text
Api/
  Endpoints/
  Contracts/
Application/
  Services/
  Interfaces/
Domain/
  Entities/
Infrastructure/
  Repositories/
Tests/
```

Use separate projects only if the task size justifies it.

### 2. Rehearse your live-coding rhythm

Use this flow during the challenge:

1. Clarify requirements and NFRs.
2. State a simple design and tradeoffs.
3. Build the thinnest working slice.
4. Add validation and error handling.
5. Add persistence or integration.
6. Add tests.
7. Refactor only where it clearly improves readability.
8. Summarise what is done, what is missing, and what you would do next.

Say your reasoning out loud. They explicitly encourage interaction, so silence is costly.

### 3. Prepare three Civil Service behaviour stories

Have one strong STAR example for each:

- Leadership
- Changing and Improving
- Managing a Quality Service

Each story should include:

- Situation: one sentence of context
- Task: what you were accountable for
- Action: what you personally did
- Result: measurable outcome
- Reflection: what you learned or changed afterward

## What to show in the coding challenge

### Lead developer signals

Show that you can simplify ambiguity:

- "I will start with a thin working slice, then add persistence and tests."
- "For this timebox I will avoid unnecessary layering, but keep interfaces where they protect us from infrastructure changes."
- "I will validate at the API boundary and keep domain rules close to the domain model/service."
- "I will use framework features rather than custom plumbing where possible."

Show quality without gold-plating:

- Meaningful names
- Small methods
- DTOs separate from domain models where useful
- Dependency injection
- Options/configuration pattern
- Cancellation tokens on async work
- Sensible HTTP status codes
- Problem details or clear error responses
- Unit tests for rules
- Integration or endpoint tests if time allows
- README-style notes if something is unfinished

### Architecture decision template

When they give the requirement, answer in this shape:

```text
I understand the core requirement as [X].
The main edge cases I see are [Y].
I will implement [thin design] first so we have something working quickly.
If time allows, I will add [tests/persistence/observability/stretch].
For production I would also consider [security/resilience/scaling], but I will keep the interview solution focused.
```

### Clarifying questions to ask

Ask only a few. Good questions:

- What is the expected input and output shape?
- Should data persist after the app restarts?
- Are there any required Azure services or is local Azurite acceptable?
- What are the expected error cases?
- Are there performance, security, audit, or accessibility concerns I should prioritise?
- Is test coverage expected as part of the timebox?

## Mock CPS-flavoured practice challenge

Use this tonight if you want one rehearsal.

Build a .NET 8 API for case document intake.

Functional requirements:

- Create a case document record with `caseUrn`, `documentType`, `receivedAt`, and `status`.
- Return the created record with an id.
- Fetch a record by id.
- List records by status.
- Reject invalid records:
  - Missing `caseUrn`
  - Missing `documentType`
  - `receivedAt` in the future
  - Unknown status

Non-functional requirements:

- Clear API structure
- Async repository methods
- Logging
- At least 3 tests
- Persistence can start in memory; add Azure Table Storage if time allows.

Stretch goals:

- Duplicate detection by `caseUrn` and `documentType`
- Pagination on list endpoint
- Health check endpoint
- OpenAPI/Swagger polish
- `CancellationToken` through service/repository methods

## C#/.NET topics to refresh

Prioritise these:

- Minimal APIs vs controllers
- Dependency injection lifetimes
- `IOptions<T>`
- Async/await and cancellation
- Records vs classes for DTOs
- Validation approaches
- HTTP status codes and REST semantics
- Exception handling middleware/problem details
- `IHostedService` only if background work appears
- Unit tests with xUnit/NUnit and mocks/fakes
- Integration tests with `WebApplicationFactory` if comfortable
- Azure Table Storage or Blob Storage basics with Azurite

Also be ready to talk about:

- Clean Architecture
- Domain Driven Design boundaries
- SOLID principles, especially SRP and DIP
- TDD/BDD pragmatism
- CI/CD quality gates
- Secure coding and secrets/configuration
- Observability: logs, metrics, tracing, health checks

## Behaviour story prompts

### Leadership

Pick an example where you set direction, mentored developers, or raised standards.

Prompts:

- What technical direction did you set?
- How did you get buy-in?
- How did you coach others?
- What improved because of your leadership?

### Changing and Improving

Pick an example where you improved delivery, code quality, architecture, testing, or ways of working.

Prompts:

- What was inefficient or risky before?
- What change did you introduce?
- How did you handle resistance?
- What measurable improvement followed?

### Managing a Quality Service

Pick an example involving reliability, supportability, security, accessibility, or user impact.

Prompts:

- What service quality issue mattered?
- How did you balance speed and quality?
- What engineering practices did you use?
- How did you monitor or prove improvement?

## Questions to ask them

Good end-of-interview questions:

- What are the highest-priority engineering standards the Lead Developer will shape in DID?
- How are architecture decisions made across CPS software engineering teams?
- What does success look like in the first 6 months?
- How do teams balance delivery pressure with quality gates, security, and accessibility?
- What is the current Azure/.NET estate like, and where is it heading?
- How much of the role is hands-on coding versus technical leadership and line management?

## Tomorrow morning checklist

- Restart machine.
- Open Visual Studio once before the interview.
- Confirm `.NET 8` project creation works.
- Start Azurite and confirm it runs.
- Open a scratch folder for the challenge.
- Have an HTTP client ready.
- Have snippets/examples nearby, but do not rely on copy-pasting large code.
- Close distracting apps.
- Join Teams early and test screen sharing.

## During the challenge

Keep narrating:

- What you understand
- What assumption you are making
- What you are building first
- Why the design is proportionate
- What you are testing
- What you would harden for production

If you get stuck, say:

```text
I am going to simplify this path so we keep a working solution, then I will come back to the richer version if time allows.
```

That is a strong lead-developer move: protect delivery while staying transparent about tradeoffs.
