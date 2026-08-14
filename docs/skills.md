<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Skills</h1>
<br clear="both">

Career-pipeline skills use a `career-pipeline-` **prefix on purpose**: a discoverability convention so typing `/` in the AI tool popup clusters this plugin’s skills and reduces name collisions with other packs. It is not a host/runtime requirement.

Natural language works too (“analyze this posting”, “set up career-pipeline here”). Descriptions in each skill’s frontmatter match the Description column below.

## Entrypoints

### Lead-sourced (optional)

1. Run `career-pipeline-source-leads` ad-hoc or on a schedule (e.g. Claude Desktop scheduled task).
2. Review `leads/<Company>.md` (open roles listed there).
3. Pass one URL, several roles, or the lead file into `career-pipeline-analyze-job`.

Removes manual board hunting when you want it. Not required.

### Direct posting

1. You already have a job URL.
2. Run `career-pipeline-analyze-job` with that URL.

Same gate either way → optional `create-application` → interview prep → analyze-offer → accept-job (or archive / delete).

## Setup

| Invoke | Description | Input | Output |
|--------|-------------|-------|--------|
| `/career-pipeline-init` | Scaffolds an empty job-search workspace from the career-pipeline template (design, leads, submissions, career, assets, consumer docs, example YAML). Use when the user asks to init, initialize, set up, or scaffold a career-pipeline / job-search workspace, or invokes /career-pipeline-init. | Empty folder (prefer); `--force` only after explicit override if non-empty | Workspace folders + `.career-pipeline.yml.example` (no live YAML, no vendored skills) |

## Lead Discovery

| Invoke | Description | Input | Output |
|--------|-------------|-------|--------|
| `/career-pipeline-source-leads` | Researches companies matching the candidate profile (or user seed criteria) and writes leads/\<Company\>.md with matching open roles. Use for ad-hoc or scheduled lead discovery; feed roles into career-pipeline-analyze-job next. Skips companies listed in search.ignore_companies. | Optional seed companies/criteria; YAML search + preferences | `leads/<Company>.md` |
| `/career-pipeline-archive-lead` | Archives a company lead file to leads/.archive and adds the company to search.ignore_companies so source-leads skips it. Use when the user wants to stop monitoring a company. | Company name; optional reason | `leads/.archive/<Company>.md` + YAML update |

## Application Lifecycle

| Invoke | Description | Input | Output |
|--------|-------------|-------|--------|
| `/career-pipeline-analyze-job` | Analyzes a job posting for fit and writes an analysis under submissions. Use when the user shares a job listing URL, passes roles from a lead file, asks to analyze a role, or wants apply/pass guidance (does not build cover letter or PDFs). | Posting URL(s) and/or lead roles | `submissions/<Company>/<Role>/<analysis>` + apply/pass guidance |
| `/career-pipeline-create-application` | Builds application artifacts for a role (skeleton, cover letter, PDFs). Use after analyze-job proceed, or when the user already decided to apply and wants artifacts without a new analysis. Does not submit to an ATS. | Company + role (analysis preferred) | `email/`, `application/` with cover letter, PDFs, exports |
| `/career-pipeline-create-interview-prep` | Builds interview prep for any round given company, role, round (1st/2nd/…), and audience. Creates interview - Nth folder on demand. Use for recruiter screens, hiring manager, technical, or later rounds. | Company, role, round, audience | `interview - Nth/<prep>` from `naming.interview.prep` |
| `/career-pipeline-analyze-offer` | Reviews an offer packet (compensation, benefits, equity) under a submission's offer/ folder. Use when the user receives an offer, pastes offer materials, or wants accept/decline guidance before career-pipeline-accept-job. | Company + role; offer materials in `offer/` or chat | `offer/<analysis>` from `naming.offer.analysis` + accept/decline guidance |
| `/career-pipeline-accept-job` | Promotes an accepted offer from submissions into career/\<Company\>/\<Role\>/ as employment history. Use after career-pipeline-analyze-offer when the user accepts a job, or when they ask to move a role into career history. | Company + role; start from offer letter, else ask, else this month | `career/<Company>/<Role>/` + YAML `background.experience` |
| `/career-pipeline-archive-submission` | Moves a closed application to submissions/.archive and cleans up empty company folders. Use when the user rejects a role, receives a rejection, withdraws, or asks to archive a submission. | Company + role; optional reason | `submissions/.archive/...` + optional `naming.archive.notes` |
| `/career-pipeline-delete-submission` | Permanently deletes a submission folder under submissions/\<Company\>/\<Role\>. Use when the user does not want to archive and confirms hard delete. Requires company and role name. | Company + role + confirm | Folder removed |

## Workspace folders

```text
design/                  # resume / cover letter HTML
leads/                   # company research from source-leads
submissions/             # live applications
career/                  # accepted roles (employment history)
```

### Submissions (active search)

```text
submissions/<Company>/<Role>/
  email/                 # user-exported .eml only (no mailbox automation in this plugin)
  application/           # analysis, cover letter, resume, full package, job post exports
  interview - 1st/       # created on demand
  interview - 2nd/
  offer/                 # created on demand (packet + offer analysis)
```

Lowercase names; related interview rounds share the `interview -` taxonomy prefix. No leading `N -` sort numbers.

**Offer:** drop offer letter, benefits, and equity docs into `offer/`, then run `career-pipeline-analyze-offer`. On proceed → `career-pipeline-accept-job`; on decline → `career-pipeline-archive-submission`.

**Email:** export/print mail into `email/` yourself. Automating every mailbox provider is out of scope; other plugins/MCPs may write into this layout if you want.

### Career history (after accept)

Offer accepted → `career-pipeline-accept-job` moves the submission tree into `career/` and scaffolds employment stages. That folder is the longer-term source of truth for the role.

```text
career/<Company>/<Role>/
  application/           # original application artifacts
  email/                 # mail kept with the role
  interview - Nth/       # interview prep from the search
  offer/                 # offer packet and details
  onboarding/            # new hire paperwork
  relocation/            # move, housing, visa
  reviews/               # performance reviews
  issues/                # workplace issues / HR notes
  leaving/               # resignation and offboarding
```

Same lowercase / taxonomy rules as submissions. `accept-job` also prepends the role to `.career-pipeline.yml` `background.experience`.

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
