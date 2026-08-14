<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Develop</h1>
<br clear="both">

How to develop this plugin on a machine that may also install a published listing later. Explicit modes avoid confusing a local symlink with a stranger install.

<br>

## Contents

- [Contents](#contents)
- [Modes](#modes)
- [Linked](#linked)
- [Unlinked](#unlinked)
- [Smoke test](#smoke-test)
- [Workspace config schema](#workspace-config-schema)

---

<br>

## Modes

| Mode | Purpose | How |
|------|---------|-----|
| **Linked** | Iterate this repo (skills + rules) | `./scripts/dev-mode.sh link` |
| **Unlinked** | No local `-dev` symlink (Directory / fresh install checks) | `./scripts/dev-mode.sh unlink` |

```bash
./scripts/dev-mode.sh status
```

After link or unlink: **reload Cursor**.

This helper only manages the local plugin symlink.

<br>

---

<br>

## Linked

```bash
./scripts/dev-mode.sh link
# reload Cursor
```

1. Symlinks this repo to `~/.cursor/plugins/local/career-pipeline-dev` (not bare `career-pipeline`, so a future listing id does not collide)
2. Removes a legacy `~/.cursor/plugins/local/career-pipeline` link when it pointed at this checkout

Verify: Local plugins → **Career Pipeline** / `career-pipeline-dev`; skills via `/career-pipeline-…`. This is not Directory proof.

<br>

---

<br>

## Unlinked

```bash
./scripts/dev-mode.sh unlink
# reload Cursor
```

Removes `career-pipeline-dev` (and a legacy `career-pipeline` link to this checkout). Then install from [cursor.directory](https://cursor.directory) or `/add-plugin` as a stranger would.

<br>

---

<br>

## Smoke test

From the plugin repo root:

```bash
./scripts/smoke.sh
# KEEP=1 WORK_DIR=/tmp/cp-smoke ./scripts/smoke.sh
```

Checks init, submission folders, Chrome + `pdfunite`, accept-job, and archive scripts. Prefer a linked `career-pipeline-dev`. Requires `google-chrome` and `pdfunite` (see [template/docs/tooling.md](../template/docs/tooling.md)). Set `CHROME_BIN` if the browser binary is not named `google-chrome`.

The same script runs in GitHub Actions on pull requests and `main` (`.github/workflows/ci.yml`). The runner is `ubuntu-latest` (Chrome is preinstalled); the workflow installs `poppler-utils`. Agent prose steps are not automated.

<br>

---

<br>

## Workspace config schema

[config.md](./config.md) (`.career-pipeline.yml` + `schemas/career-pipeline.schema.json`).

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
