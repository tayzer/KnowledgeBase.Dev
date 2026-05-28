# Knowledge Base Guidelines

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
- Prefer the existing top-level areas under `Areas/`.
- If a topic does not fit cleanly, propose the smallest viable extension to the taxonomy instead of creating ad hoc folders.
- Maintain consistent tags and cross-links with nearby notes.

## Answer Quality
- Final answers should be clear, technically specific, and explicit about confidence.
- Call out unresolved uncertainty instead of smoothing it over.
- Do not cite unsupported claims as fact.