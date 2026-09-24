# Knowledge Base Guidelines

## Engineering changes in a consuming code repository
- Understand the request, repository structure, analogous code, tests, configuration, and deployment path before changing code. The consuming repository is architectural authority.
- Prefer correctness, security, reliability, maintainability, simplicity, testability, observability, relevant performance, cost awareness, then speed. Keep changes focused and compatible with public contracts unless a breaking change is required.
- Do not blindly apply design patterns or architectural patterns. Prefer the simplest design that satisfies the requirements, fits the existing architecture, and is easy to change.
- Do not introduce an abstraction merely because one might be useful in the future. Introduce abstractions in response to concrete duplication, boundaries, substitution requirements, testability needs, or clearly evidenced near-term requirements.
- Use high cohesion, low coupling, explicit dependencies, separation of concerns, and composition where useful. Apply KISS, YAGNI, DRY, SOLID, and dependency inversion with judgment, not as mandates.
- Validate behavior in proportion to risk. Include failure, retry, cancellation, and compatibility cases when relevant. Treat security and operational reliability as part of implementation.
- Report executed checks and results exactly. Separate evidence from assumptions; state unknowns and unverified behavior. Never claim tests, deployment, or security review occurred without evidence.
- When installing this collection in an application repository, replace this file with that repository's concise shared instructions; the knowledge-base guidance below belongs to this vault.

## Repository Purpose
- This workspace is an Obsidian-style software-engineering knowledge base.
- Primary tasks are answering software-engineering questions, curating markdown notes, and expanding coverage without breaking the existing taxonomy.

## Operating Mode
- Search the vault before drafting new content or offering external guidance.
- Treat the vault as the source of truth for local knowledge, and distinguish between existing vault content, newly synthesized guidance, and externally verified updates.
- When a topic depends on current vendor behavior, framework versions, package changes, security guidance, or incomplete vault coverage, do targeted external research before finalizing the answer.
- Use the coordinator to orchestrate subagents. Subagent output is draft material, not final user-facing content.
- Review substantive answers and note edits before presenting them.
- Fact-check claims that are versioned, externally sourced, security sensitive, or otherwise uncertain.
- Use skills when relevant:
  - `kb-note-template` for new notes or deep rewrites
  - `kb-taxonomy-linking` for folder placement, tags, and wikilinks
  - `kb-fact-check-protocol` for evidence gathering and freshness checks
  - `kb-gap-analysis` for stale-coverage, audit, and roadmap work
- Use memory when available:
  - user memory for durable preferences
  - repo memory for conventions, known gaps, and domain ownership
  - session memory for active investigations
- If memory is unavailable in the current tool set, do not invent remembered facts. Fall back to repository context instead.

## Note Format
- Preserve the established note contract:
  - title
  - Date
  - Status
  - Tags
  - `## 🎯 TL;DR / Quick Reference`
  - `## 🔗 Related Concepts`
  - `## 🔄 Review Schedule`
- Add deeper sections such as Deep Dive, Resources, Practice Exercises, Personal Notes, or Code Snippet only when they improve the note.
- Preserve Obsidian wikilinks and prefer updating an existing note over duplicating the same topic elsewhere.
- Keep changes incremental and scoped. Large restructures require an explicit rationale.

## Taxonomy
- Use `Resources/KnowledgeBase/Software Engineering Taxonomy.md` and `Resources/KnowledgeBase/Taxonomy Rules.md` as authoritative.
- Keep the 13 approved top-level areas fixed. Give every concept one canonical home and link adjacent concerns.
- Add a documented leaf extension only when a valid topic is absent from the approved model; never create ad hoc top-level areas.
- Category `_Index.md` files are navigation maps. Maintain qualified index links, tags, and adjacent cross-links.

## Answer Quality
- Final answers should be clear, technically specific, and explicit about confidence.
- Call out unresolved uncertainty instead of smoothing it over.
- Do not cite unsupported claims as fact.
