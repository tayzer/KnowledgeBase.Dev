# C ou pl in g
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #engineering-practice #maintainability-and-code-health

## TL;DR / Quick Reference

**Definition:** Reference guidance for C ou pl in g.

**When to use:**
- Use this note when making a decision about C ou pl in g.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.

- Operational Coupling (Runtime dependencies)
- Developmental Coupling (Code that must change in lockstep)
- Semantic Coupling (Shared concepts and meanings)
- Functional Coupling (Competing implementations of the same logic)
- Incidental Coupling (Accidental or pure-chance dependencies)

Don't eliminate coupling, move it to where its more managable.

Warning signs
- Slow builds
- Complex test setup
- Brittle tests
- Blocked teams
- Lockstep platform releases
- Long parameter lists

Ideas
- Start with CI
- Hide information behind APIs
- Guard boundaries between modules/services/teams
- Translate and validate external data at the edge
- Accounce, dont command (Event-based design)
- Consume parsimoniously, produce generously
- Use messages unless semantics are fixed
- Tighten whats stable, loosen whats uncertain
- Use TDD to detect coupling (listen to hard tests)
- Decide which coupling to accept



## Related Concepts
- [[Areas/_Index|Software Engineering Knowledge Base]]

## Review Schedule
- [ ] Review in 3 months.
