# Generate standalone HTML pages from markdown files
# This creates clean URLs like /controls/ISM-1654.html

$controlsDir = "H:\GitHub\ISM-Controls-Guide\controls"
$outputDir = "H:\GitHub\ISM-Controls-Guide\controls-html"

# HTML template
$htmlTemplate = @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{TITLE}} - ISM Controls Guide</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      color: #333;
      text-align: left;
    }
    .header {
      background: rgba(255,255,255,0.95);
      backdrop-filter: blur(10px);
      padding: 15px 40px;
      box-shadow: 0 2px 20px rgba(0,0,0,0.1);
      position: sticky;
      top: 0;
      z-index: 100;
      display: flex;
      align-items: center;
      gap: 20px;
    }
    .back-btn {
      background: linear-gradient(135deg, #667eea, #764ba2);
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: all 0.3s ease;
    }
    .back-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    }
    .header-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: #1a1a2e;
    }
    .container {
      max-width: 900px;
      margin: 0 auto;
      padding: 30px 20px;
    }
    .content-card {
      background: white;
      border-radius: 16px;
      padding: 40px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.15);
      text-align: left;
    }
    h1 {
      font-size: 1.8rem;
      font-weight: 700;
      color: #1a1a2e;
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 3px solid #667eea;
    }
    h2 {
      font-size: 1.4rem;
      font-weight: 600;
      color: #333;
      margin-top: 30px;
      margin-bottom: 15px;
    }
    h3 {
      font-size: 1.2rem;
      font-weight: 600;
      color: #444;
      margin-top: 25px;
      margin-bottom: 12px;
    }
    p { line-height: 1.7; margin-bottom: 15px; color: #444; }
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
      font-size: 0.95rem;
    }
    th, td {
      padding: 12px 15px;
      border: 1px solid #e0e0e0;
      text-align: left;
    }
    th {
      background: linear-gradient(135deg, #667eea, #764ba2);
      color: white;
      font-weight: 600;
    }
    tr:nth-child(even) { background: #f8f9fa; }
    ul, ol { margin: 15px 0; padding-left: 25px; }
    li { margin-bottom: 8px; line-height: 1.6; }
    a { color: #667eea; text-decoration: none; font-weight: 500; }
    a:hover { text-decoration: underline; }
    code {
      background: #f1f3f4;
      padding: 3px 8px;
      border-radius: 4px;
      font-family: 'Consolas', 'Monaco', monospace;
      font-size: 0.9em;
    }
    pre {
      background: #1a1a2e;
      color: #e0e0e0;
      padding: 20px;
      border-radius: 10px;
      overflow-x: auto;
      margin: 20px 0;
    }
    pre code { background: none; padding: 0; color: inherit; }
    blockquote {
      border-left: 4px solid #667eea;
      padding: 15px 20px;
      margin: 20px 0;
      background: #f8f9ff;
      border-radius: 0 8px 8px 0;
    }
    blockquote p { margin: 0; }
    hr { border: none; border-top: 2px solid #e0e0e0; margin: 30px 0; }
    @media (max-width: 768px) {
      .header { padding: 15px 20px; flex-direction: column; align-items: flex-start; gap: 10px; }
      .content-card { padding: 25px; }
      h1 { font-size: 1.5rem; }
    }
  </style>
  <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
</head>
<body>
  <div class="header">
    <a href="../" class="back-btn">← Back to Controls</a>
    <span class="header-title">{{HEADER_TITLE}}</span>
  </div>
  <div class="container">
    <div class="content-card" id="content">
    </div>
  </div>
  <script>
    const markdown = `{{MARKDOWN_CONTENT}}`;
    const contentWithoutFrontmatter = markdown.replace(/^---[\s\S]*?---\s*/m, '');
    document.getElementById('content').innerHTML = marked.parse(contentWithoutFrontmatter);
  </script>
</body>
</html>
'@

# Process each markdown file
$mdFiles = Get-ChildItem -Path $controlsDir -Filter "row-*.md"

foreach ($file in $mdFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Extract ISM control ID from filename (e.g., row-1-ISM-1654.response.md -> ISM-1654)
    if ($file.Name -match 'ISM-(\d+)') {
        $ismId = "ISM-$($Matches[1])"
    } else {
        $ismId = $file.BaseName
    }
    
    # Extract title from frontmatter
    if ($content -match 'title:\s*"([^"]+)"') {
        $title = $Matches[1]
    } else {
        $title = $ismId
    }
    
    # Escape backticks and dollar signs for JavaScript template literal
    $escapedContent = $content -replace '`', '\`' -replace '\$', '\$'
    
    # Generate HTML
    $html = $htmlTemplate
    $html = $html -replace '\{\{TITLE\}\}', [System.Web.HttpUtility]::HtmlEncode($title)
    $html = $html -replace '\{\{HEADER_TITLE\}\}', [System.Web.HttpUtility]::HtmlEncode($title)
    $html = $html -replace '\{\{MARKDOWN_CONTENT\}\}', $escapedContent
    
    # Write to output file
    $outputFile = Join-Path $outputDir "$ismId.html"
    $html | Set-Content $outputFile -Encoding UTF8
    
    Write-Host "Generated: $ismId.html"
}

Write-Host "`nDone! Generated $(($mdFiles).Count) HTML files."
