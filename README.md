# ISM Controls Implementation Guide

Implementation guidance for Australian Information Security Manual (ISM) controls with Essential Eight and PSPF mappings.

## Live Site

🔗 **[View the Guide](https://alanburchill.github.io/ISM-Controls-Guide)**

## Contents

This repository contains 54 ISM control implementation guides covering:

- **Essential Eight** maturity levels (ML1, ML2, ML3)
- **PSPF** security classifications (NC, OS, P, S, TS)
- Step-by-step implementation instructions
- Prerequisites and dependencies
- Design decisions

## Structure

```
├── controls/          # ISM control markdown files
├── assets/           # Search index JSON
├── _data/            # Site navigation data
├── _config.yml       # Jekyll configuration
└── index.md          # Homepage with search/filter
```

## Local Development

To run locally:

```bash
bundle install
bundle exec jekyll serve
```

Then open http://localhost:4000/ISM-Controls-Guide/

## License

Content is provided for informational purposes. Refer to official ACSC documentation for authoritative guidance.
