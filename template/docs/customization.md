<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Customize your workspace</h1>
<br clear="both">

Personalization for this job-search workspace is **`.career-pipeline.yml`** at the workspace root.

Full setup order: [getting-started.md](getting-started.md).

## Checklist

1. Copy `.career-pipeline.yml.example` → `.career-pipeline.yml` if you have not already.
2. Replace name, location, and `contact.email` with yours (add `contact.phone` only if you want it on the resume).
3. Optional: set `links` (label + url) for LinkedIn, portfolio, GitHub, and similar. These become header icon chips on the resume/cover letter.
4. Replace salary floor and preferences with yours.
5. Update `search.target_roles` (and optional `also_consider` / `flag` / `search_terms`).
6. Rewrite `background` (experience, education, certifications, skills, interests, cover-letter `stories`).
7. Adjust `naming` patterns if you want different artifact basenames.
8. Keep the file at the workspace root so skills and rules can find it.
9. Browse `design/samples/`, pick a matched resume + cover letter pair, copy them to working files under `design/`, then remove `samples/` (see [getting-started.md](getting-started.md)).

## Naming patterns

Patterns are basenames without extensions. Skills fill tokens such as `{firstName}`, `{companyName}`, `{shortRole}`, and `{source}`, then add `.pdf` / `.html` / `.md` as needed.

Filename-safe cleanup is documented in the plugin field guide: [docs/config.md](../../docs/config.md) (in a checkout of career-pipeline) or the same page on GitHub.

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
