#!/usr/bin/env python3
"""Add permalink front matter to row-*-ISM-*.response.md files.

Usage:
  python scripts/add_permalinks.py --path controls [--dry-run] [--update-site-index]

This script is intentionally dependency-free (no PyYAML required).
"""
import re
import sys
from pathlib import Path
from argparse import ArgumentParser

fm_re = re.compile(r"^(---\s*\n)(.*?)(\n---\s*\n)" , re.S)

parser = ArgumentParser()
parser.add_argument("--path", default="controls")
parser.add_argument("--dry-run", action="store_true")
parser.add_argument("--update-site-index", action="store_true")
args = parser.parse_args()

root = Path(args.path)
if not root.exists():
    print(f"Path not found: {root}")
    sys.exit(1)

changed = []
for p in sorted(root.rglob("row-*-ISM-*.response.md")):
    text = p.read_text(encoding="utf8")
    m = fm_re.search(text)
    if not m:
        print(f"[SKIP] No front-matter: {p}")
        continue
    fm_body = m.group(2)
    if re.search(r"^\s*permalink\s*:\s*", fm_body, re.M):
        print(f"[OK] Has permalink: {p}")
        continue
    id_match = re.search(r"(ISM-\d+)", p.name)
    if not id_match:
        print(f"[SKIP] No ISM id in filename: {p}")
        continue
    ism_id = id_match.group(1)
    permalink = f"permalink: /controls/{ism_id}.html"
    new_fm = fm_body.rstrip() + "\n" + permalink + "\n"
    new_text = text[:m.start(2)] + new_fm + text[m.end(2):]
    if args.dry_run:
        print(f"[DRYRUN] Would add permalink to {p}: {permalink}")
    else:
        p.write_text(new_text, encoding="utf8")
        print(f"[UPDATED] Added permalink to {p}: {permalink}")
        changed.append((p, ism_id))

# Optionally update _data/site_index.yml entries so urls are canonical
if args.update_site_index and changed:
    site_index = Path('_data/site_index.yml')
    if site_index.exists():
        s = site_index.read_text(encoding='utf8')
        for _, ism in changed:
            # replace the url line that uses /row-*-ISM-XXXX.html with /controls/ISM-XXXX.html
            s_new = re.sub(r'(url:\s*"/row-[^\"]*%s\.html")' % ism, f'url: "/controls/{ism}.html"', s)
            s = s_new
        if args.dry_run:
            print(f"[DRYRUN] Would update _data/site_index.yml for {len(changed)} items")
        else:
            site_index.write_text(s, encoding='utf8')
            print(f"[UPDATED] _data/site_index.yml updated for {len(changed)} items")
    else:
        print("[NOTE] _data/site_index.yml not found; skipping site index updates")

if changed:
    print(f"Done. Files changed: {len(changed)}")
    sys.exit(0)
else:
    print("Done. No changes needed.")
    sys.exit(0)
