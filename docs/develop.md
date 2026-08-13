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
- [Developer mode](#developer-mode)
- [Consumer-like mode](#consumer-like-mode)
- [Smoke test](#smoke-test)
- [Clockify time tracking](#clockify-time-tracking)
- [Workspace config schema](#workspace-config-schema)

---

<br>

## Modes

| Mode | Purpose | How |
|------|---------|-----|
| **Developer** | Iterate this repo (skills + rules) | `./scripts/dev-mode.sh link` |
| **Consumer-like** | No local `-dev` symlink (Directory / fresh install checks) | `./scripts/dev-mode.sh unlink` |

```bash
./scripts/dev-mode.sh status
```

After link or unlink: **reload Cursor**.

This helper only manages the local plugin symlink. There is no MCP rewrite (this package is skills/rules only).

<br>

---

<br>

## Developer mode

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

## Consumer-like mode

```bash
./scripts/dev-mode.sh unlink
# reload Cursor
```

Removes `career-pipeline-dev` (and a legacy `career-pipeline` link to this checkout). Then install from [cursor.directory](https://cursor.directory) or symlink a published clone as a stranger would.

<br>

---

<br>

## Smoke test

From the plugin repo root:

```bash
./scripts/smoke-lifecycle.sh
# KEEP=1 WORK_DIR=/tmp/cp-smoke ./scripts/smoke-lifecycle.sh
```

Checks init, submission folders, Chrome + `pdfunite`, and archive scripts. Prefer a linked `career-pipeline-dev`. Requires `google-chrome` and `pdfunite` (see [template/docs/tooling.md](../template/docs/tooling.md)). Agent prose steps are not automated.

<br>

---

<br>

## Clockify time tracking

This repo is a **consumer** of [clockify-mcp-server](https://github.com/dustinestes/clockify-mcp-server). Track work against the `career-pipeline` Clockify project while building the package.

Each consumer repo keeps its own `.env`. This package uses the Clockify workspace **GitHub** (`CLOCKIFY_WORKSPACE_ID` in local `.env`).

### One-time local wiring

1. In the Clockify checkout:

```bash
cd /path/to/clockify-mcp-server
npm install && npm run build
npm run dev:link
```

2. In this repo:

```bash
cp .env.example .env
# set CLOCKIFY_API_KEY and CLOCKIFY_WORKSPACE_ID
cp .cursor/mcp.json.example .cursor/mcp.json
# absolute paths for node + clockify-mcp-server/dist/index.js
# envFile: ${workspaceFolder}/.env
```

3. Reload Cursor; enable MCP **clockify-dev**. Run `/clockify-project-init` once, then `/clockify-coding-time` for start/stop.

Do not commit API keys.

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
