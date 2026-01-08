---
permalink: /controls-html/ISM-1668.html
title: "Microsoft Office is blocked from creating executable content. (ISM-1668)"
ism_control: "ISM-1668"
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
# Microsoft Office is blocked from creating executable content. (ISM-1668)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1668 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | User application hardening |
| **Topic** | Hardening user application configurations |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Enable the ASR rule to block Office apps from creating executable content via Intune Endpoint Protection.[^2] This setting is configured under Microsoft Defender Exploit Guard in an Intune Endpoint Protection profile.[^1] This approach aligns with ASD Microsoft Office hardening guidance, which includes blocking Office applications from creating executable content.[^3]

[^1]: [Microsoft Defender Exploit Guard in Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-protection-windows-10#microsoft-defender-exploit-guard)
[^2]: [Attack surface reduction policy settings for endpoint security in Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings#attack-surface-reduction-mdm)
[^3]: [ASD Blueprint: Microsoft Office hardening](https://blueprint.asd.gov.au/design/endpoints/windows/security/microsoft-office-hardening/)

## Design Decision

> [!NOTE] Enable the Attack Surface Reduction rule to block Office apps from creating executable content via Intune. This design choice hardens Office usage in line with the control objective.

## Prerequisites

No specific prerequisites identified in source documentation.

## Implementation Steps

### Enable ASR to Block Office Executable Content

1. In Intune, open Attack Surface Reduction (MDM) policy settings.[^2]
2. Set the option "Block Office applications from creating executable content" to Block.[^2]
3. Save the policy.  
4. Optional: Review related ASR settings to strengthen protection, such as blocking Office applications from creating child processes and blocking Win32 API calls from Office macros.[^2][^3]
5. Refer to ASD Microsoft Office hardening guidance for design context.[^3]

[^1]: [Microsoft Defender Exploit Guard](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-protection-windows-10#microsoft-defender-exploit-guard)
[^2]: [Attack surface reduction policy settings for endpoint security in Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings#attack-surface-reduction-mdm)
[^3]: [ASD Blueprint: Microsoft Office hardening](https://blueprint.asd.gov.au/design/endpoints/windows/security/microsoft-office-hardening/)