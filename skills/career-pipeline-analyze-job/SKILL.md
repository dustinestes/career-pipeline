---
name: career-pipeline-analyze-job
description: >-
  Assesses a job posting for fit and writes an assessment under submissions.
  Use when the user shares a job listing URL, passes roles from a lead file,
  asks to analyze a role, or wants apply/pass guidance (does not build cover
  letter or PDFs).
disable-model-invocation: true
---

# Analyze Job

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first). Do not invent persona data.

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Job posting URL(s) and/or lead file / role list | Yes | Manual URL **or** roles from `leads/<Company>.md` |
| Company + role (if not clear from posting) | Ask if missing | Used for `submissions/<Company>/<Role>/` |

Process **each** selected role separately (batch from a lead file is fine).

## Output

- `submissions/<Company>/<Role>/<naming.assessment>.md` (at role root until create-application promotes it)
- Apply / pass guidance in chat; offer handoff to `career-pipeline-create-application` on proceed

## Instructions

1. Read workspace-root `.career-pipeline.yml` for compensation, preferences, search targets, background, and naming patterns (plugin `docs/config.md`).
2. Resolve company + role. Check for an existing assessment at:
   - `submissions/<Company>/<Role>/<naming.assessment>.md`
   - or `submissions/<Company>/<Role>/application/<naming.assessment>.md`
   If found: **stop**, show the path, ask refresh/overwrite vs leave alone. Do not re-analyze unless the user confirms refresh.
3. Fetch the posting. Evaluate salary, remote/location, fit, and career direction per YAML.
4. Create `submissions/<Company>/<Role>/` if missing. Write the assessment file at the **role root** using `naming.assessment` and the career-pipeline `assessment-format` rule.
5. Present apply/pass guidance. **Do not** create cover letters, PDFs, or `email/` / `application/` skeleton — that is `career-pipeline-create-application`.
6. On proceed, tell the user to run `/career-pipeline-create-application` (or ask in natural language).

## Examples

See [examples.md](examples.md).

## Additional resources

- Config: plugin `docs/config.md`
- Workspace config: `.career-pipeline.yml`
- Next step: `career-pipeline-create-application`
