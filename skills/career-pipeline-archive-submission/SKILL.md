---
name: career-pipeline-archive-submission
description: >-
  Moves a closed application to submissions/.archive and cleans up empty
  company folders. Use when the user rejects a role, receives a rejection,
  withdraws, or asks to archive a submission.
disable-model-invocation: true
---

# Archive Submission

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first).

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company + role (or submissions path) | Yes | |
| Archive reason | No | Written to `notes.md` |

## Output

- `submissions/.archive/<Company>/<Role>/`
- Optional `notes.md`

## Instructions

1. Confirm source exists; confirm with user before moving.
2. From job-search workspace root:

```bash
bash "<path-to-this-skill>/scripts/archive-submission.sh" "<Company>" "<Job Title>" "[reason]"
```

3. Offer commit only when requested: `Archive <Company> — <Job Title>`.

## Examples

See [examples.md](examples.md).

## Additional resources

- Script: [scripts/archive-submission.sh](scripts/archive-submission.sh)
