# Update all control HTML files to use GitHub dark mode theme

$controlsPath = "H:\GitHub\ISM-Controls-Guide\controls-html"
$files = Get-ChildItem -Path $controlsPath -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Replace body styles
    $content = $content -replace "background: linear-gradient\(135deg, #667eea 0%, #764ba2 100%\);", "background: #0d1117;"
    $content = $content -replace "color: #333;", "color: #e6edf3;"
    
    # Replace header styles
    $content = $content -replace "background: rgba\(255,255,255,0\.95\);", "background: #161b22;"
    $content = $content -replace "backdrop-filter: blur\(10px\);", "border-bottom: 1px solid #30363d;"
    $content = $content -replace "box-shadow: 0 2px 20px rgba\(0,0,0,0\.1\);", ""
    
    # Replace back button styles
    $content = $content -replace "background: linear-gradient\(135deg, #667eea, #764ba2\);", "background: #21262d; border: 1px solid #30363d;"
    $content = $content -replace "box-shadow: 0 4px 15px rgba\(102, 126, 234, 0\.4\);", "border-color: #58a6ff;"
    
    # Replace header title color
    $content = $content -replace "color: #1a1a2e;", "color: #e6edf3;"
    
    # Replace content card styles
    $content = $content -replace "background: white;", "background: #161b22;"
    $content = $content -replace "border-radius: 16px;", "border-radius: 6px; border: 1px solid #30363d;"
    $content = $content -replace "box-shadow: 0 10px 40px rgba\(0,0,0,0\.15\);", ""
    
    # Replace heading colors
    $content = $content -replace "border-bottom: 3px solid #667eea;", "border-bottom: 1px solid #30363d;"
    $content = $content -replace "color: #333;", "color: #e6edf3;"
    $content = $content -replace "color: #444;", "color: #8b949e;"
    
    # Replace table styles
    $content = $content -replace "border: 1px solid #e0e0e0;", "border: 1px solid #30363d;"
    $content = $content -replace "background: linear-gradient\(135deg, #667eea, #764ba2\);[\r\n\s]*color: white;", "background: #21262d; color: #e6edf3;"
    $content = $content -replace "tr:nth-child\(even\) \{ background: #f8f9fa; \}", "tr:nth-child(even) { background: #161b22; } tr:nth-child(odd) { background: #0d1117; }"
    
    # Replace link colors
    $content = $content -replace "color: #667eea;", "color: #58a6ff;"
    
    # Replace code styles
    $content = $content -replace "background: #f1f3f4;", "background: #21262d;"
    $content = $content -replace "background: #1a1a2e;", "background: #161b22;"
    $content = $content -replace "color: #e0e0e0;", "color: #e6edf3;"
    
    # Replace blockquote styles
    $content = $content -replace "border-left: 4px solid #667eea;", "border-left: 4px solid #58a6ff;"
    $content = $content -replace "background: #f8f9ff;", "background: rgba(88, 166, 255, 0.1);"
    
    # Replace hr
    $content = $content -replace "border-top: 2px solid #e0e0e0;", "border-top: 1px solid #30363d;"
    
    # Write updated content
    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "Updated: $($file.Name)"
}

Write-Host "`nAll files updated!"
