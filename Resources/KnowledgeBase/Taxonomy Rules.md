# Taxonomy Rules
Date: 2026-08-13
Status: 🟢 Current
Tags: #knowledge-base #taxonomy #information-architecture

## TL;DR / Quick Reference

**Definition:** Rules for creating, moving, naming, and linking published software-engineering notes.

**When to use:**
- Before adding or relocating a note under `Areas/`.
- When one topic could appear in several disciplines.

**Key Takeaways:**
- Areas define disciplines; category folders classify; notes hold knowledge; links express relationships; indexes teach the map.
- Give each concept one canonical home. Use links for cross-cutting relationships.
- Planned topics stay plain text until a real note exists.

## Deep Dive

### Canonical Home

Choose a home from reader intent, not product name or team ownership. A reusable concept belongs in its strongest discipline; provider-, runtime-, protocol-, and domain-specific treatment may be separate only when it adds distinct knowledge.

### Naming and Links

- Avoid duplicate basenames except `_Index.md`.
- Qualify contextual duplicates, for example `ASP.NET Core Configuration` and `Kubernetes Configuration`.
- Use bare wikilinks only for unique note names.
- Every `_Index.md` link is fully path-qualified and aliased.
- Do not link planned coverage.

### Indexes and Extensions

- `_Index.md` is navigation and scope boundary, not duplicated concept prose.
- The 13 top-level areas and approved category model are fixed.
- A valid omitted topic may be a documented leaf extension under the nearest category. Do not create a new top-level area without explicit approval.

### Note Quality

- Published notes need title, date, valid status, tags, TL;DR, related concepts, and review schedule.
- `🟢 Current` requires reviewed, supportable content. Formatting never promotes a note.
- Use `🟡 Needs Review` for unverified provider, framework, package, security, or version-sensitive material.
- Keep raw, machine-specific, and interview-only material in `Inbox/` or `Jobs/`.

### Migration

- Use `git mv` for tracked notes where possible.
- `Migrate-Taxonomy.ps1` is retired: it uses copy/delete moves and encodes obsolete paths.
- This is a clean cutover. Do not recreate legacy `Areas` paths, redirect stubs, or move-on-touch rules.

## Related Concepts
- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]
- [[Resources/KnowledgeBase/Documentation Standards|Documentation Standards]]
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]

## Review Schedule
- [ ] Review after an approved taxonomy change.
