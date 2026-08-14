<br><br>
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/mark/mark-paper.svg">
  <img align="right" src="../assets/mark/mark-ink.svg" height="30" alt="Career Pipeline">
</picture>
<h1>Brand</h1>
<br clear="both">

Identity for Career Pipeline: name, tagline, palette, type, and which asset to use where.

<br>

## Contents

- [Contents](#contents)
- [Name](#name)
- [Tagline](#tagline)
- [Palette](#palette)
- [Typography](#typography)
- [Assets](#assets)

---

<br>

## Name

**Career Pipeline** is the display name (two words, no hyphen).

`career-pipeline` is the repo id, plugin `name`, and skill prefix. Use the hyphen only in those technical identifiers.

<br>

---

<br>

## Tagline

**your personal career agent for every milestone**

The product is a proactive search agent you keep running over time: find or persist a search, land the next role, and keep a forward look on career milestones. It also works when something sudden happens (a leave, a termination). The point is a forward-looking habit, not a one-shot scramble.

Hero lockups outline the tagline under the wordmark in **Archivo** Medium (smaller type, centered on the name; mark spans both lines). Footer lockups stay wordmark-only; the tagline sits beside them as HTML.

**Plugin / directory description** (`plugin.json` and `.cursor-plugin/plugin.json`). Galleries take a plain string, so this stays one sentence. README heroes use the same opener plus a bullet list:

> A personal career agent for managing every milestone throughout your career: resume and cover letter templates and generation, ad-hoc and scheduled lead sourcing, personal fit analysis of job postings, per-round interview prep, offer analysis, job acceptance, and career history.

<br>

---

<br>

## Palette

| Token | Hex | Role |
|-------|-----|------|
| Soft Black | `#1A1A1A` | App-icon background; light-mode mark stroke; light-mode wordmark |
| Line Grey | `#C4C4C4` | App-icon path; dark-mode mark stroke; light-mode milestone fills |
| Pure White | `#FFFFFF` | App-icon milestones; dark-mode milestones and wordmark |
| Paper | `#F5F5F5` | Optional light surface |

Do not use pure `#000000` for Soft Black.

Light-mode marks and lockups use a Soft Black stroke with Line Grey milestones on a light page. Dark-mode twins use Line Grey plus white, swapped with `<picture>` and `prefers-color-scheme: dark`.

<br>

---

<br>

## Typography

| Face | Weights | Use |
|------|---------|-----|
| Space Grotesk | 600 / 700 | Wordmark and display titles (gallery `h1`, card titles). Wordmark lockups outline Bold so GitHub does not need the font installed. |
| Archivo | 400 / 500 / 600 | Gallery UI and body copy; hero tagline under the wordmark (outlined Medium / 500 in `lockup-hero-*.svg`) |
| Host default mono | | Markdown code blocks; gallery `code` and filename labels (`ui-monospace`) |

**Body in markdown:** GitHub defaults. Do not add custom webfonts or CSS to README or `docs/` chrome.

Resume and cover letter samples pick their own type per design pair. Those faces are not product brand fonts.

<br>

---

<br>

## Assets

| File | Use |
|------|-----|
| [`assets/logo.svg`](../assets/logo.svg) | App / plugin icon (rounded square) |
| [`assets/mark/mark-ink.svg`](../assets/mark/mark-ink.svg) | Docs header, light |
| [`assets/mark/mark-paper.svg`](../assets/mark/mark-paper.svg) | Docs header, dark |
| [`assets/lockups/lockup-stacked-ink.svg`](../assets/lockups/lockup-stacked-ink.svg) | Optional stacked lockup, light |
| [`assets/lockups/lockup-stacked-paper.svg`](../assets/lockups/lockup-stacked-paper.svg) | Optional stacked lockup, dark |
| [`assets/lockups/lockup-horizontal-ink.svg`](../assets/lockups/lockup-horizontal-ink.svg) | Footer lockup, light |
| [`assets/lockups/lockup-horizontal-paper.svg`](../assets/lockups/lockup-horizontal-paper.svg) | Footer lockup, dark |
| [`assets/lockups/lockup-hero-ink.svg`](../assets/lockups/lockup-hero-ink.svg) | Plugin and consumer README hero, light (Space Grotesk wordmark + Archivo tagline) |
| [`assets/lockups/lockup-hero-paper.svg`](../assets/lockups/lockup-hero-paper.svg) | Plugin and consumer README hero, dark |

The mark is the pipeline path and three milestone dots with no app square. Lockups pair that mark with the Career Pipeline wordmark. Horizontal lockups are icon plus wordmark only. Hero lockups add the outlined tagline; footer tagline is HTML, right-aligned beside the horizontal lockup.

Consumer workspaces get a copy of the logo, marks, and lockups under `template/assets/` so relative paths still work after init. `docs/brand.md` stays in this plugin repo.

GitHub-flavored Markdown only for chrome: `picture`, `img`, headings, `<br>`, `---`. No custom CSS.

<br>

---

<br>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../assets/lockups/lockup-horizontal-paper.svg">
  <img align="left" src="../assets/lockups/lockup-horizontal-ink.svg" height="32" alt="Career Pipeline">
</picture>
<div align="right">your personal career agent for every milestone</div>
<br clear="both">
