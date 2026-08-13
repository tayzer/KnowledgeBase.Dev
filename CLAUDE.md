# Claude Guidance For This Knowledge Base

## Repository Purpose

This is an Obsidian-style software-engineering knowledge base, not an application codebase. It serves three purposes, in order:

1. Quick reference and guides that help make software-engineering decisions.
2. A pointer layer — where content is intentionally shallow, it should link to where to go deeper.
3. A place for raw thoughts, ideas, and half-formed theories.

Treat the vault as the local source of truth. Keep existing vault content, newly synthesized guidance, and externally verified research clearly separated in your own head as you work, even if the note doesn't spell that out explicitly.

This repo already has agent instructions for Codex (`AGENTS.md`) and GitHub Copilot (`.github/copilot-instructions.md`), plus skill definitions under `.agents/skills/` and `.github/skills/`, and custom subagents under `.codex/agents/` and `.github/agents/`. This file adapts that same operating model for Claude, whose tool set differs (no custom per-repo subagents, no auto-loaded third-party `SKILL.md` files).

## Operating Workflow

- Search the vault before drafting new content, answering from memory, or creating a new note. Use Grep/Glob or the Explore agent for this.
- Prefer updating an existing note over creating a near-duplicate topic.
- Inspect nearby notes before choosing a folder, tags, title, or related wikilinks — match the neighborhood's conventions rather than inventing new ones.
- Keep edits incremental and scoped. A large restructure needs an explicit rationale, and ideally a check-in with the user first.
- When guidance depends on current vendor behavior, framework versions, packages, cloud services, or security advice, do targeted external research (WebSearch) before finalizing — prefer primary sources: official docs, specs, release notes, changelogs, security advisories.
- For multi-note or multi-step KB work, use the task list (TaskCreate/TaskUpdate) to track progress.

## Note Contract

Every published note under `Areas/` needs:

- Title as the first heading
- `Date`
- `Status` (`🟢 Current` or `🟡 Needs Review`)
- `Tags`
- `## 🎯 TL;DR / Quick Reference` — must include Definition, When to use, and Key Takeaways
- `## 🔗 Related Concepts`
- `## 🔄 Review Schedule`

Add `## 📚 Deep Dive`, `## 📖 Resources`, `## 🧪 Practice Exercises`, `## 📝 Personal Notes`, or a code snippet/gotchas block only when they materially improve the note — don't pad a note with empty sections.

Before creating or rewriting a note, read `Resources/KnowledgeBase/Documentation Templates.md` for the exact copy-paste templates (reference, hub, draft) and `Resources/KnowledgeBase/Documentation Standards.md` for the publish gate and status rules. A note that is empty, TODO-only, or still a raw bullet dump does not belong in `Areas/` — it belongs in `Inbox/`.

Note types:
- **Reference note** — default type, one concept/technology/pattern.
- **Hub note** — category overview that routes to child notes; not a bullet dump.
- **Draft note** — raw ideas, TODOs, resource lists; lives in `Inbox/` until promoted.

## Taxonomy

Use `Resources/KnowledgeBase/Software Engineering Taxonomy.md` and `Resources/KnowledgeBase/Taxonomy Rules.md` as the authoritative taxonomy contract.

- The 13 top-level areas are fixed. Each concept has one canonical home; adjacent concerns use links.
- A valid omitted topic may be a documented leaf extension under the nearest approved category. Do not create a new top-level area without explicit approval.
- Category `_Index.md` files are navigation maps. Planned coverage is plain text until a published note exists.

## Folder Map

- `Areas/` — published, structured notes; the main body of the KB.
- `Inbox/` — drafts, TODOs, raw ideas, ramblings not yet ready for `Areas/`.
- `Resources/KnowledgeBase/` — meta docs about the KB itself (standards, templates, taxonomy mapping). Read these before doing any structural note work.
- `Jobs/` — personal job-search material (CVs, JDs, interview prep, cheatsheets). This folder is git-ignored — it isn't version-tracked. Treat its contents as private; don't surface CV/salary/personal details outside what's actually asked for.

## Reusing The Existing Skill Definitions

This repo's `.agents/skills/*/SKILL.md` files encode good procedures for common KB tasks, but Claude's Skill tool only invokes skills from its own registered list — it can't run these directly. Read them as reference and follow their steps manually when the task matches:

- New note or deep rewrite → read `.agents/skills/kb-note-template/SKILL.md`
- Folder/tag/wikilink placement → read `.agents/skills/kb-taxonomy-linking/SKILL.md`
- Versioned, external, security-sensitive, or disputed claims → read `.agents/skills/kb-fact-check-protocol/SKILL.md`, then verify with WebSearch against primary sources
- Coverage audits, stale-note sweeps, roadmap/backlog work → read `.agents/skills/kb-gap-analysis/SKILL.md`

## Delegating Broad Work

The repo's `kb-coordinator` / `kb-reviewer` / `kb-researcher` / `kb-fact-checker` subagents (`.codex/agents/`, `.github/agents/`) are Codex/Copilot-specific and not available to Claude. For broad or parallel KB work, use the Agent tool instead:

- `Explore` to quickly locate existing notes, check for duplicates, or map a folder before editing.
- `general-purpose` as a stand-in researcher for a specific domain area, gap analysis, or fact-check pass — always synthesize and review its output yourself before it touches a note or reaches the user. Treat subagent output as draft material, never paste it in unreviewed.

Don't spawn agents for single-note edits — read the neighborhood yourself and edit directly.

## Interview Prep Workflow (`Jobs/`)

- Reusable templates live in `Jobs/Interview Prep/_templates/`.
- One prep pack per opportunity: `Jobs/Interview Prep/<Company> - <Role> - <YYYY-MM-DD>/`.
- Required inputs: CV, job description, company name, role title, interview stage/date, and any user concerns. If the CV or JD is missing, search `Jobs/` first — don't invent personal evidence.
- Research current company/role context from primary sources; record URLs and access dates.
- Link prep guidance back to relevant `Areas/` notes. If KB coverage is thin, extend the smallest appropriate note using the standard note contract rather than duplicating material inside the prep pack.

## Answer Quality

- Be technically specific, concise, and explicit about confidence.
- Call out unresolved uncertainty instead of smoothing it over.
- Don't cite unsupported claims as fact.
- Reference existing note paths when they materially ground an answer, using Obsidian wikilink syntax (`[[Note Name]]`) consistent with the rest of the vault.
