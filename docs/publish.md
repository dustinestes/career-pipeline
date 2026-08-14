<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Publish</h1>
<br clear="both">

How this plugin is meant to be discovered. **cursor.directory only** — this project does not target Cursor Marketplace submission.

<br>

## Contents

- [Contents](#contents)
- [Before you submit](#before-you-submit)
- [Versioning and Releases](#versioning-and-releases)
- [cursor.directory](#cursordirectory)
- [GitHub topics](#github-topics)
- [Local vs published id](#local-vs-published-id)

---

<br>

## Before you submit

1. Public GitHub repo with CI green on `main` (`.github/workflows/ci.yml` runs `./scripts/smoke.sh`)
2. README install path and [skills.md](./skills.md) match shipped skills
3. `./scripts/dev-mode.sh unlink` if you want a clean machine check (no local `-dev` symlink)

<br>

---

<br>

## Versioning and Releases

Plugin version lives in both manifests. Keep them identical:

- [`.cursor-plugin/plugin.json`](../.cursor-plugin/plugin.json) (Cursor Plugin)
- [`plugin.json`](../plugin.json) (Agent Plugins portable)

When you cut a release:

1. Bump `version` in both files to the same semver (`X.Y.Z`)
2. Update the static version badge on the root README if it still mirrors the manifest
3. Merge to `main`, then tag `vX.Y.Z` and publish a GitHub Release with notes (`gh release create vX.Y.Z`)
4. Optionally maintain a `CHANGELOG.md` so release notes are drafted from a running log

GitHub Releases are for humans: changelog, support (“which version?”), and a clear ship point. They do **not** push updates into [cursor.directory](https://cursor.directory) or Cursor Marketplace.

This project does not target Marketplace. Directory discovery is a separate, manual step (submit the repo URL once; any later re-crawl is not driven by tags or Actions). Personal installs via `/add-plugin` with a GitHub URL can also pin to an old commit, so keeping `plugin.json` version accurate still matters for support even when Directory is the front door.

There is no GitHub Action that syncs Releases to Directory. CI already runs `./scripts/smoke.sh` on pull requests and `main`. Release ritual ([#54](https://github.com/dustinestes/career-pipeline/issues/54)) is a follow-up.

<br>

---

<br>

## cursor.directory

1. Confirm skills under `skills/*/SKILL.md` and rules under `rules/*.mdc` (plugin manifest points at those paths)
2. Submit at https://cursor.directory/plugins/new when ready
3. Update profile / showcase links from in-progress to live ([github-showcase.md](./github-showcase.md))

Cutting a GitHub Release does not update the Directory listing. After the listing is live, treat Directory refreshes as manual if the site offers them; otherwise re-submit or wait for their crawl.

Tracked separately: issue [#9](https://github.com/dustinestes/career-pipeline/issues/9).

<br>

---

<br>

## GitHub topics

Suggested topics on the repo:

`agent-skills` `cursor-plugin` `job-search` `agent-plugins` `career` `interview-prep`

<br>

---

<br>

## Local vs published id

| Context | Plugin folder / id |
|---------|-------------------|
| Developer machine | `career-pipeline-dev` via `./scripts/dev-mode.sh link` |
| Manifest `name` | `career-pipeline` (`.cursor-plugin/plugin.json`) |
| Display name | Career Pipeline |

Do not treat a local `-dev` symlink as Directory proof.

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
