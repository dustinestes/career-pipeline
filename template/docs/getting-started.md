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

- `candidate` (name, location)
- `contact` (`email` required; `phone` optional and omitted from HTML when absent)
- `compensation` and `preferences`
- `search` (target roles and terms)
- `background` (summary, experience, education, skills, stories)
- `naming` if you want different artifact basenames

Field checklist: [customization.md](customization.md). Plugin field guide: [docs/config.md](../../docs/config.md) (in a plugin checkout) or the same page on GitHub.

## 2. Build resume and cover letter HTML

Work with AI in Cursor to produce your HTML from the YAML.

1. Choose one resume sample and one cover letter sample under `design/` (for example `resume_sample_1.html` and `cover_letter_sample_1.html`).
2. Ask the agent to read `.career-pipeline.yml` as the only source of personal facts and rewrite the chosen samples into stable working files (for example `resume.html` and `cover-letter.html`).
3. Ask the agent to **delete all other sample HTML** in `design/` so only those two working files remain (plus optional `exports/`).
4. For every later application, cover letters under `submissions/` must reuse the working cover letter’s layout and styles. Follow the career-pipeline `cover-letter-standards` rule.

Do not leave sample persona details in your working files once you have replaced the example with your own.

## 3. Then use the pipeline skills

| Skill | When |
|-------|------|
| `source-leads` | Company discovery |
| `analyze-job` | A concrete posting |
| `initial-interview` / `next-interview` | Interview rounds |
| `archive-job` | Close or withdraw |

Example prompts:

- "Analyze this job posting: \<url\>"
- "Source leads for warehouse supervisor roles in Austin"
- "Prep me for the first interview at \<Company\>"

Human overview: [README.md](../README.md). Optional PDF tooling: [tooling.md](tooling.md).
