---
name: career-pipeline-init
description: >-
  Scaffolds an empty job-search workspace from the career-pipeline template
  (design, leads, submissions, consumer docs, example YAML). Use when the user
  asks to init, initialize, set up, or scaffold a career-pipeline / job-search
  workspace, or invokes /career-pipeline-init.
disable-model-invocation: true
---

# Career Pipeline Init

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Target directory | No | Default: cwd |
| Explicit override if non-empty | No | Pass `--force` only after user confirms |

## Output

- Scaffold folders + `.career-pipeline.yml.example` (no live YAML; no skills/rules)

## Instructions

### Step 0: Confirm target

1. Default target is the open workspace / cwd.
2. Do **not** init inside the career-pipeline **plugin** repo.
3. Prefer an **empty** folder (a bare `.git` directory is OK).
4. If the folder is not empty: warn, explain merge risk, and proceed only after the user explicitly overrides. Then pass `--force` to the script.
5. If the folder already looks like a career-pipeline workspace (live `.career-pipeline.yml`, or design/leads/submissions plus example/docs), **stop**. Ask them to use a new folder.

### Step 1: Run scaffold

From the target directory (cwd = job-search folder), run this skill's script:

```bash
# Resolve path from the installed career-pipeline-init skill (plugin), not from .cursor/skills
bash "<path-to-this-skill>/scripts/init-workspace.sh"
# Non-empty override after user confirmation:
bash "<path-to-this-skill>/scripts/init-workspace.sh" --force
```

The script copies **consumer payload only** from plugin `template/`:

- `design/`, `leads/`, `submissions/`
- `docs/`, `AGENTS.md`, `README.md`
- `.career-pipeline.yml.example`

It does **not** copy skills or rules (those stay on the plugin). It does **not** create `.career-pipeline.yml`.

### Step 2: Personalization checklist (always show)

After a successful init, tell the user:

1. Copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and replace Jordan Hale with their details.
2. Build working resume/cover HTML from `design/` samples (see `docs/getting-started.md`).
3. Then run a job skill, for example `/career-pipeline-analyze-job` with a posting URL (see `docs/skills.md`).

Job-search skills refuse to run until `.career-pipeline.yml` exists.

### Natural language examples

Users can say things like:

- "Set up a career-pipeline workspace in this folder"
- "Initialize my job search repo"
- "Scaffold career-pipeline here"

Or invoke `/career-pipeline-init` explicitly.

## Additional resources

- Scaffold script: [scripts/init-workspace.sh](scripts/init-workspace.sh)
- Consumer getting started: plugin `template/docs/getting-started.md` (copied into the workspace as `docs/getting-started.md`)
