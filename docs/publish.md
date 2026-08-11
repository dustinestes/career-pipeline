<br><br>
<img align="right" src="../assets/logo.svg" height="40" alt="career-pipeline">
<h1>Publish</h1>
<br clear="both">

How this plugin is meant to be discovered. **cursor.directory only** — this project does not target Cursor Marketplace submission.

<br>

## Contents

- [Contents](#contents)
- [Before you submit](#before-you-submit)
- [cursor.directory](#cursordirectory)
- [GitHub topics](#github-topics)
- [Local vs published id](#local-vs-published-id)

---

<br>

## Before you submit

1. Public GitHub repo green on `main`
2. `./scripts/smoke-lifecycle.sh` passes
3. README install path and [skills.md](./skills.md) match shipped skills
4. `./scripts/dev-mode.sh unlink` if you want a clean machine check (no local `-dev` symlink)

<br>

---

<br>

## cursor.directory

1. Confirm skills under `skills/*/SKILL.md` and rules under `rules/*.mdc` (plugin manifest points at those paths)
2. Submit at https://cursor.directory/plugins/new when ready
3. Update profile / showcase links from in-progress to live ([github-showcase.md](./github-showcase.md))

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

<strong>career-pipeline</strong>
<div align="right">

[MIT License](../LICENSE)

</div>
<br clear="both">
