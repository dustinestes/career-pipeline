# Design

Editable resume and cover letter HTML for this job-search workspace.

## Sample templates

The plugin template ships sample starting points (Jordan Hale persona):

| File | Purpose |
|------|---------|
| `resume_sample_1.html` | Resume layout sample |
| `cover_letter_sample_1.html` | Cover letter layout sample |

More variants may appear later (`*_sample_2`, and so on).

## Choose once, then lock in

1. Pick one resume sample and one cover letter sample (usually a matching pair).
2. Rewrite them from your `.career-pipeline.yml` into stable working files (for example `resume.html` and `cover-letter.html`).
3. **Delete the unused samples** (and any other leftover HTML) so `design/` holds only those two working sources plus optional `exports/`.

After that, skills and agents must treat those two files as the only layout and style sources. Per-job cover letters copy the working cover letter’s CSS and structure; they do not restyle.

Contact chips come from `.career-pipeline.yml` `contact.email` (required) and `contact.phone` only when present.

`exports/` is optional storage for finished PDFs when you choose to export. Export is not required to use the pipeline.

Setup walkthrough: [docs/getting-started.md](../docs/getting-started.md).
