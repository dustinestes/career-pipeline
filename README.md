# career-pipeline

Reusable **Agent Skills** + **Cursor rules** for a structured job search: source leads, qualify roles, build applications, and prep interview rounds.

This repo is an installable **plugin** (multi-skill pack). The [`template/`](template/) directory is a forkable empty workspace for your own content.

| Layer | What you get |
|-------|----------------|
| Skills | `source-leads`, `analyze-job`, `initial-interview`, `next-interview`, `archive-job` |
| Rules | Assessment, cover letter, interview prep, lead, and application standards |
| Template | Alpha-sorted folders (`design`, `leads`, `submissions`) for a personal job-search workspace |

Compatible with **Cursor**, **Claude Code** (skills), and any host that loads [Agent Skills](https://agentskills.io) / [Agent Plugins](https://agent-plugins.org).

## Install

### Cursor plugin (local)

```bash
ln -s /path/to/career-pipeline ~/.cursor/plugins/local/career-pipeline-dev
```

Reload Cursor. Copy [`template/`](template/) as your job-search workspace so folder paths in the skills resolve.

### Project skills (any Agent Skills host)

```bash
cp -R skills/* your-job-search/.cursor/skills/
cp -R rules/* your-job-search/.cursor/rules/   # Cursor rules
# Claude Code:
cp -R skills/* your-job-search/.claude/skills/
```

Or start from the template:

```bash
cp -R template my-job-search
cd my-job-search
```

Personalization config (YAML profile) and design templates are being added next. See open issues on this repository.

### Discoverability

List on [cursor.directory](https://cursor.directory) after the package is ready for strangers. This project does not target Cursor Marketplace submission.

## Lifecycle

| Stage | You do | Skill | Agent produces |
|-------|--------|-------|----------------|
| Discovery | Describe target profile | `source-leads` | `leads/<Company>.md` |
| Posting | Paste URL | `analyze-job` | Fit assessment → artifacts on proceed |
| Interview | Share invite | `initial-interview` | Phase skeleton + prep |
| Later rounds | Audience/format notes | `next-interview` | Round prep |
| Closed | Confirm | `archive-job` | Archive move |

## Personal data

This public package ships **no** live applications, emails, or personal resumes. Keep your private search (for example a private `Resume` repo) separate and treat **career-pipeline** as the upstream plugin/template.

See [docs/consuming-from-private-workspace.md](docs/consuming-from-private-workspace.md).

## Docs

| Doc | Audience |
|-----|----------|
| [docs/develop.md](docs/develop.md) | Maintainer setup (including Clockify time tracking) |
| [template/docs/tooling.md](template/docs/tooling.md) | PDF export in a job-search workspace |
| [docs/consuming-from-private-workspace.md](docs/consuming-from-private-workspace.md) | Using this plugin from a private search repo |
| [docs/tooling.md](docs/tooling.md) | Pointer to workspace tooling |

## Packaging

| Path | Role |
|------|------|
| `.cursor-plugin/plugin.json` | Cursor Plugin manifest |
| `plugin.json` | Agent Plugins portable manifest |
| `skills/` | Agent Skills |
| `rules/` | Cursor rules (job-search standards) |
| `.cursor/rules/` | Maintainer workflow for this repo |
| `template/` | Empty job-search workspace |

## License

MIT
