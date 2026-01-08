---
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
date_generated: "2026-01-06"
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

Enable the ASR rule to block Microsoft Office from creating child processes via Intune Endpoint Security. The policy to deploy is the ASR rule that blocks all Office applications from creating child processes (D4F940AB-401B-4EFC-AADC-AD5F3C50688A), as described in ACSC Essential Eight guidance and Defender for Endpoint documentation[^1][^2]. Implement the policy using Graph Explorer or Intune settings to import/apply the ASR configuration[^3].

## Design Decision

> [!NOTE] Enable the ASR rule to block Office applications from creating child processes via Intune. This eliminates Office-created child processes, reducing the attack surface.

## Prerequisites

* **Licensing:** Recommended: Microsoft 365 E5. [^2]
* **Permissions/Roles:** Not provided in source documentation. [^2]
* **Dependencies:** Microsoft Defender for Endpoint prerequisites:
  - Microsoft Defender Antivirus must be set as the primary antivirus and must not be running in passive mode or be disabled.
  - Real-time protection must be on.
  - Cloud-Delivery Protection must be on.
  - You must have Cloud connectivity for protection updates.
  - Deployment of ASR rules via Intune or another enterprise management solution is supported and commonly used. [^2]

## Implementation Steps

### Blocking creation of Office applications from creating child processes

To implement blocking creation of Office applications from creating child processes:

1. Navigate to Graph Explorer and authenticate. [^1]
2. Create a POST request, using the beta schema to the Attack Surface Reduction policy endpoint: https://graph.microsoft.com/beta/deviceManagement/templates/0e237410-1367-4844-bd7f-15fb0f08943b/createInstance. [^1]
3. Copy the JSON in the ACSC Windows Hardening Guidelines-Attack Surface Reduction policy and paste it in the request body. [^1]
4. (Optional) modify the name value if necessary. [^1]

Notes:
- This ASR Endpoint Security policy contains the specific ASR rule: Block all Office applications from creating child processes (D4F940AB-401B-4EFC-AADC-AD5F3C50688A). [^1]
- The Attack Surface Reduction (ASR) policy configures the ACSC-recommended rules in audit mode while deploying. [^1]

## References

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^2]: [Enable attack surface reduction rules - Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/defender-endpoint/enable-attack-surface-reduction)

[^3]: [Intune endpoint security Attack surface reduction settings - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)
