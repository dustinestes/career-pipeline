# Customize your workspace

Personalization for this job-search workspace is **`.career-pipeline.yml`** at the workspace root.

## Checklist

1. Open `.career-pipeline.yml` (the template ships a filled **Jordan Hale** example).
2. Replace name, location, salary floor, and preferences with yours.
3. Update `search.target_roles` (and optional `also_consider` / `flag` / `search_terms`).
4. Rewrite `background` (experience, education, certifications, skills, interests, cover-letter `stories`).
5. Adjust `naming` patterns if you want different artifact basenames.
6. Keep the file at the workspace root so skills and rules can find it.

Do not add a `candidate-profile.md` or a `4 - Reference/` folder. Agents read only `.career-pipeline.yml`.

## Naming patterns

Patterns are basenames without extensions. Skills fill tokens such as `{firstName}`, `{companyName}`, `{shortRole}`, and `{source}`, then add `.pdf` / `.html` / `.md` as needed.

Filename-safe cleanup (special characters in titles, cross-platform) is documented in the plugin field guide: [docs/config.md](../../docs/config.md) (in a checkout of career-pipeline) or the same page on GitHub.

## Related

- PDF export commands: [tooling.md](tooling.md)
- Plugin field guide: [docs/config.md](../../docs/config.md)
