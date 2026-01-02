---
permalink: /controls-html/ISM-1667.html
title: "Microsoft Office is blocked from creating child processes. (ISM-1667)"
ism_control: "ISM-1667"
revision: "0"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
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
date_generated: "2025-12-25"
---
# Microsoft Office is blocked from creating child processes. (ISM-1667)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1667 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | User application hardening |
| **Topic** | Hardening user application configurations |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Enable the ASR rule that blocks all Office applications from creating child processes and deploy it via Intune (Endpoint Security) to enforce the block.[^1][^3] This approach aligns with ACSC Essential Eight guidance and Defender ASR documentation.[^2]

[^1]:[Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^2]:[Enable attack surface reduction rules - Microsoft Defender for Endpoint | Microsoft Learn](https://learn.microsoft.com/en-us/defender-endpoint/enable-attack-surface-reduction)

[^3]:[Intune endpoint security Attack surface reduction settings - Microsoft Intune | Microsoft Learn](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)

## Design Decision

> [!NOTE] Enable the ASR rule to block Microsoft Office from creating child processes via Intune.

## Prerequisites

* **Licensing:** Microsoft 365 E5 license recommended. [^2]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:** Microsoft Defender Antivirus must be the primary antivirus; Real-time protection must be on; Cloud-Delivery Protection must be on; Cloud Protection network connectivity must be on. [^2]

[^1]:[Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)
[^2]:[Enable attack surface reduction rules - Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/defender-endpoint/enable-attack-surface-reduction)

## Implementation Steps

### Enable ASR rule to block Office apps from creating child processes

1. Navigate to Graph Explorer and authenticate.[^1]

2. Create a POST request, using the beta schema to the Attack Surface Reduction policy endpoint:  
   https://graph.microsoft.com/beta/deviceManagement/templates/0e237410-1367-4844-bd7f-15fb0f08943b/createInstance.[^1]

3. Copy the JSON in the ACSC Windows Hardening Guidelines-Attack Surface Reduction policy and paste it in the request body.  
   Link: [ACSC Windows Hardening Guidelines-Attack Surface Reduction.json](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/policies/ACSC%20Windows%20Hardening%20Guidelines-Attack%20Surface%20Reduction.json)[^1]

4. (Optional) modify the name value if necessary.[^1]

> [!NOTE] This ASR policy contains the specific rule: Block all Office applications from creating child processes (D4F940AB-401B-4EFC-AADC-AD5F3C50688A).[^1]

[^1]:https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden