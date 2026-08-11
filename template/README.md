# Career pipeline workspace

Job-search workspace used with the **career-pipeline** plugin (skills + rules live on the plugin, not in this folder).

## Quick start

1. Install the **career-pipeline** plugin (see parent README)
2. Prefer creating this folder via `/career-pipeline-init` (or “set up career-pipeline in this folder”) into an **empty** directory
3. Copy [`.career-pipeline.yml.example`](.career-pipeline.yml.example) → `.career-pipeline.yml` and replace the Jordan Hale example with your details
4. Build resume and cover letter HTML from a sample under `design/` (see getting started)
5. Invoke `/analyze-job` with a posting URL (or ask in natural language)

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

See the parent [career-pipeline README](../README.md) for plugin install and manual alternatives.
