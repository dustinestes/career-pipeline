---
name: career-pipeline-archive-lead
description: >-
  Archives a company lead file to leads/.archive and adds the company to
  search.ignore_companies so career-pipeline-source-leads skips it. Use when the user wants to
  stop monitoring a company.
disable-model-invocation: true
---

# Archive Lead

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first). Needed for `ignore_companies`.

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company name | Yes | Must match `leads/<Company>.md` |
| Reason | No | Optional note |

## Output

- `leads/.archive/<Company>.md`
- Company appended to `.career-pipeline.yml` `search.ignore_companies`

## Instructions

1. Confirm `leads/<Company>.md` exists and the user wants to stop monitoring.
2. Run from job-search workspace root:

```bash
bash "<path-to-this-skill>/scripts/archive-lead.sh" "<Company>" "[reason]"
```

3. Confirm the YAML ignore list updated (or edit manually if the script warned).

## Additional resources

- Script: [scripts/archive-lead.sh](scripts/archive-lead.sh)
