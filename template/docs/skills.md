# Skills

Career-pipeline skills use a `career-pipeline-` **prefix on purpose**: a discoverability convention so typing `/` in the AI tool popup clusters this plugin’s skills and reduces name collisions with other packs. It is not a host/runtime requirement.

Natural language works too (“analyze this posting”, “set up career-pipeline here”). Descriptions in each skill’s frontmatter match the Description column below.

**Future (not shipped):** [`career-pipeline-accept-job`](https://github.com/dustinestes/career-pipeline/issues/27) will promote an accepted offer into `career/<Company>/<Role>/` employment history.

## Entrypoints

### Lead-sourced (optional)

1. Run `career-pipeline-source-leads` ad-hoc or on a schedule (e.g. Claude Desktop scheduled task).
2. Review `leads/<Company>.md` (open roles listed there).
3. Pass one URL, several roles, or the lead file into `career-pipeline-analyze-job`.

Removes manual board hunting when you want it. Not required.

### Direct posting

1. You already have a job URL.
2. Run `career-pipeline-analyze-job` with that URL.

Same gate either way → optional `create-application` → interview prep / archive / delete.

## Setup

| Invoke | Description | Input | Output |
|--------|-------------|-------|--------|
| `/career-pipeline-init` | Scaffolds an empty job-search workspace from the plugin template (design, leads, submissions, consumer docs, example YAML). Use when the user asks to init, initialize, set up, or scaffold a career-pipeline / job-search workspace. | Empty folder (prefer); `--force` only after explicit override if non-empty | Workspace folders + `.career-pipeline.yml.example` (no live YAML, no vendored skills) |

## Lead Discovery

| Invoke | Description | Input | Output |
|--------|-------------|-------|--------|
| `/career-pipeline-source-leads` | Researches companies matching the candidate profile (or user seed criteria) and writes leads/\<Company\>.md with matching open roles. Use for ad-hoc or scheduled lead discovery; feed roles into career-pipeline-analyze-job next. Skips companies listed in search.ignore_companies. | Optional seed companies/criteria; YAML search + preferences | `leads/<Company>.md` |
| `/career-pipeline-archive-lead` | Archives a company lead file to leads/.archive and adds the company to search.ignore_companies so source-leads skips it. Use when the user wants to stop monitoring a company. | Company name; optional reason | `leads/.archive/<Company>.md` + YAML update |

## Application Lifecycle

| Invoke | Description | Input | Output |
|--------|-------------|-------|--------|
| `/career-pipeline-analyze-job` | Assesses a job posting for fit and writes an assessment under submissions. Use when the user shares a job listing URL, passes roles from a lead file, asks to analyze a role, or wants apply/pass guidance (does not build cover letter or PDFs). | Posting URL(s) and/or lead roles | `submissions/<Company>/<Role>/<assessment>.md` + apply/pass guidance |
| `/career-pipeline-create-application` | Builds application artifacts for a role (skeleton, cover letter, PDFs). Use after analyze-job proceed, or when the user already decided to apply and wants artifacts without a new assessment. Does not submit to an ATS. | Company + role (assessment preferred) | `email/`, `application/` with cover letter, PDFs, exports |
| `/career-pipeline-create-interview-prep` | Builds interview prep for any round given company, role, round (1st/2nd/…), and audience. Creates interview - Nth folder on demand. Use for recruiter screens, hiring manager, technical, or later rounds. | Company, role, round, audience | `interview - Nth/interview-prep.md` |
| `/career-pipeline-archive-submission` | Moves a closed application to submissions/.archive and cleans up empty company folders. Use when the user rejects a role, receives a rejection, withdraws, or asks to archive a submission. | Company + role; optional reason | `submissions/.archive/...` |
| `/career-pipeline-delete-submission` | Permanently deletes a submission folder under submissions/\<Company\>/\<Role\>. Use when the user does not want to archive and confirms hard delete. Requires company and role name. | Company + role + confirm | Folder removed |

## Submission folders

```text
submissions/<Company>/<Role>/
  email/                 # user-exported .eml only (no mailbox automation in this plugin)
  application/           # assessment, cover letter, resume, combined, posting PDFs
  interview - 1st/       # created on demand
  interview - 2nd/
```

Lowercase names; related interview rounds share the `interview -` taxonomy prefix. No leading `N -` sort numbers.

**Email:** export/print mail into `email/` yourself. Automating every mailbox provider is out of scope; other plugins/MCPs may write into this layout if you want.
