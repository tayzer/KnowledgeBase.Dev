---
date: 2026-04-30
status: Current
tags:
  - gamedev
  - ai
  - goap
  - utility-ai

---

# Game AI

## Quick Reference

**Definition:** Game AI is the design of game-agent perception, decision, and action systems that produce useful and understandable play, rather than necessarily optimal decisions.

**When to use:**
- When comparing approaches for NPC decision-making, behavior selection, and dynamic response systems.
- When choosing a decision model for an agent's behaviors, authoring tools, and frame budget.

**Key points:**
- Start with a small explicit rule set when behaviors are few and predictable. Add a more flexible model when the game needs it.
- Measure decision cost at the expected agent count and update rate; expensive planning need not run every frame.
- Debug the reason for an action, not only the resulting animation. Log state, selected action, and rejected alternatives.

---

## Deep Dive

### Choose a decision model

| Model | Useful when | Main cost or limit |
| --- | --- | --- |
| Finite state machine | A small set of explicit modes and transitions is enough. | Transitions become hard to manage as combinations multiply. |
| Behavior tree | Designers need hierarchical tasks with reusable selectors and sequences. | Tick order, shared state, and interruption rules need clear debugging. |
| Goal-oriented action planning (GOAP) | An agent should build a sequence of actions from preconditions, effects, and goals. | Action/world-state modeling and search cost grow with the domain; plans must handle state changes. |
| Utility scoring | An agent chooses among competing actions from current considerations. | Scores and curves require tuning; naive selection can oscillate. |

These can be combined. For example, utility scoring can choose a goal while a behavior tree executes it. Choose based on the player-visible behavior and authoring workflow, then prototype one agent and profile a crowd.

### Implementation checklist

1. Define observable inputs, actions, and the desired player experience.
2. Specify update frequency, interruption rules, and what happens when an action fails.
3. Make decisions inspectable in a debug view; record chosen action and decisive inputs.
4. Test edge cases such as missing targets, rapidly changing goals, and many simultaneous agents.

### Sources

- Jeff Orkin, ["Applying Goal-Oriented Action Planning to Games"](https://cdn.aaai.org/Workshops/2004/WS-04-04/WS04-04-006.pdf) (2004), for GOAP's action and planning model. Checked 2026-09-24.
- Dave Mark and Kevin Dill, ["Improving AI Decision Modeling Through Utility Theory"](https://media.gdcvault.com/gdc10/slides/MarkDill_ImprovingAIUtilityTheory.pdf) (GDC 2010), for utility scoring and consideration design. Checked 2026-09-24.
- The FSM and behavior-tree rows are general design summaries; source-specific details and engine APIs remain to be verified before expanding those sections.

## Related Concepts
- [[Entity Component System]]

## Review Schedule
- [ ] Review in 3 months
