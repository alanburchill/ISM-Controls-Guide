---
title: "Microsoft’s vulnerable driver blocklist is implemented."
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
date_generated: "2026-01-13"
---
# Microsoft’s vulnerable driver blocklist is implemented.

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

Configure **Microsoft vulnerable driver blocklist** via **Intune** device security settings and deploy the App Control policy refresh tool using **Intune** deployment method.[^1]

[^1]: [Microsoft recommended driver block rules](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules)

## Design Decision

Use **Windows Defender Application Control (WDAC)** to configure **Turn on Microsoft vulnerable driver blocklist** and deploy **ScriptName.ps1** via **Intune**.

> [!NOTE]
> Deploying **ScriptName.ps1** also disables **Other Feature**.

## Prerequisites

- **Dependencies:** Windows 10 or Windows 11 endpoints with **WDAC** support[^2]. Hardware virtualization support and **Virtualization Based Security (VBS)** enabled with **UEFI lock**[^3]. Deployment via **Intune** for cloud-managed devices or **Group Policy** for hybrid devices[^2][^3]. Access to the vulnerable driver blocklist artifacts: the **App Control policy refresh tool** and the blocklist binaries; copy **SiPolicy.p7b** to %windir%\system32\CodeIntegrity; run the App Control policy refresh tool to apply policies[^1]. Plan to deploy WDAC in audit mode before enforcement[^2].

[^1]: [Microsoft recommended driver block rules](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules)
[^2]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)
[^3]: [Implementing application control](https://www.cyber.gov.au/resources-business-and-government/maintaining-devices-and-systems/system-hardening-and-administration/system-hardening/implementing-application-control)

## Implementation Steps

### Deploy blocklist via Intune Script

1. Download the App Control policy refresh tool[^1].
2. Download and extract the vulnerable driver blocklist binaries[^1].
3. Select either the audit-only version or the enforced version and rename the file to **SiPolicy.p7b**[^1].
4. Copy **SiPolicy.p7b** to %windir%\system32\CodeIntegrity[^1].
5. Run the App Control policy refresh tool you downloaded in Step 1 above to activate and refresh all App Control policies on your computer[^1].
6. To check that the policy was successfully applied on your computer: Open Event Viewer and browse to Applications and Services Logs - Microsoft - Windows - CodeIntegrity - Operational. Select Filter Current Log... Replace "<All Event IDs>" with "3099" and select OK. You should find a 3099 event where the PolicyNameBuffer and PolicyIdBuffer match the Name and ID from PolicyInfo settings found in the blocklist App Control Policy XML in this article[^1].
7. Note: Your computer might have more than one 3099 event if other App Control policies are present[^1].

### Enable blocklist via Intune Settings Catalog

Not provided in source documentation.

[^1]: [Microsoft recommended driver block rules](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules)
[^2]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)
[^3]: [Implementing application control](https://www.cyber.gov.au/resources-business-and-government/maintaining-devices-and-systems/system-hardening-and-administration/system-hardening/implementing-application-control)

## Additional related information