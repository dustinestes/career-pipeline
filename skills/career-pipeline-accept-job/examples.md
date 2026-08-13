# Accept Job Examples

## After offer review

**Input:** Company `Acme`, role `Warehouse Supervisor`; offer letter in `offer/` states first day 14 September 2026; user says they accepted.

Agent reads the letter, uses `2026-09`, confirms the move, runs `accept-job.sh`. Submission tree lands under `career/Acme/Warehouse Supervisor/` with `onboarding/`, `relocation/`, `reviews/`, `issues/`, and `leaving/` added. YAML gets a new current `background.experience` entry; the prior `end: present` job closes at that start month.

## Start date missing from packet

**Input:** Same company/role; `offer/` has no start / hire / first-day date.

Agent asks the user. If they give a month, use it. If they proceed without one, use this month.

## No offer review yet

**Input:** User wants to accept Acme / Warehouse Supervisor but `offer/offer-review.md` is missing.

Agent warns, points at `career-pipeline-analyze-offer`, and only runs accept after the user confirms they already accepted without a review.

## Already in career history

**Input:** `submissions/Acme/Warehouse Supervisor/` is gone; `career/Acme/Warehouse Supervisor/` exists.

Agent shows the career path and stops. Does not move or rewrite YAML.
