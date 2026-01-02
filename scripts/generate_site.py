#!/usr/bin/env python3
"""
Generate ISM Controls Guide static site from markdown files.

Usage:
    python generate_site.py                    # Generate all pages
    python generate_site.py --control ISM-1654 # Generate single control
    python generate_site.py --theme light      # Use light theme (default: dark)
    python generate_site.py --dry-run          # Show what would be generated
"""

import argparse
import re
import json
from pathlib import Path

# Paths
SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
CONTROLS_DIR = PROJECT_DIR / "controls"
OUTPUT_DIR = PROJECT_DIR / "controls-html"
ASSETS_DIR = PROJECT_DIR / "assets"

# GitHub Dark Mode Theme
DARK_THEME = """
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
      background: #0d1117;
      min-height: 100vh;
      color: #e6edf3;
      text-align: left;
    }
    .header {
      background: #161b22;
      border-bottom: 1px solid #30363d;
      padding: 15px 40px;
      position: sticky;
      top: 0;
      z-index: 100;
      display: flex;
      align-items: center;
      gap: 20px;
    }
    .back-btn {
      background: #21262d;
      border: 1px solid #30363d;
      color: white;
      padding: 10px 20px;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: all 0.3s ease;
    }
    .back-btn:hover {
      border-color: #58a6ff;
      color: #58a6ff;
    }
    .container {
      max-width: 900px;
      margin: 0 auto;
      padding: 30px 20px;
    }
    .content-card {
      background: #161b22;
      border: 1px solid #30363d;
      border-radius: 6px;
      padding: 40px;
      text-align: left;
    }
    h1 {
      font-size: 1.8rem;
      font-weight: 700;
      color: #e6edf3;
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 1px solid #30363d;
    }
    h2 {
      font-size: 1.4rem;
      font-weight: 600;
      color: #e6edf3;
      margin-top: 30px;
      margin-bottom: 15px;
    }
    h3 {
      font-size: 1.2rem;
      font-weight: 600;
      color: #8b949e;
      margin-top: 25px;
      margin-bottom: 12px;
    }
    p { line-height: 1.7; margin-bottom: 15px; color: #8b949e; }
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
      font-size: 0.95rem;
    }
    th, td {
      padding: 12px 15px;
      border: 1px solid #30363d;
      text-align: left;
    }
    th {
      background: #21262d;
      color: #e6edf3;
      font-weight: 600;
    }
    tr:nth-child(even) { background: #161b22; }
    tr:nth-child(odd) { background: #0d1117; }
    ul, ol { margin: 15px 0; padding-left: 25px; color: #8b949e; }
    li { margin-bottom: 8px; line-height: 1.6; }
    a { color: #58a6ff; text-decoration: none; font-weight: 500; }
    a:hover { text-decoration: underline; }
    code {
      background: #21262d;
      padding: 3px 8px;
      border-radius: 4px;
      font-family: 'Consolas', 'Monaco', monospace;
      font-size: 0.9em;
      color: #e6edf3;
    }
    pre {
      background: #161b22;
      color: #e6edf3;
      padding: 20px;
      border-radius: 6px;
      overflow-x: auto;
      margin: 20px 0;
      border: 1px solid #30363d;
    }
    pre code { background: none; padding: 0; color: inherit; }
    blockquote {
      border-left: 4px solid #58a6ff;
      padding: 15px 20px;
      margin: 20px 0;
      background: rgba(88, 166, 255, 0.1);
      border-radius: 0 6px 6px 0;
    }
    blockquote p { margin: 0; color: #e6edf3; }
    hr { border: none; border-top: 1px solid #30363d; margin: 30px 0; }
    @media (max-width: 768px) {
      .header { padding: 15px 20px; }
      .content-card { padding: 25px; }
      h1 { font-size: 1.5rem; }
    }
"""

# Light Theme (original)
LIGHT_THEME = """
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
"""


def get_html_template(theme: str = "dark") -> str:
    """Return HTML template with specified theme."""
    css = DARK_THEME if theme == "dark" else LIGHT_THEME
    
    return f'''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{{{TITLE}}}} - ISM Controls Guide</title>
  <style>{css}
  </style>
  <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
</head>
<body>
  <div class="header">
    <a href="../" class="back-btn">← Back to Controls</a>
  </div>
  <div class="container">
    <div class="content-card" id="content">
    </div>
  </div>
  <script>
    const markdown = `{{{{MARKDOWN_CONTENT}}}}`;
    const contentWithoutFrontmatter = markdown.replace(/^---[\\s\\S]*?---\\s*/m, '');
    document.getElementById('content').innerHTML = marked.parse(contentWithoutFrontmatter);
  </script>
</body>
</html>'''


def extract_frontmatter(content: str) -> dict:
    """Extract YAML frontmatter from markdown content."""
    frontmatter = {}
    match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if match:
        for line in match.group(1).split('\n'):
            if ':' in line:
                key, value = line.split(':', 1)
                key = key.strip()
                value = value.strip().strip('"').strip("'")
                frontmatter[key] = value
    return frontmatter


def clean_title(title: str) -> str:
    """Remove (ISM-XXXX) suffix from title."""
    return re.sub(r'\s*\(ISM-\d+\)$', '', title)


def add_title_to_markdown(content: str, title: str) -> str:
    """Add h1 title after frontmatter in markdown content."""
    # Find end of frontmatter
    match = re.match(r'^(---\s*\n.*?\n---\s*\n)', content, re.DOTALL)
    if match:
        frontmatter = match.group(1)
        rest = content[len(frontmatter):]
        # Remove any existing h1 that matches the title pattern
        rest = re.sub(r'^#\s+.+?\(ISM-\d+\)\s*\n+', '', rest)
        return f"{frontmatter}# {title}\n\n{rest}"
    return f"# {title}\n\n{content}"


def escape_for_js(content: str) -> str:
    """Escape content for JavaScript template literal."""
    return content.replace('\\', '\\\\').replace('`', '\\`').replace('$', '\\$')


def generate_html(md_file: Path, theme: str = "dark") -> tuple[str, str, dict]:
    """
    Generate HTML from a markdown file.
    
    Returns: (ism_id, html_content, metadata)
    """
    content = md_file.read_text(encoding='utf-8')
    
    # Extract ISM ID from filename
    match = re.search(r'ISM-(\d+)', md_file.name)
    ism_id = f"ISM-{match.group(1)}" if match else md_file.stem
    
    # Extract frontmatter
    frontmatter = extract_frontmatter(content)
    
    # Get and clean title
    raw_title = frontmatter.get('title', ism_id)
    title = clean_title(raw_title)
    
    # Add title to markdown content (after frontmatter)
    content_with_title = add_title_to_markdown(content, title)
    
    # Escape for JavaScript
    escaped_content = escape_for_js(content_with_title)
    
    # Generate HTML
    template = get_html_template(theme)
    html = template.replace('{{TITLE}}', title)
    html = html.replace('{{MARKDOWN_CONTENT}}', escaped_content)
    
    # Build metadata for search index
    metadata = {
        'id': ism_id,
        'ism_control': ism_id,
        'title': raw_title,
        'section': frontmatter.get('section', ''),
        'topic': frontmatter.get('topic', ''),
        'url': f'controls-html/{ism_id}.html',
    }
    
    # Parse essential_eight list
    e8_match = re.search(r'essential_eight:\s*\n((?:\s+-\s+"[^"]+"\s*\n)+)', content)
    if e8_match:
        metadata['essential_eight'] = re.findall(r'"([^"]+)"', e8_match.group(1))
    
    # Parse pspf_levels list
    pspf_match = re.search(r'pspf_levels:\s*\n((?:\s+-\s+"[^"]+"\s*\n)+)', content)
    if pspf_match:
        metadata['pspf_levels'] = re.findall(r'"([^"]+)"', pspf_match.group(1))
    
    return ism_id, html, metadata


def generate_search_index(all_metadata: list[dict], output_path: Path):
    """Generate search_index.json for the main index page."""
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(all_metadata, f, indent=2)
    print(f"Generated: {output_path.name} ({len(all_metadata)} entries)")


def main():
    parser = argparse.ArgumentParser(
        description='Generate ISM Controls Guide static site from markdown files.',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  python generate_site.py                     # Generate all pages (dark theme)
  python generate_site.py --theme light       # Generate with light theme
  python generate_site.py --control ISM-1654  # Generate single control
  python generate_site.py --dry-run           # Preview without writing files
  python generate_site.py --no-index          # Skip search index generation
        '''
    )
    parser.add_argument(
        '--control', '-c',
        help='Generate only a specific control (e.g., ISM-1654)'
    )
    parser.add_argument(
        '--theme', '-t',
        choices=['dark', 'light'],
        default='dark',
        help='Color theme (default: dark)'
    )
    parser.add_argument(
        '--dry-run', '-n',
        action='store_true',
        help='Show what would be generated without writing files'
    )
    parser.add_argument(
        '--no-index',
        action='store_true',
        help='Skip generating search_index.json'
    )
    parser.add_argument(
        '--output', '-o',
        type=Path,
        default=OUTPUT_DIR,
        help=f'Output directory (default: {OUTPUT_DIR})'
    )
    parser.add_argument(
        '--input', '-i',
        type=Path,
        default=CONTROLS_DIR,
        help=f'Input directory with markdown files (default: {CONTROLS_DIR})'
    )
    
    args = parser.parse_args()
    
    # Ensure output directory exists
    if not args.dry_run:
        args.output.mkdir(parents=True, exist_ok=True)
    
    # Find markdown files
    if args.control:
        # Find specific control
        pattern = f"*{args.control}*.md"
        md_files = list(args.input.glob(pattern))
        if not md_files:
            print(f"Error: No markdown file found matching '{args.control}'")
            return 1
    else:
        md_files = list(args.input.glob("row-*.md"))
    
    if not md_files:
        print(f"Error: No markdown files found in {args.input}")
        return 1
    
    print(f"Generating {len(md_files)} HTML page(s) with {args.theme} theme...")
    print()
    
    all_metadata = []
    
    for md_file in sorted(md_files):
        ism_id, html, metadata = generate_html(md_file, args.theme)
        all_metadata.append(metadata)
        
        output_file = args.output / f"{ism_id}.html"
        
        if args.dry_run:
            print(f"  [DRY-RUN] Would generate: {output_file.name}")
        else:
            output_file.write_text(html, encoding='utf-8')
            print(f"  Generated: {output_file.name}")
    
    print()
    
    # Generate search index
    if not args.no_index and not args.control:
        index_path = ASSETS_DIR / "search_index.json"
        if args.dry_run:
            print(f"[DRY-RUN] Would generate: {index_path}")
        else:
            generate_search_index(all_metadata, index_path)
    
    print(f"\nDone! Generated {len(md_files)} HTML file(s).")
    return 0


if __name__ == '__main__':
    exit(main())
