---
title: ".NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed. (ISM-1655)"
ism_control: "ISM-1655"
revision: "0"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
section: "Operating system hardening"
topic: "Hardening operating system configurations"
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
# .NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed. (ISM-1655)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1655 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | Hardening operating system configurations |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Disabling or removing .NET Framework 3.5 (includes .NET 2.0 and 3.0) reduces the OS attack surface.[^1]

Implementation uses the UserApplicationHardening-RemoveFeatures.ps1 script and deploys it via Intune using the 'Scripts' option, with these script settings: Run this script using the logged on credentials: No; Enforce script signature check: No; Run script in 64-bit PowerShell Host: No.[^1]

Assign the script to a deployment group to apply the control across devices.[^1]

[^1]:Essential Eight user application hardening - Essential Eight | Microsoft Learn(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Design Decision

> [!NOTE] The design uses the UserApplicationHardening-RemoveFeatures.ps1 script to disable .NET Framework 3.5 (including 2.0 and 3.0) and Windows PowerShell 2.0, aligning with the control requirement. Deploy this script through Intune using the Scripts option to enforce removal across managed devices.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:** [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1) and Intune Script deployment capability. [^1]

[^1]:[Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Implementation Steps

### Deploy UserApplicationHardening-RemoveFeatures.ps1 via Intune Scripts

The UserApplicationHardening-RemoveFeatures.ps1 PowerShell script disables or removes .NET Framework 3.5 (includes .NET 2.0 and 3.0), Internet Explorer, and Windows PowerShell 2.0 as part of the Essential Eight user application hardening controls[^1]. The script is referenced remotely and deployed via Intune using the 'Scripts' option[^1].

Note: The script turns off the .NET Framework 3.5 feature if installed[^3].

1. Add the [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1) as a PowerShell script with the following options:

- Run this script using the logged on credentials: **No**
- Enforce script signature check: **No**
- Run script in 64-bit PowerShell Host: **No**[^1]

2. Assign the script to a deployment group[^1].

[^1]:Essential Eight user application hardening - Essential Eight(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)
[^3]:Deploy .NET Framework 3.5 by using Deployment Image Servicing and Management (DISM)(https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-net-framework-35-by-using-deployment-image-servicing-and-management--dism?view=windows-11)