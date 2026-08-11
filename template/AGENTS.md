# Agent Entry Point

Job search workspace powered by the **career-pipeline** plugin (skills + rules).

## Personal context

Require workspace-root [`.career-pipeline.yml`](.career-pipeline.yml). If missing, ask the user to copy [`.career-pipeline.yml.example`](.career-pipeline.yml.example) and edit it (or run `career-pipeline-init` in an empty folder first). Setup: [docs/getting-started.md](docs/getting-started.md). Skills: [docs/skills.md](docs/skills.md).

## Workflows

| Skill | Use when |
|-------|----------|
| `career-pipeline-init` | Empty folder needs scaffold |
| `career-pipeline-source-leads` | Discover companies / open roles (ad-hoc or scheduled) |
| `career-pipeline-archive-lead` | Stop monitoring a company |
| `career-pipeline-analyze-job` | Assess a posting (manual URL or from a lead) |
| `career-pipeline-create-application` | Build application artifacts |
| `career-pipeline-create-interview-prep` | Prep any interview round |
| `career-pipeline-analyze-offer` | Review offer packet before accept/decline |
| `career-pipeline-archive-submission` | Close/withdraw with archive |
| `career-pipeline-delete-submission` | Hard-delete a submission |

## Standards

Career-pipeline plugin rules — assessment format, offer review, cover letter, interview prep, application standards.

## Human docs

- [README.md](README.md)
- [docs/getting-started.md](docs/getting-started.md)
- [docs/skills.md](docs/skills.md)
- [docs/customization.md](docs/customization.md)
- [docs/tooling.md](docs/tooling.md)
