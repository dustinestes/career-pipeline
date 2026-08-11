# Getting started

Resume and persona setup is **pre-work**. Skills and automation need source material: who you are, what roles you want, and HTML you are willing to tailor per application.

## 1. Edit your persona file

Open **`.career-pipeline.yml`** at the workspace root (the template ships a filled Jordan Hale example).

Update at least:

- `candidate` (name, location)
- `contact` (`email` required; `phone` optional and omitted from HTML when absent)
- `compensation` and `preferences`
- `search` (target roles and terms)
- `background` (summary, experience, education, skills, stories)
- `naming` if you want different artifact basenames

Field checklist: [customization.md](customization.md). Plugin field guide: [docs/config.md](../../docs/config.md).

## 2. Build resume and cover letter HTML

Work with AI in Cursor to produce your HTML from the YAML.

1. Choose one resume sample and one cover letter sample under `design/` (for example `resume_sample_1.html` and `cover_letter_sample_1.html`). More samples may be added later.
2. Ask the agent to read `.career-pipeline.yml` as the only source of personal facts and rewrite the chosen samples into stable working files (for example `resume.html` and `cover-letter.html`).
3. Ask the agent to **delete all other sample HTML** in `design/` so only those two working files remain (plus optional `exports/`).
4. For every later application, cover letters under `submissions/` must reuse the working cover letter’s layout and styles. Follow `.cursor/rules/cover-letter-standards.mdc` for tone and structure.

Do not leave sample persona details in your working files once you have replaced the example with your own.

## 3. Then use the pipeline skills

With YAML and design sources in place, invoke skills as needed:

| Skill | When |
|-------|------|
| `source-leads` | Company discovery |
| `analyze-job` | A concrete posting |
| `initial-interview` / `next-interview` | Interview rounds |
| `archive-job` | Close or withdraw |

Human overview: [README.md](../README.md). Optional PDF tooling: [tooling.md](tooling.md).
