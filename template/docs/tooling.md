<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Tooling</h1>
<br clear="both">

Prerequisites for PDF export and application assembly.

## Required

| Tool | Purpose |
|------|---------|
| [Cursor](https://cursor.com) | IDE with rules and skills support |
| Google Chrome | Headless HTML → PDF export |
| `pdfunite` | Merge cover letter + resume (poppler-utils) |

### Install pdfunite

```bash
# Debian/Ubuntu
sudo apt install poppler-utils

# macOS
brew install poppler
```

## Chrome headless export

Run from the application folder unless noted. Resolve `pattern` and `extension` from `.career-pipeline.yml` `naming.*` (plugin `docs/config.md`).

### Cover letter (continuous — preferred)

Single uninterrupted page, no pagination artifacts. Resolve `naming.application.cover_letter` (HTML working copy is always `{basename}.html`; print uses configured `extension`, default `pdf`):

```bash
google-chrome --headless=new --window-size=816,900 \
  --print-to-pdf="<cover_letter>.<extension>" \
  --print-to-pdf-no-header --no-margins \
  "file://$PWD/<cover_letter>.html?continuous"
```

### Resume (from repo root)

Resolve `naming.application.resume`:

```bash
google-chrome --headless=new --window-size=816,900 \
  --print-to-pdf="design/exports/<resume>.<extension>" \
  --print-to-pdf-no-header --no-margins \
  "file://$PWD/design/resume.html?continuous"
```

Use your working resume path (often copied from a pair under `design/samples/`).

### Full package PDF

Resolve cover letter, resume, and `naming.application.full_package`:

```bash
pdfunite <cover_letter>.pdf <resume>.pdf <full_package>.<extension>
```

### Company careers page / job-site export

Resolve from `naming.application.job_post_export` (include `{source}` so LinkedIn,
Indeed, and careers-page captures do not overwrite each other):

```bash
google-chrome --headless=new --disable-gpu \
  --print-to-pdf="<job_post_export>.<extension>" \
  --no-margins --virtual-time-budget=10000 \
  "<careers-url>"
```

Skip if the page is JS-rendered and returns blank content.

## LinkedIn job posting PDF

Agents cannot authenticate to LinkedIn. Print to PDF from a logged-in browser.

If the print truncates (single page, cuts off mid-sentence), run in DevTools console before Ctrl+P:

```js
document.querySelectorAll('*').forEach(el => {
  el.style.setProperty('overflow', 'visible', 'important');
  el.style.setProperty('max-height', 'none', 'important');
  el.style.setProperty('height', 'auto', 'important');
});
```

## Optional: publish resume site

Wire your own CI (for example GitHub Pages) if you want a public HTML resume. Not required for the pipeline.

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
