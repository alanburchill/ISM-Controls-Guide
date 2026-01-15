#!/usr/bin/env python3
"""Generate controls/ISM-XXXX.md from controls/row-*-ISM-XXXX.response.md files.

Writes idempotent generated files and skips unchanged output.
"""
import re
import sys
from pathlib import Path
from datetime import datetime

fm_re = re.compile(r"^---\s*\n(.*?)\n---\s*\n", re.S)

rows_dir = Path('controls')
if not rows_dir.exists():
    print('controls directory not found', file=sys.stderr)
    sys.exit(1)

generated = []
for p in sorted(rows_dir.glob('row-*-ISM-*.response.md')):
    text = p.read_text(encoding='utf8')
    m = fm_re.match(text)
    if not m:
        print(f"[SKIP] No front-matter: {p}")
        continue
    fm_text = m.group(1)
    body = text[m.end():]
    # Extract fields from fm
    title = re.search(r'^title:\s*"?(.*?)"?\s*$', fm_text, re.M)
    ism = re.search(r'ISM-\d+', p.name)
    revision = re.search(r'^revision:\s*"?(.*?)"?\s*$', fm_text, re.M)
    updated = re.search(r'^updated:\s*"?(.*?)"?\s*$', fm_text, re.M)

    if not ism:
        print(f"[SKIP] No ISM id in filename: {p}")
        continue
    ism_id = ism.group(0)
    title_text = title.group(1) if title else ism_id
    rev_text = revision.group(1) if revision else ''
    updated_text = updated.group(1) if updated else ''

    gen_path = rows_dir / f"{ism_id}.md"
    gen_fm = ["---"]
    gen_fm.append(f"permalink: /controls/{ism_id}.html")
    gen_fm.append(f"title: \"{title_text}\"")
    gen_fm.append(f"ism_control: \"{ism_id}\"")
    if rev_text:
        gen_fm.append(f"revision: \"{rev_text}\"")
    if updated_text:
        gen_fm.append(f"updated: \"{updated_text}\"")
    gen_fm.append(f"generated_from: \"{p.name}\"")
    gen_fm.append(f"date_generated: \"{datetime.utcnow().date().isoformat()}\"")
    gen_fm.append("---\n")

    gen_content = "\n".join(gen_fm) + body

    # Idempotent write: only write if content differs
    if gen_path.exists():
        existing = gen_path.read_text(encoding='utf8')
        if existing == gen_content:
            print(f"[SKIP] Up-to-date: {gen_path}")
            continue
    gen_path.write_text(gen_content, encoding='utf8')
    print(f"[WRITE] Generated: {gen_path}")
    generated.append(gen_path)

if generated:
    print(f"Done. Generated {len(generated)} files.")
    sys.exit(0)
else:
    print("Done. Nothing to generate.")
    sys.exit(0)
