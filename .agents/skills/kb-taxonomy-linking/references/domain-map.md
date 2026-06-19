# Domain Map

## Current Top-Level Areas
- `Areas/Architecture and Patterns/`: architecture, system design, architectural styles, design patterns, design principles, integration, messaging, concurrency, frontend architecture, and anti-patterns.
- `Areas/Cloud and Delivery/`: cloud services, deployment, containers, serverless delivery, CI/CD-adjacent cloud workflows, and production delivery mechanics.
- `Areas/Data and State/`: relational databases, NoSQL systems, caching, cloud storage, data warehouses, persistence, state management, query design, and data modeling tradeoffs.
- `Areas/Developer Workflow/`: code review, maintainability habits, local tooling, command-line workflow, source control, automation, mapping, configuration, and general engineering approaches.
- `Areas/Domain Overlays/`: domain-specific overlays such as web development and game development that bridge multiple horizontal areas.
- `Areas/Languages and Frameworks/`: programming languages, runtimes, frameworks, .NET, C#, language features, framework-specific APIs, and SDK usage.
- `Areas/Operations and Reliability/`: monitoring, alerting, incident response, SLO/SLA thinking, production operations, reliability practices, and runbooks.
- `Areas/Security/`: secure design, authentication, authorization, secrets, dependency risk, threat modeling, vulnerability mitigation, and hardening guidance.
- `Areas/Testing and Quality/`: unit, integration, contract, end-to-end, regression, QA strategy, testability, and verification guidance.

## Legacy-To-Current Mapping
- `Areas/DotNet/` -> `Areas/Languages and Frameworks/`
- `Areas/Patterns/` -> `Areas/Architecture and Patterns/`
- `Areas/Data Stores/` -> `Areas/Data and State/`
- `Areas/DevOps/` -> `Areas/Cloud and Delivery/` or `Areas/Operations and Reliability/`, depending on whether the topic is delivery or runtime reliability.
- `Areas/CodingPractices/Testing/` -> `Areas/Testing and Quality/`
- `Areas/CodingPractices/` -> `Areas/Developer Workflow/` for non-testing maintainability and workflow topics.
- `Areas/SourceControl/` -> `Areas/Developer Workflow/`
- `Areas/GameDev/` -> `Areas/Domain Overlays/` when the topic is domain context, or the strongest horizontal area when it is a reusable engineering concept.

## Placement Heuristics
- Choose the area that best matches the primary question a reader would ask.
- Prefer the current taxonomy for new notes, even if nearby legacy references still exist.
- If a topic spans two areas, place it in the strongest primary area and bridge the rest with wikilinks.
- Prefer updating an existing note over creating a sibling note with overlapping scope.
- Extend the taxonomy with the smallest viable subfolder before proposing a new top-level area.
- During migration, move existing notes only when touched or reviewed, and leave temporary redirect stubs if backlink stability requires them.