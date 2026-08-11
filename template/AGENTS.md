# Agent Entry Point

Job search workspace powered by the **career-pipeline** plugin (skills + rules).

## Personal context

Require workspace-root [`.career-pipeline.yml`](.career-pipeline.yml). If missing, ask the user to copy [`.career-pipeline.yml.example`](.career-pipeline.yml.example) and edit it (or run `career-pipeline-init` in an empty folder first). Setup: [docs/getting-started.md](docs/getting-started.md).

## Workflows (invoke explicitly or via natural language)

| Skill | Use when |
|-------|----------|
| `career-pipeline-init` | Empty folder needs scaffold |
| `source-leads` | Discovering companies to target, not a specific posting |
| `analyze-job` | New job posting URL |
| `initial-interview` | First interview invite |
| `next-interview` | Follow-up interview rounds |
| `archive-job` | Rejection, withdraw, or close |

## Standards

Career-pipeline plugin rules — assessment format, cover letter, interview prep, application standards. Do not assume they live under this repo’s `.cursor/rules/` unless the user vendored a pinned snapshot.

## Human docs

- [README.md](README.md)
- [docs/getting-started.md](docs/getting-started.md)
- [docs/customization.md](docs/customization.md)
- [docs/tooling.md](docs/tooling.md)
