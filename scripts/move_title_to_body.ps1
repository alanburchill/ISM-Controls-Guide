# Move title from header into main content body

$controlsPath = "H:\GitHub\ISM-Controls-Guide\controls-html"
$files = Get-ChildItem -Path $controlsPath -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Extract the title from header-title span
    if ($content -match '<span class="header-title">([^<]+)</span>') {
        $title = $Matches[1].Trim()
        
        # Remove the header-title span entirely
        $content = $content -replace '\s*<span class="header-title">[^<]+</span>', ''
        
        # Add h1 title at the start of markdown content (after the --- frontmatter closing)
        # The markdown starts after `const markdown = \`---` and frontmatter, then after the closing `---`
        # We need to insert an h1 after the frontmatter ends
        $content = $content -replace '(date_generated: "[^"]+"\s*\r?\n---\r?\n)', "`$1# $title`n`n"
    }
    
    # Write updated content
    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "Updated: $($file.Name)"
}

Write-Host "`nAll files updated!"
