# Game AI
Date: 2026-04-30
Status: Needs Review
Tags: #gamedev #ai #goap #utility-ai

## 🎯 TL;DR / Quick Reference

**Definition:** A high-level overview of decision-making approaches used for non-player characters and autonomous systems in games.

**When to use:**
- When comparing approaches for NPC decision-making, behavior selection, and dynamic response systems.
- When deciding whether goal planning or score-based choice better fits a game’s AI needs.

**Key Takeaways:**
- ✅ **GOAP** is useful when agents need explicit goals, actions, and planning over possible steps.
- ✅ **Utility AI** is useful when agents need to score several possible actions and choose the best current option.
- ⚠️ **Authoring complexity matters:** the right approach depends on explainability, tooling, and how often behaviors need to change.

---

## 📚 Deep Dive

### What This Note Covers
This note currently serves as a compact overview of two common game-AI approaches that are worth expanding later into dedicated notes.

### Approaches
- **GOAP (Goal-Oriented Action Planning):** models AI as goals plus actions that can be chained into a plan.
- **Utility AI:** scores candidate actions based on the current world state and chooses the highest-value option.

### Selection Heuristics
- Use GOAP when the interesting part of the problem is planning toward goals across multiple steps.
- Use Utility AI when the interesting part is continuously evaluating the current situation and choosing among competing actions.
- Keep the authoring and debugging workflow in mind, not just the runtime behavior.

## 🔗 Related Concepts
- [[Areas/Domains and Specialisms/Game Development/Game Architecture/Entity Component System]]

## 🔄 Review Schedule
- [ ] Review in 3 months
