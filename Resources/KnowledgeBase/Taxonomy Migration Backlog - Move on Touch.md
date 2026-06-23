# Taxonomy Migration Backlog - Move on Touch
Date: 2026-06-12
Status: 🟡 Needs Review
Tags: #knowledge-base #taxonomy #migration #backlog

## 🎯 TL;DR / Quick Reference

**Definition:** First-pass execution backlog for incremental migration from legacy areas to the new category hubs.

**When to use:**
- During normal note edits and periodic taxonomy maintenance.
- When deciding which note to move next without doing a big-bang reorganization.

**Key Takeaways:**
- ✅ Move notes only when touched or reviewed.
- ✅ Prioritize high-traffic and cross-link-heavy notes first.
- ⚠️ Keep temporary redirect stubs until backlinks are stable.

---

## 📚 Deep Dive

### Priority Rules
1. Priority 1: category-defining notes and notes with broad backlinks.
2. Priority 2: frequently consulted implementation notes.
3. Priority 3: niche or low-traffic notes.

### First-Pass Backlog

| Priority | Source Note | Current Location | Target Category | Trigger To Move |
|---|---|---|---|---|
| P1 | CleanArchitecture | `Areas/Patterns/SystemArchitecture/CleanArchitecture.md` | `Areas/Architecture and Patterns/` | Next content update or review pass |
| P1 | CQRS | `Areas/Patterns/SystemArchitecture/CQRS.md` | `Areas/Architecture and Patterns/` | Next content update or review pass |
| P1 | Microservices | `Areas/Patterns/SystemArchitecture/Microservices.md` | `Areas/Architecture and Patterns/` | Next content update or review pass |
| P1 | Repository Pattern | `Areas/Patterns/Application/Repository.md` | `Areas/Architecture and Patterns/` | Next content update or review pass |
| P1 | NullableReferenceTypes | `Areas/DotNet/NullableReferenceTypes.md` | `Areas/Languages and Frameworks/` | Next content update or review pass |
| P1 | Linq | `Areas/DotNet/Linq.md` | `Areas/Languages and Frameworks/` | Next content update or review pass |
| P1 | PostgreSQL | `Areas/Data Stores/PostgreSQL.md` | `Areas/Data and State/` | Next content update or review pass |
| P1 | Redis | `Areas/Data Stores/Redis.md` | `Areas/Data and State/` | Next content update or review pass |
| P1 | IntegrationTestingAspNet | `Areas/CodingPractices/Testing/IntegrationTestingAspNet.md` | `Areas/Testing and Quality/` | Next content update or review pass |
| P1 | MsTest | `Areas/CodingPractices/Testing/MsTest.md` | `Areas/Testing and Quality/` | Next content update or review pass |
| P2 | CodeReviewGuidelines | `Areas/CodingPractices/CodeReviewGuidelines.md` | `Areas/Developer Workflow/` | Next content update or review pass |
| P2 | Mappers | `Areas/CodingPractices/Mappers.md` | `Areas/Developer Workflow/` | Next content update or review pass |
| P2 | DockerDotNet | `Areas/DevOps/DockerDotNet.md` | `Areas/Cloud and Delivery/` | Next content update or review pass |
| P2 | AzureServicesOverview | `Areas/DevOps/AzureServicesOverview.md` | `Areas/Cloud and Delivery/` | Next content update or review pass |
| P2 | PowerShellCliEssentials | `Areas/DevOps/PowerShellCliEssentials.md` | `Areas/Developer Workflow/` | Next content update or review pass |
| P2 | SourceControl area notes | `Areas/SourceControl/` | `Areas/Developer Workflow/` | First source-control note touch |
| Done | Entity Framework notes | Legacy Data Stores EF notes | `Areas/Data and State/Data Access/Entity Framework/` | Reorganized during Data and State review on 2026-06-23 |
| P3 | ThreadPool | `Areas/Patterns/Concurrency/ThreadPool.md` | `Areas/Architecture and Patterns/` | Next content update or review pass |
| P3 | Async | `Areas/Patterns/Concurrency/Async.md` | `Areas/Architecture and Patterns/` | Next content update or review pass |

### Deferred Domain Overlay Work
- Keep `Areas/GameDev/` as an overlay during migration.
- Route game-specific notes into horizontal categories where possible and keep domain context in overlay hubs.

### Migration Checklist Per Note
1. Move note to target category path.
2. Add or update related links to horizontal hub and domain overlay (if relevant).
3. Create a short redirect stub in old location.
4. Remove stub only after backlink cleanup.

## 🔗 Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Mapping - Current to Target|Taxonomy Mapping - Current to Target]]
- [[Architecture and Patterns]]
- [[Languages and Frameworks]]
- [[Data and State]]
- [[Cloud and Delivery]]
- [[Testing and Quality]]
- [[Developer Workflow]]

## 🔄 Review Schedule
- [ ] Review in 2 weeks