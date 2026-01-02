# Update all control HTML files to remove ISM suffix from titles and remove redundant h1

$controlsPath = "H:\GitHub\ISM-Controls-Guide\controls-html"
$files = Get-ChildItem -Path $controlsPath -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Remove (ISM-XXXX) suffix from <title> tag
    $content = $content -replace '(<title>.*?)\s*\(ISM-\d+\)(\s*-\s*ISM Controls Guide</title>)', '$1$2'
    
    # Remove (ISM-XXXX) suffix from header-title span
    $content = $content -replace '(<span class="header-title">.*?)\s*\(ISM-\d+\)(</span>)', '$1$2'
    
    # Remove the redundant h1 heading line from markdown (the line starting with # that contains the title)
    # This matches: # Title text (ISM-XXXX) followed by newline
    $content = $content -replace '(?m)^# .+?\(ISM-\d+\)\s*[\r\n]+', ''
    
    # Write updated content
    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "Updated: $($file.Name)"
}

Write-Host "`nAll files updated!"
