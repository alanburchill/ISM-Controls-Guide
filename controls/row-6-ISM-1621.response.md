---
title: "Windows PowerShell 2.0 is disabled or removed. (ISM-1621)"
ism_control: "ISM-1621"
revision: "1"
updated: "Sep-21"
guideline: ""
section: "Operating system hardening"
topic: "PowerShell"
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
# Windows PowerShell 2.0 is disabled or removed. (ISM-1621)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1621 |
| **Revision** | 1 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | PowerShell |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

PowerShell 2.0 is disabled or removed on Windows devices as part of OS hardening.[^2]

Implement by deploying a PowerShell script that removes legacy features using the Intune management extension.[^1][^3]

Deploy through the InTune 'Scripts' option: upload the script, set Run this script using the logged on credentials to No, assign to the appropriate groups, and rely on Intune to report success or failure.[^2][^3]

[^1]: [Use PowerShell Scripts on Windows Devices in Intune](https://learn.microsoft.com/en-us/intune/intune-service/apps/powershell-scripts)
[^2]: [Privileged access deployment](https://learn.microsoft.com/en-us/security/privileged-access-workstations/privileged-access-deployment#manage-local-applications)
[^3]: [Powershell Scripts and Remediations | ASD](https://blueprint.asd.gov.au/design/platform/client/device-security/)

## Design Decision

> [!NOTE] Remove PowerShell 2.0 by deploying a dedicated script through the Intune 'Scripts' option.

## Prerequisites

* **Permissions/Roles:** PowerShell scripts run under administrator privileges when deployed in a user context with administrator rights. [^1]

* **Dependencies:** Requires Microsoft Intune service and the Intune management extension to upload and run PowerShell scripts on Windows devices. [^1]

* **Dependencies:** Intune supports deploying PowerShell scripts through the Intune management extension; scripts execute on endpoints and report results. [^3]

[^1]: [Use PowerShell Scripts on Windows Devices in Intune](https://learn.microsoft.com/en-us/intune/intune-service/apps/powershell-scripts)

[^3]: [Powershell Scripts and Remediations | In some cases Microsoft Intune policies may not exist for a particular endpoint setting.](https://blueprint.asd.gov.au/design/platform/client/device-security/)

## Implementation Steps

### Using UserApplicationHardening-RemoveFeatures.ps1 script via Intune

Not provided in source documentation.