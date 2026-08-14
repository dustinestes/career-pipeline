<br><br>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/lockups/lockup-hero-paper.svg">
    <img src="assets/lockups/lockup-hero-ink.svg" alt="Career Pipeline — your personal career agent for every milestone" width="520">
  </picture>
</p>

<br>

<p align="center">
  <a href="https://github.com/dustinestes/career-pipeline/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/dustinestes/career-pipeline/ci.yml?branch=main&style=flat-square&label=CI&labelColor=C4C4C4" alt="CI"></a>
  <img src="https://img.shields.io/badge/status-pre--release-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="Pre-release">
  <img src="https://img.shields.io/badge/version-0.1.0-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="version 0.1.0">
  <img src="https://img.shields.io/badge/license-MIT-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="MIT">
  <img src="https://img.shields.io/badge/stack-Agent%20Skills%20%2F%20Cursor%20Plugin-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="Agent Skills / Cursor Plugin">
</p>

<br>

---

A personal career agent for managing every milestone throughout your career:

- Resume and cover letter templates and generation
- Ad-hoc and scheduled lead sourcing
- Personal fit analysis of job postings
- Per-round interview prep
- Offer analysis
- Job acceptance
- Career history

---

<br>

This repo is an installable **plugin**. After install, init an empty folder as your job-search workspace. The [`template/`](template/) directory is the scaffold payload (also usable manually).

| Layer | What you get |
|-------|----------------|
| Skills | Prefixed `career-pipeline-*` skills (init, leads, analyze, create application/prep/offer, accept-job, archive/delete) |
| Rules | Assessment, cover letter, interview prep, lead, and application standards |
| Template | Folders (`design`, `leads`, `submissions`, `career`), example YAML, consumer docs |

Compatible with **Cursor**, **Claude Code** (skills), and any host that loads [Agent Skills](https://agentskills.io) / [Agent Plugins](https://agent-plugins.org).

## Install

### Main path (recommended)

1. Install the plugin locally (developer id `career-pipeline-dev`):

```bash
./scripts/dev-mode.sh link
# reload Cursor — Local plugins → Career Pipeline / career-pipeline-dev
./scripts/dev-mode.sh status
```

Maintainer modes: [docs/develop.md](docs/develop.md). Directory publish: [docs/publish.md](docs/publish.md).

2. Create an **empty** folder for your job search (a bare `git init` is fine). Open it in Cursor.

3. Init the workspace (natural language or slash command):

- "Set up a career-pipeline workspace in this folder"
- `/career-pipeline-init`

4. Copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it. Pick a pair under `design/samples/`, adapt to working HTML. Then use `/career-pipeline-analyze-job` (or ask in plain language).

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

List on [cursor.directory](https://cursor.directory) when ready. Steps: [docs/publish.md](docs/publish.md). This project does not target Cursor Marketplace submission.

## Flow

Two ways into the same pipeline: **searching yourself** (paste a posting into analyze) or a **personal career agent** (`source-leads` ad-hoc or on a host schedule, then feed roles into analyze). Scheduling is a host feature, not a separate skill.

```mermaid
flowchart TD
  subgraph setup [Setup]
    initNode["Init workspace<br/>skill: career-pipeline-init<br/>out: folders + .career-pipeline.yml.example"]
    configNode["Configure persona<br/>manual: copy/edit .career-pipeline.yml<br/>plus design HTML pre-work"]
    initNode --> configNode
  end

  subgraph findRoles [Find roles]
    selfFind["Searching yourself<br/>you already have a posting URL"]
    agentFind["Personal career agent<br/>skill: career-pipeline-source-leads<br/>out: leads/Company.md<br/>ad-hoc or host schedule"]
    archiveLead["Stop watching company<br/>skill: career-pipeline-archive-lead<br/>out: leads/.archive + ignore_companies"]
    agentFind -.-> archiveLead
  end

  configNode --> selfFind
  configNode --> agentFind

  assess["Assess fit<br/>skill: career-pipeline-analyze-job<br/>out: submissions/Company/Role/analysis"]
  selfFind -->|"paste URL"| assess
  agentFind -->|"feed roles from lead"| assess

  subgraph lifecycle [Application lifecycle]
    applyDecide{"Apply or pass?"}
    buildApp["Build application<br/>skill: career-pipeline-create-application<br/>out: application/ cover letter PDFs"]
    prepLoop["Interview prep<br/>skill: career-pipeline-create-interview-prep<br/>out: interview - Nth/"]
    reviewOffer["Review offer<br/>skill: career-pipeline-analyze-offer<br/>out: offer/analysis"]
    offerDecide{"Accept or decline?"}
    archiveSub["Close role<br/>skill: career-pipeline-archive-submission<br/>out: submissions/.archive"]
    deleteSub["Hard delete<br/>skill: career-pipeline-delete-submission<br/>out: folder removed"]
    emailNote["Email optional<br/>manual export into email/<br/>no mailbox automation"]
  end

  assess --> applyDecide
  applyDecide -->|apply| buildApp
  applyDecide -->|pass| archiveSub
  buildApp --> prepLoop
  prepLoop -->|"another round"| prepLoop
  prepLoop --> reviewOffer
  buildApp -.-> emailNote
  reviewOffer --> offerDecide
  offerDecide -->|decline| archiveSub
  archiveSub -.->|"instead of archive"| deleteSub

  subgraph careerHist [Career history]
    acceptJob["Accept role<br/>skill: career-pipeline-accept-job<br/>out: career/Company/Role + YAML experience"]
  end

  offerDecide -->|accept| acceptJob
```

| Folder | Role |
|--------|------|
| `leads/` | Company research from lead sourcing |
| `submissions/` | Active applications |
| `career/` | Accepted roles (employment history) |

## Skills

Skill names use a `career-pipeline-` **prefix on purpose**: a discoverability convention so `/` in the AI tool popup clusters this plugin’s commands and reduces collisions with other packs. Not a host requirement. Natural language also works.

Full tables (Invoke / Description / Input / Output) and folder layout: **[docs/skills.md](docs/skills.md)** (mirrored into workspace `docs/skills.md` after init).

### Quick catalog

| Group | Invoke |
|-------|--------|
| Setup | `/career-pipeline-init` |
| Lead Discovery | `/career-pipeline-source-leads`, `/career-pipeline-archive-lead` |
| Application | `/career-pipeline-analyze-job`, `/career-pipeline-create-application`, `/career-pipeline-create-interview-prep`, `/career-pipeline-analyze-offer`, `/career-pipeline-accept-job`, `/career-pipeline-archive-submission`, `/career-pipeline-delete-submission` |

## Personal data

This public package ships **no** live applications, emails, or personal resumes. Keep your private search separate and treat **career-pipeline** as the upstream plugin.

See [docs/consuming-from-private-workspace.md](docs/consuming-from-private-workspace.md).

## Docs

| Doc | Audience |
|-----|----------|
| [docs/README.md](docs/README.md) | Maintainer docs index |
| [docs/skills.md](docs/skills.md) | Skill catalog (plugin + mirrored in workspace) |
| [docs/config.md](docs/config.md) | `.career-pipeline.yml` field guide (schema + naming) |
| [docs/develop.md](docs/develop.md) | `dev-mode` link/unlink, Clockify, smoke test / CI |
| [docs/publish.md](docs/publish.md) | cursor.directory + GitHub topics (not Marketplace) |
| [template/docs/getting-started.md](template/docs/getting-started.md) | Consumer setup after init |
| [template/docs/customization.md](template/docs/customization.md) | YAML checklist |
| [template/docs/tooling.md](template/docs/tooling.md) | Optional PDF export |
| [docs/consuming-from-private-workspace.md](docs/consuming-from-private-workspace.md) | Private search repo + plugin |
| [docs/tooling.md](docs/tooling.md) | Pointer to workspace tooling |

## Packaging

| Path | Role |
|------|------|
| `.cursor-plugin/plugin.json` | Cursor Plugin manifest (`displayName`, author email) |
| `plugin.json` | Agent Plugins portable manifest |
| `skills/` | Agent Skills (plugin-owned; single source of truth) |
| `rules/` | Cursor rules (plugin-owned) |
| `scripts/dev-mode.sh` | Link/unlink local `career-pipeline-dev` |
| `scripts/smoke.sh` | Maintainer smoke (init, folders, PDF, archive); CI on PR and `main` |
| `.cursor/rules/` | Maintainer workflow for this repo only |
| `template/` | Scaffold payload for init / manual copy |

## License

MIT

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
