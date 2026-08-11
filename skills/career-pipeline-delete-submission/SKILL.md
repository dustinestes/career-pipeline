---
name: career-pipeline-delete-submission
description: >-
  Permanently deletes a submission folder under submissions/<Company>/<Role>.
  Use when the user does not want to archive and confirms hard delete. Requires
  company and role name.
disable-model-invocation: true
---

# Delete Submission

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Point at example / init.

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company | Yes | |
| Role / job title | Yes | |
| Explicit confirm | Yes | Irreversible (unless git history) |

## Output

- Folder removed from `submissions/`
- Empty company directory removed when no roles remain

## Instructions

1. Resolve path. Show it to the user and require explicit confirmation to hard-delete (not archive).
2. If they prefer keep history, redirect to `career-pipeline-archive-submission`.
3. From job-search workspace root:

```bash
bash "<path-to-this-skill>/scripts/delete-submission.sh" "<Company>" "<Job Title>"
```

4. Offer commit only when requested.

## Additional resources

- Script: [scripts/delete-submission.sh](scripts/delete-submission.sh)
