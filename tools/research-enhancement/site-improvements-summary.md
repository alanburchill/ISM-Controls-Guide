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

### Footnote format fix
- **Issue:** 55 footnote definitions across 22 control files used old bare-text formats — either `Title (<url>)` (auto-link) or `Title — <url>` — which render as plain text rather than hyperlinks. Four footnote titles also contained `|` pipe characters, which kramdown was interpreting as table column separators, rendering a spurious one-cell table in the page footer.
- **Fix:** Converted all footnote definitions to the correct `[Title](url)` format. Replaced `|` with `—` in the four affected titles (ISM-1704, ISM-1810, ISM-1692, ISM-1486).
- **Files affected:** ISM-1485, ISM-1486, ISM-1542, ISM-1544, ISM-1585, ISM-1654, ISM-1655, ISM-1659, ISM-1667, ISM-1670, ISM-1671, ISM-1672, ISM-1673, ISM-1674, ISM-1686, ISM-1692, ISM-1698, ISM-1699, ISM-1702, ISM-1704, ISM-1808, ISM-1810, ISM-1824

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

> For SEO infrastructure, layout/CSS, CI/CD pipeline, and tooling changes see `tools/research-enhancement/jekyll-site-improvements-playbook.md`.
