# Interview Prep Folder Standard

Use this folder for reusable interview-prep templates and per-opportunity prep packs.

## Folder Naming

Create one folder per opportunity:

```text
Jobs/Interview Prep/<Company> - <Role> - <YYYY-MM-DD>/
```

Use the interview date when known. If there is no interview date yet, use the prep date and note that assumption in `00-inputs-and-source-pack.md`.

## Required Inputs

Each prep pack should identify:

- CV path or source file.
- Job description path or source file.
- Company name and official website.
- Role title.
- Interview stage and interview date, if known.
- Any user-provided constraints, concerns, or target outcomes.

If the CV or job description is missing, do not invent evidence. Mark the source as missing and continue only where useful.

## Document Contract

Copy these templates into each opportunity folder:

- `00-inputs-and-source-pack.md`
- `01-role-company-brief.md`
- `02-cv-jd-fit-map.md`
- `03-technical-prep-plan.md`
- `04-behaviour-story-bank.md`
- `05-question-bank.md`
- `06-gap-log.md`
- `07-final-briefing.md`

## Source Rules

- Candidate evidence must come from the CV, existing job notes, or explicit user input.
- Company claims need source URLs and access dates.
- Current vendor, framework, cloud, security, public-sector, or hiring-process claims need targeted research.
- Prep content should link to relevant KB notes with Obsidian wikilinks.
- Missing software-engineering documentation should be added or logged using the vault note template.

## Agent Workflow

Use `interview-prep-coordinator` for the full pack. It can route focused work to:

- `interview-company-researcher`
- `interview-evidence-mapper`
- `interview-technical-drill-builder`
- `interview-behaviour-coach`
- `interview-prep-reviewer`