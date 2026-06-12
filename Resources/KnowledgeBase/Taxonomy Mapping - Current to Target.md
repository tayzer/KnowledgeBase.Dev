# Taxonomy Mapping - Current to Target
Date: 2026-06-12
Status: 🟡 Needs Review
Tags: #knowledge-base #taxonomy #migration #information-architecture

## 🎯 TL;DR / Quick Reference

**Definition:** Mapping table and migration guidance from the current top-level `Areas/` taxonomy to the target category model.

**When to use:**
- When deciding where to place or move an existing note.
- When creating new notes during the migration period.
- When validating that the taxonomy change remains incremental and low-risk.

**Key Takeaways:**
- ✅ Migrate incrementally using new category hub notes first.
- ✅ Keep one canonical note location and use links to bridge cross-cutting topics.
- ⚠️ Avoid a big-bang move to reduce broken links and taxonomy drift.

---

## 📚 Deep Dive

### Mapping Table

| Current Area | Target Category | Notes |
|---|---|---|
| `Areas/DotNet/` | `Areas/Languages and Frameworks/` | Primary home for C#, .NET, ASP.NET, language/runtime features. |
| `Areas/Patterns/` | `Areas/Architecture and Patterns/` | Includes architecture, design patterns, CQRS, concurrency patterns. |
| `Areas/Data Stores/` | `Areas/Data and State/` | Includes relational/NoSQL stores, warehousing, caching, persistence concerns. |
| `Areas/DevOps/` | `Areas/Cloud and Delivery/` | CI/CD, IaC, deployment pipelines, provisioning, container delivery workflows. |
| `Areas/CodingPractices/Testing/` | `Areas/Testing and Quality/` | Integration/unit testing strategy, test frameworks, verification guidance. |
| `Areas/SourceControl/` | `Areas/Developer Workflow/` | Source control, branching, versioning workflow, local developer automation. |
| `Areas/CodingPractices/` (non-testing) | `Areas/Developer Workflow/` | Code review standards, maintainability habits, documentation workflow. |
| `Areas/DevOps/` (runtime reliability topics) | `Areas/Operations and Reliability/` | Monitoring, alerting, incidents, SLO/SLA, production runbooks. |
| `Areas/GameDev/` | Domain overlay hubs | Keep as domain overlays (for example GameDev hub) linking to horizontal categories. |

### Placement Rules During Migration
1. Place new notes in the target category first.
2. If a topic spans categories, choose the strongest primary area and bridge with wikilinks.
3. Move existing notes only when touched or reviewed (move-on-touch).
4. Leave temporary redirect stubs in legacy locations until backlinks are cleaned.

### Migration Sequence
1. Create and publish target category hub notes.
2. Add links from each hub note to current source areas.
3. Migrate active notes first.
4. Run periodic backlink checks and remove stubs only after links are stable.

## 🔗 Related Concepts
- [[Resources/KnowledgeBase/Documentation Standards|Documentation Standards]]
- [[Resources/KnowledgeBase/Documentation Templates|Documentation Templates]]

## 🔄 Review Schedule
- [ ] Review in 1 month