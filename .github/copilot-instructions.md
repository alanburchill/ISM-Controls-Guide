# Essential 8 Guide — AI Coding Instructions

## Project Overview

A Jekyll-powered GitHub Pages site providing implementation guidance for Australian Essential Eight (E8) controls in Microsoft environments. Each control page is generated from Markdown files with YAML front matter. The site currently contains **54 ISM controls**.

- **Live site:** <https://e8guide.com>
- **Preview site:** <https://alanburchill.github.io/ISM-Controls-Guide-preview/> (deploys from `research-review-controls` branch)
- **Repository:** `alanburchill/ISM-Controls-Guide`

## Architecture

```
controls/               → 54 ISM control markdown files (Jekyll converts to HTML)
_layouts/
  control.html          → Control detail page template (prev/next nav, JSON-LD, callouts)
  default.html          → Generic page template (about, 404, etc.)
_includes/
  header.html           → Shared site header
  seo.html              → Canonical URL, meta description, Open Graph, Twitter Card, favicon
  analytics.html        → GA4 snippet (conditional on site.google_analytics)
assets/
  css/main.css          → Shared stylesheet (GitHub dark-mode theme)
  search_index.json     → Client-side search data (one entry per control)
_data/
  site_index.yml        → Navigation / index data grouped by section
index.html              → Homepage with search box, filters, and control cards (vanilla JS)
view.html               → Legacy client-side control viewer (kept for backwards compat)
about.md                → About page
404.html                → Custom 404 page
robots.txt              → Crawl directives + sitemap reference
sitemap.xml             → Sitemap index (references sitemap-1.xml)
sitemap-1.xml           → URL set for all control pages
security.txt            → .well-known/security.txt
CNAME                   → Custom domain (e8guide.com)
Gemfile                 → Ruby dependencies (jekyll ~> 4.2, jekyll-last-modified-at, jekyll-feed)
_config.yml             → Jekyll settings, defaults, GA4 ID, GSC token
.github/
  copilot-instructions.md → This file
  workflows/
    pages.yml             → Production deploy (main → GitHub Pages) + smoke tests
    preview.yml           → Preview deploy (research-review-controls → preview repo)
    controls-maintenance.yml → Manual workflow for bulk control fixes
docs/                   → Local-only documentation (gitignored, not deployed)
tools/
  check-preview.ps1     → Local script to verify preview site
```

### What is NOT tracked (gitignored)

| Pattern | Reason |
|---------|--------|
| `scripts/` | Legacy Python generators, superseded by Jekyll |
| `docs/` | Internal documentation, playbooks, review notes |
| `.github/agents/` | VS Code Copilot agent definitions (local dev only) |
| `.github/workflows/add-permalinks.yml` | Broken workflow (depends on untracked scripts) |
| `.github/workflows/generate-controls.yml` | Broken workflow (depends on untracked scripts) |
| `*.zip`, `*.code-workspace` | Binary / editor artifacts |

---

## Control File Conventions

### Naming

Files are named `ISM-XXXX.md` (e.g., `ISM-1621.md`). No `row-N-` prefix.

### Front Matter

Every control file requires this YAML front matter:

```yaml
---
permalink: /controls/ISM-XXXX.html   # Required — defines the URL
title: "Brief control description"
ism_control: "ISM-XXXX"
revision: "1"
updated: "Sep-21"
generated_from: "row-N-ISM-XXXX.response.md"   # Source response file
date_generated: "2026-02-13"                     # When this page was generated
---
```

The `permalink` field is critical — controls expect `/controls/ISM-XXXX.html` URLs.

### Content Structure

Every control page follows this section order:

```markdown
## Control title (repeated as H2)

| Property | Value |
| ---------- | ------- |
| **ISM Control** | ISM-XXXX |
| **Revision** | N |
| **Updated** | Mon-YY |
| **Guideline** | … |
| **Section** | … |
| **Topic** | … |
| **Essential Eight** | ML1, ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary
<narrative text with footnote references [^1][^2]>

> [!IMPORTANT]   ← optional GitHub-style alert
> Critical context

### Footnotes       ← immediately after Summary (before Design Decision)
[^1]: [Title](url)
[^2]: [Title](url)

## Design Decision
> [!NOTE]
> Implementation approach

## Prerequisites
### Dependencies
### Permissions/Roles

## Implementation Steps
### Step group heading
1. Step …
2. Step …

## Additional related information   ← optional
- Description [Link text](url)
```

### Footnote Format

All footnote definitions **must** use markdown link syntax:

```markdown
[^1]: [Descriptive title](https://example.com/page)
```

**Never** use bare-text formats like `Title (https://url)` or `Title — https://url` — kramdown renders these as plain text, not hyperlinks.

**Never** use pipe characters (`|`) in footnote definition text — kramdown interprets them as table delimiters. Use an em dash (`—`) instead.

### GitHub-Style Alerts / Callouts

The control layout includes client-side JS that converts GitHub-flavoured blockquote alerts into styled callouts. Supported types:

```markdown
> [!NOTE]
> Informational context

> [!WARNING]
> Potential risk

> [!TIP]
> Helpful suggestion

> [!IMPORTANT]
> Critical information

> [!CAUTION]
> Dangerous action
```

### Product Naming

- Use **Intune** (not "InTune") — this is Microsoft's official product name
- Use **Microsoft Entra** (not "Azure AD") for identity services
- Use **App Control for Business** (not "WDAC" alone) when referring to the product

---

## Styling

- **Theme:** GitHub dark mode (`#0d1117` background, `#e6edf3` text, `#58a6ff` links, `#30363d` borders)
- **Shared styles:** `assets/css/main.css` — header, navigation, cards, back-button, footer
- **Control layout:** `_layouts/control.html` — page-specific styles (callouts, footnotes, scrollable tables)
- **Homepage:** `index.html` — inline CSS/JS for search, filters, and control cards

---

## SEO & Analytics

| Feature | Implementation |
|---------|---------------|
| Google Analytics 4 | `_includes/analytics.html`, measurement ID in `_config.yml` (`google_analytics`) |
| Google Search Console | Verification token in `_config.yml` (`google_site_verification`) + `google010e8f920b8d5758.html` |
| Canonical URLs | `_includes/seo.html` — `<link rel="canonical">` on every page |
| Open Graph / Twitter | `_includes/seo.html` — `og:title`, `og:description`, `twitter:card` |
| JSON-LD | `_layouts/control.html` — `TechArticle` schema on every control page |
| Sitemap | `sitemap.xml` (index) + `sitemap-1.xml` (URL set) — **manually maintained** |
| robots.txt | Points crawlers to sitemap |
| RSS/Atom feed | Jekyll-feed plugin generates `feed.xml` |

---

## Build & Deploy

### Production (automatic)

Jekyll builds on every push to `main` via `.github/workflows/pages.yml`:
1. Checkout → Ruby 3.2 → `bundle install` → `jekyll build`
2. Upload artifact → Deploy to GitHub Pages
3. **Smoke tests** run post-deploy: GA4 tag, GSC meta, canonical links, JSON-LD, sitemap, robots.txt, security.txt, feed.xml, 404 page

### Preview (automatic)

Pushes to `research-review-controls` deploy to a separate preview repo via `.github/workflows/preview.yml`:
- Preview URL: `https://alanburchill.github.io/ISM-Controls-Guide-preview/`
- Zero impact on production

### Local development

```bash
bundle install
bundle exec jekyll serve --baseurl ""
# Open http://localhost:4000/
```

Note: `baseurl` is empty in `_config.yml` (custom domain), so use `--baseurl ""` locally.

---

## Data Files

| File | Purpose | Update When |
|------|---------|-------------|
| `assets/search_index.json` | Client-side search data (one JSON object per control with id, title, section, topic, url, essential_eight, pspf_levels, content) | Adding or modifying controls |
| `_data/site_index.yml` | Navigation structure grouped by section | Adding or modifying controls |
| `_config.yml` | Jekyll settings, layout defaults, GA4 ID, GSC token, excluded files | Changing site structure or analytics |

---

## Adding a New Control

1. Create `controls/ISM-XXXX.md` with all required front matter fields (see above)
2. Set `permalink: /controls/ISM-XXXX.html`
3. Follow the content structure: property table → Summary → Footnotes → Design Decision → Prerequisites → Implementation Steps
4. Add an entry to `assets/search_index.json` with `id`, `ism_control`, `title`, `section`, `topic`, `url`, `essential_eight`, `pspf_levels`, and `content`
5. Add an entry to `_data/site_index.yml` under the appropriate section
6. Add the control URL to `sitemap-1.xml`

---

## Markdownlint

The `.markdownlint.json` config disables these rules:
- **MD013** — line length (control content is often wide)
- **MD026** — trailing punctuation in headings
- **MD033** — inline HTML (used in implementation steps)
- **MD060** — code fence language

---

## Important Reminders

- The `permalink` front matter field is **critical** — omitting it breaks the URL routing
- Footnote definitions go under `### Footnotes` immediately after `## Summary`, before `## Design Decision`
- The `scripts/` folder exists on disk but is **gitignored** — legacy Python generators, not used for site builds
- The `docs/` folder is **gitignored** — local documentation and review notes only
- `view.html` is a legacy client-side viewer kept for backward compatibility; new controls use Jekyll-rendered pages
- The `_data/site_index.yml` URLs still use old `row-N-ISM-XXXX.html` format — Jekyll redirects handle this
- Control pages have prev/next navigation built into the layout, sorted by `ism_control` field
