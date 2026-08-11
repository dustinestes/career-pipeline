# Develop (maintainers)

## Clockify time tracking

This repo is a consumer of [clockify-mcp-server](https://github.com/dustinestes/clockify-mcp-server). Track work against the `career-pipeline` Clockify project while building the package.

Each consumer repo keeps its own `.env` so API key / workspace can differ per project. This package uses the Clockify workspace **GitHub** (`CLOCKIFY_WORKSPACE_ID` in local `.env`) so public GitHub work stays separate from Personal or client workspaces.

### One-time local wiring

1. In the Clockify checkout (skills + MCP server binary):

```bash
cd /path/to/clockify-mcp-server
npm install && npm run build
npm run dev:link
```

2. In this repo, add credentials:

```bash
cp .env.example .env
# set CLOCKIFY_API_KEY
# set CLOCKIFY_WORKSPACE_ID for the workspace that should own career-pipeline
```

3. Wire project MCP (points at the Clockify `dist` + **this** repo’s `.env`):

```bash
cp .cursor/mcp.json.example .cursor/mcp.json
# edit command/args to absolute paths for node + clockify-mcp-server/dist/index.js
# keep envFile as ${workspaceFolder}/.env
```

`.cursor/mcp.json` and `.env` are gitignored. `.clockify.yml` is committed (no secrets).

4. Reload Cursor (`Developer: Reload Window`), then:

- Enable MCP **clockify-dev** under Customize → MCP (project MCP; often starts disabled)
- Skills are **not** under “Project plugins”. Local plugins live under user/local installs (`~/.cursor/plugins/local/clockify-dev`). Look for **Clockify** / **clockify-dev** in the Installed / Local plugins list, not the project-only filter.

If the local plugin still does not appear (common while stress-testing), symlink the skills into this workspace (already gitignored):

```bash
mkdir -p .cursor/skills
ln -sfn /path/to/clockify-mcp-server/skills/clockify-coding-time .cursor/skills/
ln -sfn /path/to/clockify-mcp-server/skills/clockify-project-init .cursor/skills/
ln -sfn /path/to/clockify-mcp-server/skills/clockify-project-init-automated .cursor/skills/
```

Then reload again and invoke `/clockify-coding-time` (or the other skill names) from chat.

5. First time in this repo, run `/clockify-project-init` so Clockify has a `career-pipeline` project and GitHub labels as tasks. After that, use `/clockify-coding-time` (or the MCP tools) to start/stop/summarize.

### Day to day

| Moment | Action |
|--------|--------|
| Start an issue | `/clockify-coding-time` → start (description from issue number/title) |
| Ship a PR / finish | stop timer (rounding per `.clockify.yml`) |
| Check the day | `clockify_today_summary` |

Do not commit API keys. Do not reuse another checkout’s `.env` if that file pins a different workspace.

### Publish later

When Clockify is on the Marketplace (or `npx`), drop the local `clockify-dev` link (`npm run dev:unlink` in that repo), install the published plugin, and keep this repo’s `.clockify.yml` + `.env` (or plugin variables). See Clockify `docs/setup.md`.

## Workspace config schema

Personalization for job-search workspaces: [docs/config.md](config.md) (`.career-pipeline.yml` + `schemas/career-pipeline.schema.json`).

## Smoke test (stranger-ready loop)

From the plugin repo root:

```bash
./scripts/smoke-lifecycle.sh
# KEEP=1 WORK_DIR=/tmp/cp-smoke ./scripts/smoke-lifecycle.sh   # leave workspace for inspection
```

Checks:

1. Local plugin under `~/.cursor/plugins/local/career-pipeline` or `career-pipeline-dev` exposes all `career-pipeline-*` skills (falls back to repo `skills/` with a warning)
2. Init scaffold (example YAML only; no vendored skills)
3. Submission shape: assessment → `email/` + `application/` → `interview - 1st/`
4. Chrome headless PDF + `pdfunite` on design samples
5. `archive-submission` and `archive-lead` (+ `ignore_companies`)

Requires `google-chrome` and `pdfunite` (see [template/docs/tooling.md](../template/docs/tooling.md)). Skill **agent** steps (web research, cover letter prose) are not automated; scripts cover structure and export.
