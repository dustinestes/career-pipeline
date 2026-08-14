<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Config</h1>
<br clear="both">

Workspace personalization lives in **`.career-pipeline.yml`** at the job-search workspace root. Schema: [`schemas/career-pipeline.schema.json`](../schemas/career-pipeline.schema.json). Example to copy: [`template/.career-pipeline.yml.example`](../template/.career-pipeline.yml.example) (Jordan Hale; also what init copies into a workspace). Scaffold ships the example only; job-search skills require the live file.

Workspace users: start with [template/docs/getting-started.md](../template/docs/getting-started.md) (or `docs/getting-started.md` after init).

## Top-level sections

| Section | Purpose |
|---------|---------|
| `version` | Config schema version (`1`) |
| `candidate` | Name and home location |
| `contact` | Email (required) and optional phone |
| `links` | Optional labeled URLs rendered as header icon chips |
| `compensation` | Salary floor and equity stance |
| `preferences` | Work mode, location notes, company stage/risk |
| `search` | Target roles, search terms, and optional `ignore_companies` |
| `background` | Experience, education, skills, stories. `career-pipeline-accept-job` prepends the accepted role to `experience` and closes any `end: present` entry |
| `naming` | Basename patterns for application artifacts |

## Contact

```yaml
contact:
  email: jordan.hale@example.com
  # phone: "+1-512-555-0148"   # optional
```

- `email` is required. Resume and cover letter HTML should use it for mailto chips.
- `phone` is optional. When omitted, do not invent a number and do not render a phone chip on the resume or cover letter.

## Links

Optional list of `{ label, url }` for portfolios and social profiles:

```yaml
links:
  - label: LinkedIn
    url: https://www.linkedin.com/in/example
  - label: Portfolio
    url: https://example.com
```

- Omit the whole `links` key when you have none.
- Resume and cover letter HTML should render these as **header icon chips** on the right of the contact row (`contact-icons` / `icon-chip`), matching the sample design. Use `title` (and accessible label) from `label`; pick a simple SVG by label or host (LinkedIn, GitHub, globe for site/portfolio). Fill icons with the design accent color.
- Omit the icon group entirely when `links` is missing or empty.

## Compensation and equity

- `salary_floor` is base salary in `currency` units.
- When `equity_counts_toward_floor` is `false`, equity/RSU does not satisfy the floor. Quote equity language from postings when relevant; apply the YAML stance instead of a separate essay file.

## Search

- `target_roles`, optional `also_consider` / `flag` / `search_terms`
- `ignore_companies` — list of company names `career-pipeline-source-leads` should skip (filled by `career-pipeline-archive-lead`)

## Background experience (accept-job)

`career-pipeline-accept-job` edits `background.experience` when you accept a role:

- Prepends `{ employer, title, start, end: present }` (`start` is `YYYY-MM` from the offer letter, else the user, else this month)
- Rewrites any existing `end: present` to that start month (previous current job)

Folder history lives under `career/<Company>/<Role>/`, not in YAML. If the script cannot patch the file, add the entry by hand.

## Naming patterns

Patterns are **basenames only** (no directory, no extension). Skills resolve tokens, then append the format the workflow already uses (`.pdf`, `.html`, `.md`).

| Key | Typical use |
|-----|-------------|
| `resume_version` | Fills `{version}` in `resume` |
| `resume` | Export under `design/exports/` |
| `cover_letter` | Cover letter HTML/PDF in the application folder |
| `assessment` | Fit assessment markdown |
| `job_posting_export` | Job-site screen capture / posting PDF |
| `combined_pdf` | Merged cover letter + resume packet |

Default Jordan Hale patterns:

```yaml
naming:
  resume_version: "v1"
  resume: "{firstName}{lastName}_Resume_{version}"
  cover_letter: "{firstName}_{companyName}_CoverLetter"
  assessment: "assessment"
  job_posting_export: "{source}_{companyName}_{shortRole}"
  combined_pdf: "{firstName}_{companyName}_{shortRole}"
```

### Tokens

| Token | Source |
|-------|--------|
| `{firstName}` | `candidate.first_name` |
| `{lastName}` | `candidate.last_name` |
| `{version}` | `naming.resume_version` |
| `{companyName}` | Active application company (filename-safe) |
| `{shortRole}` | Shortened job title (filename-safe) |
| `{source}` | Posting origin label (`LinkedIn`, `Indeed`, `Summitlane`, …) |

`{source}` keeps multiple exports for the same role from overwriting each other.

### Filename-safe cleanup

Apply when building `{shortRole}`, `{companyName}`, and `{source}` for filenames. One rule for Win/macOS/Linux (Windows is the strictest):

1. Shorten the job title into `{shortRole}` first, then sanitize.
2. Replace `\ / : * ? " < > |` and ASCII control characters with `_`.
3. Collapse whitespace and `_` runs; trim leading/trailing spaces, dots, and `_`.
4. If the result is a Windows reserved name (`CON`, `PRN`, `AUX`, `NUL`, `COM1`–`COM9`, `LPT1`–`LPT9`), append `_role`.
5. Prefer ASCII letters, digits, `_`, and `-` in the final token.

Example: `Sr. Ops Manager (Nights) — Austin/TX` → something like `SrOpsManager_Nights_AustinTX`.

### Future: per-artifact output format

v1 does not nest format/extension under `naming`. Tracked as [#15](https://github.com/dustinestes/career-pipeline/issues/15).

## Validate an example

From the repo root (requires PyYAML and jsonschema):

```bash
python3 - <<'PY'
import json, yaml, pathlib
from jsonschema import validate
root = pathlib.Path(".")
schema = json.loads((root / "schemas/career-pipeline.schema.json").read_text())
data = yaml.safe_load((root / "template/.career-pipeline.yml.example").read_text())
validate(instance=data, schema=schema)
print("ok")
PY
```

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
