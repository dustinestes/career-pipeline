---
name: initial-interview
description: >-
  Promotes an application to the interview folder structure and builds first-round
  interview prep. Use when the user receives an interview invite, mentions a
  recruiter screen, or asks to prep for a 1st interview.
disable-model-invocation: true
---

# Initial Interview

## Instructions

**Input:** Company + role title, or path to `submissions/<Company>/<Job Title>/`. Optional: invite email (`.eml`).

### Step 1: Locate application

Resolve folder path. If missing, stop and ask the user to run `analyze-job` first.

### Step 2: Promote to phase skeleton (if flat)

If the folder has artifacts at root (no `0 - Email/` yet):

1. Run `.cursor/skills/initial-interview/scripts/create-skeleton.sh "<app-folder>"`
2. Move to `1 - Application/` (basenames from `.career-pipeline.yml` `naming.*`):
   - Assessment markdown (`naming.assessment`)
   - Cover letter HTML/PDF (`naming.cover_letter`)
   - Resume PDF (resolved `naming.resume`; do not rename)
   - Combined PDF (`naming.combined_pdf`)
   - Job posting PDFs (`naming.job_posting_export`)
3. Place invite `.eml` files in `0 - Email/` (create `Sent/` subfolder for outbound if needed)

**Notes:**
- Interview folders (2–5) have no audience suffix in the folder name
- Track audience/format inside `interview-prep.md`

### Step 3: Gather invite metadata

Parse `0 - Email/` for date, time, timezone, type (phone/video/in-person), tool, and attendee names. Ask the user to fill anything missing.

### Step 4: Build 1st interview prep

1. Re-read `1 - Application/` assessment markdown (basename from `naming.assessment`)
2. Identify screening priorities: comp, remote/travel, role scope, top 2–3 strengths
3. Write `2 - 1st Interview/interview-prep.md` per `.cursor/rules/interview-prep-standards.mdc`:
   - Metadata header
   - Company Research (fresh web search)
   - Context summary from assessment
   - Questions to ask (position, team, process)
   - Prepared strength responses
   - Prepared gap responses (honest, not self-disqualifying)
   - Salary Benchmarking (sources noted; flag when deeper comp research would help)
   - Equity note if posting mentions RSU/stock — apply `.career-pipeline.yml` `compensation.equity_counts_toward_floor` / `notes`

### Step 5: Commit

Offer commit only when user requests.

## Examples

See [examples.md](examples.md).

## Additional resources

- Skeleton script: [scripts/create-skeleton.sh](scripts/create-skeleton.sh)
- Interview prep standards: `.cursor/rules/interview-prep-standards.mdc`
- Workspace config: `.career-pipeline.yml`
