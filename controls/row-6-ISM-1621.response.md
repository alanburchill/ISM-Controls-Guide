---
title: "Windows PowerShell 2.0 is disabled or removed."
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
date_generated: "2026-01-13"
---
# Windows PowerShell 2.0 is disabled or removed.

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

Configure **Disable Windows PowerShell 2.0** using the **UserApplicationHardening-RemoveFeatures.ps1** script and deploy it with the **Intune 'Scripts' option**.[^1]

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Design Decision

Use **Essential Eight** to (1) configure **Windows PowerShell 2.0 removal** and (2) deploy **UserApplicationHardening-RemoveFeatures.ps1** via **InTune 'Scripts' option**.

> [!NOTE]
> Deploying **UserApplicationHardening-RemoveFeatures.ps1** also disables **.NET Framework 3.5** (includes .NET 2.0 and 3.0) and **Windows PowerShell 2.0**.

## Prerequisites

### Dependencies
- Ability to create and deploy a **Settings Catalog** policy[^1].
- Access to the **UserApplicationHardening-RemoveFeatures.ps1**[^1].

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Implementation Steps

### Remove Internet Explorer 11 and related features using **UserApplicationHardening-RemoveFeatures.ps1**

1. Sign in to the Microsoft Intune admin center. Navigate to Devices > Scripts and remediations > Platform scripts > Add > Windows 10 and later. [^4]

2. In Basics, provide:
   - Name: Enter a name for the PowerShell script.
   - Description: Enter a description for the PowerShell script.

3. In Script settings, specify:
   - Script location: Browse to the PowerShell script. The script must be less than 200 KB (ASCII). 
   - Script content: Use the script file **UserApplicationHardening-RemoveFeatures.ps1**. If URL is not provided, the script name should be bold.

4. Configure the following script execution options:

| Setting | Value |
| ------- | ----- |
| Run this script using the logged on credentials | No |
| Enforce script signature check | No |
| Run script in 64-bit PowerShell Host | No |

5. Assign the script to a deployment group. [^4]

6. Monitor run status in the Intune portal. If the script fails, follow the retry guidance shown in the Intune script deployment flow. [^4]

> [!NOTE]
> This script also disables **.NET Framework 3.5** (includes **.NET 2.0** and **3.0**) and **Windows PowerShell 2.0**. [^1]

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^4]: [Add PowerShell Scripts to Windows Devices in Microsoft Intune - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/apps/powershell-scripts)

## Additional related information

- Windows features management with PowerShell guidance for disabling specific features including Windows PowerShell 2.0 [Add, remove, or hide Windows features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features)

- Intune PowerShell script deployment guidance shows how to create, configure, and assign PowerShell scripts to devices [Add PowerShell Scripts to Windows Devices in Microsoft Intune - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/apps/powershell-scripts)

- Blocking PowerShell for EDU Tenants provides blocking guidance for PowerShell usage in educational environments [Blocking PowerShell for EDU Tenants - School Data Sync](https://learn.microsoft.com/en-us/schooldatasync/blocking-powershell-for-edu)

- ASD Blueprint: Windows features outlines recommended Windows features configuration and notes that PowerShell 2.0 should be disabled or removed [ASD Blueprint: Windows features](https://blueprint.asd.gov.au/design/endpoints/windows/configuration/windows-features/)

- Deploying a privileged access solution offers guidance on finishing workstation hardening and script-based controls [Deploying a privileged access solution - Privileged access](https://learn.microsoft.com/en-us/security/privileged-access-workstations/privileged-access-deployment)