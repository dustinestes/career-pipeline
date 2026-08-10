# Career pipeline workspace

Forkable job-search workspace used with the **career-pipeline** plugin (skills + rules).

## Quick start

1. Install or symlink the parent **career-pipeline** plugin (see parent README)
2. Edit [`.career-pipeline.yml`](.career-pipeline.yml) (ships as a Jordan Hale example; replace with your details)
3. Add design sources under `design/` when templates are available (see open issues)
4. In Cursor, invoke `/analyze-job` with a posting URL (or ask in natural language)

Setup checklist: [docs/customization.md](docs/customization.md).

## Lifecycle

| Stage | Invoke | Output |
|-------|--------|--------|
| Company discovery | `source-leads` | `leads/<Company>.md` |
| New posting | `analyze-job` | Assessment + cover letter + PDFs under `submissions/` |
| Interview invite | `initial-interview` | Phase skeleton + prep |
| Later rounds | `next-interview` | Round prep |
| Closed | `archive-job` | Moved under `.archive/` |

## Docs

- [docs/customization.md](docs/customization.md) — YAML profile setup
- [docs/tooling.md](docs/tooling.md) — Chrome headless PDF + `pdfunite`

See the parent [career-pipeline README](../README.md) for plugin install options.
