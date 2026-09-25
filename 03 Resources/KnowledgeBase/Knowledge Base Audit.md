---
date: 2026-09-24
status: Implemented
tags:
  - knowledge-base
  - audit
  - information-architecture
---

# Software Engineering Knowledge Base Audit

## Outcome

The audit was approved and implemented on 2026-09-24 with the corrected scope: keep all 13 top-level areas, 159 approved category indexes, and planned-only categories. No category folder was removed. The ten separate migration-source directory paths remain for a later provenance-based decision. The inventory and note-by-note actions below record the baseline and proposed work; the implementation record below states what changed.

## Implementation record (2026-09-24)

- Moved `Caching Strategies.md` to `State, Coordination and Workflows/Caching and Ephemeral State`, and `Data Lakes.md` and `Data Warehouses.md` to `Data Systems/Analytics and Data Processing`. Existing category folders remain. Index links now expose the moved notes at their canonical homes.
- Converted all 126 `Areas/` topic notes and 159 category indexes to Obsidian `date`, `status`, and `tags` properties with plain headings. Preserved existing dates and tags; all topic notes remain `Needs Review`. Removed decorative markers from live headings, bullets, examples, and guidance.
- Added canonical Software Engineering Reference Note, Category Index, and Inbox Capture templates under the vault's configured `00 System/Templates/` folder. Updated standards, agent guidance, template skill, taxonomy rules, generator, and validator. The user configured the shared Templates folder; this task did not edit `.obsidian` settings.
- Generated links with short Quick Reference descriptions for all 126 published topics and leaf-extension routes across all 159 indexes, while retaining planned coverage as plain text. Published topics no longer appear as planned topics. Clarified six overlapping category boundaries.
- Repaired damaged definitions, placeholder titles, broken SOLID and OCP Markdown links, and malformed Azurite content. Preserved its interview-specific wording in `Resources/KnowledgeBase/Azurite Historical Interview Capture.md`. Replaced the long migrated `Software Engineering Laws.md` material with a concise reference and retained the original wording and images in `Resources/KnowledgeBase/Software Engineering Laws Historical Capture.md` for attribution and image-rights review.
- Corrected a ranked subset of Azure messaging, EF Core, MySQL, and SQL index claims against primary documentation. Source URLs and check dates are in the touched notes. This is targeted verification, not a whole-note fact check; all notes remain `Needs Review`.
- `Validate-KnowledgeBase.ps1 -Strict` passes with zero errors and warnings after the index refresh. In Obsidian, opened the Analytics and Data Processing index and followed its Data Lakes link to the moved note. After the user configured `00 System/Templates`, the template picker listed all three Software Engineering templates. Inserting the Reference Note into a scratch note produced the expected date, `Needs Review` status, tags list, title, and required headings. The scratch note was removed. The guide's cross-vault Reference Note link also opened the template in Obsidian.

## Scope and method

The inventory, proposed actions, and path map in the sections below preserve the preimplementation audit. Read them alongside the implementation record above.

Reviewed all `Areas/` topic notes and category indexes; compared each folder and leaf extension with the approved taxonomy and migration ledger. Checked names, conceptual boundaries, nesting, note placement, metadata, headings, and links. Eleven selected technical claims were checked against primary documentation. This is a risk-ranked sample, not a full technical verification of every note. The historical migration ledger and source archive remain evidence, not live navigation.

Baseline on 2026-09-24: 126 topic notes, 159 `_Index.md` files, 197 directories beneath `Areas/`, 29 registered content-bearing leaf extensions, and 10 legacy directory paths outside the taxonomy (nine directly empty, one containing only an empty child). All 126 topic notes say `Needs Review`; none has YAML frontmatter. `Validate-KnowledgeBase.ps1 -Strict` reports zero errors and warnings under its current rules.

## Findings

| Priority | Finding | Evidence and action |
| --- | --- | --- |
| Immediate | Published notes are absent from navigation. | No topic note has a wikilink in any category index. All 74 topic notes directly in category folders are unlisted; 52 more sit in leaf extensions. Generate indexes from actual published files and link extensions from their parent indexes. |
| Immediate | Some text and links are damaged. | `Microservices.md:8` and `Event-Driven Architecture.md:8` have links spliced into definitions. `Coupling.md` and `Software Engineering Laws.md` have spaced-letter placeholders. `Azurite.md` repeats synthetic reference material and mixes interview/machine-specific instructions into a reusable note. Repair these by reading source content, not by blind replacement. |
| Immediate | Existing link validation misses Markdown links. | Twelve broken relative Markdown-link occurrences: ten `SRP.md`/`OCP.md`/`LSP.md`/`ISP.md`/`DIP.md` references in `SOLID Principles.md`, plus two obsolete `V2/Design Patterns` paths in `Open-Closed Principle.md`. Replace with links to canonical notes and extend validation to local Markdown links. |
| High | Folder structure is broadly coherent; index text is the main weakness. | The 13 approved areas separate disciplines. The 95 indexes without published descendants represent planned categories, not obsolete folders. Three areas have no topic notes yet: Reliability and Operations, Security and Privacy, and Software Delivery and Evolution. Retain all of them and make the published/planned distinction clear in navigation. |
| High | A few topic placements cross category boundaries. | `Caching Strategies.md` explains application and distributed caching but sits under Streaming and Derived Data; `Data Lakes.md` and `Data Warehouses.md` describe analytics storage but sit there too. Review those note homes against the existing Caching and Ephemeral State and Analytics and Data Processing categories. Keep the category folders. |
| Medium | Some adjacent categories need explicit scope. | Frontend Architecture vs Frontend and UX Engineering; Engineering Process vs Planning and Estimation; provider-agnostic Data Access vs Entity Framework Core. Add boundary sentences and cross-links in their indexes before considering a rename or merge. |
| Medium | Ten local directory paths appear to be migration remnants. | They have no Markdown files, are outside the approved manifest, and their former note paths map to current homes in the migration ledger. This is provenance evidence, not a rule to remove empty planned categories. Verify each local path before any targeted cleanup. |
| High | Content depth and provenance vary. | 27 topic notes have fewer than 200 words; ten have no `Deep Dive` heading; 12 have one or fewer wikilinks. Only 13 topic notes contain a web URL, though absence of a URL alone does not prove a claim unsupported. Deepen decision-heavy and vendor notes first. |
| Medium | Metadata and guidance disagree. | `Areas/` stores `Date`, `Status`, and `Tags` as body lines; templates and standards use decorative icons; generated indexes use plain headings while their generator still emits icon status values. Use one icon-free Obsidian-property contract and update generator, guidance, skills, and validator together. |
| Medium | Current validator misses navigation failures. | It requires the approved 159 indexes, 729 terminal occurrences, and 13 areas, but checks neither local Markdown links nor whether indexes expose published notes. Retain those taxonomy expectations and add checks for usable navigation. |

The full note-by-note actions and folder inventory appear below. `Keep` means retain the present canonical draft, not certify factual accuracy. No duplicate pair is clear enough to merge without an editorial comparison. In particular, scope `Unit of Work` around transaction boundaries while linking to `Repository Pattern`; distinguish Service-Based Architecture from SOA rather than merging them by name alone.

## Folder and subfolder assessment

**Verdict:** keep the 13 approved top-level areas, the 159 taxonomy category indexes, and the 29 registered content-bearing leaf extensions. A planned category is valid even when no note has been published beneath it. This audit found no approved category whose name or boundary is clearly obsolete. Its strongest structural improvement is clearer index scope and direct links to published notes, not a smaller tree. The 95 indexes without published descendants should remain marked as planned navigation.

| Area | Topic notes | Category indexes | Structural assessment |
| --- | ---: | ---: | --- |
| Application Development | 9 | 10 | Keep: application surfaces and engineering concerns have a clear home. |
| Architecture and System Design | 26 | 28 | Keep: styles, distributed systems, patterns, and domain design are distinct branches. Clarify the Frontend Architecture boundary. |
| Cloud and Platform Engineering | 10 | 15 | Keep: platform, infrastructure, and provider-specific branches make sense. Link Azure's published leaf extensions from its index. |
| Data Systems | 33 | 14 | Keep: data model, storage, transaction, analytics, and product branches are useful. Review three topic placements described below. |
| Domains and Specialisms | 2 | 5 | Keep: domain-specific treatment differs from reusable framework notes. |
| Engineering Practice | 12 | 12 | Keep: construction, review, process, tooling, and professional practice fit here. Clarify process versus delivery planning. |
| Foundations | 11 | 8 | Keep: language-independent concepts and computing foundations are coherent. |
| Languages, Runtimes and Frameworks | 19 | 16 | Keep: language, runtime, and framework-specific details belong here. Some paths are deep; indexes should make them easy to reach. |
| Reliability and Operations | 0 | 10 | Keep: an approved, distinct discipline with planned coverage. Empty today does not make it obsolete. |
| Security and Privacy | 0 | 10 | Keep: an approved, distinct discipline with planned coverage. Empty today does not make it obsolete. |
| Software Delivery and Evolution | 0 | 11 | Keep: lifecycle, release, versioning, and evolution are distinct from daily engineering practice. |
| State, Coordination and Workflows | 1 | 7 | Keep: application state and workflow concerns differ from durable data systems. |
| Testing and Quality | 3 | 12 | Keep: testing levels, techniques, tooling, and quality practice have a coherent split. |

### Specific boundary and placement checks

| Current folders or notes | Assessment | Proposed improvement, pending review |
| --- | --- | --- |
| `Data Systems/Streaming and Derived Data` and `State, Coordination and Workflows/Caching and Ephemeral State` | Both folders make sense. `Caching Strategies.md` covers application, distributed, and HTTP caching rather than streaming. | Consider moving that note to Caching and Ephemeral State; retain both folders and link from data-system contexts. |
| `Data Systems/Streaming and Derived Data` and `Data Systems/Analytics and Data Processing` | Both folders make sense. `Data Lakes.md` and `Data Warehouses.md` are primarily analytics/storage concepts. | Consider moving those two notes to Analytics and Data Processing; keep Event Sourcing, Materialized Read Model, and Stream Processing Architecture under Streaming and Derived Data. |
| `Architecture and System Design/Frontend Architecture` and `Application Development/Frontend and UX Engineering` | Architecture versus implementation and UX is a valid distinction, but the indexes use generic descriptions. | Keep both folders; state the distinction and add contextual cross-links. |
| `Engineering Practice/Engineering Process` and `Software Delivery and Evolution/Planning and Estimation` | Team workflow versus product delivery lifecycle is a workable boundary. | Keep both; explain that boundary in each index before considering any move. |
| `Data Systems/Data Access` and `Languages, Runtimes and Frameworks/.../Entity Framework Core` | Provider-agnostic data access versus .NET-specific ORM guidance is a sound split. | Keep both; link conceptual and framework-specific notes. |
| `Cloud Platforms/Azure`, `Frameworks and Platforms/DotNET`, and their content-bearing leaf extensions | Provider/framework grouping is justified despite deep paths. The retrieval failure comes from indexes omitting published notes and leaf extensions. | Keep the folders; make indexes expose their actual notes and child folders. |

This is a placement review, not approval to move those notes. Search backlinks and compare each note's scope before any path change. No category rename, merge, or removal is recommended on current evidence.

### Local migration-source folders

Ten local directory paths are untracked and absent from the approved manifest. Nine are directly empty; `Derived Data and Analytics` contains only its empty `Analytical Platforms` child. Unlike planned category folders, these *specific old paths* appear as sources in `Taxonomy Migration Ledger.md`, with note destinations elsewhere. That gives a provenance-based reason to treat them as legacy remnants; emptiness alone is not the reason. They are recorded here, with no deletion performed or approved:

| Local folder | Destination recorded in migration ledger |
| --- | --- |
| `Areas/Data Systems/Data Access/Entity Framework` | .NET / Entity Framework Core / Performance. |
| `Areas/Data Systems/Data Models and Query Languages/Non-Relational Systems` | Data Systems / Database Technologies. |
| `Areas/Data Systems/Data Models and Query Languages/Relational Systems` | Data Systems / Database Technologies. |
| `Areas/Data Systems/Derived Data and Analytics` | Data Systems / Streaming and Derived Data and Analytics and Data Processing. |
| `Areas/Data Systems/Derived Data and Analytics/Analytical Platforms` | Data Systems / Analytics and Data Processing. |
| `Areas/Data Systems/Distributed Systems and Consensus` | Architecture and System Design / Distributed Systems / Fundamentals. |
| `Areas/Data Systems/Encoding and Evolution` | Data Systems / Encoding, Schemas and Evolution. |
| `Areas/Data Systems/Storage and Retrieval/Object Storage` | Parent Storage and Retrieval category. |
| `Areas/Data Systems/Transactions and Consistency` | Data Systems / Consistency and Transactions and Concurrency. |
| `Areas/Testing and Quality/Testing` | ASP.NET Core integration testing and MSTest homes. |

Review the folder-level inventory below for every approved category and registered leaf extension. The historical migration ledger and source archive remain intact.

## Proposed note system

The original proposal called for three copyable Markdown templates under the repository. The user clarified that the vault's configured template folder is `00 System/Templates/`, so the implemented files are `Software Engineering - Reference Note.md`, `Software Engineering - Category Index.md`, and `Software Engineering - Inbox Capture.md` there. `Documentation Templates.md` provides usage guidance and links to those files. The vault's Templates core plugin can insert `{{title}}` and `{{date}}`; this task did not edit shared `.obsidian/` settings. See [Obsidian Templates](https://help.obsidian.md/Plugins/Templates) and [Properties](https://help.obsidian.md/Editing+and+formatting/Properties).

### Reference note draft

```markdown
---
date: "{{date}}"
status: Needs Review
tags: []
---

# {{title}}

## Quick Reference

**What it is:** One-sentence definition.

**Use when:** Concrete situation or decision.

**Key points:**
- One actionable principle.
- One important limit or tradeoff.

## Related Concepts

- Add only links that explain prerequisites, alternatives, or applications.

## Review Schedule

- Review when the cited technology changes or the note is next used for a decision.
```

Add `Deep Dive` modules only when needed: mechanism, worked example, alternatives and tradeoffs, pitfalls, and sources. Remove empty optional modules from finished notes. Keep first heading as title after frontmatter. Preserve existing `Date` values as `date`; preserve status and tags while converting. `Current` is never assigned through formatting alone.

### Category index draft

```markdown
---
date: "{{date}}"
status: Needs Review
tags: []
---

# {{title}}

## Quick Reference

State category boundary and when to start here.

## Published Notes

- Link each directly published note with a short reason to open it.

## Subcategories

- Link each approved child index with a short scope description; mark planned branches clearly.

## Planned Coverage

- List planned topics as plain text, without unresolved links.

## Related Concepts

- Link adjacent live categories only when the distinction helps navigation.

## Review Schedule

- Review when published notes or category boundaries change.
```

Generate published-note links from actual files while preserving approved planned categories and plain-text planned topics in the indexes. Path-qualify and alias `_Index.md` wikilinks because their basenames repeat.

### Inbox capture draft

```markdown
---
date: "{{date}}"
---

# {{title}}

## Raw Thought

Capture the thought without requiring a complete explanation.

## Why Revisit

State the question, decision, or idea worth keeping.

## Candidate Links

- Add existing notes only when they genuinely connect.

## Next Action

- Keep researching, fold into an existing note, or publish a new note after review.
```

Use one Inbox file per idea. During review, search existing notes first, retain useful raw context, and record the destination link. Keep interview, machine-specific, and unverified material in Inbox or Jobs until suitable for reusable guidance.

## Risk-ranked primary-source checks

Eleven claims were checked on 2026-09-24. These verdicts cover individual statements, not whole notes. All affected notes remain `Needs Review`.

| Note and line | Verdict | Finding and proposed correction | Primary source |
| --- | --- | --- | --- |
| `Azure Event Grid.md:17` | Partial | Distinguish namespace push/pull delivery from basic-topic push delivery. | [Microsoft Event Grid delivery](https://learn.microsoft.com/en-us/azure/event-grid/namespace-push-delivery-overview), [event schema](https://learn.microsoft.com/en-us/azure/event-grid/event-schema) |
| `Azure Service Bus.md:18` | Partial | Sessions support ordered processing of related messages sharing a session ID; scope this to applicable tiers and session behavior. | [Microsoft message sessions](https://learn.microsoft.com/en-us/azure/service-bus-messaging/message-sessions) |
| `Azure Queue Storage.md:17` | Supported | Current 64 KB message limit is supported; retain version context during full-note review. | [Microsoft Queue Storage overview](https://learn.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction) |
| `Azure Event Hubs.md:18` | Supported with nuance | Order is within a partition; changing partition count can affect key-to-partition mapping. | [Microsoft Event Hubs scalability](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-scalability) |
| `QueryOptimisations.md:27` | Stale | EF Core 3+ normally throws for untranslatable expressions outside the final projection; explicit materialization moves later work client-side. | [Microsoft EF Core client evaluation](https://learn.microsoft.com/en-us/ef/core/querying/client-eval) |
| `QueryOptimisations.md:44` | Unsupported | `ExecuteSqlRaw` is not the general choice for queries returning results. Use parameterized `FromSql` or `SqlQuery` where appropriate; use command APIs for commands without returned rows. | [Microsoft EF Core SQL queries](https://learn.microsoft.com/en-us/ef/core/querying/sql-queries) |
| `MemoryAllocations.md:14` | Partial | Scalar-only DTO projections do not track entity instances; `AsNoTracking` matters when results include entities. | [Microsoft EF Core tracking](https://learn.microsoft.com/en-us/ef/core/querying/tracking) |
| `MemoryAllocations.md:16` | Partial | Streaming normally avoids client list buffering, but EF can buffer internally for retries or split queries. | [Microsoft efficient querying](https://learn.microsoft.com/en-us/ef/core/performance/efficient-querying) |
| `SQL Joins and Indexes.md:10` | Unsupported | Absence of a suitable index often raises scan work; an optimizer may choose a scan even when an index exists. Inspect the actual plan. | [PostgreSQL EXPLAIN](https://www.postgresql.org/docs/18/using-explain.html) |
| `SQL Joins and Indexes.md:76` | Partial | A clustered index organizes rows by key in engines such as SQL Server; it does not guarantee query result order. | [Microsoft SQL Server index design](https://learn.microsoft.com/en-us/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver17) |
| `MySQL.md:15` | Partial | InnoDB is MySQL 8.4's default transactional engine and supports ACID transactions. State product/version; do not turn that fact into an unqualified recommendation. | [MySQL InnoDB introduction](https://dev.mysql.com/doc/refman/8.4/en/innodb-introduction.html) |

Next research batch: Azure service selection and Azurite; .NET dependency-injection lifetimes and ASP.NET Core testing; EF Core performance; database product notes; storage-provider specifics; AI-assisted development and security-sensitive guidance. Check publication/version dates during each review and record sources in the affected note.

## Ranked implementation list after approval

1. Repair corrupted definitions and headings, duplicate Azurite placeholder sections, the self-link in `Architecture Fitness Functions.md`, and the 12 broken Markdown-link occurrences. Validate content manually.
2. Create the three canonical Markdown templates; revise documentation standards, template guidance, and note-template skill to match plain headings and properties.
3. Convert `Areas/` metadata to `date`, `status`, and `tags` YAML properties without changing values; remove decorative icons from live note headings/status/bullets while preserving authored meaning. Do not bulk-promote statuses.
4. Keep the approved taxonomy. Update its index generator to list every published note and content-bearing leaf extension while retaining planned branches and plain-text planned topics. Give overlapping category indexes clear boundaries and contextual cross-links. Review the three candidate note placements separately before any move.
5. Extend validator for YAML values, local Markdown links, index reachability, and icon-free live templates/notes while preserving checks for the approved 13 areas, 159 category indexes, and 729 planned terminal occurrences. Inspect representative templates and navigation in Obsidian.
6. Deepen thin decision-heavy notes and process the fact-check queue in batches, starting with unsupported and stale claims above. Keep `Needs Review` until each whole note is supportable.

## Checks for later implementation

- Every published topic is reachable through `Areas/_Index.md` and category indexes. Indexes without published descendants accurately label their planned coverage rather than claiming to list published notes.
- All live internal wikilinks and local Markdown links resolve; path-qualified `_Index.md` links remain unambiguous. Historical archive material is explicitly excluded from live-link checks.
- All 13 approved areas, 159 category indexes, and 29 registered leaf extensions remain unless a later, evidence-backed change is approved. Planned-only categories are clearly labeled; their lack of notes is not a validation failure.
- The ten local migration-source directory paths have an explicit disposition based on ledger provenance and current contents; no other folder is treated as obsolete merely because it is empty.
- All `Areas/` notes have parseable `date`, `status`, and `tags` properties with original values preserved; live headings/status markers have no decorative icons.
- Three repository templates insert cleanly in Obsidian, and representative quick-reference, deep-dive, index, and Inbox paths work without changing shared `.obsidian/` settings.

## Complete note action ledger

Paths are relative to this repository. Each row was reviewed for retrieval, depth, linking, overlap, and likely home. `Keep draft` preserves `Needs Review`.

| Topic note | Action |
| --- | --- |
| `Areas/Application Development/API Design/API Versioning.md` | deepen examples; replace index-only links with concrete compatibility concepts |
| `Areas/Application Development/Backend Engineering/Constructor Injection.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Application Development/Backend Engineering/Dependency Injection.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Application Development/Backend Engineering/Dependency Injection/Scoped Lifetime.md` | keep; targeted technical/source review |
| `Areas/Application Development/Backend Engineering/Dependency Injection/Singleton Lifetime.md` | keep; targeted technical/source review |
| `Areas/Application Development/Backend Engineering/Dependency Injection/Transient Lifetime.md` | keep; targeted technical/source review |
| `Areas/Application Development/Backend Engineering/Method Injection.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Application Development/Backend Engineering/Property Injection.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Application Development/Frontend and UX Engineering/UI Composition/Model-View-Controller.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Architectural Styles/Cell-Based Architecture.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Architectural Styles/Clean Architecture.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Architectural Styles/Layered Architectures/Monolith.md` | deepen 81-word quick reference |
| `Areas/Architecture and System Design/Architectural Styles/Microservices.md` | repair corrupted Definition; retain remainder |
| `Areas/Architecture and System Design/Architectural Styles/Modular Monolith.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture/Service-Based Architecture.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture/Service-Oriented Architecture.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Architectural Styles/Space-Based Architecture.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Architecture Decision Making/Architecture Fitness Functions.md` | repair self-link; align H1 with filename |
| `Areas/Architecture and System Design/Architecture Fundamentals/Distributed Monolith.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Architecture Fundamentals/Service Locator.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Design Patterns/Behavioural Patterns/Strategy.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Design Patterns/Behavioural Patterns/Template Method.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Design Patterns/Enterprise Application Patterns/Specification.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Design Patterns/Structural Patterns/Decorator.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Design Patterns/Structural Patterns/Plugin.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Distributed Systems/Distributed Computation/Actor Model.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Distributed Systems/Fundamentals/Distributed Systems and Consensus.md` | deepen roadmap-style hub with consensus guidance |
| `Areas/Architecture and System Design/Domain-Driven Design/DDD and Architecture/CQRS.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Domain-Driven Design/Tactical Design/Repository Pattern.md` | keep; targeted technical/source review |
| `Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture.md` | repair corrupted Definition; deepen 71-word note |
| `Areas/Architecture and System Design/Integration and Messaging/Integration Styles/API Gateway Pattern.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Backend for Frontend.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Message-Driven Architecture.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/Integration and Messaging/Integration Styles/Service Communication.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Architecture and System Design/System Design/Component Design/Service Composition.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Compute/Azure Functions.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Event Grid.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Event Hubs.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Messaging Service Selection.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Queue Storage.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging/Azure Service Bus.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite.md` | repair synthetic definition; extract interview and machine-specific excerpt; add concept links; vendor fact-check |
| `Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers/Docker and .NET.md` | replace Azure-index-only link with container concepts; vendor fact-check |
| `Areas/Cloud and Platform Engineering/Platform Engineering/Service Mesh.md` | keep; targeted technical/source review |
| `Areas/Cloud and Platform Engineering/Serverless/Serverless Architecture.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Analytics and Data Processing/Amazon Redshift.md` | deepen product tradeoffs; vendor fact-check |
| `Areas/Data Systems/Analytics and Data Processing/Google BigQuery.md` | deepen product tradeoffs; vendor fact-check |
| `Areas/Data Systems/Analytics and Data Processing/Snowflake.md` | deepen 72-word note; vendor fact-check |
| `Areas/Data Systems/Consistency/Consistency Models.md` | keep; targeted technical/source review |
| `Areas/Data Systems/Data Access/Data Access.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Data Access/Unit of Work.md` | scope to transaction boundary; remove repository duplicate; verify DbContext/testing guidance |
| `Areas/Data Systems/Data Models and Query Languages/Data Modeling.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Data Models and Query Languages/NoSQL Databases.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Data Models and Query Languages/Relational Databases.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Data Models and Query Languages/SQL Joins and Indexes.md` | keep; targeted technical/source review |
| `Areas/Data Systems/Database Technologies/Cassandra.md` | deepen; replace duplicate index links; vendor fact-check |
| `Areas/Data Systems/Database Technologies/MongoDB.md` | deepen; replace duplicate index links; vendor fact-check |
| `Areas/Data Systems/Database Technologies/MySQL.md` | deepen 72-word note; replace sole index link; vendor fact-check |
| `Areas/Data Systems/Database Technologies/Oracle.md` | deepen 77-word note; replace sole index link; vendor fact-check |
| `Areas/Data Systems/Database Technologies/PostgreSQL.md` | deepen 89-word note; replace sole index link; vendor fact-check |
| `Areas/Data Systems/Database Technologies/Redis.md` | deepen; add concept links; vendor fact-check |
| `Areas/Data Systems/Encoding, Schemas and Evolution/JSON.md` | keep; targeted technical/source review |
| `Areas/Data Systems/Encoding, Schemas and Evolution/Schema Migrations.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Replication and Partitioning/Replication and Partitioning.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Storage and Retrieval/Amazon S3.md` | deepen; vendor fact-check |
| `Areas/Data Systems/Storage and Retrieval/Azure Blob Storage.md` | deepen; vendor fact-check |
| `Areas/Data Systems/Storage and Retrieval/B-Trees.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Storage and Retrieval/Cloud Storage Services.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Storage and Retrieval/Google Cloud Storage.md` | deepen; vendor fact-check |
| `Areas/Data Systems/Storage and Retrieval/LSM Trees.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Storage and Retrieval/Storage Engines.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Streaming and Derived Data/Caching Strategies.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Streaming and Derived Data/Data Lakes.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Streaming and Derived Data/Data Warehouses.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Streaming and Derived Data/Event Sourcing.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Streaming and Derived Data/Materialized Read Model.md` | keep; targeted technical/source review |
| `Areas/Data Systems/Streaming and Derived Data/Stream Processing Architecture.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Data Systems/Transactions and Concurrency/Transactions and Isolation Levels.md` | keep; targeted technical/source review |
| `Areas/Domains and Specialisms/Game Development/Game AI.md` | deepen practical selection guidance; add concept links |
| `Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System.md` | keep; targeted technical/source review |
| `Areas/Engineering Practice/Code Design and Construction/Dependency Inversion Principle.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Code Design and Construction/Interface Segregation Principle.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Code Design and Construction/Liskov Substitution Principle.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Code Design and Construction/Mappers.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Code Design and Construction/Open-Closed Principle.md` | repair two obsolete V2 relative links at lines 76-77; keep content draft |
| `Areas/Engineering Practice/Code Design and Construction/Single Responsibility Principle.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Code Design and Construction/SOLID Principles.md` | repair five nonexistent SRP/OCP/LSP/ISP/DIP relative links |
| `Areas/Engineering Practice/Code Review/Code Review Guidelines.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Developer Tooling/AI-Assisted Development.md` | keep; targeted technical/source review |
| `Areas/Engineering Practice/Engineering Process/Engineering Approaches.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Engineering Practice/Maintainability and Code Health/Coupling.md` | repair spaced-letter title and definition; deepen; replace root-index-only link |
| `Areas/Engineering Practice/Professional Practice/Software Engineering Laws.md` | repair spaced-letter title/definition; editorial and source review; link concepts |
| `Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming/Async.md` | keep; targeted technical/source review |
| `Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming/Future and Promise.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Concurrency Patterns Overview.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Producer-Consumer.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns/Thread Pool.md` | keep; targeted technical/source review |
| `Areas/Foundations/Programming Concepts/Abstraction and Modularity/Abstraction.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Programming Concepts/Abstraction and Modularity/Encapsulation.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Programming Concepts/Composition and Reuse/Composition Over Inheritance.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Programming Concepts/Programming Paradigms/Inheritance.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Foundations/Programming Concepts/Programming Paradigms/Object-Oriented Programming Overview.md` | keep hub; review overbroad four-pillars definition |
| `Areas/Foundations/Programming Concepts/Programming Paradigms/Polymorphism.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs/ASP.NET Core Integration Testing.md` | deepen runnable test example; vendor fact-check |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration/ASP.NET Core Options Pattern.md` | deepen use and behavior; vendor fact-check |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/Performance/MemoryAllocations.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/Performance/QueryOptimisations.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/Game Frameworks/Unity Resources.md` | keep resource hub in place; link it from the Game Frameworks index and add Unity topic links when published |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Async and Concurrency/Immutable and Concurrent Collections.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics/Generic Constraints.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Access Modifiers.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/CSharp Fundamentals.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Delegates, Events, and Actions.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals/Expression-Bodied Members.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/LINQ/LINQ.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Dictionary.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/HashSet.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/List.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/JavaScript and TypeScript/JavaScript/JavaScript Fundamentals.md` | keep; targeted technical/source review |
| `Areas/Languages, Runtimes and Frameworks/Languages/Shell and Scripting/PowerShell CLI Essentials.md` | keep; targeted technical/source review |
| `Areas/State, Coordination and Workflows/Workflow and Long-Running Processes/Sagas/Saga Pattern.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Testing and Quality/Test Automation and Tooling/Test Runners/MSTest.md` | deepen runner details; vendor fact-check |
| `Areas/Testing and Quality/Testing Fundamentals/Behavior-Driven Development.md` | keep draft; normalize metadata/icons; retain Needs Review |
| `Areas/Testing and Quality/Testing Fundamentals/Test-Driven Development.md` | keep draft; normalize metadata/icons; retain Needs Review |

## Folder-level inventory

All 197 physical subdirectories beneath `Areas/` are classified below: 158 approved category folders, 29 registered content-bearing leaf extensions, and ten local migration-source remnants. The `Areas/` root index is the 159th approved category index. `Keep; planned coverage is valid` is an affirmative taxonomy assessment, not a removal decision. Specific boundary questions are marked in the result column.

| Folder | Classification | Audit result |
| --- | --- | --- |
| `Areas/Application Development` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Application Development/API Design` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Application Development/API Design/HTTP APIs` | Approved category | Keep; planned coverage is valid. |
| `Areas/Application Development/Backend Engineering` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Application Development/Backend Engineering/Dependency Injection` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Application Development/Command-Line Applications` | Approved category | Keep; planned coverage is valid. |
| `Areas/Application Development/Desktop` | Approved category | Keep; planned coverage is valid. |
| `Areas/Application Development/Frontend and UX Engineering` | Approved category | Keep; clarify implementation/UX boundary against frontend architecture. |
| `Areas/Application Development/Frontend and UX Engineering/UI Composition` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Application Development/Interprocess and Client Integration` | Approved category | Keep; planned coverage is valid. |
| `Areas/Application Development/Mobile` | Approved category | Keep; planned coverage is valid. |
| `Areas/Application Development/Real-Time Applications` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Architectural Styles` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Architectural Styles/Layered Architectures` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Architecture and System Design/Architectural Styles/Service-Oriented Architecture` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Architecture and System Design/Architecture Decision Making` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Architecture Fundamentals` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Design Patterns` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Design Patterns/Behavioural Patterns` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Architecture and System Design/Design Patterns/Enterprise Application Patterns` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Architecture and System Design/Design Patterns/Structural Patterns` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Architecture and System Design/Distributed Systems` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Distributed Systems/Communication` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Distributed Systems/Coordination and Consensus` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Distributed Systems/Distributed Computation` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Distributed Systems/Failure Models and Trade-offs` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Distributed Systems/Fundamentals` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Distributed Systems/Membership and Discovery` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Distributed Systems/Time, Ordering and Causality` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Domain-Driven Design` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Domain-Driven Design/Context Integration` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Domain-Driven Design/DDD and Architecture` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Domain-Driven Design/Foundations` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Domain-Driven Design/Strategic Design` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Domain-Driven Design/Tactical Design` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Frontend Architecture` | Approved category | Keep; clarify architecture boundary against frontend engineering. |
| `Areas/Architecture and System Design/Integration and Messaging` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Integration and Messaging/Integration Styles` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/Integration and Messaging/Message Design and Contracts` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Integration and Messaging/Messaging Semantics` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Integration and Messaging/Messaging Technologies` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/Integration and Messaging/Transactional Messaging` | Approved category | Keep; planned coverage is valid. |
| `Areas/Architecture and System Design/System Design` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Architecture and System Design/System Design/Component Design` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Cloud and Platform Engineering` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Cloud and Platform Engineering/Cloud Economics` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Cloud Fundamentals` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Cloud Governance` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Cloud Networking` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Cloud Platforms` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure` | Approved category | Keep; link published Compute, Messaging, and Storage leaf notes. |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Compute` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Messaging` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Cloud and Platform Engineering/Compute` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Containers and Orchestration` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Cloud and Platform Engineering/Containers and Orchestration/Kubernetes` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Infrastructure as Code` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Managed Data and Integration Services` | Approved category | Keep; planned coverage is valid. |
| `Areas/Cloud and Platform Engineering/Platform Engineering` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Cloud and Platform Engineering/Serverless` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Analytics and Data Processing` | Approved category | Keep; candidate home for Data Lakes and Data Warehouses. |
| `Areas/Data Systems/Consistency` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Data Access` | Approved category | Keep; document provider-agnostic scope. |
| `Areas/Data Systems/Data Access/Entity Framework` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Data Lifecycle and Governance` | Approved category | Keep; planned coverage is valid. |
| `Areas/Data Systems/Data Models and Query Languages` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Data Models and Query Languages/Non-Relational Systems` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Data Models and Query Languages/Relational Systems` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Database Technologies` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Derived Data and Analytics` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Derived Data and Analytics/Analytical Platforms` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Distributed Systems and Consensus` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Encoding and Evolution` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Encoding, Schemas and Evolution` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Replication and Partitioning` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Replication and Partitioning/Partitioning` | Approved category | Keep; planned coverage is valid. |
| `Areas/Data Systems/Replication and Partitioning/Replication` | Approved category | Keep; planned coverage is valid. |
| `Areas/Data Systems/Storage and Retrieval` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Storage and Retrieval/Object Storage` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Data Systems/Streaming and Derived Data` | Approved category | Keep; review Caching Strategies, Data Lakes, and Data Warehouses note homes. |
| `Areas/Data Systems/Transactions and Concurrency` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Data Systems/Transactions and Consistency` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Domains and Specialisms` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Domains and Specialisms/AI and Machine Learning` | Approved category | Keep; planned coverage is valid. |
| `Areas/Domains and Specialisms/Embedded Systems` | Approved category | Keep; planned coverage is valid. |
| `Areas/Domains and Specialisms/Game Development` | Approved category | Keep; domain guidance differs from game framework specifics. |
| `Areas/Domains and Specialisms/Game Development/Game Architecture` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Domains and Specialisms/Web Development` | Approved category | Keep; planned coverage is valid. |
| `Areas/Engineering Practice` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Engineering Practice/Code Design and Construction` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Engineering Practice/Code Review` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Engineering Practice/Debugging and Problem Solving` | Approved category | Keep; planned coverage is valid. |
| `Areas/Engineering Practice/Developer Tooling` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Engineering Practice/Documentation` | Approved category | Keep; planned coverage is valid. |
| `Areas/Engineering Practice/Engineering Process` | Approved category | Keep; clarify team-process boundary against delivery planning. |
| `Areas/Engineering Practice/Maintainability and Code Health` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Engineering Practice/Professional Practice` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Engineering Practice/Source Control` | Approved category | Keep; planned coverage is valid. |
| `Areas/Engineering Practice/Team Practices` | Approved category | Keep; planned coverage is valid. |
| `Areas/Engineering Practice/Technical Leadership` | Approved category | Keep; planned coverage is valid. |
| `Areas/Foundations` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Foundations/Algorithms and Data Structures` | Approved category | Keep; planned coverage is valid. |
| `Areas/Foundations/Computer Architecture and Hardware` | Approved category | Keep; planned coverage is valid. |
| `Areas/Foundations/Concurrency and Parallelism` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Foundations/Concurrency and Parallelism/Asynchronous Programming` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Foundations/Concurrency and Parallelism/Concurrent Patterns` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Foundations/Mathematics for Software` | Approved category | Keep; planned coverage is valid. |
| `Areas/Foundations/Networking` | Approved category | Keep; planned coverage is valid. |
| `Areas/Foundations/Operating Systems` | Approved category | Keep; planned coverage is valid. |
| `Areas/Foundations/Programming Concepts` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Foundations/Programming Concepts/Abstraction and Modularity` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Foundations/Programming Concepts/Composition and Reuse` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Foundations/Programming Concepts/Programming Paradigms` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Build and Package Ecosystems` | Approved category | Keep; planned coverage is valid. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/APIs` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/ASP.NET Core/Configuration` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core` | Approved category | Keep; document .NET-specific ORM scope. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/Performance` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/Frontend Frameworks` | Approved category | Keep; planned coverage is valid. |
| `Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/Game Frameworks` | Approved category | Keep; framework specifics differ from game domain guidance. |
| `Areas/Languages, Runtimes and Frameworks/Languages` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Async and Concurrency` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Generics` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Language Fundamentals` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/LINQ` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/JavaScript and TypeScript` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Languages, Runtimes and Frameworks/Languages/JavaScript and TypeScript/JavaScript` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/Shell and Scripting` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Languages, Runtimes and Frameworks/Languages/SQL` | Approved category | Keep; planned coverage is valid. |
| `Areas/Languages, Runtimes and Frameworks/Runtimes` | Approved category | Keep; planned coverage is valid. |
| `Areas/Languages, Runtimes and Frameworks/Runtimes/DotNET CLR` | Approved category | Keep; planned coverage is valid. |
| `Areas/Languages, Runtimes and Frameworks/Runtimes/JavaScript Runtimes` | Approved category | Keep; planned coverage is valid. |
| `Areas/Languages, Runtimes and Frameworks/SDKs and Libraries` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Chaos and Failure Testing` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/High Availability and Disaster Recovery` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Incident Management` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Observability` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Performance and Capacity` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Production Operations` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Reliability Engineering Fundamentals` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/Resilience and Fault Tolerance` | Approved category | Keep; planned coverage is valid. |
| `Areas/Reliability and Operations/SLIs, SLOs and Error Budgets` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Application Security` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Cloud and Infrastructure Security` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Cryptography, Certificates and Secrets` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Identity and Access Management` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Privacy and Data Protection` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Secure Delivery and Supply Chain` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Security Fundamentals` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Threat Modeling` | Approved category | Keep; planned coverage is valid. |
| `Areas/Security and Privacy/Vulnerability Management` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Build and Continuous Integration` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Configuration Management` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Continuous Delivery and Deployment` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Feature Management` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Migration and Modernisation` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Planning and Estimation` | Approved category | Keep; clarify delivery-planning boundary against engineering process. |
| `Areas/Software Delivery and Evolution/Release Strategies` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Requirements Engineering` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Software Maintenance and Evolution` | Approved category | Keep; planned coverage is valid. |
| `Areas/Software Delivery and Evolution/Versioning, Compatibility and Deprecation` | Approved category | Keep; planned coverage is valid. |
| `Areas/State, Coordination and Workflows` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/State, Coordination and Workflows/Application Coordination` | Approved category | Keep; planned coverage is valid. |
| `Areas/State, Coordination and Workflows/Background Processing` | Approved category | Keep; planned coverage is valid. |
| `Areas/State, Coordination and Workflows/Caching and Ephemeral State` | Approved category | Keep; candidate home for Caching Strategies. |
| `Areas/State, Coordination and Workflows/Sessions and Identity Context` | Approved category | Keep; planned coverage is valid. |
| `Areas/State, Coordination and Workflows/State Management` | Approved category | Keep; planned coverage is valid. |
| `Areas/State, Coordination and Workflows/Workflow and Long-Running Processes` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/State, Coordination and Workflows/Workflow and Long-Running Processes/Sagas` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Testing and Quality` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Testing and Quality/Advanced Testing Techniques` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Contract Testing` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/End-to-End Testing` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Integration Testing` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Performance and Reliability Testing` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Quality Practices` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Test Architecture` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Test Automation and Tooling` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Testing and Quality/Test Automation and Tooling/Test Runners` | Registered leaf extension | Keep; published content has an approved leaf home. |
| `Areas/Testing and Quality/Test Data and Environments` | Approved category | Keep; planned coverage is valid. |
| `Areas/Testing and Quality/Testing` | Migration-source remnant | Historical source path documented by ledger; no removal proposed. |
| `Areas/Testing and Quality/Testing Fundamentals` | Approved category | Keep; published subtree needs direct index links. |
| `Areas/Testing and Quality/Unit Testing` | Approved category | Keep; planned coverage is valid. |
