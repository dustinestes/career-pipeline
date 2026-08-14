# Analyze Job Examples

## Direct posting URL

**Input:** `https://careers.example.com/jobs/warehouse-supervisor`

Agent resolves company/role, checks no prior analysis, writes `submissions/Example Co/Warehouse Supervisor/job-post-analysis.md` (from `naming.application.analysis`), presents apply/pass. Does not build cover letter until `career-pipeline-create-application`.

## From a lead file

**Input:** User points at `leads/Acme.md` Open Roles and asks to analyze the two linked postings.

Agent runs analyze for each role (separate folders), skipping any that already have analyses unless refresh is confirmed.

## Prior analysis exists

**Input:** Same URL as a previous run.

Agent finds existing analysis, shows path, asks refresh vs stop.
