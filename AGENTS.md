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

## Review `Needs Review` Notes

- For a substantive backlog review, work from the current inventory and prepare one review proposal per source under `01 Inbox/Needs Review Proposals/`, with a queue mapping proposal to canonical source. Keep the source note, index, inventory, and source status unchanged while the user reviews proposals.
- Assess accuracy against primary sources where practical, useful detail, the KB note/index contract, and the best canonical location. Correct the proposal's main content; record evidence, specific changes, unresolved claims, location reasoning, and promotion blockers in its review section. Keep proposals at `status: Draft`.
- Review proposals iteratively with the user. Approval authorizes promotion of that proposal's approved content to the canonical path; it does not automatically approve other proposals.
- After promotion, update relevant indexes and inventory. Set the canonical note to `Current` only when its whole content is supportable; otherwise retain `Needs Review` and document what remains unresolved. Never mark an Inbox proposal `Current`.

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

Use the canonical [[00 System/Templates/Software Engineering - Reference Note|Reference Note]] template and preserve the note contract for notes under `Areas/`:

- `date`, `status`, and `tags` in Obsidian properties. Keep existing values during conversion; default new published notes to `Needs Review`.
- Title as the first heading after properties.
- `Quick Reference`
- `Related Concepts`
- `Review Schedule`

The Quick Reference should include a definition, when to use the topic, actionable points, and a meaningful limit. Add deeper sections such as Deep Dive, examples, alternatives, pitfalls, or sources only when they materially improve the note. Use plain headings and bullets without decorative icons. Template compliance does not establish factual accuracy.

## Taxonomy

- Use [[Software Engineering Taxonomy|Software Engineering Taxonomy]] and [[Taxonomy Rules|Taxonomy Rules]] as authoritative sources.
- The 13 top-level areas are fixed. Give each concept one canonical home and bridge cross-cutting topics with wikilinks.
- Use a leaf extension under the nearest approved category for a valid omitted topic; do not create a top-level area without explicit approval.
- Use category `_Index.md` files for navigation. Planned topics stay plain text until a published note exists.
- Retain approved planned category folders and indexes even if no note is published there yet; do not infer obsolescence from emptiness.
- Use [[00 System/Templates/Software Engineering - Category Index|Category Index]] for new indexes and [[00 System/Templates/Software Engineering - Inbox Capture|Inbox Capture]] for one raw idea per Inbox file.

## Answer Quality

- Be technically specific, concise, and clear about confidence.
- Call out unresolved uncertainty instead of smoothing it over.
- Do not cite unsupported claims as fact.
- Mention relevant existing note paths when they materially ground the answer.
