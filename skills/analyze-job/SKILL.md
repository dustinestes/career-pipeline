---
name: analyze-job
description: >-
  Assesses a job posting for fit and builds application artifacts when approved.
  Use when the user shares a job listing URL, asks to analyze a role, or starts
  a new application.
disable-model-invocation: true
---

# Analyze Job

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first). Do not invent persona data.

## Instructions

### Phase 1: Assess (always first)

1. Read workspace-root `.career-pipeline.yml` for compensation, preferences, search targets, background, and naming patterns (see plugin `docs/config.md` for tokens and filename-safe cleanup).
2. Fetch the job posting from the URL provided (LinkedIn, careers page, or other).
3. Evaluate:
   - **Salary** — flag if below `compensation.salary_floor`; note if not listed; respect `equity_counts_toward_floor`
   - **Remote / location** — verify using `preferences.work_mode` and `preferences.location_notes`
   - **Fit** — strengths table, gaps, honest framing from `background`
   - **Career direction** — flag roles per `search.flag` / `target_roles` / `also_consider`
4. Resolve the assessment basename from `naming.assessment` and write content per the career-pipeline `assessment-format` rule.
5. **Stop.** Present the assessment and wait for proceed/pass. Do not create files until approved.

### Phase 2: Build (only after proceed)

Create `submissions/<Company>/<Job Title>/` and produce files in order. Resolve each basename from `.career-pipeline.yml` `naming.*` (sanitize `{companyName}`, `{shortRole}`, `{source}` per `docs/config.md`):

```
Task Progress:
- [ ] <naming.assessment>.md
- [ ] <naming.cover_letter>.html (clone layout/CSS from working `design/` cover letter; follow cover-letter-standards)
- [ ] <naming.cover_letter>.pdf
- [ ] Latest resume PDF from design/exports/ (preserve resolved naming.resume filename)
- [ ] Combined PDF: <naming.combined_pdf>.pdf
- [ ] Job posting PDF(s): <naming.job_posting_export>.pdf (set {source} per origin)
```

**Cover letter:** Copy the working cover letter under `design/` (layout and CSS unchanged). Edit only the branding block and letter body. Follow the career-pipeline `cover-letter-standards` rule.

**PDF export:** See [docs/tooling.md](docs/tooling.md).

**Job posting PDFs:**
- LinkedIn — user prints while logged in; `{source}` = `LinkedIn`
- Careers page — headless Chrome when possible; `{source}` = short company/site label
- Indeed or other boards — set `{source}` accordingly so exports do not overwrite each other

### Phase 3: Commit

Offer to stage and commit. Only commit when the user explicitly requests it. Message format: `Add <Company> application — <Job Title>`.

## Examples

See [examples.md](examples.md).

## Additional resources

- PDF export and prerequisites: [docs/tooling.md](docs/tooling.md)
- Config field guide: plugin `docs/config.md`
- Workspace config: `.career-pipeline.yml`
