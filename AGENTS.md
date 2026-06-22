# Codex Guidance For This Knowledge Base

## Repository Purpose

- This repository is an Obsidian-style software-engineering knowledge base, not an application codebase.
- Primary work is answering software-engineering questions, curating markdown notes, expanding coverage, and maintaining the vault taxonomy.
- Treat the vault as the local source of truth. Separate existing vault content, newly synthesized guidance, and externally verified updates.

## Operating Workflow

- Search the vault before drafting new content, answering from memory, or creating a new note.
- Prefer updating an existing note over creating a duplicate topic.
- Inspect nearby notes before choosing a folder, tags, title, or related wikilinks.
- Keep edits incremental and scoped. Large restructures need an explicit rationale.
- When guidance depends on current vendor behavior, framework versions, packages, cloud services, security advice, or incomplete vault coverage, perform targeted external research before finalizing.
- Prefer primary sources for current claims: official documentation, specifications, release notes, changelogs, maintainer guidance, and security advisories.

## Codex Skills

Use repo skills under `.agents/skills` when their descriptions match the task:

- `kb-note-template` for new notes, deep rewrites, and template normalization.
- `kb-taxonomy-linking` for folder placement, tags, note names, and wikilinks.
- `kb-fact-check-protocol` for versioned, externally sourced, security-sensitive, disputed, or likely stale claims.
- `kb-gap-analysis` for stale coverage, thin notes, duplication, taxonomy friction, and roadmap work.

## Codex Custom Agents

- Project custom agents live under `.codex/agents`.
- Use specialist agents when the user explicitly asks for subagents or when a task is broad enough to benefit from parallel specialist review.
- Do not return raw subagent output to the user. Synthesize findings into one reviewed answer or note change.
- Use `kb-coordinator` as the orchestration model for substantial KB work.
- Use `kb-reviewer` as the final quality gate for substantive answers and note edits.
- Use `kb-researcher` and `kb-fact-checker` for fresh external claims and uncertainty checks.
- Use `interview-prep-coordinator` for substantial job-interview prep work that combines a CV, job description, company research, and KB-linked study material.
- Use `interview-prep-reviewer` as the final quality gate for substantive interview-prep packs.

## Interview Prep Workflow

- Store reusable interview-prep templates under `Jobs/Interview Prep/_templates/`.
- Store one prep pack per opportunity under `Jobs/Interview Prep/<Company> - <Role> - <YYYY-MM-DD>/`.
- Required prep inputs are the CV, job description, company name, role title, interview stage/date when known, and any user concerns or goals.
- If the CV or job description is missing, search likely `Jobs/` locations first; do not invent personal evidence.
- Research current company and role context from primary sources where possible, and record URLs, publication dates when available, and access dates.
- Link prep guidance to relevant KB notes. If documentation is missing or thin, update or create the smallest appropriate `Areas/` note using the standard note contract.
- Keep candidate evidence, generated answer framing, vault guidance, and external research clearly separated.

## Note Contract

Preserve the established note pattern for notes under `Areas/`:

- Title as the first heading.
- `Date`
- `Status`
- `Tags`
- `TL;DR / Quick Reference`
- `Related Concepts`
- `Review Schedule`

The TL;DR should include a definition, when to use the topic, and key takeaways. Add deeper sections such as Deep Dive, Resources, Practice Exercises, Personal Notes, Gotchas, or Code Snippet only when they materially improve the note.

## Taxonomy

- Prefer the current top-level areas under `Areas/`: `Architecture and Patterns`, `Cloud and Delivery`, `Data and State`, `Developer Workflow`, `Domain Overlays`, `Languages and Frameworks`, `Operations and Reliability`, `Security`, and `Testing and Quality`.
- If a topic spans areas, place it where the reader would look first and bridge adjacent concepts with wikilinks.
- If a topic does not fit cleanly, propose the smallest viable extension under an existing area before creating a new top-level area.
- During taxonomy migration, move notes only when touched or reviewed, and preserve backlink stability.

## Answer Quality

- Be technically specific, concise, and clear about confidence.
- Call out unresolved uncertainty instead of smoothing it over.
- Do not cite unsupported claims as fact.
- Mention relevant existing note paths when they materially ground the answer.
