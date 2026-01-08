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
date_generated: "2026-01-07"
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

Disable the .NET Framework 3.5 SP1 feature (including .NET 2.0 and 3.0) by using Windows PowerShell to disable specific features with the Disable-WindowsOptionalFeature cmdlet.[^1][^2] Intune can run PowerShell remediation scripts to automate this removal, aligning with InTune remediation options.[^1] Use Get-WindowsOptionalFeature to verify the feature state and determine if a restart is required.[^1]

[^1]: [https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features)
[^2]: [https://4sysops.com/archives/why-and-how-to-uninstall-end-of-life-net-framework-runtimes/](https://4sysops.com/archives/why-and-how-to-uninstall-end-of-life-net-framework-runtimes/)
[^3]: [https://blueprint.asd.gov.au/security-and-governance/system-security-plan/system-hardening-user-apps/](https://blueprint.asd.gov.au/security-and-governance/system-hardening-system-hardening-user-apps/)

## Design Decision

> [!NOTE] Use a PowerShell script remediation deployed via Intune to disable the .NET Framework 3.5 feature. The script uses the Disable-WindowsOptionalFeature cmdlet to remove the feature.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:** Not provided in source documentation. [^1]

[^1]: [Use Windows PowerShell to disable specific features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features)

## Implementation Steps

### Disable .NET Framework 3.5 via PowerShell (Intune remediation)

1. Use Windows PowerShell to disable the .NET Framework 3.5 feature by running the Disable-WindowsOptionalFeature cmdlet.  [^1]

2. Automate remediation without Group Policy by:
   - a) Creating a scheduled task to run the PowerShell script, or
   - b) Using Microsoft Intune to run PowerShell scripts on client devices.  [^1]

3. Verify the feature state after remediation by running Get-WindowsOptionalFeature to confirm the current state and whether a restart is required.  [^1]

4. If the feature needs to be re-enabled in the future, use Enable-WindowsOptionalFeature.  [^1]

5. Note: NET Framework 3.5 SP1 can be disabled via Windows Features.  [^2]

6. Script reference notice:
   - The remediation script content is not provided in this document. It is referenced remotely in the official documentation: [Use Windows PowerShell to disable specific features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features).  [^1]

[^1]: [Use Windows PowerShell to disable specific features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features)
[^2]: [Why and how to uninstall end-of-life .NET Framework runtimes](https://4sysops.com/archives/why-and-how-to-uninstall-end-of-life-net-framework-runtimes/)