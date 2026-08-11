# Getting started

Resume and persona setup is **pre-work**. Skills need a real config file and HTML you are willing to tailor per application.

## 0. Init (if this folder is empty)

With the career-pipeline plugin installed, in an empty folder say:

- "Set up a career-pipeline workspace here"
- or `/career-pipeline-init`

That copies design samples, `leads/`, `submissions/`, docs, and `.career-pipeline.yml.example`. It does **not** create `.career-pipeline.yml`.

## 1. Create and edit your persona file

```bash
cp .career-pipeline.yml.example .career-pipeline.yml
```

Edit `.career-pipeline.yml`. Job-search skills refuse to run until this file exists.

Update at least:

- `candidate`, `contact`, optional `links`, `compensation`, `preferences`
- `search` (target roles, terms; optional `ignore_companies`)
- `background`, `naming` as needed

Field checklist: [customization.md](customization.md). Skill catalog: [skills.md](skills.md).

## 2. Build resume and cover letter HTML

1. Choose samples under `design/`.
2. Ask the agent to rewrite from `.career-pipeline.yml` into working files (e.g. `resume.html`, `cover-letter.html`).
3. Delete unused samples so only working files remain (plus optional `exports/`).

## 3. Two ways to find roles

**Lead-sourced:** `/career-pipeline-source-leads` (or a scheduled host task) → pass roles into `/career-pipeline-analyze-job`.

**Direct:** paste a job URL into `/career-pipeline-analyze-job`.

Then `/career-pipeline-create-application` for artifacts. Prep rounds with `/career-pipeline-create-interview-prep`.

Export mail into `email/` yourself if you want it on file (no mailbox automation in this plugin).

Full tables: [skills.md](skills.md). Optional PDF tooling: [tooling.md](tooling.md).
