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
| Archive reason | No | Written to `naming.archive.notes` (pattern + extension) |

## Output

- `submissions/.archive/<Company>/<Role>/`
- Optional notes file from `naming.archive.notes` (default `archive-notes.md`)

## Instructions

1. Confirm source exists; confirm with user before moving.
2. Read `naming.archive.notes.pattern` and `.extension` from workspace-root `.career-pipeline.yml` (defaults: `archive-notes`, `md`).
3. From job-search workspace root:

```bash
bash "<path-to-this-skill>/scripts/archive-submission.sh" "<Company>" "<Job Title>" "[reason]" "[notes-basename]" "[notes-extension]"
```

Pass the YAML pattern as the notes basename and extension as the fifth arg. When reason is empty, omit args 3–5 or pass empty reason.

4. Offer commit only when requested: `Archive <Company> — <Job Title>`.

## Examples

See [examples.md](examples.md).

## Additional resources

- Script: [scripts/archive-submission.sh](scripts/archive-submission.sh)
- Related (hard delete): `career-pipeline-delete-submission`
