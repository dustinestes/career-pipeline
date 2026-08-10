# Consuming career-pipeline from a private workspace

Your lived-in job search (applications, emails, real resume) should stay **private**. Publish **career-pipeline** as the scrubbed upstream.

## Recommended layout

| Repo | Visibility | Role |
|------|------------|------|
| `career-pipeline` | Public | Plugin + template |
| `Resume` (or similar) | Private | Your real content + local `.cursor/` copy or plugin install |

## Options

### A. Install plugin, keep private workspace (preferred)

1. Symlink or Marketplace-install `career-pipeline` as a Cursor/Agent plugin
2. Keep `~/workspaces/Resume` (or a copy of `template/`) as the content workspace
3. Periodically pull skill/rule updates from `career-pipeline` into the private repo only if you vendor them under `.cursor/`

### B. Vendor skills into the private repo

```bash
rsync -a --delete /path/to/career-pipeline/skills/ ~/workspaces/Resume/.cursor/skills/
rsync -a --delete /path/to/career-pipeline/rules/ ~/workspaces/Resume/.cursor/rules/
```

Commit those updates in the private repo when you want a pinned snapshot.

### C. Submodule / subtree (optional)

Advanced: add `career-pipeline` as a submodule and point docs at `career-pipeline/skills`. Most people prefer A or B.

## Do not publish from the private repo

Before any public template push from a personal search repo:

- Remove or anonymize `submissions/`
- Replace `candidate-profile.md` with the example
- Strip PDFs, `.eml`, and CI secrets
