---
title: "Application control is implemented on workstations. (ISM-0843)"
ism_control: "ISM-0843"
revision: "9"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
section: "Operating system hardening"
topic: "Application control"
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
date_generated: "2026-01-07"
---
# Application control is implemented on workstations. (ISM-0843)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-0843 |
| **Revision** | 9 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | Application control |
| **Essential Eight** | ML1, ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

WDAC enforces application control on workstations and is configured through App Control for Business[^1]. Policy deployment can be achieved through cloud-based Intune or Configuration Manager to centrally manage WDAC settings[^2][^3]. View and switch policy modes with PowerShell cmdlets such as Get-AsWdacPolicy and Enable-AsWdacPolicy[^4].

[^1]: [App Control for Windows](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/appcontrol#app-control-and-smart-app-control)
[^2]: [Application Control - ASD blueprint](https://blueprint.asd.gov.au/security-and-governance/essential-eight/application-control/)
[^3]: [Windows Defender Application Control management with Configuration Manager](https://learn.microsoft.com/en-us/intune/configmgr/protect/deploy-use/use-device-guard-with-configuration-manager#create-an-application-control-policy)
[^4]: [Manage Application Control settings with PowerShell](https://learn.microsoft.com/en-us/azure/azure-local/manage/manage-wdac?view=azloc-2512#manage-application-control-settings-with-powershell)

## Design Decision

> [!NOTE] App Control for Business will be used to implement Windows Defender Application Control (WDAC) policies, managed via Intune, on all workstations.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:** Production-signed Windows Server 2025 build; OSConfig PowerShell module installed on the server; Windows 10 version 1909 or later on the client; App Control Wizard installed; .NET Desktop Runtime 8.0 or later (required by the App Control Wizard). [^1]

[^1]: [Configure App Control for Business by using OSConfig](https://learn.microsoft.com/en-us/azure/osconfig/osconfig-how-to-configure-app-control-for-business#prerequisites)

## Implementation Steps

### Prerequisites for App Control for Business WDAC via OSConfig

1. You must be running a production-signed Windows Server 2025 build on your device. This requirement ensures compliance with the App Control for Business policies. Caution: Flight-signed binaries are not permitted.  
2. The OSConfig PowerShell module must be installed on your server device. See OSConfig prerequisites for details.  
3. You must be running Windows 10 version 1909 or later on your client device, and have the App Control Wizard installed.  
Note: If the client device doesn't have .NET Desktop Runtime 8.0 or later installed, the App Control Wizard will prompt you to download and install this application.  

[^4]: [Configure App Control for Business by using OSConfig](https://learn.microsoft.com/en-us/azure/osconfig/osconfig-how-to-configure-app-control-for-business#prerequisites)

### WDAC policy management with App Control for Business using PowerShell

1. Connect to one of the machines and use the following cmdlets to enable the desired Application Control policy in "Audit" or "Enforced" mode. In this build, there are two cmdlets:
   - Enable-AsWdacPolicy — Affects all cluster nodes.
   - Enable-ASLocalWDACPolicy — Affects only the node on which the cmdlet is run.  
2. To view the current policy mode, run:
   ```powershell
   Get-AsWdacPolicyMode
   ```
3. Switch the policy mode globally with:
   ```powershell
   Enable-AsWdacPolicy -Mode <PolicyMode [Audit | Enforced]>
   ```
   Example to switch to audit mode:
   ```powershell
   Enable-AsWdacPolicy -Mode Audit
   ```
4. If you prefer per-node changes, run:
   ```powershell
   Enable-ASLocalWDACPolicy -Mode <PolicyMode [Audit | Enforced]>
   ```
5. Confirm the policy mode after switching:
   ```powershell
   Get-AsWdacPolicyMode
   ```
   Note: The Orchestrator will take up to two to three minutes to switch to the selected mode.  
6. When an application is blocked, WDAC creates a corresponding event. Review the Event log to understand details of the policy blocking the application.  

[^1]: [Manage Application Control settings with PowerShell](https://learn.microsoft.com/en-us/azure/azure-local/manage/manage-wdac?view=azloc-2512#manage-application-control-settings-with-powershell)  
[^2]: [Switch Application Control policy modes](https://learn.microsoft.com/en-us/azure/azure-local/manage/manage-wdac?view=azloc-2512#manage-application-control-settings-with-powershell)

### Deploy WDAC policy using Configuration Manager

1. In the Configuration Manager console, go to Assets and Compliance, then Endpoint Protection, and select Windows Defender Application Control.  
2. On the Home tab, in the Create group, select Create Application Control policy.  
3. On the General page of the Create Application Control policy Wizard, specify:
   - Name: Enter a unique name for this Application Control policy.
   - Description: Optionally, enter a description to identify it in the Configuration Manager console.
   - Enforce a restart of devices so that this policy can be enforced for all processes: After the device processes the policy, a restart is scheduled based on Client Settings for Computer Restart. Applications currently running won’t apply the new policy until after a restart. Applications launched after the policy applies will honor the new policy.
   - Enforcement Mode: Choose Enforce or Audit Only.
4. On the Inclusions tab, choose whether to Authorize software that is trusted by the Intelligent Security Graph (ISG).  
5. If you want to add trust for specific files or folders on devices, select Add. In the Add Trusted File or Folder dialog, specify a local file or folder path to trust. You can also specify a file or folder path on a remote device.
   - Use Trust for specific files/folders to overcome issues with managed installers, trust LOB apps, or trusted OS image apps.  
6. Complete the wizard.  
7. Validate policy application on target devices.  

[^3]: [Windows Defender Application Control management with Configuration Manager](https://learn.microsoft.com/en-us/intune/configmgr/protect/deploy-use/use-device-guard-with-configuration-manager#create-an-application-control-policy)

This section reflects the use of App Control for Business as the mechanism to implement WDAC policies. For broader guidance on App Control for Business features and Smart App Control behavior, refer to the App Control for Windows documentation.  
[^5]: [App Control for Windows](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/appcontrol#app-control-and-smart-app-control)