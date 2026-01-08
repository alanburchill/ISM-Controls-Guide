---
permalink: /controls-html/ISM-1654.html
title: "Internet Explorer 11 is disabled or removed. (ISM-1654)"
ism_control: "ISM-1654"
revision: "0"
updated: "Sep-21"
guideline: ""
section: "Operating system hardening"
topic: "Hardening operating system configurations"
essential_eight:
  - "ML1"
  - "ML2"
  - "ML3"
pspf_levels:
  - "NC"
  - "OS"
  - "P"
  - "S"
  - "TS"
date_generated: "2026-01-08"
---
# Internet Explorer 11 is disabled or removed. (ISM-1654)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1654 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | Hardening operating system configurations |
| **Essential Eight** | ML1, ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Internet Explorer 11 is not installed on workstations as part of user-application hardening.[^1] ASD Essential Eight guidance describes hardening of user applications and deployment via Intune on endpoints.[^2] Not provided in source documentation.

[^1]: [Internet Explorer 11 - Internet Explorer is not installed on<SYSTEM-NAME>workstations.](https://blueprint.asd.gov.au/design/platform/client/device-configuration/)

[^2]: [User application hardening](https://blueprint.asd.gov.au/security-and-governance/system-security-plan/system-hardening-user-apps/)

## Design Decision

> [!NOTE] Internet Explorer 11 will be disabled by removing Internet Explorer 11 features using the script UserApplicationHardening-RemoveFeatures.ps1, deployed via the Intune Scripts option.

## Prerequisites

No specific prerequisites identified in source documentation.

## Implementation Steps

Not provided in source documentation.