# Script to update search_index.json with content from markdown files
# This adds the Summary section as searchable content

$controlsPath = Join-Path $PSScriptRoot "..\controls"
$indexPath = Join-Path $PSScriptRoot "..\assets\search_index.json"

# Read existing search index
$searchIndex = Get-Content $indexPath -Raw | ConvertFrom-Json

# Process each control in the index
foreach ($control in $searchIndex) {
    $ismId = $control.ism_control
    
    # Find the matching markdown file
    $mdFile = Get-ChildItem -Path $controlsPath -Filter "*$ismId*.md" | Select-Object -First 1
    
    if ($mdFile) {
        $content = Get-Content $mdFile.FullName -Raw
        
        # Extract content between ## Summary and the next ## heading
        if ($content -match '## Summary\s*\r?\n([\s\S]*?)(?=\r?\n## |\r?\n\[\^|\z)') {
            $summary = $Matches[1].Trim()
            
            # Remove footnote references like [^1] and markdown links
            $summary = $summary -replace '\[\^\d+\]', ''
            $summary = $summary -replace '\[([^\]]+)\]\([^\)]+\)', '$1'
            
            # Clean up extra whitespace
            $summary = $summary -replace '\s+', ' '
            $summary = $summary.Trim()
            
            # Add content field to the control
            $control | Add-Member -NotePropertyName "content" -NotePropertyValue $summary -Force
            
            Write-Host "Added content for $ismId" -ForegroundColor Green
        } else {
            Write-Host "No Summary found for $ismId" -ForegroundColor Yellow
        }
    } else {
        Write-Host "No markdown file found for $ismId" -ForegroundColor Red
    }
}

# Save updated search index
$searchIndex | ConvertTo-Json -Depth 10 | Set-Content $indexPath -Encoding UTF8

Write-Host "`nSearch index updated successfully!" -ForegroundColor Cyan
Write-Host "File saved to: $indexPath"
