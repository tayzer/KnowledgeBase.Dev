---
name: kb-fact-check-protocol
description: "Fact-check software-engineering answers and note drafts with evidence and freshness checks. Use when claims are versioned, externally sourced, security-sensitive, disputed, or likely to have changed."
argument-hint: "Draft answer, claims, note path, and freshness concerns"
context: fork
---

# KB Fact-Check Protocol

## When to Use
- Validate a synthesized answer before it reaches the user.
- Verify current best-practice claims or framework-version guidance.
- Audit a note that might be stale, disputed, or insufficiently supported.

## Procedure
1. Break the material into concrete claims.
2. Use the vault first to identify what is already documented and whether the local note status implies caution.
3. Use the [evidence checklist](./references/evidence-checklist.md) to prioritize primary sources.
4. Record version, date, source quality, and any conflict between sources.
5. Mark each claim as supported, partially supported, unsupported, stale, or ambiguous.
6. Provide corrected wording or a narrower safe statement for any weak claim.
7. Flag notes that should be updated because the local KB appears behind current guidance.

## Output Expectations
- Claims checked
- Verdict per claim
- Evidence used and freshness notes
- Safer wording or corrections
- Candidate KB updates triggered by the review