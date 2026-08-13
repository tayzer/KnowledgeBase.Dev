# Interview Preparation Workflow
Date: 2026-06-22
Status: Needs Review
Tags: #developer-workflow #interview-prep #career-development #knowledge-base

## TL;DR / Quick Reference

**Definition:** A repeatable workflow for turning a CV, job description, company research, and this knowledge base into a focused software-engineering interview prep pack.

**When to use:**
- When preparing for a software-engineering interview with a known role or job description.
- When mapping CV evidence to job requirements.
- When a role exposes gaps in the knowledge base that should be documented before interview practice.

**Key Takeaways:**
- Use the CV and job description as the factual spine of the prep.
- Research current company and role context from primary sources.
- Link technical prep back to existing KB notes and add missing notes with the standard template.
- Keep candidate evidence, external research, and suggested answer framing clearly separate.

---

## Deep Dive

### Standard Prep Inputs

- CV or resume.
- Job description.
- Company name and official website.
- Interview stage and date.
- Existing job notes under `Jobs/`.
- User concerns, strengths, or target outcomes.

### Standard Prep Folder

Create one folder per opportunity:

```text
Jobs/Interview Prep/<Company> - <Role> - <YYYY-MM-DD>/
```

Use the template pack in `Jobs/Interview Prep/_templates/`:

- `00-inputs-and-source-pack.md`
- `01-role-company-brief.md`
- `02-cv-jd-fit-map.md`
- `03-technical-prep-plan.md`
- `04-behaviour-story-bank.md`
- `05-question-bank.md`
- `06-gap-log.md`
- `07-final-briefing.md`

### Evidence Rules

- CV evidence can be reframed, but not invented.
- Missing personal evidence should be marked as `Needs user evidence`.
- Company claims need source URLs and access dates.
- Current vendor, framework, cloud, security, and public-sector claims should be researched before finalizing.
- AI-generated application content must remain truthful and factually grounded in the user's own experience.

### KB Linking Rules

- Search the vault before writing technical prep.
- Link relevant notes with wikilinks.
- If a role asks for a topic that is missing or too thin, update the smallest existing note that fits.
- If no note exists, create one under the strongest `Areas/` taxonomy location using the standard note pattern.
- Track open documentation work in the prep folder's `06-gap-log.md`.

### Agent Routing

- Use `interview-prep-coordinator` for full prep packs.
- Use `interview-company-researcher` for company and role research.
- Use `interview-evidence-mapper` for CV-to-JD fit.
- Use `interview-technical-drill-builder` for technical drills and KB-linked study paths.
- Use `interview-behaviour-coach` for story preparation.
- Use `interview-prep-reviewer` before finalizing substantive prep packs.

## Related Concepts

- [[Areas/Engineering Practice/_Index]]
- [[Engineering Approaches]]
- [[Code Review Guidelines]]
- [[Inbox/Azure Functions Interview Cheat Sheet|Azure Functions Interview Cheatsheet]]

## Review Schedule

- [ ] Review in 3 months
