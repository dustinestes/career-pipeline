---
name: next-interview
description: >-
  Builds interview prep for 2nd round and beyond based on round number and
  audience. Use when the user mentions a follow-up interview, panel, hiring
  manager call, or names a specific interview phase.
disable-model-invocation: true
---

# Next Interview

## Instructions

**Input:** Company, role, round (2nd/3rd/4th), and any known details: audience, format, topics, interviewer names.

### Step 1: Map round to folder

| Round | Folder |
|-------|--------|
| 2nd | `3 - 2nd Interview/` |
| 3rd | `4 - 3rd Interview/` |
| 4th | `5 - 4th Interview/` |

Resolve `3 - Applications/<Company>/<Job Title>/`. If phase skeleton missing, run `initial-interview` promotion steps first.

### Step 2: Gather context

Ask the user for anything not in the invite or prior prep:
- Interviewer names, titles, LinkedIn if available
- Format (panel, technical, behavioral, presentation)
- Stated or expected topics
- Duration and tool (Zoom, Teams, onsite)

### Step 3: Read prior material

- `1 - Application/assessment.md`
- Previous round `interview-prep.md` files
- Relevant emails in `0 - Email/`

### Step 4: Build ad-hoc prep

Write `<round-folder>/interview-prep.md`:

1. Metadata header per `.cursor/rules/interview-prep-standards.mdc`
2. **Fresh** Company Research — do not reuse stale content from earlier rounds
3. Audience-specific sections (e.g. "About [Interviewer]", "Scope note", "Approach for This Call")
4. Tailored talking points and questions based on format and what the user learned from prior rounds

No fixed template beyond header and research requirements. Adapt structure to the stated audience.

### Step 5: Commit

Offer commit only when user requests.

## Examples

See [examples.md](examples.md).

## Additional resources

- Interview prep standards: `.cursor/rules/interview-prep-standards.mdc`
- Prior round preps in the application folder
