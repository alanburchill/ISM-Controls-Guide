---
permalink: /controls-html/ISM-1654.html
title: "Internet Explorer 11 is disabled or removed. (ISM-1654)"
ism_control: "ISM-1654"
revision: "0"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
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
date_generated: "2025-12-25"
---
# Internet Explorer 11 is disabled or removed. (ISM-1654)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1654 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | Hardening operating system configurations |
| **Essential Eight** | ML1, ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Internet Explorer 11 is disabled or removed on Windows endpoints as part of OS hardening.[^1] Implement this by applying the [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1) script, which disables or removes Internet Explorer and related features.[^1] Deploy the script via Intune using the Scripts option in the admin center, uploading the PS1 file and assigning it to the target devices; refer to the Intune deployment workflow for scripts and remediations.[^2][^3]

[^1]:Resources and references(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden#resources-and-references)
[^2]:Use Remediations to Detect and Fix Support Issues - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/remediations)
[^3]:Intune-ACSC-Windows-Hardening-Guidelines/scripts/UserApplicationHardening-RemoveFeatures.ps1 at main · microsoft/Intune-ACSC-Windows-Hardening-Guidelines · GitHub(https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1)

## Design Decision

> [!NOTE] The design disables Internet Explorer 11 by running the provided script (UserApplicationHardening-RemoveFeatures.ps1) and deploys it through Intune using the Scripts deployment option to meet the control requirement.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:** [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1); Deploy using Microsoft Intune with the Scripts option. [^1]

[^1]:Resources and references(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden#resources-and-references)

## Implementation Steps

### Remove Features with UserApplicationHardening-RemoveFeatures.ps1

1. Sign in to the Intune admin center. [^2]

2. Navigate to Devices > Manage devices > Scripts and remediations. [^2]

3. Choose Create script package to create a script package. [^2]

4. In the Basics step, provide a Name (e.g., UserApplicationHardening-RemoveFeatures) and an optional Description. [^2]

5. On the Settings step, upload both the Detection script file and the Remediation script file. The remediation uses the script named UserApplicationHardening-RemoveFeatures.ps1, which is hosted remotely at the following URL: [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1). The detection script must use exit code 1 to indicate detection; any other exit code prevents remediation from running; an empty output indicates no issue found. [^2][^3]

6. Finish the options on the Settings page with:
   - Run this script using the logged-on credentials: value dependent on the script. [^2]
   - Enforce script signature check: No. [^2]
   - Run script in 64-bit PowerShell: No. [^2]

7. Select Next, then assign any Scope tags as needed. [^2]

8. In the Assignments step, select the device groups to deploy the script package. [^2]

9. Complete the Review + Create step to deploy. [^2]

10. Monitor script deployment status in the Intune admin center: Scripts and remediations → Device status. [^2]

Notes:
- The script is intended to meet: Internet Explorer is disabled or removed; .NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed; Windows PowerShell 2.0 is disabled or removed. [^1]

- The script file referenced here is hosted remotely. [^3]

[^1]:Resources and references (https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden#resources-and-references)
[^2]:Use Remediations to Detect and Fix Support Issues - Microsoft Intune | Microsoft Learn (https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/remediations)
[^3]:Intune-ACSC-Windows-Hardening-Guidelines/scripts/UserApplicationHardening-RemoveFeatures.ps1 (https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1)