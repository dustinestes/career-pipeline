<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Consuming from a private workspace</h1>
<br clear="both">

Your lived-in job search (applications, emails, real resume) should stay **private**. Publish **career-pipeline** as the scrubbed upstream plugin.

## Recommended layout

| Repo | Visibility | Role |
|------|------------|------|
| `career-pipeline` | Public | Plugin + template scaffold |
| `Resume` (or similar) | Private | Your real content workspace |

## Options

### A. Install plugin + init (preferred)

1. Install or symlink `career-pipeline` as a Cursor/Agent plugin
2. Open an empty private folder (or create one) and run `/career-pipeline-init` (or ask to set up career-pipeline)
3. Copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and personalize
4. Skills and rules stay on the plugin so updates reach every workspace

Do not vendor career-pipeline skills into the private repo as the source of truth. You may still add **your own** skills under the workspace `.cursor/skills/`.

### B. Manual template copy (plugin still installed)

```bash
cp -R /path/to/career-pipeline/template ~/workspaces/Resume
cd ~/workspaces/Resume
cp .career-pipeline.yml.example .career-pipeline.yml
```

Same personalization steps as after init.

### C. Vendored skills (no plugin) — pinned snapshot

```bash
cp -R /path/to/career-pipeline/template ~/workspaces/Resume
mkdir -p ~/workspaces/Resume/.cursor/skills ~/workspaces/Resume/.cursor/rules
cp -R /path/to/career-pipeline/skills/* ~/workspaces/Resume/.cursor/skills/
cp -R /path/to/career-pipeline/rules/* ~/workspaces/Resume/.cursor/rules/
```

Updates require re-copying skills/rules or switching to option A.

## Do not publish from the private repo

Before any public template push from a personal search repo:

- Remove or anonymize `submissions/` and `career/`
- Replace `.career-pipeline.yml` with the public example (or strip personal fields)
- Strip PDFs, `.eml`, and CI secrets

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
