---
date: 2026-11-09
status: Needs Review
tags:
  - domain-driven-design
  - eventstorming
  - domain-discovery
  - collaborative-modeling
---

# EventStorming

## Quick Reference

**Definition:** EventStorming, introduced by Alberto Brandolini, is a collaborative workshop approach for exploring a business domain by arranging **significant facts that have happened** (domain events) into a shared timeline and incrementally exposing rules, decisions, misunderstandings, and possible boundaries.

**When to use:**
- Map an unfamiliar or cross-functional business domain and discover where people disagree about how work happens.
- Explore a particular workflow, its exceptions, policies, and hand-offs with domain experts.
- Investigate candidate subdomains or bounded contexts **before** committing to architecture, or refine a critical process for software design.

**Key Takeaways:**
- Start with **domain events** expressed in business language and past tense (for example, `Order Submitted`), not implementation events or a list of API calls.
- A **Big Picture** workshop explores the landscape; **Process Modelling** zooms into a workflow; **Software Design** adds technical design detail where justified. These are different scopes, not three compulsory meetings.
- Introduce new notation only when it improves a conversation. Capture disagreements and unanswered questions as **hotspots**.
- EventStorming is **not** Event Sourcing, CQRS, a message schema, or a mandate to deploy asynchronous services. Workshop events are modelling concepts, not automatically production integration events.
- **Limit:** Its output is a hypothesis about business reality and design opportunities, which still needs expert validation and executable verification of important rules.

## Core Building Blocks

| Element | Question it answers | Example |
| --- | --- | --- |
| Domain event | What business-significant fact has happened? | `Payment Authorised` |
| Hotspot | What is disputed, painful, or unknown? | "Can stock expire while payment is pending?" |
| Actor / external system | Who or what participates? | Customer, Payment Provider |
| Command / action | What intention can trigger a change? | `Reserve Stock` |
| Policy | What rule triggers or governs a reaction? | "After payment approval and stock reservation, confirm the order" |
| Read model / information | What facts are needed to decide? | Available stock, order status |
| Aggregate (design-level) | Where might a consistency/invariant boundary belong? | Order (candidate only) |

Orange sticky notes commonly represent domain events. Other colours differ by workshop style and facilitation convention; **agree a legend instead of treating colour as the underlying meaning**. Big Picture does not require commands, policies, read models, or aggregates to be drawn from the start.

**Event versus command:** `Order Confirmed` records something that occurred; `Confirm Order` names an intention. A business event may be relevant even when no software is involved. An event placed on the workshop wall says nothing yet about brokers, delivery guarantees, persistence, or event schema.

## Workshop Scopes

| Scope | Primary aim | Typical output |
| --- | --- | --- |
| **Big Picture** | Expose an end-to-end business landscape, terminology conflicts, bottlenecks, pivotal moments, and possible boundaries | Event timeline, hotspots, candidate areas for deeper inquiry |
| **Process Modelling** | Understand the decisions, triggers, participants, and exceptions of one workflow | Events connected to commands, actors, policies, and information needs |
| **Software Design** | Explore responsibility and consistency boundaries for a selected capability | Candidate aggregates, commands, events, and integration decisions to validate |

Select the smallest useful scope. A narrow process session can be run without first modelling the whole organisation, and a Big Picture session need not turn into software design.

## Running a Big Picture Workshop

1. **Define the business question and boundaries.** Explain the desired learning outcome, the segment of the business, and what is out of scope; invite knowledgeable people from different parts of the process.
2. **Create events independently.** Ask participants to write meaningful things that *happened* in past tense, one per note. Resist prematurely imposing a happy-path sequence or technical model.
3. **Build the shared timeline.** Place and rearrange the events in an approximately chronological flow. Discuss duplication, competing interpretations, parallel work, and missing steps.
4. **Mark hotspots.** Record conflicting terms, unknown policies, delays, exceptions, risks, and disagreements; do not force instant consensus.
5. **Identify pivotal moments and boundaries.** Look for business phases, changes in responsibility, friction, and language shifts. Treat subdomain and bounded-context boundaries as **candidates** to investigate, not lines proven by sticky notes.
6. **Choose the next investigation.** Prioritise hotspots or a high-value process for a more detailed session. Photograph or export the board, record a legend and glossary, and assign owners to unanswered questions.

For a narrower **Process Modelling** session, add actor-triggered commands, automated policies, required information, and success/failure paths as they become useful. In **Software Design**, challenge consistency invariants and ownership before deciding on aggregates or services.

## Worked Example: Online Order Fulfilment

*Illustrative events, not a universal business process or a suggested service architecture.*

```text
Order Submitted
    |
Stock Reserved  ---- alternative: Stock Reservation Failed
    |
Payment Authorised ---- alternative: Payment Declined
    |
Order Confirmed
    |
Parcel Dispatched
```

Questions and additional cards worth discussing:

- **Actor and command:** Customer issues `Submit Order`. What does the business mean by "submitted" versus "confirmed"?
- **Policies:** What must be true to confirm an order? Is stock reservation time-limited? When does a failed payment release stock?
- **Information:** Which actor or system knows available stock? How fresh must that view be?
- **Hotspot:** What happens when payment is authorised but the reservation expires or fulfilment fails?
- **Boundary hypothesis:** Payment, stock allocation, and fulfilment may have different language and owners; verify business invariants and change cadence before mapping them to bounded contexts or services.

The diagram is intentionally incomplete. A proper workshop should expose missing transitions, failure cases, cancellations, concurrent orders, and the different participants' interpretations. Derive precise behaviour examples or acceptance scenarios **after** resolving the relevant questions.

## Trade-offs and Failure Modes

**Strengths:** Works across disciplines, surfaces tacit knowledge and organisational disagreement, makes the flow of business facts visible, and supports strategic as well as detailed discovery.

**Costs and pitfalls:**
- Poor participant diversity or dominant voices can produce a persuasive but inaccurate model.
- The unstructured opening can feel chaotic; skilled facilitation is needed to make disagreement safe and useful.
- Event names can hide different meanings across contexts. Reconcile terminology locally rather than forcing one enterprise-wide definition.
- Do not infer one aggregate, microservice, queue topic, or database table per event or sticky-note cluster.
- Do not treat a clean timeline as proof that retries, concurrency, failure recovery, legal obligations, or non-functional needs have been handled.
- Do not mistake EventStorming's domain events for published integration events. Designing production messaging requires explicit contracts, ownership, durability, and failure semantics.

## Alternatives and Follow-through

- [[Domain Storytelling]] is often preferable for focused **actor collaboration, work-object hand-offs, and a concrete narrative**; it can provide a gentler entry into discovery.
- Process mapping or BPMN may be better when formal sequencing, gateways, and workflow responsibilities are the immediate target.
- Translate selected findings into agreed language, business decisions, bounded-context hypotheses, and acceptance examples. Use tests and design reviews to validate actual system behaviour and architectural boundaries.

## Related Concepts

- [[Domain Storytelling]] - complementary actor- and activity-centred domain discovery.
- [[40 Knowledge/Software Engineering/02 Areas/Architecture and System Design/Domain-Driven Design/_Index|Domain-Driven Design]] - domain language and strategic boundaries.
- [[Event-Driven Architecture]] - possible architecture choice, **not** implied by EventStorming.
- [[Event Sourcing]] - state persistence based on event history, a separate design decision.
- [[CQRS]] - separation of read and write models, also independent of the workshop method.

## Sources

- [EventStorming official website](https://www.eventstorming.com/) - creator's description, uses, and adaptable workshop styles; accessed 2026-11-09.
- [Alberto Brandolini, *Introducing EventStorming*](https://leanpub.com/introducing_eventstorming) - primary method reference, contents and scope; book page last updated 2021-08-26, accessed 2026-11-09.
- [Interview with Alberto Brandolini on DDD and EventStorming](https://www.codecentric.de/en/knowledge-hub/blog/alberto-brandolini-domain-driven-design-eventstorming) - incremental notation, hotspots, and distinction between Big Picture and process/software design; accessed 2026-11-09.
- [EventStorming official book overview](https://www.eventstorming.com/book/) - background and origins; accessed 2026-11-09.

## Review Schedule

- [ ] Review after facilitating or participating in a workshop, or within 12 months (by 2027-11-09). Confirm the notation choices, scope, and examples against primary sources before promotion to `Current`.
