# career-pipeline

Reusable **Agent Skills** + **Cursor rules** for a structured job search: source leads, qualify roles, build applications, and prep interview rounds.

This repo is an installable **plugin**. After install, init an empty folder as your job-search workspace. The [`template/`](template/) directory is the scaffold payload (also usable manually).

| Layer | What you get |
|-------|----------------|
| Skills | Prefixed `career-pipeline-*` skills (init, leads, analyze, create application/prep, archive/delete) |
| Rules | Assessment, cover letter, interview prep, lead, and application standards |
| Template | Folders (`design`, `leads`, `submissions`), example YAML, consumer docs |

Compatible with **Cursor**, **Claude Code** (skills), and any host that loads [Agent Skills](https://agentskills.io) / [Agent Plugins](https://agent-plugins.org).

## Install

### Main path (recommended)

1. Install or symlink the plugin:

```bash
ln -s /path/to/career-pipeline ~/.cursor/plugins/local/career-pipeline-dev
# or: ~/.cursor/plugins/local/career-pipeline
```

Either local folder name works; Cursor loads skills from the linked checkout. Reload Cursor after linking.

2. Create an **empty** folder for your job search (a bare `git init` is fine). Open it in Cursor.

3. Init the workspace (natural language or slash command):

- "Set up a career-pipeline workspace in this folder"
- `/career-pipeline-init`

4. Copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it. Adapt `design/` samples. Then use `/career-pipeline-analyze-job` (or ask in plain language).

Job-search skills stop until `.career-pipeline.yml` exists. Walkthrough after init: `docs/getting-started.md` in your workspace. Full skill tables: [docs/skills.md](docs/skills.md).

### Alternative: manual scaffold (no init skill)

```bash
cp -R template my-job-search
cd my-job-search
cp .career-pipeline.yml.example .career-pipeline.yml
# edit .career-pipeline.yml, then open in Cursor with the plugin installed
```

### Alternative: vendored skills (no plugin)

Pinned snapshot only. Plugin updates will **not** reach this copy; re-copy or switch to the plugin when you want updates.

```bash
cp -R template my-job-search
cp -R skills/* my-job-search/.cursor/skills/
cp -R rules/* my-job-search/.cursor/rules/
cd my-job-search
cp .career-pipeline.yml.example .career-pipeline.yml
```

Field guide: [docs/config.md](docs/config.md).

### Discoverability

List on [cursor.directory](https://cursor.directory) after the package is ready for strangers. This project does not target Cursor Marketplace submission.

## Skills

Skill names use a `career-pipeline-` **prefix on purpose**: a discoverability convention so `/` in the AI tool popup clusters this plugin’s commands and reduces collisions with other packs. Not a host requirement. Natural language also works.

Full tables (Invoke / Description / Input / Output), entrypoints, and folder layout: **[docs/skills.md](docs/skills.md)** (mirrored into workspace `docs/skills.md` after init).

### Entrypoints

| Route | How |
|-------|-----|
| Lead-sourced | `/career-pipeline-source-leads` (ad-hoc or scheduled) → feed roles into `/career-pipeline-analyze-job` |
| Direct posting | Paste a job URL into `/career-pipeline-analyze-job` |

### Quick catalog

| Group | Invoke |
|-------|--------|
| Setup | `/career-pipeline-init` |
| Lead Discovery | `/career-pipeline-source-leads`, `/career-pipeline-archive-lead` |
| Application | `/career-pipeline-analyze-job`, `/career-pipeline-create-application`, `/career-pipeline-create-interview-prep`, `/career-pipeline-archive-submission`, `/career-pipeline-delete-submission` |

## Personal data

This public package ships **no** live applications, emails, or personal resumes. Keep your private search separate and treat **career-pipeline** as the upstream plugin.

See [docs/consuming-from-private-workspace.md](docs/consuming-from-private-workspace.md).

## Docs

| Doc | Audience |
|-----|----------|
| [docs/skills.md](docs/skills.md) | Skill catalog (plugin + mirrored in workspace) |
| [docs/config.md](docs/config.md) | `.career-pipeline.yml` field guide (schema + naming) |
| [docs/develop.md](docs/develop.md) | Maintainer setup (Clockify) + `scripts/smoke-lifecycle.sh` |
| [template/docs/getting-started.md](template/docs/getting-started.md) | Consumer setup after init |
| [template/docs/customization.md](template/docs/customization.md) | YAML checklist |
| [template/docs/tooling.md](template/docs/tooling.md) | Optional PDF export |
| [docs/consuming-from-private-workspace.md](docs/consuming-from-private-workspace.md) | Private search repo + plugin |
| [docs/tooling.md](docs/tooling.md) | Pointer to workspace tooling |

## Packaging

| Path | Role |
|------|------|
| `.cursor-plugin/plugin.json` | Cursor Plugin manifest |
| `plugin.json` | Agent Plugins portable manifest |
| `skills/` | Agent Skills (plugin-owned; single source of truth) |
| `rules/` | Cursor rules (plugin-owned) |
| `scripts/smoke-lifecycle.sh` | Maintainer dry-run (init, folders, PDF, archive) |
| `.cursor/rules/` | Maintainer workflow for this repo only |
| `template/` | Scaffold payload for init / manual copy |

## License

MIT
