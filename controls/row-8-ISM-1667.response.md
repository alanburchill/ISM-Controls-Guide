---
title: "Microsoft Office is blocked from creating child processes. (ISM-1667)"
ism_control: "ISM-1667"
revision: "0"
updated: "Sep-21"
guideline: ""
section: "User application hardening"
topic: "Hardening user application configurations"
essential_eight:
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
# Microsoft Office is blocked from creating child processes. (ISM-1667)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1667 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | User application hardening |
| **Topic** | Hardening user application configurations |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Enable the ASR rule named “Block all Office applications from creating child processes” in Intune to prevent Office apps from spawning child processes. Configure the rule to Block to enforce the behavior; available options include Not configured, Audit mode, Warn, and Disable. The rule is identified by GUID D4F940AB-401B-4EFC-AADC-AD5F3C50688A and is documented in the Intune ASR profile settings guidance.[^1]

[^1]: [Attack surface reduction (MDM) - ASR profile settings](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings#attack-surface-reduction-mdm)

## Design Decision

> [!NOTE] The ASR rule to block Office applications from creating child processes will be enabled via Intune.

## Prerequisites

No specific prerequisites identified in source documentation.

## Implementation Steps

### Enable ASR rule to block Office apps from creating child processes via Intune

Not provided in source documentation.