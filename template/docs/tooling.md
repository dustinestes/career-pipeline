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

Single uninterrupted page, no pagination artifacts:

```bash
google-chrome --headless=new --window-size=816,900 \
  --print-to-pdf="cover-letter-<company>.pdf" \
  --print-to-pdf-no-header --no-margins \
  "file://$PWD/cover-letter-<company>.html?continuous"
```

### Resume (from repo root)

```bash
google-chrome --headless=new --window-size=816,900 \
  --print-to-pdf="1 - Design/Exports/<resume-filename>.pdf" \
  --print-to-pdf-no-header --no-margins \
  "file://$PWD/1 - Design/resume.html?continuous"
```

### Combined application PDF

```bash
pdfunite cover-letter-<company>.pdf <ResumeFile>.pdf <Prefix>_<Company>_<ShortRole>.pdf
```

### Company careers page

```bash
google-chrome --headless=new --disable-gpu \
  --print-to-pdf="<Company> - <Job Title>.pdf" \
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
