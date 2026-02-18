#!/usr/bin/env pwsh
# Checks the preview site for key SEO/analytics elements
# Usage: .\tools\check-preview.ps1

$url = "https://alanburchill.github.io/ISM-Controls-Guide-preview/"

Write-Host "`nFetching $url ...`n" -ForegroundColor Cyan
$html = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content

function Check($label, $pattern) {
    if ($html -match $pattern) {
        Write-Host "  ✅ $label" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $label" -ForegroundColor Red
    }
}

Write-Host "── Build info ──────────────────────────────────────" -ForegroundColor DarkGray
$ts = if ($html -match "Site generated: ([^<]+)") { $Matches[1].Trim() } else { "not found" }
Write-Host "  🕐 $ts`n"

Write-Host "── Analytics & Verification ────────────────────────" -ForegroundColor DarkGray
Check "Google Analytics (GA4)"        "G-542SSSJ56F"
Check "gtag.js script loaded"         "googletagmanager\.com/gtag/js"
Check "GSC verification meta"         "google-site-verification"

Write-Host "`n── SEO Meta Tags ────────────────────────────────────" -ForegroundColor DarkGray
Check "meta description"              '<meta name="description"'
Check "canonical link"                '<link rel="canonical"'
Check "Open Graph title"              'property="og:title"'
Check "Twitter card"                  'name="twitter:card"'

Write-Host "`n── Structured Data ──────────────────────────────────" -ForegroundColor DarkGray
Check "JSON-LD present"               'application/ld\+json'

Write-Host "`n── Favicon ──────────────────────────────────────────" -ForegroundColor DarkGray
Check "SVG data URI favicon"          'data:image/svg\+xml'

Write-Host "`n── Preview banner ───────────────────────────────────" -ForegroundColor DarkGray
Check "Preview banner visible"        "PREVIEW.*research-review-controls"

Write-Host ""
