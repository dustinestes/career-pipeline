---
name: career-pipeline-create-application
description: >-
  Builds application artifacts for a role (skeleton, cover letter, PDFs). Use
  after career-pipeline-analyze-job proceed, or when the user already decided to apply and
  wants artifacts without a new assessment. Does not submit to an ATS.
disable-model-invocation: true
---

# Create Application

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first).

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company + role, or path under `submissions/` | Yes | |
| Job posting URL | If no assessment yet | Fetch posting for cover letter / exports |
| Existing assessment | Preferred | From prior `career-pipeline-analyze-job` |

## Output

```text
submissions/<Company>/<Role>/
  email/              # for user-exported .eml (manual; see docs)
  application/        # assessment, cover letter, resume PDF, combined, posting exports
```

## Instructions

1. Resolve `submissions/<Company>/<Role>/`. Prefer an existing assessment (role root or `application/`). If missing and the user skipped analyze, optionally run a light fit check or ask them to run `career-pipeline-analyze-job` first.
2. Run this skill's skeleton script (plugin skill path):

```bash
bash "<path-to-this-skill>/scripts/create-skeleton.sh" "<app-folder>"
```

Creates only `email/` and `application/` (lowercase; no numeric prefixes).

3. Move any role-root assessment into `application/` (basename from `naming.assessment`).
4. Produce artifacts into `application/` (basenames from YAML `naming.*`):

```
Task Progress:
- [ ] <naming.assessment>.md (already present or moved)
- [ ] <naming.cover_letter>.html (clone layout/CSS from working design/ cover letter)
- [ ] <naming.cover_letter>.pdf
- [ ] Latest resume PDF from design/exports/ (preserve naming.resume filename)
- [ ] Combined PDF: <naming.combined_pdf>.pdf
- [ ] Job posting PDF(s): <naming.job_posting_export>.pdf
```

**Cover letter:** Follow career-pipeline `cover-letter-standards`. **PDF export:** workspace `docs/tooling.md`.

**Email:** Do not automate mailbox sync. Remind the user they may export/print `.eml` into `email/` manually (optional `email/sent/` for outbound).

5. Offer commit only when the user requests. Message: `Add <Company> application — <Job Title>`.

## Additional resources

- Skeleton: [scripts/create-skeleton.sh](scripts/create-skeleton.sh)
- Tooling: workspace `docs/tooling.md`
- Config: plugin `docs/config.md`
