---
title: ".NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed. (ISM-1655)"
ism_control: "ISM-1655"
revision: "0"
updated: "Sep-21"
guideline: ""
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
date_generated: "2026-01-08"
---
# .NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed. (ISM-1655)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1655 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | Hardening operating system configurations |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

ISM-1655 requires that .NET Framework 3.5 (including .NET 2.0 and 3.0) be disabled or removed. Implement using the provided script UserApplicationHardening-RemoveFeatures.ps1 and deploy it through the InTune 'Scripts' option to automate removal on endpoints. This approach aligns with ASD Essential Eight guidance for User Application Hardening.[^1][^2]

[^1]: [https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features)

[^2]: [https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/](https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/)

## Design Decision

> [!NOTE] Disable .NET Framework 3.5 (includes .NET 2.0 and 3.0) using the UserApplicationHardening-RemoveFeatures.ps1 script. Deploy the script through the Intune 'Scripts' option.

## Prerequisites

* **Permissions/Roles:** The current user must be a member of the local Administrators group to add or remove Windows features. [^2]

* **Dependencies:** Microsoft Intune is required to deploy the UserApplicationHardening-RemoveFeatures.ps1 script to Windows client devices using the InTune 'Scripts' option; Windows PowerShell capabilities on client devices are required to execute the script. [^1]

[^1]: [Add, remove, or hide Windows features (windows-10) – Use Windows PowerShell to disable specific features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features)

[^2]: [Deploy .NET Framework 3.5 by using Deployment Image Servicing and Management (DISM)](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-net-framework-35-by-using-deployment-image-servicing-and-management--dism?view=windows-11#deploy-net-framework-35-by-using-deployment-image-servicing-and-management-dism)

## Implementation Steps

### Remove features using UserApplicationHardening-RemoveFeatures.ps1

1. Deploy the UserApplicationHardening-RemoveFeatures.ps1 PowerShell script to target Windows devices using the InTune Scripts option.[^1]

2. The script disables the required Windows features, including .NET Framework 3.5, per Essential Eight guidance.[^3]

3. If a device cannot access Windows Update to obtain feature files, ensure the script can use a local or offline source to manage features in a deployment image or offline context. This can involve DISM/Disable-WindowsOptionalFeature workflows as described in the referenced guidance.[^2][^1]

4. As part of Essential Eight hardening, ensure Windows PowerShell 2.0 is disabled or removed, and configure PowerShell to use Constrained Language Mode where applicable.[^3]

5. Verify the feature removal after script execution:
   - Run the following command to verify .NET Framework 3.5 (NetFx3) is disabled or removed:
     ```powershell
     Get-WindowsOptionalFeature -Online -FeatureName NetFx3
     ```
   - Check that the FeatureState indicates Disabled (or Removed).[^1]

6. Monitor and document the outcome of the deployment, including any restart requirements or follow-up actions, and adjust the Intune script deployment as needed.[^1]

[^1]: [Use Windows PowerShell to disable specific features](https://learn.microsoft.com/en-us/windows/client-management/client-tools/add-remove-hide-features#use-windows-powershell-to-disable-specific-features)
[^2]: [Deploy .NET Framework 3.5 by using Deployment Image Servicing and Management (DISM)](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-net-framework-35-by-using-deployment-image-servicing-and-management--dism?view=windows-11#deploy-net-framework-35-by-using-deployment-image-servicing-and-management-dism)
[^3]: [Essential Eight guidance](https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/)