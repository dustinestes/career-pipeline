# Agent Entry Point

Job search workspace powered by **career-pipeline** skills and rules.

## Personal context

Planned: workspace-root `.career-pipeline.yml` (salary floor, target roles, file naming). Skills still mention a legacy profile path until that lands.

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
- [docs/tooling.md](docs/tooling.md)
