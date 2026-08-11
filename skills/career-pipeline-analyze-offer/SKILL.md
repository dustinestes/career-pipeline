---
name: career-pipeline-analyze-offer
description: >-
  Reviews an offer packet (compensation, benefits, equity) under a submission's
  offer/ folder. Use when the user receives an offer, pastes offer materials, or
  wants accept/decline guidance before career-pipeline-accept-job.
disable-model-invocation: true
---

# Analyze Offer

## Prerequisites

If workspace-root `.career-pipeline.yml` is missing, **stop**. Tell the user to copy `.career-pipeline.yml.example` → `.career-pipeline.yml` and edit it (or run `career-pipeline-init` first). Do not invent persona data.

Prefer an existing submission under `submissions/<Company>/<Role>/` with `application/` artifacts (run `career-pipeline-create-application` first if missing).

## Input

| Field | Required | Notes |
|-------|----------|-------|
| Company + role, or path under `submissions/` | Yes | Ask if missing |
| Offer materials | Yes | Files under `offer/` and/or pasted in chat |

## Output

```text
submissions/<Company>/<Role>/
  offer/                 # created on demand
    <user materials>   # offer letter, benefits, equity docs (user-supplied)
    offer-review.md      # structured review
```

Accept / decline guidance in chat; on proceed, hand off to `career-pipeline-accept-job`. On decline, point to `career-pipeline-archive-submission`.

## Instructions

1. Read workspace-root `.career-pipeline.yml` for `compensation.*`, preferences, and background (plugin `docs/config.md`).
2. Resolve `submissions/<Company>/<Role>/`. Create `offer/` if missing (lowercase single segment; do not invent other lifecycle folders).
3. If `offer/offer-review.md` already exists: **stop**, show the path, ask refresh/overwrite vs leave alone. Do not re-review unless the user confirms refresh.
4. Collect materials. Prompt the user to drop or paste the offer letter, benefits docs, equity program docs, and related packet files into `offer/` (chat paste is fine). If `offer/` has no usable materials and nothing was pasted, **stop and wait** — do not invent base salary, bonus, benefits, or equity terms.
5. When materials exist, review:
   - **Compensation:** compare base (and total cash if stated) to YAML `compensation.salary_floor` / `currency` / `notes`. Compare against public comps for recent or current comparable roles; cite sources and flag uncertainty.
   - **Benefits:** competitiveness vs typical packages for the role/market; flag gaps or concerns.
   - **Equity:** when present, quote language and vesting verbatim; assess competitiveness and apply `compensation.equity_counts_toward_floor` plus optional `compensation.notes`. Skip equity section only when the packet has none.
6. Write `offer/offer-review.md` per career-pipeline `offer-review-format`. Present accept/decline guidance in chat.
7. On proceed/accept, tell the user to run `/career-pipeline-accept-job` (or ask in natural language). On decline, point to `/career-pipeline-archive-submission`.

## Examples

See [examples.md](examples.md).

## Additional resources

- Config: plugin `docs/config.md`
- Workspace config: `.career-pipeline.yml`
- Next step (accept): `career-pipeline-accept-job`
- Decline path: `career-pipeline-archive-submission`
