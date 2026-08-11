# Design

Editable resume and cover letter HTML for this job-search workspace.

## Sample templates

Matched resume + cover letter pairs live under [`samples/`](samples/). Every pair uses the same Jordan Hale content model (contact chips, optional link icons, light/dark where present, print / `?continuous` export). Styles differ so you can shop without designing from scratch.

Browse side by side: open [`samples/index.html`](samples/index.html) in a browser (double-click / Open With is fine; no local server required). Each card is a static section for one sample number. Sample HTML files also carry matching `career-pipeline_*` meta tags (label, summary, details) so tooling and the gallery stay aligned. No sample is preferred by the tool; pick by number when working with AI.

| Meta (on each sample HTML) | Purpose |
|----------------------------|---------|
| `career-pipeline_sample` | Pair number |
| `career-pipeline_label` | Short name |
| `career-pipeline_summary` | Design / theme one-liner |
| `career-pipeline_details` | Factual layout notes |

When adding another pair, add `resume_sample_N.html` / `cover_letter_sample_N.html` with those metas, then copy another card block in `index.html`.

## Choose once, then lock in

1. Browse `samples/` (or `samples/index.html`).
2. Copy your chosen resume + cover letter into working files at `design/` (for example `resume.html` and `cover-letter.html`), then rewrite from `.career-pipeline.yml`.
3. **Delete `samples/`** (and any other leftover HTML) so `design/` holds only those two working sources plus optional `exports/`.

After that, skills and agents must treat those two files as the only layout and style sources. Per-job cover letters copy the working cover letter’s CSS and structure; they do not restyle.

Contact chips come from `.career-pipeline.yml` `contact.email` (required) and `contact.phone` only when present. Optional `links` (label + url) render as header icon chips on the right of the contact row (see sample `contact-icons`).

`exports/` is optional storage for finished PDFs when you choose to export. Export is not required to use the pipeline.

Setup walkthrough: [docs/getting-started.md](../docs/getting-started.md).
