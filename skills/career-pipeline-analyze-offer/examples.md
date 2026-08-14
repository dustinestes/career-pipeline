# Analyze Offer Examples

## Fresh offer packet

**Input:** Company `Acme`, role `Warehouse Supervisor`; user drops offer PDF and benefits PDF into `offer/`.

Agent creates `offer/` if needed, reads the files, writes `offer/offer-analysis.md` (from `naming.offer.analysis`) with compensation/benefits/equity sections, presents accept/decline. On proceed, points to `career-pipeline-accept-job`.

## Materials missing

**Input:** User asks to analyze the offer for Acme / Warehouse Supervisor but `offer/` is empty.

Agent creates `offer/` if missing, asks the user to paste or drop the offer letter and related docs, then **stops** until materials exist.

## Prior review exists

**Input:** Same company/role; `offer/offer-analysis.md` already present.

Agent shows the path, asks refresh vs leave alone. Only re-reviews after confirm.
