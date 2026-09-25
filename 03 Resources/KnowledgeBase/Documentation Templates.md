---
date: 2026-04-30
status: Current
tags:
  - documentation
  - knowledge-base
  - template
  - markdown
---

# Documentation Templates

## Quick Reference

**What it is:** Usage guide for the three canonical, copyable templates in `00 System/Templates/`.

**Use when:** Starting a reference note, category index, or one-idea Inbox capture.

**Key points:**
- [[00 System/Templates/Software Engineering - Reference Note|Reference Note]] is the default for a single published topic in `Areas/`.
- [[00 System/Templates/Software Engineering - Category Index|Category Index]] routes readers through published notes and approved planned categories.
- [[00 System/Templates/Software Engineering - Inbox Capture|Inbox Capture]] keeps one unfinished thought easy to revisit.

## Use in Obsidian

The vault's Templates core plugin is configured to use `00 System/Templates`. Create a new note, then run **Templates: Insert template** and choose one of the three Software Engineering templates. This guide does not change shared `.obsidian` settings.

The Reference Note and Inbox Capture templates use `{{title}}` for the active note title. All three use `{{date:YYYY-MM-DD}}` for today's date. Replace `Category Name` manually in a new `_Index.md`; Obsidian's `{{title}}` would insert `_Index`, not the category name. Keep the date variable quoted in YAML; edit template files in Source mode so Live Preview does not replace the variable while editing. In an existing note, Obsidian merges template properties with its current properties; inspect the result before saving.

See [Obsidian Templates](https://help.obsidian.md/Plugins/Templates) and [Obsidian Properties](https://help.obsidian.md/Editing+and+formatting/Properties).

## Choose and Finish a Template

| Need | Template | Before treating it as finished |
| --- | --- | --- |
| Explain one concept or decision | [[00 System/Templates/Software Engineering - Reference Note|Reference Note]] | Give a concrete use case, a key limit, useful related links, and deeper sections only where they help. |
| Navigate a category | [[00 System/Templates/Software Engineering - Category Index|Category Index]] | Link actual published notes and approved child indexes; leave planned topic names as text. |
| Capture a thought quickly | [[00 System/Templates/Software Engineering - Inbox Capture|Inbox Capture]] | Keep one idea per file and a next action; search for a canonical note during later review. |

Replace instructional text and remove empty optional sections. New `Areas/` notes start with `status: Needs Review`. Follow [[40 Knowledge/Software Engineering/03 Resources/KnowledgeBase/Documentation Standards|Documentation Standards]] before changing status to `Current`.

## Related Concepts

- [[40 Knowledge/Software Engineering/03 Resources/KnowledgeBase/Documentation Standards|Documentation Standards]]
- [[Taxonomy Rules|Taxonomy Rules]]

## Review Schedule

- Review when the templates or Obsidian workflow changes.
