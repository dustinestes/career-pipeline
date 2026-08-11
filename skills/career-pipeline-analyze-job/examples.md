# Analyze Job Examples

## Direct posting URL

**Input:** `https://careers.example.com/jobs/warehouse-supervisor`

Agent resolves company/role, checks no prior assessment, writes `submissions/Example Co/Warehouse Supervisor/assessment.md`, presents apply/pass. Does not build cover letter until `career-pipeline-create-application`.

## From a lead file

**Input:** User points at `leads/Acme.md` Open Roles and asks to analyze the two linked postings.

Agent runs analyze for each role (separate folders), skipping any that already have assessments unless refresh is confirmed.

## Prior assessment exists

**Input:** Same URL as a previous run.

Agent finds existing assessment, shows path, asks refresh vs stop.
