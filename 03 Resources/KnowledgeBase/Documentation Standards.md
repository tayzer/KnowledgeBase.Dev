---
date: 2026-04-30
status: Current
tags:
  - documentation
  - knowledge-base
  - standards
  - markdown
---

# Documentation Standards

## Quick Reference

**What it is:** The publishing standard for software-engineering notes in this knowledge base.

**Use when:** Creating or reviewing a note in `Areas/`, a category index, or a quick capture in `Inbox/`.

**Key points:**
- Use one canonical home per concept. Use meaningful wikilinks for prerequisites, alternatives, applications, and category boundaries.
- Put a useful answer near the top. Add deeper material only when it helps a reader understand or act.
- Keep the 13 approved areas and planned categories. An empty category is a valid planned home, not an obsolete folder.
- Template structure does not certify factual accuracy. New published notes start as `Needs Review`.

## Note Types

### Reference note

Use for one concept, technology, pattern, or practice. Start from [[00 System/Templates/Software Engineering - Reference Note|Reference Note]]. The first heading is the title. Properties at the top hold `date`, `status`, and `tags`.

The required body is short: `Quick Reference` states what it is, when to use it, actionable points, and a meaningful limit; `Related Concepts` gives navigational links; `Review Schedule` says when to revisit. Add `Deep Dive`, examples, alternatives and tradeoffs, pitfalls, or sources only when useful. Remove empty optional sections before publishing.

### Category index

Use `_Index.md` for category boundaries and navigation. Start from [[00 System/Templates/Software Engineering - Category Index|Category Index]]. Show directly published notes under `Published Notes` and approved children under `Subcategories`; explain why a reader should open each link. Keep planned topics as plain text under `Planned Coverage` until their note exists. Mark planned branches clearly. Path-qualify and alias `_Index.md` wikilinks because their basenames repeat.

An index is a map, not a duplicate of its child notes. Planned categories remain in the tree even when they have no published topic yet.

### Inbox capture

Use [[00 System/Templates/Software Engineering - Inbox Capture|Inbox Capture]] for one raw thought, question, or idea per file. Keep its original context while shaping it. During review, search for an existing note first; then fold it in, keep researching, or publish a new reference note. Link the destination from the capture. Interview-only, machine-specific, and unverified material stays in `Inbox/` or `Jobs/` until suitable for reusable guidance.

## Publish and Review Gate

Before a note enters `Areas/`, check that it has a clear title, valid `date`, `status`, and `tags` properties, a useful `Quick Reference`, `Related Concepts`, and `Review Schedule`. Avoid empty files, TODO-only pages, raw bullet dumps, and unresolved placeholder links. If no related published note exists yet, say so in plain text rather than creating an unresolved link.

Use `Needs Review` for new, incomplete, unverified, or possibly stale notes. Set `Current` only after the whole note's important claims are supportable; a formatting pass or single checked claim does not promote it. For versioned, vendor, security, and performance guidance, check primary sources and record source and access or publication dates where relevant. See [[Content Review and Fact Check Queue|Content Review and Fact Check Queue]].

When normalizing an older `Areas/` note, preserve its original date, status, tags, meaning, and valid links. Convert body metadata to properties without silently changing review state. Use plain headings and bullets; avoid decorative icons.

## Navigation Rules

- Search the vault before making a new note. Prefer improving an existing canonical note over a duplicate.
- Use bare wikilinks only for unique note names; qualify ambiguous targets. Use path-qualified, aliased links for `_Index.md`.
- Link concepts when the relationship helps retrieval or comparison, not merely because terms co-occur.
- Place a cross-cutting topic in its strongest primary area and bridge other contexts with links.
- Update the nearest category index when a published note is added or moved. Keep planned-only navigation visible and clearly marked.

## Related Concepts

- [[Documentation Templates|Documentation Templates]]
- [[Taxonomy Rules|Taxonomy Rules]]
- [[Software Engineering Taxonomy|Software Engineering Taxonomy]]

## Review Schedule

- Review when the note contract or taxonomy changes.
