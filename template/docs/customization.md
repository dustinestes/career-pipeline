# Customize your workspace

Personalization for this job-search workspace is **`.career-pipeline.yml`** at the workspace root.

Full setup order (persona YAML, then resume HTML): [getting-started.md](getting-started.md).

## Checklist

1. Open `.career-pipeline.yml` (the template ships a filled **Jordan Hale** example).
2. Replace name, location, and `contact.email` with yours (add `contact.phone` only if you want it on the resume).
3. Replace salary floor and preferences with yours.
4. Update `search.target_roles` (and optional `also_consider` / `flag` / `search_terms`).
5. Rewrite `background` (experience, education, certifications, skills, interests, cover-letter `stories`).
6. Adjust `naming` patterns if you want different artifact basenames.
7. Keep the file at the workspace root so skills and rules can find it.
8. Build resume and cover letter HTML from chosen samples under `design/`, then keep only those working files (see [getting-started.md](getting-started.md)).

## Naming patterns

Patterns are basenames without extensions. Skills fill tokens such as `{firstName}`, `{companyName}`, `{shortRole}`, and `{source}`, then add `.pdf` / `.html` / `.md` as needed.

Filename-safe cleanup (special characters in titles, cross-platform) is documented in the plugin field guide: [docs/config.md](../../docs/config.md) (in a checkout of career-pipeline) or the same page on GitHub.

## Related

- Setup walkthrough: [getting-started.md](getting-started.md)
- Design samples: [design/README.md](../design/README.md)
- Optional PDF export: [tooling.md](tooling.md)
- Plugin field guide: [docs/config.md](../../docs/config.md)
