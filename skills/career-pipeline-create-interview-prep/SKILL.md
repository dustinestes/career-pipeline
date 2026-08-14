---
name: career-pipeline-create-interview-prep
description: >-
  Builds interview prep for any round given company, role, round (1st/2nd/…),
  and audience. Creates interview - Nth folder on demand. Use for recruiter
  screens, hiring manager, technical, or later rounds.
disable-model-invocation: true
---

# Create Interview Prep

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Point at example / init.

Prefer an existing application under `submissions/<Company>/<Role>/` with `application/` artifacts (run `career-pipeline-create-application` first if missing).

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company | Yes | |
| Role | Yes | |
| Round | Yes | `1st`, `2nd`, `3rd`, … |
| Audience | Yes | recruiter, hiring manager, technical, panel, etc. |
| Format / topics / interviewer names | No | Ask if useful |

## Output

- Folder `submissions/<Company>/<Role>/interview - <Nth>/` created if missing (e.g. `interview - 1st`)
- `<naming.interview.prep>` in that folder (pattern + extension; default `interview-prep.md`) per career-pipeline `interview-prep-standards`

## Instructions

1. Resolve submission path. Ensure `email/` and `application/` exist (create-application); do not invent the old 14-folder skeleton. Read `naming.interview.prep` from YAML.
2. Map round → folder name: `interview - 1st`, `interview - 2nd`, … Create **only that** folder if missing.
3. Read analysis and prior prep under `application/` and earlier `interview - *` folders. Read invites from `email/` when present (user-exported mail only).
4. Write the prep file (`pattern` + `.` + `extension`) with metadata header (round + audience), company research, strengths/gaps, questions, salary notes per standards.
5. Offer commit only when requested.

## Additional resources

- Interview prep standards: career-pipeline `interview-prep-standards` rule
- Workspace config: `.career-pipeline.yml`
