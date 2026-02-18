# Site Improvements Summary — Non-Control-Specific Changes

**Date:** 2026-02-19  
**Branch:** `research-review-controls` → merged to `main`  
**Scope:** Infrastructure, SEO, CI/CD, layout, and cross-cutting content quality work

---

## 1. Content Quality Passes

These passes ran across all 54 controls before the research enrichment batches.

### Phase 0/1/2 — Prompt-leak and URL cleanup
- Removed AI prompt-leak artefacts (e.g. "As an AI language model…", "I cannot verify…") from generated content
- Fixed broken, deprecated or irrelevant citations (GitHub blob URLs, Microsoft retired docs)
- Merged duplicate footnotes pointing to the same target

### Phase 3 — Content accuracy review (all 54 controls)
Four batches reviewed every control for:
- Outdated product references (e.g. NPAPI-era Java guidance, IE6-era references)
- Incorrect maturity level assignments
- Missing blank lines causing markdownlint errors (MD022, MD032, MD031)
- Non-standard `### Footnotes` heading placement (moved to immediately after `## Summary`)

### Improvement pass — Formatting and typo sweep
- Fixed relative URL cross-references (e.g. `./ISM-XXXX` → `/controls/ISM-XXXX.html`)
- Corrected double-period sentence endings
- Standardised footnote backlink format throughout

### URL accuracy passes 1 & 2
- Replaced GitHub-sourced citations with canonical Microsoft Learn / ACSC / NIST links
- Removed footnotes where the linked page had no relevance to the control topic
- De-duplicated footnotes referencing the same canonical source

### Markdownlint compliance (#11)
- Resolved all outstanding `markdownlint` errors across `controls/*.md`
- Updated `.markdownlint.json` to relax `MD013` (line length) for table rows only

---

## 2. Cross-Control Scoping Fix — Server vs. Workstation Patching

**Affected controls:** ISM-1696, ISM-1902  
**Problem:** Both controls scope to "workstations, non-internet-facing servers and network devices" but the Implementation Steps recommended Windows Autopatch and Intune, which only support Windows 10/11 and Windows Server 2025 (Intune-joined). Pre-2025 servers were left without guidance.

**Changes applied to both controls:**
- Added explicit `> [!NOTE]` callout scoping Autopatch/EAM to Intune-enrolled workstations only
- Added **WSUS + Group Policy** section for on-premises server patching (0-day and non-critical SLOs)
- Added **Azure Update Manager** section for cloud/hybrid servers with 48-hour and non-critical windows
- Fixed the Broad ring deployment table to remove incorrect "Servers" row (ISM-1902)

---

## 3. SEO Infrastructure

All files new unless noted.

| File | Purpose |
|------|---------|
| `sitemap.xml` | Sitemap index — submitted to Google Search Console |
| `sitemap-1.xml` | Full URL list with `<lastmod>` from `date_generated`; priority 0.8 for control pages |
| `robots.txt` | Liquid template; `Disallow:` empty, `Sitemap:` points to `{{ site.url }}/sitemap.xml` |
| `404.html` | Custom 404 page with `sitemap: false` front matter |
| `security.txt` | `/.well-known/security.txt`; Contact → GitHub Issues; Expires 2027 |
| `feed.xml` | RSS/Atom feed via `jekyll-feed` plugin (added to `Gemfile` + `_config.yml`) |
| `google010e8f920b8d5758.html` | Google Search Console file-based ownership verification |
| `_includes/analytics.html` | GA4 `gtag.js` conditional on `site.google_analytics` config var |
| `_includes/seo.html` | Canonical link, `<meta name="description">`, OG/Twitter cards, GSC meta tag, SVG emoji favicon 🛡️ |

### Config additions (`_config.yml`)
```yaml
google_analytics: "G-542SSSJ56F"
google_site_verification: "010e8f920b8d5758"
plugins:
  - jekyll-feed
feed:
  path: feed.xml
```

### Layout includes
`seo.html` and `analytics.html` were added to the `<head>` of:
- `_layouts/default.html`
- `_layouts/control.html`
- `index.html` (uses `layout: null` — includes added directly)
- `view.html` (uses `layout: null` — front matter added + inline GA4 block)

### JSON-LD structured data
Added `TechArticle` schema to `_layouts/control.html` `<head>`, populated with:
- `name`: ISM control number
- `headline` / `description`: page title (truncated to 110/155 chars)
- `url`: canonical URL
- `dateModified`: `page.date_generated`
- `author` / `publisher`: Essential 8 Guide organisation

---

## 4. Layout and CSS Improvements

### Container width
`_layouts/control.html` inline `.container` override increased from `900px` → `1200px` to match the index page footer and give tables more horizontal room.

### Scrollable wide tables
Added to `_layouts/control.html`:
```css
.content-card table {
  display: block;
  overflow-x: auto;
  max-width: 100%;
}
```
Fixes registry-path tables (e.g. ISM-1542, ISM-1690) where a 1300px+ table was being crushed into a 900px container, causing the "Effect" column to wrap over 5–6 lines.

---

## 5. CI/CD Pipeline

### Preview deployment workflow (`.github/workflows/preview.yml`)
- Triggers on push to `research-review-controls` + `workflow_dispatch`
- Builds Jekyll with `--baseurl "/ISM-Controls-Guide-preview"`
- Removes `CNAME` from built site (prevents preview repo claiming `e8guide.com`)
- Injects sticky yellow ⚠️ PREVIEW banner on every page
- Deploys to separate repo `alanburchill/ISM-Controls-Guide-preview` via `peaceiris/actions-gh-pages@v4` and `PREVIEW_DEPLOY_TOKEN` PAT
- **Preview URL:** `https://alanburchill.github.io/ISM-Controls-Guide-preview/`
- Zero production impact — completely separate Pages deployment

### Smoke-test job (both workflows)
Added a `smoke-test` job (needs: `deploy`) to both `preview.yml` and `pages.yml`:
- Waits 90 seconds for Pages propagation
- Runs 21 `curl`-based checks via bash
- Fails the workflow (visible in Actions tab) if any check fails

**Checks performed:**

| Group | Checks |
|-------|--------|
| Homepage | GA4 ID, gtag.js, GSC meta, `<meta description>`, canonical, OG, Twitter card, SVG favicon, preview banner |
| Control page (ISM-0843) | GA4, canonical, JSON-LD `application/ld+json`, meta description |
| Ancillary files | `sitemap.xml`, `sitemap-1.xml`, `robots.txt`, `security.txt`, `feed.xml`, `404.html`, GSC verification file |

### Local verification script (`tools/check-preview.ps1`)
PowerShell script that replicates the CI smoke tests locally against the preview URL. Run with:
```powershell
.\tools\check-preview.ps1
```

---

## 6. Tooling / Repo Housekeeping

| File | Purpose |
|------|---------|
| `url_inventory.csv` | Inventory of all footnote URLs across 54 controls for audit |
| `tools/url-review/footnotes-extract.txt` | Extracted raw footnote definitions for review |
| `tools/url-review/generation-quality-issues.md` | Condensed rules for AI-generated content quality gates |
| `tools/url-review/review-progress.md` | Phase 3 review tracking across all 54 controls |
| `tools/research-enhancement/research-pass-1.md` | Detailed findings for research enrichment pass 1 (5 controls) |
| `tools/research-enhancement/research-pass-2.md` | Detailed findings for research enrichment pass 2 (ISM-1485 to ISM-1511) |
| `.github/agents/Research Agent.agent.md` | AI research agent definition with quality gates and citation hygiene rules |
