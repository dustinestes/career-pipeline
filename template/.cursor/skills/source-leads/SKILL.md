---
name: source-leads
description: >-
  Researches companies matching the candidate's target profile (or a
  user-supplied seed company/criteria) and writes a research profile to
  2 - Leads/<Company>.md. Use when the user wants to discover companies to
  target rather than assess a specific job listing.
disable-model-invocation: true
---

# Source Leads

## Instructions

### Phase 1: Establish criteria

1. Read `4 - Reference/candidate-profile.md` for salary floor, location
   requirement, target roles, and company stage/risk tolerance.
2. If the user supplied specific companies, seed criteria, or a reference
   company ("companies like X"), use those as the starting point. Otherwise
   use the candidate profile's stage/risk preference and target roles directly.
3. Confirm the short list of candidate companies with the user before doing
   deep research on each one, unless the user has already named them explicitly.

### Phase 2: Research (per company)

For each company, first check whether `2 - Leads/<Company>.md` already
exists. **If it exists, this is a refresh** — follow the "Refreshing an
existing lead file" procedure in `.cursor/rules/lead-format.mdc` rather than
writing a fresh file from scratch. Do not skip re-verifying a section just
because a prior run already filled it in; company facts, sentiment, and news
all go stale.

For a new company (no existing file):

1. Find the official careers page URL — this goes at the top of the lead file
   even if no matching roles are found, so the user can dig manually.
2. Gather: sector, headquarters, employee count, funding/stage, founding year.
3. Gather products/services (brief bullet list, not marketing copy).
4. Assess market sentiment — growth trajectory, funding confidence, competitive
   position, and any red flags (layoffs, leadership churn, negative press).
5. Find recent news from the last 6 months, with links.
6. Scan the careers page (or LinkedIn Jobs) for open roles matching the target
   roles in the candidate profile. Include title, link, location, and posted
   date where available. If nothing matches, say so explicitly rather than
   omitting the section.
7. Write `2 - Leads/<Company>.md` per `.cursor/rules/lead-format.mdc`, with
   this run's findings as the first (only) entry in Open Roles History.

### Phase 3: Present

Summarize each lead in 2-3 sentences with the recommendation-worthy signal
(why it fits the risk/stage profile) and point to the file. On a refresh,
call out what changed since the last run — new/closed roles, a shift in
sentiment, or a Trends note worth flagging (e.g. a title that keeps
reappearing). Do not auto-proceed to `analyze-job` on any discovered
posting — that's a separate, explicit step the user chooses to take.

## Examples

See [examples.md](examples.md).

## Additional resources

- Candidate profile: `4 - Reference/candidate-profile.md`
- Lead file format: `.cursor/rules/lead-format.mdc`
