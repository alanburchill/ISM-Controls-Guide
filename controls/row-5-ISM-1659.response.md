---
title: "Microsoft’s vulnerable driver blocklist is implemented. (ISM-1659)"
ism_control: "ISM-1659"
revision: "1"
updated: "Dec-23"
guideline: ""
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
date_generated: "2026-01-08"
---
# Microsoft’s vulnerable driver blocklist is implemented. (ISM-1659)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1659 |
| **Revision** | 1 |
| **Updated** | Dec-23 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | Application control |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Turn on Microsoft’s vulnerable driver blocklist using Windows Defender Application Control (WDAC) policies deployed via Microsoft Intune.[^1]

To apply the blocklist, download the vulnerable driver blocklist binary, select the enforced version and rename the file to SiPolicy.p7b, copy it to %windir%\system32\CodeIntegrity, and run the App Control policy refresh tool to activate and refresh all policies; reboot if any vulnerable drivers are already running, and verify the policy in Event Viewer (Applications and Services Logs - Microsoft - Windows - CodeIntegrity - Operational, look for event 3099 with matching PolicyNameBuffer and PolicyIdBuffer).[^2][^3]

[^1]: [App Control for Business and AppLocker Overview](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/appcontrol-for-business-and-applocker-overview)
[^2]: [Microsoft recommended driver block rules](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules#steps-to-download-and-apply-the-vulnerable-driver-blocklist-binary)
[^3]: [Microsoft vulnerable driver blocklist](https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control#administrator-protection#microsoft-vulnerable-driver-blocklist)

## Design Decision

> [!NOTE] Turn on Microsoft vulnerable driver blocklist in the Intune device security settings to prevent vulnerable drivers from running.

## Prerequisites

* **Dependencies:** Microsoft Intune is required to configure WDAC (Windows Defender Application Control) policies for application control on workstations. [^5]

[^5]: [Windows Defender Application Control (WDAC) is used to apply application control on<SYSTEM-NAME>workstations and is configured via Microsoft Intune to:](https://blueprint.asd.gov.au/security-and-governance/essential-eight/application-control/)

## Implementation Steps

### Turn on Microsoft vulnerable driver blocklist in Intune device security settings

Not provided in source documentation.
---
⚠️ **URL Validation Warnings:**
- **https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/appcontrol-for-business-and-applocker-overview** - HTTP 404
