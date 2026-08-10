# Career pipeline workspace

Forkable job-search workspace used with the **career-pipeline** plugin (skills + rules).

## Quick start

1. Install or symlink the parent **career-pipeline** plugin (see parent README)
2. Add design sources under `1 - Design/` when templates are available (see open issues)
3. In Cursor, invoke `/analyze-job` with a posting URL (or ask in natural language)

Personalization currently still referenced as a candidate profile in skills; a YAML config (`.career-pipeline.yml`) is the planned replacement.

## Lifecycle

| Stage | Invoke | Output |
|-------|--------|--------|
| Company discovery | `source-leads` | `2 - Leads/<Company>.md` |
| New posting | `analyze-job` | Assessment + cover letter + PDFs under `3 - Applications/` |
| Interview invite | `initial-interview` | Phase skeleton + prep |
| Later rounds | `next-interview` | Round prep |
| Closed | `archive-job` | Moved under `# - Archive/` |

## Docs

- [docs/tooling.md](docs/tooling.md) — Chrome headless PDF + `pdfunite`

See the parent [career-pipeline README](../README.md) for plugin install options.
