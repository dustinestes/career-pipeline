# source-leads Examples

## Example 1: Seeded by a reference company

**Input:** "Find companies similar to Cursor and NinjaOne — fast-growing
startup, sweat equity, don't mind short-term pay decrease for equity upside."

**Agent step 1 — confirm candidate list:**

```
Based on your risk/stage preference, a few candidates worth researching:

- Automox — patch/endpoint automation, direct overlap with your packaging background
- Kandji — Apple MDM, well-funded, growing fast
- Vercel — dev platform, strong AI-tooling angle

Want me to build lead profiles for these, or a different set?
```

**Agent step 2 — after confirmation, per company:**

```markdown
# Vercel

**Careers page:** https://vercel.com/careers
**Researched:** 2026-08-06

---

## Overview

Frontend cloud platform for deploying and scaling web apps, built around
Next.js. Strong developer-experience focus and heavy AI-tooling investment
(v0, AI SDK).

| Field | Value |
|-------|-------|
| Sector | Developer tooling / cloud infrastructure |
| Headquarters | San Francisco, CA |
| Employee count | ~800 (approx, LinkedIn) |
| Funding / stage | Series E, $250M raised, ~$3.25B valuation |
| Founded | 2015 |

## Products / Services

- Vercel platform (hosting, deployment, edge functions)
- Next.js (open source framework, maintained by Vercel)
- v0 (AI-assisted UI generation)
- AI SDK

...

## Open Roles History

### 2026-08-06

- Platform Engineer, Infrastructure — [listing](URL) — Remote (US)
- No dedicated "Automation Engineer" title found — closest matches listed above
```

## Example 2: No seed given

**Input:** "What other companies should I be looking at?"

Agent reads `4 - Reference/candidate-profile.md` stage/risk section directly,
proposes a short list grounded in target roles and risk profile, and confirms
before researching each one in depth.

## Example 3: Refreshing an existing lead

**Input:** "Check Vercel again" (three months after the file in Example 1 was created)

**Agent:** Sees `2 - Leads/Vercel.md` already exists, treats this as a
refresh per `.cursor/rules/lead-format.mdc`. Re-verifies Overview, Products/
Services, Market Sentiment, and Fit Notes rather than assuming they still
hold; replaces Recent News with the new trailing 6 months; prepends a new
dated section to Open Roles History without touching the 2026-08-06 entry:

```markdown
## Open Roles History

### 2026-11-06

- Platform Engineer, Infrastructure — [listing](URL) — Remote (US)
- Software Engineer, Deployment Infrastructure — [listing](URL) — Remote (US)

### 2026-08-06

- Platform Engineer, Infrastructure — [listing](URL) — Remote (US)
- No dedicated "Automation Engineer" title found — closest matches listed above

## Trends

"Platform Engineer, Infrastructure" has now appeared in both the August and
November checks — either sustained hiring need or the role hasn't been
filled. Worth asking about team size/turnover if this comes up in an
application.
```

Then reports back: "Vercel still hasn't moved on funding since the last
check, but there's a second infra role open now, and Platform Engineer,
Infrastructure has stayed open since August — worth asking why in an
interview if you apply."
