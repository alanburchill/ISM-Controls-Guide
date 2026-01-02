# Essential 8 Guide - AI Coding Instructions

## Project Overview

A Jekyll-powered GitHub Pages site providing implementation guidance for Australian Essential Eight (E8) controls in Microsoft environments. Each control page is generated from Markdown files with YAML front matter.

**Live site:** https://e8guide.com

## Architecture

```
controls/           → Source markdown files (Jekyll converts to HTML)
_layouts/           → Jekyll templates (control.html for detail pages)
assets/             → search_index.json (powers client-side search)
_data/              → site_index.yml (navigation data)
index.html          → Main page with search/filter UI (vanilla JS)
scripts/            → Legacy generation scripts (NOT USED - Jekyll handles conversion)
```

## Key Patterns

### Control Markdown Files (`controls/*.md`)
Each file follows this structure:
```yaml
---
permalink: /controls-html/ISM-XXXX.html  # Required for URL routing
title: "Control description (ISM-XXXX)"
ism_control: "ISM-XXXX"
essential_eight: ["ML1", "ML2", "ML3"]   # Maturity levels
pspf_levels: ["NC", "OS", "P", "S", "TS"] # Security classifications
section: "Category name"
topic: "Subcategory"
---
# Heading

| Property | Value |
|----------|-------|
...

## Summary
## Design Decision  
## Prerequisites
## Implementation Steps
```

### Adding New Controls
1. Create `controls/row-N-ISM-XXXX.response.md` with required front matter
2. Include `permalink: /controls-html/ISM-XXXX.html` to maintain URL structure
3. Update `assets/search_index.json` to include the new control for search

### Styling
- **Theme:** GitHub dark mode (`#0d1117` background, `#e6edf3` text, `#58a6ff` links)
- **Layout:** `_layouts/control.html` - modify for all control pages
- **Index:** `index.html` contains inline CSS and JavaScript for search/filter

## Build & Deploy

Jekyll builds automatically via GitHub Actions on push to `main`:
- Workflow: `.github/workflows/pages.yml`
- No local build required for deployment

**Local development:**
```bash
bundle install
bundle exec jekyll serve
# Open http://localhost:4000/ISM-Controls-Guide/
```

## Data Files

| File | Purpose | Update When |
|------|---------|-------------|
| `assets/search_index.json` | Client-side search data | Adding/modifying controls |
| `_data/site_index.yml` | Navigation structure | Adding/modifying controls |
| `_config.yml` | Jekyll settings, defaults | Changing site structure |

## Important Notes

- `controls-html/` folder is **legacy** - Jekyll now generates HTML from markdown
- The `scripts/` folder contains old Python/PowerShell generators (superseded by Jekyll)
- Front matter `permalink` is critical - controls expect `/controls-html/ISM-XXXX.html` URLs
- Footnotes use kramdown syntax: `[^1]` with `[^1]: Reference text` at end
