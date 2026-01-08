---
title: "Microsoft’s vulnerable driver blocklist is implemented. (ISM-1659)"
ism_control: "ISM-1659"
revision: "1"
updated: "Dec-23"
guideline: "Guidelines for system hardening"
section: "Operating system hardening"
topic: "Application control"
essential_eight:
  - "ML3"
pspf_levels:
  - "NC"
  - "OS"
  - "P"
  - "S"
  - "TS"
date_generated: "2026-01-06"
---
# Microsoft’s vulnerable driver blocklist is implemented. (ISM-1659)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1659 |
| **Revision** | 1 |
| **Updated** | Dec-23 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | Application control |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Turn on Microsoft vulnerable driver blocklist using Intune device security settings. Microsoft recommends enabling the blocklist to prevent loading of known vulnerable or malicious drivers and provides deployment guidance via App Control for Business in Intune; the blocklist is updated with each major Windows release. Blocking can cause device or software malfunctions; test in audit mode before enforcing, and be aware that the blocklist may be enabled by default on newer Windows versions and can be controlled via Windows Security.[^1]

## Design Decision

> [!NOTE] Enable the Microsoft vulnerable driver blocklist using Intune device security settings to block loading of vulnerable kernel drivers.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^2]
* **Dependencies:** Not provided in source documentation. [^3]

## Implementation Steps

### Microsoft vulnerable driver blocklist via Intune App Control

1. Assess feasibility. If HVCI or S mode is unavailable, proceed with blocking the vulnerable driver blocklist within App Control for Business policy. Not providing HVCI/S mode is not a blocker to applying the blocklist in App Control.[^1]

2. In Intune, prepare or update an App Control for Business policy to include the vulnerable driver blocklist. Validate the policy in audit mode and review audit block events before enforcing.[^1]

3. Obtain the blocklist content:
   - Download the App Control policy refresh tool: https://aka.ms/refreshpolicy
   - Download and extract the vulnerable driver blocklist binaries: https://aka.ms/VulnerableDriverBlockList
   - Choose either the audit-only version or the enforced version and rename the file to SiPolicy.p7b.[^1]

4. Deploy the blocklist file:
   - Copy SiPolicy.p7b to %windir%\system32\CodeIntegrity.[^1]

5. Activate and refresh policies:
   - Run the App Control policy refresh tool you downloaded in Step 3 to activate and refresh all App Control policies on the device.[^1]

6. Verify policy application:
   - Open Event Viewer.
   - Navigate to Applications and Services Logs - Microsoft - Windows - CodeIntegrity - Operational.
   - Filter Current Log for 3099.
   - Confirm a 3099 event where the PolicyNameBuffer and PolicyIdBuffer match the Name and ID from PolicyInfo settings found in the blocklist App Control Policy XML. Note: there may be more than one 3099 event if other App Control policies are present.[^1]

7. Reboot requirement:
   - If any vulnerable drivers are already running that would be blocked by the policy, reboot the device for the block to take effect. Not providing a reboot may leave the driver loaded until the next restart.[^1]

8. Optional hardening step:
   - Enable the Attack Surface Reduction (ASR) rule “Block abuse of exploited vulnerable signed drivers” to prevent loading of vulnerable drivers, per Microsoft guidance.[^1]

## References

[^1]: [Microsoft recommended driver block rules](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules)

[^2]: [Settings list for the Microsoft Intune security baseline for Microsoft Defender for Endpoint - Microsoft Intune | Microsoft Learn](https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-defender)

[^3]: [Configure Microsoft Intune for increased device security - Microsoft Intune | Microsoft Learn](https://learn.microsoft.com/en-us/intune/intune-service/protect/zero-trust-secure-devices)
