<br><br>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/lockups/lockup-hero-paper.svg">
    <img src="assets/lockups/lockup-hero-ink.svg" alt="Career Pipeline — your personal career agent for every milestone" width="520">
  </picture>
</p>

<br>

<p align="center">
  <img src="https://img.shields.io/badge/workspace-scaffold-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="Workspace scaffold">
  <img src="https://img.shields.io/badge/requires-career--pipeline%20plugin-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="Requires career-pipeline plugin">
  <img src="https://img.shields.io/badge/license-MIT-1A1A1A?style=flat-square&labelColor=C4C4C4" alt="MIT">
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

Job-search workspace used with the **career-pipeline** plugin (skills + rules live on the plugin, not in this folder).

---

<br>

## Quick start

1. Install the **career-pipeline** plugin (see parent README)
2. Prefer creating this folder via `/career-pipeline-init` into an **empty** directory
3. Copy [`.career-pipeline.yml.example`](.career-pipeline.yml.example) → `.career-pipeline.yml` and replace the Jordan Hale example with your details
4. Build resume and cover letter HTML from a pair under `design/samples/` (see getting started)
5. Use `/career-pipeline-analyze-job` with a posting URL, or source leads first

Walkthrough: [docs/getting-started.md](docs/getting-started.md). Skill catalog: [docs/skills.md](docs/skills.md).

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

## Skills (summary)

| Group | Invoke |
|-------|--------|
| Setup | `/career-pipeline-init` |
| Lead Discovery | `/career-pipeline-source-leads`, `/career-pipeline-archive-lead` |
| Application | `/career-pipeline-analyze-job`, `/career-pipeline-create-application`, `/career-pipeline-create-interview-prep`, `/career-pipeline-analyze-offer`, `/career-pipeline-accept-job`, `/career-pipeline-archive-submission`, `/career-pipeline-delete-submission` |

The `career-pipeline-` prefix is intentional for `/` popup discoverability. Details: [docs/skills.md](docs/skills.md).

## Docs

- [docs/getting-started.md](docs/getting-started.md) — Persona YAML + resume HTML pre-work
- [docs/skills.md](docs/skills.md) — Skill tables (Invoke / Description / Input / Output)
- [docs/customization.md](docs/customization.md) — YAML profile checklist
- [docs/tooling.md](docs/tooling.md) — Optional Chrome headless PDF + `pdfunite`
- [design/README.md](design/README.md) — Sample templates

See the parent [career-pipeline README](../README.md) for plugin install and manual alternatives.

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
