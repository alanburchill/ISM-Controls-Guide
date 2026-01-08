---
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

Disable Internet Explorer 11 as a standalone browser using Intune Settings Catalog: Administrative Templates > Windows Components > Internet Explorer, enable "Disable Internet Explorer 11 as a standalone browser (User)", and deploy to target devices[^1]. To completely remove IE11, add the UserApplicationHardening-RemoveFeatures.ps1 script as an InTune PowerShell script with the following options: Run this script using the logged on credentials: No; Enforce script signature check: No; Run script in 64-bit PowerShell Host: No, then assign the script to a deployment group; the script also disables .NET Framework 3.5 and Windows PowerShell 2.0[^2].

[^1]: [Internet Explorer 11 is disabled or removed](https://learn.microsoft.com/en-au/compliance/anz/e8-app-harden#internet-explorer-11-is-disabled-or-removed#Internet-Explorer-11-is-disabled-or-removed)

[^2]: [Internet Explorer 11 is disabled or removed](https://learn.microsoft.com/en-au/compliance/anz/e8-app-harden#internet-explorer-11-is-disabled-or-removed#Internet-Explorer-11-is-disabled-or-removed)

## Design Decision

> [!NOTE] Internet Explorer 11 will be disabled or removed by deploying the UserApplicationHardening-RemoveFeatures.ps1 script via the Intune 'Scripts' option.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:**
  1. Settings Catalog policy in Intune to disable Internet Explorer 11 as a standalone browser (User) via the setting: Disable Internet Explorer 11 as a standalone browser (User). [^1]
  2. UserApplicationHardening-RemoveFeatures.ps1 script for complete removal of Internet Explorer 11. [^1]
  3. Add the UserApplicationHardening-RemoveFeatures.ps1 script as a PowerShell script with options:
     - Run this script using the logged on credentials: No
     - Enforce script signature check: No
     - Run script in 64-bit PowerShell Host: No [^2]
  4. Assign the script to a deployment group. [^2]

[^1]: [Internet Explorer 11 is disabled or removed](https://learn.microsoft.com/en-au/compliance/anz/e8-app-harden#internet-explorer-11-is-disabled-or-removed#Internet-Explorer-11-is-disabled-or-removed)
[^2]: [Internet Explorer 11 is disabled or removed](https://learn.microsoft.com/en-au/compliance/anz/e8-app-harden#internet-explorer-11-is-disabled-or-removed)

## Implementation Steps

### Disable Internet Explorer 11 as a standalone browser and remove IE11 via Intune

1. Create a new Settings Catalog policy.
2. Browse by category, and search for: Disable Internet Explorer 11 as a standalone browser (User).
3. Go to Administrative Templates\Windows Components\Internet Explorer and select the setting: Disable Internet Explorer 11 as a standalone browser (User).
4. Enable the setting Disable Internet Explorer 11 as a standalone browser (User).
5. Deploy the policy to a set of devices or users. [^1]

### Remove Internet Explorer 11 via PowerShell script (Intune Script deployment)

1. Add the [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1) as a PowerShell script with the following options:
   - Run this script using the logged on credentials: No
   - Enforce script signature check: No
   - Run script in 64-bit PowerShell Host: No [^1]

2. Assign the script to a deployment group. [^2]

3. Note: This script also disables .NET Framework 3.5 (includes .NET 2.0 and 3.0) and Windows PowerShell 2.0. [^2]

4. Deploy the script via the InTune 'Scripts' option. [^2]

[^1]: [Internet Explorer 11 is disabled or removed](https://learn.microsoft.com/en-au/compliance/anz/e8-app-harden#internet-explorer-11-is-disabled-or-removed)
[^2]: [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1)