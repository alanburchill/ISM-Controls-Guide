---
title: "Windows PowerShell 2.0 is disabled or removed. (ISM-1621)"
ism_control: "ISM-1621"
revision: "1"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
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
date_generated: "2026-01-06"
---
# Windows PowerShell 2.0 is disabled or removed. (ISM-1621)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1621 |
| **Revision** | 1 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | PowerShell |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Windows PowerShell 2.0 is disabled or removed by deploying the UserApplicationHardening-RemoveFeatures.ps1 script.[^1] Deploy the script via Intune Remediations by packaging a detection script and a remediation script, uploading both files, and assigning the package to a deployment group.[^2] Follow the Remediations guidance to configure UTF-8 encoding, script-signature settings, and execution context, and to enable on-demand remediation as needed.[^2]

## Design Decision

> [!NOTE] The Windows PowerShell 2.0 feature is disabled by deploying the provided script (UserApplicationHardening-RemoveFeatures.ps1) via Intune Remediations, enabling detection and automatic remediation. Assign the remediation package to the target device group and configure the schedule as needed.

## Prerequisites

* **Licensing:** Remediations require users of the devices to have one of the following licenses: Windows Enterprise E3 or E5 (included in Microsoft 365 F3, E3, or E5); Windows Education A3 or A5 (included in Microsoft 365 A3 or A5); Windows Virtual Desktop Access (VDA) per user. [^2]
* **Permissions/Roles:** Not provided in source documentation.
* **Dependencies:** Not provided in source documentation.

## Implementation Steps

### Deploy UserApplicationHardening-RemoveFeatures.ps1 via Intune Remediations

1. Sign in to the Microsoft Intune admin center.[^2]

2. Navigate to **Devices** > **Manage devices** > **Scripts and remediations**.[^2]

3. Create a script package.  
   - This starts the Remediations workflow for a new script package.[^2]

4. In the Basics step, enter a name for the package, for example: **UserApplicationHardening-RemoveFeatures**. Optionally add a description. The version cannot be edited.[^2]

5. On the Settings page, upload both the Detection script file and the Remediation script file.  
   - Detection script file: Not provided in source documentation.  
   - Remediation script file: [UserApplicationHardening-RemoveFeatures.ps1](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/scripts/UserApplicationHardening-RemoveFeatures.ps1).[^1]

6. Configure the following options:
   - Run this script using the logged-on credentials: **No**  
   - Enforce script signature check: **No**  
   - Run script in 64-bit PowerShell Host: **No**[^2]

7. In Assignments, assign the script package to a deployment group (e.g., the Secure Workstations group).[^2]

8. Complete the workflow by selecting **Review + Create**. The script package is now created and ready for deployment.[^2]

9. Optional: Run remediation on-demand to verify deployment.  
   1. Sign in to the Intune admin center.  
   2. Navigate to **Devices** > **By platform** > **Windows** > select a supported device.  
   3. On the device’s Overview page, select the ellipsis (...) > **Run remediation (preview)**.  
   4. In the Run remediation pane, select the script package to run.  
   5. To execute immediately, select **Run remediation**.[^2]

Background: The script turns off Windows PowerShell 2.0, if installed. This behavior is described in the referenced source. [^1]

## References

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^2]: [Use Remediations to Detect and Fix Support Issues - Microsoft Intune | Microsoft Learn](https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/remediations)
