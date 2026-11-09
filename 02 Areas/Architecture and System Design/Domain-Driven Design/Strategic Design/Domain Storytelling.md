---
date: 2026-11-09
status: Needs Review
tags:
  - domain-driven-design
  - domain-modeling
  - domain-discovery
  - collaborative-modeling
---

# Domain Storytelling

## Quick Reference

**Definition:** Domain Storytelling is a collaborative domain-discovery technique in which domain experts narrate concrete examples of how work happens while a facilitator draws a simple, numbered pictographic story showing **who does what, with what, and with whom**.

**When to use:**
- Discover how a business process actually works across people, departments, and software.
- Build a shared domain vocabulary before choosing data models, service boundaries, or implementation details.
- Compare the current process (*as-is*) with a proposed process (*to-be*) or investigate a confusing hand-off.

**Key Takeaways:**
- Model a **specific scenario**, normally the common or happy path first, rather than trying to encode every possible branch in one diagram.
- Show **actors**, **work objects**, and **activities**; number the activities so the domain expert can retell the story in order.
- Record assumptions and exceptions as annotations; model materially different cases as separate stories.
- Replay the completed story with domain experts and preserve disagreements or unresolved questions.
- **Limit:** A domain story is a shared-understanding aid, not a complete requirements specification, a BPMN model, or proof that the future software design is correct.

## How the Notation Works

| Element | Meaning | Example |
| --- | --- | --- |
| Actor | A person, group, or system actively participating in the story | Customer, Sales Clerk, Warehouse |
| Work object | Something an actor creates, uses, changes, or passes on; physical or informational | Order, Stock List, Pick List |
| Activity | An arrow labelled with a domain verb, initiated by an actor | submits, checks, sends |
| Sequence number | The order in which the story's activities are told | 1, 2, 3... |
| Annotation / group | Assumption, exception, clarification, or meaningful boundary | "Assume the item is in stock" |

Use the experts' terms rather than translating them immediately into classes, endpoints, tables, or messages. The same work object may appear more than once as activities progress. A story is not a conventional flowchart: branching logic is usually better handled with notes or another concrete scenario.

## Running a Workshop

1. **Set the question and scope.** Choose a business outcome and decide whether to describe *as-is* or *to-be*, at a coarse or detailed level, and whether software systems belong in the picture.
2. **Invite the right people.** Include the practitioners who do the work, relevant neighbouring roles, and a facilitator; do not substitute only architects or managers for domain expertise.
3. **Ask for one real or realistic example.** Start with a common case. Ask: "Who starts this?", "What do they work with?", and "What happens next?"
4. **Draw a sentence at a time.** Add an actor, action arrow, work object, and sequence number, leaving time for the experts to correct the drawing. Do not pre-design the system on their behalf.
5. **Probe hand-offs and surprises.** Ask where information comes from, who owns each decision, what changes, and what happens in a materially different case. Annotate uncertainties instead of silently resolving them.
6. **Retell and validate.** Read the numbered story from the beginning. Have participants correct it, identify vocabulary conflicts, and agree which alternative stories deserve a separate pass.
7. **Turn insights into follow-up work.** Capture glossary terms, business rules, questions, candidate boundaries, and concrete acceptance examples. Confirm these separately; the picture itself is not an approval of software behaviour.

A whiteboard, paper, or shared canvas is enough. The facilitator's pacing and participation matter more than polished artwork.

## Worked Example: Fulfilling an Order

*Illustrative scenario, not a universal ordering process: an item is in stock and payment has already been accepted.*

1. **Customer** submits an **Order** to **Sales**.
2. **Sales** checks the **Stock List** for the ordered item.
3. **Sales** sends an **Order Confirmation** to **Customer**.
4. **Sales** sends a **Pick List** to **Warehouse**.
5. **Warehouse** picks the **Item**, prepares a **Parcel**, and hands it to **Carrier**.

The drawn version would contain actors and work-object icons connected by numbered activity arrows. This text merely captures the narrated sentences; it is **not** the full pictographic notation.

**Follow-up stories/questions:** What happens when stock is unavailable? Who can cancel after confirmation? Does Warehouse interpret "picked" the same way Sales does? Do the hand-offs suggest separate ownership or only organisational boundaries? These are discovery questions, **not** predetermined bounded contexts.

## Scope, Outputs, and Trade-offs

- **Scope choices:** coarse versus detailed; *as-is* versus *to-be*; *pure* (without software) versus *digitalised* (including software). State these before comparing drawings.
- **Outputs worth keeping:** a photograph or editable story with scope and date, glossary, assumptions, unresolved questions, alternative scenarios, and links to proposed requirements or examples.
- **Strengths:** accessible to non-technical practitioners; exposes hidden work, role differences, information flows, and inconsistent terminology.
- **Weaknesses:** facilitation and participant selection affect results; a tidy story can conceal exceptions, timing, concurrency, or organisational disagreement.
- **Avoid:** drawing only the idealised process; turning every noun into a class; forcing conditional branches into the pictographic language; treating the diagram as an executable acceptance test.

## Choosing Between Techniques

- Use **Domain Storytelling** when the key question is **who collaborates, what they exchange, and how a concrete workflow unfolds**.
- Use [[EventStorming]] when the key question is **which domain-significant facts occur, in what order, and where the rules, friction, and boundaries lie**. It is also suitable for broad, initially messy exploration; it does not require an event-driven architecture.
- Use detailed process notation (for example BPMN) when explicit branching, gateways, or formal workflow analysis is needed. Use example-based acceptance tests when the goal becomes verifiable behaviour rather than initial discovery.
- These techniques can complement one another: stories can reveal actors and hand-offs to investigate through events, and EventStorming hotspots can identify specific stories to narrate.

## Related Concepts

- [[EventStorming]] - complementary domain discovery using business events and timeline-based modelling.
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Domain-Driven Design/_Index|Domain-Driven Design]] - broader modelling practice and domain language.
- [[Behavior-Driven Development]] - collaborative specification of concrete, testable behaviour after discovery.

## Sources

- [Hofer and Schwentner, Domain Storytelling: Quick-Start Guide](https://domainstorytelling.org/quick-start-guide) - primary method description, notation, scope, and workshop procedure; accessed 2026-11-09.
- [Domain Storytelling: Requirements](https://domainstorytelling.org/requirements) - connecting stories to requirements; accessed 2026-11-09.
- [Hofer and Schwentner, *Domain Storytelling* (Addison-Wesley, 2022)](https://domainstorytelling.org/book) - method reference; book description checked 2026-11-09.
- [Thoughtworks Technology Radar: Domain storytelling](https://www.thoughtworks.com/en-gb/radar/techniques/domain-storytelling) - practitioner perspective and comparison; published 2024-10-23, accessed 2026-11-09.

## Review Schedule

- [ ] Review after applying the technique in a real workshop, or within 12 months (by 2027-11-09), and validate that the examples and method descriptions still match the primary sources.
