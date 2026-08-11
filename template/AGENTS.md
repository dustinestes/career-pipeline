# Agent Entry Point

Job search workspace powered by **career-pipeline** skills and rules.

## Personal context

Read workspace-root [`.career-pipeline.yml`](.career-pipeline.yml) for salary floor, target roles, background, and naming patterns. Setup: [docs/getting-started.md](docs/getting-started.md).

## Workflows (invoke explicitly)

| Skill | Use when |
|-------|----------|
| `source-leads` | Discovering companies to target, not a specific posting |
| `analyze-job` | New job posting URL |
| `initial-interview` | First interview invite |
| `next-interview` | Follow-up interview rounds |
| `archive-job` | Rejection, withdraw, or close |

## Standards

`.cursor/rules/` — assessment format, cover letter design, interview prep, application standards.

## Human docs

- [README.md](README.md)
- [docs/getting-started.md](docs/getting-started.md)
- [docs/customization.md](docs/customization.md)
- [docs/tooling.md](docs/tooling.md)
