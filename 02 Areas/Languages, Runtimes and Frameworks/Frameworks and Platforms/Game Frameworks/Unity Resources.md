---
date: 2026-04-30
status: Current
tags:
  - unity
  - resources
  - gamedev
  - learning

---

# Unity Resources

## Quick Reference

**Definition:** A curated note for Unity-specific learning resources that are worth revisiting while exploring engine patterns and implementation details.

**When to use:**
- When starting a Unity-specific topic and you want official docs or runnable examples quickly.
- When you want a lightweight launch point for ECS/DOTS or procedural-generation exploration.

**Key Takeaways:**
- **Official docs and sample repositories** are the fastest way to understand Unity-specific APIs and workflows.
- **Runnable examples** are especially valuable for engine and systems topics.
- Caution: **Resource notes need pruning:** keep only references that are still useful and relevant.

---

## Deep Dive

### ECS / DOTS
- [Unity Entities samples: Jobs example](https://github.com/Unity-Technologies/EntityComponentSystemSamples/blob/master/EntitiesSamples/Assets/ExampleCode/Jobs.cs) — official job-system code in the samples repository. The repository README currently specifies Unity 6.2 and Entities package 1.4; check the file's branch before reuse.
- [Unity DOTS samples repository](https://github.com/Unity-Technologies/EntityComponentSystemSamples) — official runnable examples. README checked 2026-09-24: Unity 6.2 and package 1.4 releases for Entities, Netcode, Physics, and Entities.Graphics.

### Procedural Generation
- [Catlike Coding maze tutorial](https://catlikecoding.com/unity/tutorials/prototypes/maze-2/) — independent procedural-generation walkthrough. Its compatible Unity version was not stated on the page checked 2026-09-24; verify before following it in a current project.

### How To Use This Note
Use this as a resource hub, not as the main conceptual explanation. The deeper reasoning should live in the corresponding concept note, while this page holds the most useful starting references.

## Review refinements

For each resource, explain its learning task and applicable Unity editor and package version. Check redirects and update or remove retired links. Use the current Unity Manual and package documentation for version-specific APIs. This remains a resource hub; Godot guidance belongs in its planned category.

## Related Concepts
- [[Entity Component System]]

## Sources

- [Primary documentation](https://docs.unity3d.com/Manual/index.html) (accessed 2026-09-24; check version at source).

## Review Schedule
- [ ] Review 3 months after promotion; use the approval date as the anchor
