---
name: career-pipeline-accept-job
description: >-
  Promotes an accepted offer from submissions into career/<Company>/<Role>/ as
  employment history. Use after career-pipeline-analyze-offer when the user
  accepts a job, or when they ask to move a role into career history.
disable-model-invocation: true
---

# Accept Job

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first).

Prefer `career-pipeline-analyze-offer` first (`offer/` + `naming.offer.analysis`). If that review is missing, warn and continue only after the user confirms they already accepted.

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company + role, or path under `submissions/` | Yes | Ask if missing |
| Start month | No | `YYYY-MM`. Resolve from the offer letter; else ask; else this month |

## Output

```text
career/<Company>/<Role>/
  application/           # moved from the submission
  email/
  interview - Nth/       # moved when present
  offer/                 # offer packet and details
  onboarding/            # new hire paperwork
  relocation/            # move, housing, visa
  reviews/               # performance reviews
  issues/                # workplace issues / HR notes
  leaving/               # resignation and offboarding
```

`.career-pipeline.yml` `background.experience`: new current role prepended; any `end: present` set to the start month.

## Instructions

1. Resolve `submissions/<Company>/<Role>/`. If it is missing and `career/<Company>/<Role>/` already exists, **stop** and show the career path (already accepted).
2. Resolve start month (`YYYY-MM`), then confirm the move:
   1. Read `offer/` (offer letter, packet files, offer analysis from `naming.offer.analysis`) and extract the start / hire / first-day date when present. Convert to `YYYY-MM`.
   2. If none is found, ask the user for the start month.
   3. If the user does not provide one, use this month.
   If YAML has a current `end: present` job, tell them that entry’s end becomes this start month.
3. From job-search workspace root:

```bash
bash "<path-to-this-skill>/scripts/accept-job.sh" "<Company>" "<Job Title>" "[YYYY-MM]"
```

4. Confirm `career/<Company>/<Role>/` and the YAML experience update (or edit manually if the script warned). Other open submissions stay in `submissions/`; archive or delete them separately if the search is over.
5. Offer commit only when requested: `Accept <Company> — <Job Title>`.

## Examples

See [examples.md](examples.md).

## Additional resources

- Script: [scripts/accept-job.sh](scripts/accept-job.sh)
- Prior step: `career-pipeline-analyze-offer`
- Folder map: plugin `docs/skills.md` (workspace copy: `docs/skills.md`)
