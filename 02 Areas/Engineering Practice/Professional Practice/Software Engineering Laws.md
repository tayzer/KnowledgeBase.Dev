---
date: 2026-08-13
status: Current
tags:
  - knowledge-base
  - engineering-practice
  - professional-practice

---

# Software Engineering Laws

## Quick Reference

**Definition:** Named observations about project schedules, team structure, system growth, and measurement that help frame engineering decisions.

**When to use:** Use one as a prompt to question a plan or diagnose a pattern, then check whether its assumptions fit the situation.

**Key points:**
- These are heuristics, not rules that predict every project.
- Prefer evidence from the current team and system over a memorable quotation.
- Exact wording and attribution should be checked before quoting a law externally.

## Deep Dive

| Observation | Practical question | Limit |
| --- | --- | --- |
| Brooks' law | Will adding people to a late project add coordination and onboarding work before it adds capacity? | Does not mean adding capacity is always harmful; task independence and onboarding time matter. |
| Conway's law | Does the communication structure shape the system boundaries the team can sustain? | An influence on design, not proof that every module mirrors a team. |
| Linus's law | Will wider review and testing expose defects in this context? | Review helps only when reviewers have time, relevant skill, access, and feedback is acted on. |

These formulations are paraphrased prompts. The longer migrated source capture, including quotations and images needing provenance review, is [[Software Engineering Laws Historical Capture|preserved separately]].

### Sources checked

- Brooks, *The Mythical Man-Month* (1975), [book PDF hosted by Carnegie Mellon](https://www.cs.cmu.edu/afs/cs/academic/class/15712-s19/www/papers/mythicalmanmonth00fred.pdf). The schedule question paraphrases the book's discussion of adding manpower to late software projects; it is not a verbatim quote. Checked 2026-09-24.
- Conway, ["How Do Committees Invent?"](https://www.melconway.com/Home/Committees_Paper.html) (1968). The author's [retrospective](https://melconway.com/Home/Conways_Law.html) provides the familiar law wording. Checked 2026-09-24.
- Raymond, ["The Cathedral and the Bazaar"](https://catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/) (first presented 1997; linked revision 2002). Source of the named observation; treat the review claim as a conditional heuristic, not a defect-discovery guarantee. Checked 2026-09-24.

## Related Concepts
- [[Engineering Approaches]]
- [[Architecture Fitness Functions]]

## Review Schedule
- [ ] Recheck source links and attribution before quoting any law; revisit when adding a new observation.
