---
name: analyze-job
description: >-
  Assesses a job posting for fit and builds application artifacts when approved.
  Use when the user shares a job listing URL, asks to analyze a role, or starts
  a new application.
disable-model-invocation: true
---

# Analyze Job

## Instructions

### Phase 1: Assess (always first)

1. Read `4 - Reference/candidate-profile.md` for salary floor, remote requirement, target roles, background facts, and file naming.
2. Fetch the job posting from the URL provided (LinkedIn, careers page, or other).
3. Evaluate:
   - **Salary** — flag if below floor; note if not listed
   - **Remote** — verify actual location (see candidate profile location note)
   - **Technical fit** — strengths table, gaps, honest framing
   - **Career direction** — flag ops/consulting/management per candidate profile
4. Write assessment content per `.cursor/rules/assessment-format.mdc`.
5. **Stop.** Present the assessment and wait for proceed/pass. Do not create files until approved.

### Phase 2: Build (only after proceed)

Create `submissions/<Company>/<Job Title>/` and produce files in order:

```
Task Progress:
- [ ] assessment.md
- [ ] cover-letter-<company>.html (from design/cover-letter.html)
- [ ] cover-letter-<company>.pdf
- [ ] Latest resume PDF from design/Exports/ (preserve filename)
- [ ] Combined PDF: <Prefix>_<Company>_<ShortRole>.pdf
- [ ] Job posting PDF(s)
```

**Cover letter:** Edit CSS branding block and body. Follow `.cursor/rules/cover-letter-standards.mdc`.

**PDF export:** See [docs/tooling.md](docs/tooling.md).

**Job posting PDFs:**
- LinkedIn — user prints while logged in; document overflow fix if needed
- Careers page — headless Chrome when possible

### Phase 3: Commit

Offer to stage and commit. Only commit when the user explicitly requests it. Message format: `Add <Company> application — <Job Title>`.

## Examples

See [examples.md](examples.md).

## Additional resources

- PDF export and prerequisites: [docs/tooling.md](docs/tooling.md)
- Candidate profile: `4 - Reference/candidate-profile.md`
