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
date_generated: "2025-12-25"
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

Microsoft’s vulnerable driver blocklist is implemented to harden Windows against known vulnerable kernel drivers.[^1] Turn on the Microsoft vulnerable driver blocklist using Intune device security settings, applying the blocklist via App Control policy or Defender security baselines, and verify enforcement via Event Viewer (CodeIntegrity Operational log).[^1][^2] Microsoft recommends enabling memory protection features such as HVCI (memory integrity) or S mode when possible to augment the blocklist; if not feasible, rely on the blocklist within App Control and test in audit mode before enforcement.[^1]

[^1]:Microsoft recommended driver block rules | Microsoft Learn(https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules)
[^2]:Settings list for the Microsoft Intune security baseline for Microsoft Defender for Endpoint - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-defender)

## Design Decision

> [!NOTE] Enable the Microsoft vulnerable driver blocklist via Intune device security settings to block loading of known vulnerable or malicious drivers on managed Windows devices.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^2]
* **Dependencies:** Intune service and Windows devices required. Settings Catalog in Intune is used to configure device configuration policies. [^3]

[^1]:Device restriction settings for Windows devices in Microsoft Intune(https://learn.microsoft.com/en-us/intune/intune-service/configuration/device-restrictions-windows-10)
[^2]:Device restriction settings for Windows devices in Microsoft Intune(https://learn.microsoft.com/en-us/intune/intune-service/configuration/device-restrictions-windows-10)
[^3]:Device restriction settings for Windows devices in Microsoft Intune(https://learn.microsoft.com/en-us/intune/intune-service/configuration/device-restrictions-windows-10)

## Implementation Steps

### Turn on Microsoft vulnerable driver blocklist using Intune App Control policy

1. Download the App Control policy refresh tool from the Microsoft link: https://aka.ms/refreshpolicy. [^1]

2. Download and extract the vulnerable driver blocklist binaries from the Microsoft link: https://aka.ms/VulnerableDriverBlockList. [^1]

3. In your environment, select either the audit-only version or the enforced version, and rename the file to SiPolicy.p7b. [^1]

4. Copy SiPolicy.p7b to %windir%\system32\CodeIntegrity. [^1]

5. Run the App Control policy refresh tool you downloaded in Step 1 to activate and refresh all App Control policies on the computer. [^1]

6. To verify policy application:
   - Open Event Viewer.
   - Navigate to Applications and Services Logs - Microsoft - Windows - CodeIntegrity - Operational.
   - Filter the Current Log for Event ID 3099.
   - Confirm that the PolicyNameBuffer and PolicyIdBuffer match the Name and ID from PolicyInfo settings found in the blocklist App Control Policy XML. Note: a reboot may be required for certain drivers to be blocked. [^1]

7. Note: Blocking vulnerable drivers can cause devices or software to malfunction, and the blocklist is not guaranteed to block every driver. Microsoft balances security with compatibility. [^1]

8. If this setting isn’t possible to enable via Intune device security settings, Microsoft recommends applying the latest blocklist using App Control for Business. [^1]

[^1]:Microsoft recommended driver block rules | Microsoft Learn(https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules)