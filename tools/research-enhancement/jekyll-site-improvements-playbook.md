# Jekyll Documentation Site — Improvements Playbook

**Scope:** Reusable improvement patterns for a Jekyll-based GitHub Pages documentation site  
**Applies to:** Sites using Liquid templates, Kramdown markdown, GitHub Actions for CI/CD, and GitHub Pages hosting

---

## 1. Content Quality Passes

### 1.1 AI-generated content cleanup
When content has been AI-generated, run a dedicated pass to remove:
- Prompt-leak artefacts — phrases like "As an AI language model…", "I cannot verify…", "As requested…"
- Hedging language that undermines authoritative guidance
- Placeholder text left as "Not provided" or "To be determined"
- Inconsistent product name capitalisation (e.g. "InTune" → "Intune", "Azure active directory" → "Entra ID")

### 1.2 Citation and footnote hygiene
- **Replace GitHub blob/raw URLs** with canonical product documentation URLs (e.g. `learn.microsoft.com`, official vendor docs)
- **Remove irrelevant citations** — verify each footnote actually supports the claim it is attached to
- **Deduplicate** — where multiple footnotes point to the same URL, consolidate to one
- **Validate URLs** — check for 404s, redirects to homepages, or pages that have moved
- Place all footnote definitions under a `### Footnotes` heading immediately after `## Summary` (before `## Design Decision`)

Tooling: export all footnote URLs to a CSV (`url_inventory.csv`) for bulk review.

### 1.3 Markdownlint compliance
Common errors in generated content and their fixes:

| Rule | Description | Fix |
|------|-------------|-----|
| MD022 | Headings must be surrounded by blank lines | Add blank line before and after every `##`/`###` |
| MD031 | Fenced code blocks must be surrounded by blank lines | Add blank line before and after every ` ``` ` block |
| MD032 | Lists must be surrounded by blank lines | Add blank line before and after every bullet/numbered list |
| MD013 | Line length | Relax for table rows in `.markdownlint.json` |

`.markdownlint.json` recommendation:
```json
{
  "MD013": {
    "tables": false
  }
}
```

### 1.4 Formatting and consistency pass
- Fix relative cross-reference links to use site-root-relative paths (`/section/page.html` not `./page`)
- Remove double-period sentence endings (`..`)
- Standardise footnote backlink symbol (kramdown default: `&#8617;` set in `_config.yml`)
- Ensure consistent heading hierarchy — no skipped levels (e.g. `##` directly to `####`)

### 1.5 Scope consistency review
For any content where a recommended tool has a narrower applicability than the topic scope:
- Add an explicit `> [!NOTE]` callout stating which platforms/scenarios the recommendation applies to
- Add a separate section covering the excluded platforms
- Example pattern: a cloud-managed tool (e.g. Intune) recommended for a topic that also covers on-premises servers — add a second section for on-premises equivalents (e.g. WSUS + Group Policy, or Azure Update Manager for hybrid)

---

## 2. SEO Infrastructure

### 2.1 Required files

| File | Content | Notes |
|------|---------|-------|
| `sitemap.xml` | Sitemap index pointing to `sitemap-1.xml` | Submit this URL to Google Search Console |
| `sitemap-1.xml` | Full `<urlset>` — one `<url>` per page with `<loc>`, `<lastmod>`, `<priority>` | Use Liquid to iterate `site.pages` |
| `robots.txt` | `User-agent: *`, `Disallow:` (empty), `Sitemap: {{ site.url }}/sitemap.xml` | Must be a Liquid template (add front matter `---`) |
| `404.html` | Custom not-found page with navigation back to home | Add `sitemap: false` to front matter |
| `security.txt` | `Contact:`, `Expires:` | Deploy to `/.well-known/security.txt` using `permalink` front matter |
| `feed.xml` | RSS/Atom feed | Use `jekyll-feed` plugin — add to `Gemfile` and `_config.yml` plugins list |
| `google[token].html` | GSC file verification | File content: `google-site-verification: google[token].html` |

### 2.2 `_includes/seo.html`
Create a single include added to every layout `<head>`:
```html
<!-- Canonical URL -->
<link rel="canonical" href="{{ site.url }}{{ page.url }}">

<!-- Meta description -->
{% assign _page_desc = page.description | default: page.title | truncate: 155 | default: site.description %}
<meta name="description" content="{{ _page_desc }}">

<!-- Google Search Console verification -->
{% if site.google_site_verification %}
<meta name="google-site-verification" content="{{ site.google_site_verification }}">
{% endif %}

<!-- Open Graph -->
<meta property="og:title" content="{{ page.title | default: site.title }}">
<meta property="og:description" content="{{ _page_desc }}">
<meta property="og:url" content="{{ site.url }}{{ page.url }}">
<meta property="og:type" content="website">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="{{ page.title | default: site.title }}">
<meta name="twitter:description" content="{{ _page_desc }}">

<!-- Emoji favicon (no image file needed) -->
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🛡️</text></svg>">
```

### 2.3 `_includes/analytics.html`
```html
{% if site.google_analytics %}
<script async src="https://www.googletagmanager.com/gtag/js?id={{ site.google_analytics }}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '{{ site.google_analytics }}');
</script>
{% endif %}
```

### 2.4 `_config.yml` additions
```yaml
google_analytics: ""         # GA4 Measurement ID e.g. G-XXXXXXXXXX
google_site_verification: "" # GSC meta tag content= value only

plugins:
  - jekyll-feed

feed:
  path: feed.xml
```

### 2.5 JSON-LD structured data (detail pages)
Add to the detail page layout `<head>` — use `TechArticle` for technical documentation:
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "TechArticle",
  "name": {{ page.title | jsonify }},
  "headline": {{ page.title | truncate: 110 | jsonify }},
  "description": {{ page.title | truncate: 155 | jsonify }},
  "url": "{{ site.url }}{{ page.url }}",
  "dateModified": "{{ page.date_generated }}",
  "inLanguage": "en-AU",
  "author": { "@type": "Organization", "name": "{{ site.title }}", "url": "{{ site.url }}" },
  "publisher": { "@type": "Organization", "name": "{{ site.title }}", "url": "{{ site.url }}" }
}
</script>
```

### 2.6 Layouts that bypass includes
Any layout using `layout: null` (or no layout) will not inherit includes from `default.html`. Audit all root-level HTML files:
- Add Jekyll front matter (`layout: null`) if missing — required for Liquid to be processed
- Add `{% include seo.html %}` and `{% include analytics.html %}` directly inside `<head>`

---

## 3. Layout and CSS Improvements

### 3.1 Consistent container width
Ensure the detail page layout container width matches or is close to the index/landing page width. A common mistake is a layout-specific override that is narrower than the main stylesheet:
```css
/* In layout <style> block — override main.css if needed */
.container {
  max-width: 1200px; /* match or approach landing page width */
}
```

### 3.2 Scrollable wide tables
Tables containing long content (e.g. registry paths, file paths, long URLs) will overflow or crush columns when the table natural width exceeds the container. Fix:
```css
.content-card table {
  display: block;
  overflow-x: auto;
  max-width: 100%;
}
```
This allows the table to scroll horizontally on small viewports and at natural width on large ones, without wrapping column content.

---

## 4. CI/CD Pipeline Patterns

### 4.1 Preview deployment on a separate URL
Purpose: review changes before merging to `main`, with zero risk to the production site.

Pattern:
1. Create a second public GitHub repo (e.g. `my-repo-preview`)
2. Enable Pages on it (Settings → Pages → `gh-pages` branch / root)
3. Create a fine-grained PAT scoped to the preview repo with Contents: Read and Write
4. Store as `PREVIEW_DEPLOY_TOKEN` secret on the source repo
5. Workflow builds with `--baseurl "/my-repo-preview"`, removes `CNAME`, injects a visible preview banner, then deploys via `peaceiris/actions-gh-pages@v4` with `external_repository` and `personal_token`

Key points:
- Remove `CNAME` from the built `_site` directory before deploying — prevents the preview repo from claiming the custom domain
- Use `concurrency: cancel-in-progress: true` to cancel superseded builds on rapid pushes
- Banner injection via `sed` on all `*.html` files in `_site`:
  ```bash
  find _site -name "*.html" -exec sed -i \
    's|<body>|<body><div style="...">⚠️ PREVIEW — branch: my-branch</div>|g' {} \;
  ```

### 4.2 Post-deploy smoke tests
Add a `smoke-test` job after `deploy` in both the preview and production workflows.

Structure:
```yaml
smoke-test:
  needs: deploy          # or build-and-deploy for preview
  runs-on: ubuntu-latest
  steps:
    - name: Wait for Pages propagation
      run: sleep 90

    - name: Run checks
      run: |
        BASE="https://your-site.com"
        PASS=0; FAIL=0
        check() {
          local label="$1" url="$2" pattern="$3"
          if curl -s --max-time 15 "$url" | grep -q "$pattern"; then
            echo "✅  $label"; PASS=$((PASS+1))
          else
            echo "❌  $label  (url: $url)"; FAIL=$((FAIL+1))
          fi
        }
        check "GA4 present"       "$BASE/"              "G-XXXXXXXXXX"
        check "meta description"  "$BASE/"              'name="description"'
        check "canonical"         "$BASE/"              'rel="canonical"'
        check "sitemap"           "$BASE/sitemap.xml"   "<sitemapindex"
        check "robots.txt"        "$BASE/robots.txt"    "Sitemap:"
        [ "$FAIL" -eq 0 ] || exit 1
```

Recommended checks:
- **Homepage:** GA4 ID, `gtag.js`, GSC meta, `<meta description>`, canonical, OG, Twitter card, favicon, custom banner (for preview)
- **Detail page:** GA4, canonical, JSON-LD `application/ld+json`, meta description
- **Ancillary:** `sitemap.xml`, `sitemap-1.xml`, `robots.txt`, `security.txt`, `feed.xml`, `404.html`, GSC verification file

### 4.3 Local verification script
Maintain a PowerShell equivalent of the CI smoke tests for local use:
```powershell
# tools/check-preview.ps1
$h = (Invoke-WebRequest "https://your-preview-url/" -UseBasicParsing).Content
function Check($label, $pattern) {
  if ($h -match $pattern) { Write-Host "  ✅ $label" -ForegroundColor Green }
  else { Write-Host "  ❌ $label" -ForegroundColor Red }
}
Check "GA4"         "G-XXXXXXXXXX"
Check "Description" 'name="description"'
Check "Canonical"   'rel="canonical"'
```

---

## 5. Tooling and Housekeeping

### 5.1 URL inventory
Export all footnote/citation URLs to a CSV with columns: `control`, `footnote_number`, `url`, `status`. Use this for bulk validation and identifying deprecated links.

### 5.2 Content quality gates document
Maintain a condensed rules document (`generation-quality-issues.md`) used as a system prompt reference when AI-generating or reviewing content. Key rules to include:
- No prompt-leak phrases
- All citations must be directly relevant
- `> [!NOTE]` for scope caveats
- Footnote placement convention
- Product name capitalisation reference list

### 5.3 Progress tracking
For large review passes across many pages, maintain a review-progress tracker (`review-progress.md`) with a table of all pages, their review status, and issues found. Allows batching and handoff between sessions.
