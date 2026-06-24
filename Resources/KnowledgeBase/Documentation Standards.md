# Documentation Standards
Date: 2026-04-30
Status: 🟢 Current
Tags: #documentation #knowledge-base #standards #markdown

## 🎯 TL;DR / Quick Reference

**Definition:** The publishing standard for software-engineering notes in this knowledge base.

**When to use:**
- When creating a new note under `Areas/`.
- When rewriting a thin, inconsistent, or placeholder note.
- When deciding whether a topic should be a reference note, hub note, or draft.

**Key Takeaways:**
- ✅ **Published notes need a minimum contract:** title, `Date`, `Status`, `Tags`, `TL;DR`, `Related Concepts`, and `Review Schedule`.
- ✅ **Not every note is the same type:** use reference notes for individual topics, hub notes for category overviews, and keep rough material in `Inbox/` until it is ready.
- ✅ **Quality beats coverage:** empty files, TODO-only pages, and raw bullet dumps should not live in `Areas/` as if they are complete notes.
- ⚠️ **Template compliance is not enough on its own:** a note can match the structure and still be too thin to be useful.

---

## 📚 Deep Dive

### Purpose
This vault already has a strong note pattern, but it is not yet applied consistently. The goal of this standard is to make new notes predictable, easier to maintain, and easier to navigate without forcing every page into the same depth.

### Note Types

#### 1. Reference Notes
Use a reference note for one concept, technology, pattern, or practice.

Examples:
- `Nullable Reference Types`
- `Clean Architecture`
- `Repository Pattern`

Reference notes are the default note type in `Areas/`.

#### 2. Hub Notes
Use a hub note when the topic is a category that points readers to several child notes.

Examples:
- `Relational Databases`
- `NoSQL Databases`
- `Cloud Storage Services`

Hub notes should summarize the category, explain how to compare options, and link to the child notes. They should not be loose encyclopedic bullet dumps.

#### 3. Draft Notes
Use a draft note for topic seeds, raw ideas, TODOs, resource lists, and partial research.

Draft notes belong in `Inbox/` until they are shaped into either a reference note or a hub note. Do not keep draft-only material in `Areas/`.

### Minimum Publish Gate For Notes In `Areas/`
A note is ready to live in `Areas/` only when all of the following are true:

1. It is not empty and not just `TODO`.
2. It includes:
   - a title
   - `Date`
   - `Status`
   - `Tags`
   - `## 🎯 TL;DR / Quick Reference`
   - `## 🔗 Related Concepts`
   - `## 🔄 Review Schedule`
3. The TL;DR includes:
   - `Definition`
   - `When to use`
   - `Key Takeaways`
4. It has at least one useful related concept or an intentional decision that no internal link exists yet.
5. It gives the reader enough guidance to make a better decision, not just a dictionary definition.

### Depth Expectations
- Use a short note when the topic is genuinely simple.
- Add `## 📚 Deep Dive` when the topic has important tradeoffs, implementation concerns, examples, or common mistakes.
- Add `## 📖 Resources` when there are high-value references worth returning to.
- Add `## 🧪 Practice Exercises` when the topic benefits from deliberate practice.
- Add `## 📝 Personal Notes` only when it captures useful project or learning observations.

If a note is in `Areas/` and still feels like a stub, either deepen it or move the rough content back to `Inbox/`.

### Linking And Naming Rules
- Prefer updating an existing note over creating a near-duplicate.
- Use wikilinks that match the target file name so the link resolves predictably.
- Use folder-qualified wikilinks only when disambiguation is necessary.
- Link to adjacent concepts that help the reader navigate decisions, not just anything loosely related.
- When a topic spans multiple areas, place it in the strongest primary area and bridge the rest with wikilinks.

### Status Guidance
- `🟢 Current`: the note is accurate enough to rely on.
- `🟡 Needs Review`: the note is incomplete, thin, or likely stale.

If a note is still exploratory rather than publishable, keep it out of `Areas/`.

### Recommended Review Flow
1. Decide whether the topic is a reference note, hub note, or draft.
2. Search for the closest existing note before creating a new one.
3. Start from the appropriate template in [[Resources/KnowledgeBase/Documentation Templates|Documentation Templates]].
4. Add the minimum required structure.
5. Add depth only where it materially helps the reader.
6. Add related links that help navigation.
7. Mark the note `🟡 Needs Review` if it is still thin or version-sensitive.

---

## 🔗 Related Concepts
- [[Resources/KnowledgeBase/Documentation Templates|Documentation Templates]]
- [[Code Review Guidelines]]

## 📖 Resources
- `.github/skills/kb-note-template/assets/note-template.md` for the agent-facing minimal template

## 🧪 Practice Exercises
1. Rewrite one empty or TODO-only note as a proper draft in `Inbox/`.
2. Convert one category note into a hub note with a decision guide and child links.
3. Take one thin note and decide whether to deepen it or downgrade it to `🟡 Needs Review`.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months