# Documentation Templates
Date: 2026-04-30
Status: 🟢 Current
Tags: #documentation #knowledge-base #template #markdown

## 🎯 TL;DR / Quick Reference

**Definition:** Copyable markdown templates for the main note types used in this knowledge base.

**When to use:**
- When creating a new note from scratch.
- When normalizing an older note that does not follow the current structure.
- When deciding how much structure a hub note or draft note should have.

**Key Takeaways:**
- ✅ **Use the reference template by default** for single concepts, technologies, and practices.
- ✅ **Use the hub template** for category notes that route readers to child topics.
- ✅ **Keep draft notes lightweight** and out of `Areas/` until they are publishable.

---

## 📚 Deep Dive

### Reference Note Template
Use for one concept, pattern, technology, or practice.

````markdown
# <Title>
Date: <YYYY-MM-DD>
Status: 🟡 Needs Review
Tags: #tag1 #tag2

## 🎯 TL;DR / Quick Reference

**Definition:** <One-sentence description of the concept.>

**When to use:**
- <Case where the concept is appropriate>
- <Optional second case>

**Key Takeaways:**
- ✅ <Important benefit or principle>
- ✅ <Second important benefit or principle>
- ⚠️ <Important tradeoff, risk, or caveat>

**Code Snippet:**
```language
<Only include when an example materially helps>
```

**Gotchas:**
- ⚠️ <Common mistake, misconception, or hidden cost>

---

## 📚 Deep Dive

### Conceptual Foundation
<Explain why the concept exists and what problem it solves.>

### Practical Guidance
- <Concrete rule, tradeoff, or implementation tip>
- <Concrete rule, tradeoff, or implementation tip>

### Comparison With Alternatives
<Explain where this approach fits relative to nearby options.>

## 🔗 Related Concepts
- [[RelatedNote]]

## 📖 Resources
- <Official documentation or high-value reference>

## 🧪 Practice Exercises
1. <Exercise>
2. <Exercise>

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
````

### Hub Note Template
Use for category overviews that organize several child notes.

```markdown
# <Category Title>
Date: <YYYY-MM-DD>
Status: 🟡 Needs Review
Tags: #tag1 #tag2

## 🎯 TL;DR / Quick Reference

**Definition:** <What this category covers.>

**When to use:**
- <When someone should start with this hub note>

**Key Takeaways:**
- ✅ <High-level strength or selection rule>
- ⚠️ <Important tradeoff or boundary>

---

## 📚 Deep Dive

### What This Category Covers
<Describe the scope of the category and what is out of scope.>

### How To Choose Within This Category
- <Decision criterion>
- <Decision criterion>
- <Decision criterion>

### Child Notes
- [[ChildNoteOne]] - <What it is best for>
- [[ChildNoteTwo]] - <What it is best for>
- [[ChildNoteThree]] - <What it is best for>

## 🔗 Related Concepts
- [[RelatedHubOrReferenceNote]]

## 📖 Resources
- <Optional reference if it adds value>

## 🔄 Review Schedule
- [ ] Review in 3 months
```

### Draft Note Template
Use for raw ideas, TODOs, research fragments, and resource collections before promotion into `Areas/`.

```markdown
# <Draft Title>
Date: <YYYY-MM-DD>
Status: 🟡 Needs Review
Tags: #draft #tag1

## Goal
<What this draft is trying to capture or answer.>

## Current Notes
- <Observation>
- <Observation>

## Open Questions
- <Question>
- <Question>

## Candidate Related Notes
- [[PossibleTargetNote]]

## Next Step
- <Promote to reference note>
- <Promote to hub note>
- <Keep researching>
```

### Practical Rules
- Remove sections that do not add value.
- Do not keep empty optional sections in finished notes unless they serve as an intentional placeholder.
- If a note in `Areas/` still looks like the draft template, it is not ready yet.

---

## 🔗 Related Concepts
- [[Documentation Standards]]

## 📖 Resources
- [[NullableReferenceTypes]]
- [[Repository]]
- [[CodeReviewGuidelines]]

## 🧪 Practice Exercises
1. Create a new note from the reference template and compare it with an older note that does not follow the contract.
2. Rewrite one category note from a bullet dump into the hub template.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months