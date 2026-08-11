---
name: career-pipeline-source-leads
description: >-
  Researches companies matching the candidate profile (or user seed criteria)
  and writes leads/<Company>.md with matching open roles. Use for ad-hoc or
  scheduled lead discovery; feed roles into career-pipeline-analyze-job next.
  Skips companies listed in search.ignore_companies.
disable-model-invocation: true
---

# Source Leads

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first).

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Seed companies / criteria | No | Otherwise use YAML `search` + `preferences` |
| Confirm short list before deep research | Yes (unless user named companies) | |

## Output

- `leads/<Company>.md` per career-pipeline `lead-format` rule
- Chat summary; do **not** auto-run `career-pipeline-analyze-job`

## Instructions

### Phase 1: Establish criteria

1. Read `.career-pipeline.yml` for compensation, preferences, and `search` (including `ignore_companies`).
2. Skip any company in `search.ignore_companies` (and prefer not to re-propose archived leads under `leads/.archive/`).
3. Confirm the short list unless the user already named companies.

### Phase 2: Research (per company)

If `leads/<Company>.md` exists, refresh per `lead-format`. Otherwise research careers page, overview, products, sentiment, news, and matching open roles; write the lead file.

### Phase 3: Present

Summarize leads. Tell the user they can pass one URL, several roles, or the whole lead file into `career-pipeline-analyze-job`.

## Examples

See [examples.md](examples.md).

## Additional resources

- Workspace config: `.career-pipeline.yml`
- Lead format: career-pipeline `lead-format` rule
- Archive a lead: `career-pipeline-archive-lead`
