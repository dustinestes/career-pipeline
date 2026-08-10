# Tooling

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

Run from the application folder unless noted.

### Cover letter (continuous — preferred)

Single uninterrupted page, no pagination artifacts. Resolve the cover letter
basename from `.career-pipeline.yml` `naming.cover_letter`:

```bash
google-chrome --headless=new --window-size=816,900 \
  --print-to-pdf="<cover_letter>.pdf" \
  --print-to-pdf-no-header --no-margins \
  "file://$PWD/<cover_letter>.html?continuous"
```

### Resume (from repo root)

Resolve the resume basename from `naming.resume` / `naming.resume_version`:

```bash
google-chrome --headless=new --window-size=816,900 \
  --print-to-pdf="design/exports/<resume>.pdf" \
  --print-to-pdf-no-header --no-margins \
  "file://$PWD/design/resume.html?continuous"
```

### Combined application PDF

Resolve cover letter, resume, and combined basenames from `naming.*`:

```bash
pdfunite <cover_letter>.pdf <resume>.pdf <combined_pdf>.pdf
```

### Company careers page / job-site export

Resolve from `naming.job_posting_export` (include `{source}` so LinkedIn,
Indeed, and careers-page captures do not overwrite each other):

```bash
google-chrome --headless=new --disable-gpu \
  --print-to-pdf="<job_posting_export>.pdf" \
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
