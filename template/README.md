# Career pipeline workspace

Forkable job-search workspace used with the **career-pipeline** plugin (skills + rules).

## Quick start

1. Install or symlink the parent **career-pipeline** plugin (see parent README)
2. Edit [`.career-pipeline.yml`](.career-pipeline.yml) (ships as a Jordan Hale example; replace with your details)
3. Build resume and cover letter HTML from a sample under `design/` (work with AI; details in getting started)
4. In Cursor, invoke `/analyze-job` with a posting URL (or ask in natural language)

Walkthrough: [docs/getting-started.md](docs/getting-started.md).

## Lifecycle

| Stage | Invoke | Output |
|-------|--------|--------|
| Company discovery | `source-leads` | `leads/<Company>.md` |
| New posting | `analyze-job` | Assessment + cover letter + PDFs under `submissions/` |
| Interview invite | `initial-interview` | Phase skeleton + prep |
| Later rounds | `next-interview` | Round prep |
| Closed | `archive-job` | Moved under `.archive/` |

## Docs

- [docs/getting-started.md](docs/getting-started.md) — Persona YAML + resume HTML pre-work
- [docs/customization.md](docs/customization.md) — YAML profile checklist
- [docs/tooling.md](docs/tooling.md) — Optional Chrome headless PDF + `pdfunite`
- [design/README.md](design/README.md) — Sample templates

See the parent [career-pipeline README](../README.md) for plugin install options.
