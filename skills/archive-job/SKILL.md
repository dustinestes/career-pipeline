---
name: archive-job
description: >-
  Moves a closed application to the archive folder and cleans up empty company
  directories. Use when the user rejects a role, receives a rejection, withdraws,
  or asks to archive an application.
disable-model-invocation: true
---

# Archive Job

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first).

## Instructions

**Input:** Company + role title, or path to `submissions/<Company>/<Job Title>/`. Optional: archive reason.

### Step 1: Confirm source

Verify `submissions/<Company>/<Job Title>/` exists. Confirm with user before moving.

### Step 2: Archive

Run from the **job-search workspace root** (cwd). The script resolves that root from cwd/git (or `CAREER_PIPELINE_ROOT`), not from the skill install path. Locate `scripts/archive-job.sh` on this installed skill (plugin path), then:

```bash
bash "<path-to-this-skill>/scripts/archive-job.sh" "<Company>" "<Job Title>" "[reason]"
```

Or perform equivalent steps manually:
1. Move folder to `submissions/.archive/<Company>/<Job Title>/`
2. Use `git mv` when files are tracked
3. If `submissions/<Company>/` has no remaining role subfolders, remove the empty company directory
4. If reason provided, write `notes.md` in the archived folder

### Step 3: Do not normalize legacy data

Archived trees may have inconsistent folder names from earlier workflow versions. Leave them as-is.

### Step 4: Commit

Offer commit only when user requests. Suggested message: `Archive <Company> — <Job Title>`.

## Examples

See [examples.md](examples.md).

## Additional resources

- Archive script: [scripts/archive-job.sh](scripts/archive-job.sh)
