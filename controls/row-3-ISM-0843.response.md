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
date_generated: "2025-12-25"
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

This section documents implementing WDAC-based application control on Windows workstations using App Control for Business, managed via Microsoft Intune. App Control for Business policies use the Windows ApplicationControl CSP to govern allowed apps and can tag apps deployed through Intune as approved via a managed installer[^1][^2]. Base policies can be extended with supplemental policies and deployed through Intune to define which applications are allowed to run on devices[^1][^2]. 

[^1]:Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)
[^2]:Windows 11 Security Book - Application And Driver Control | Microsoft Learn(https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control)

## Design Decision

> [!NOTE] Implement WDAC via App Control for Business policies managed with Intune to control which apps can run on Windows workstations. Use a managed installer to automatically tag apps deployed through Intune as trusted, enabling WDAC policy enforcement to apply to those apps.

## Prerequisites

* **Licensing:** Windows edition and licensing requirements for Windows Defender App Control for Business (WDAC). See Windows edition and licensing requirements. [^1]
* **Permissions/Roles:** Intune Administrator role required to enable the managed installer; App Control for Business permission (Delete, Read, Assign, Create, Update, and View Reports); View reports requires either App Control for Business permission with View Reports or Organization permission with Read. Government cloud support applies to Intune endpoint security App Control for Business. [^1]
* **Dependencies:** Intune endpoint security App Control for Business; Intune Management Extension as a managed installer on enrolled Windows devices; Devices enrolled in Intune; RBAC permissions as described; Intune supports US Government clouds and 21Vianet. [^1]

[^1]:Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)

## Implementation Steps

### Deploy WDAC via App Control for Business with Intune Managed Installer

1. In the Intune admin center, go to **Endpoint security** > **App Control for Business** > **Managed installer** and select **Create**. Enter a descriptive **Name** and optional **Description**.  
   - On **Settings**, set **Enable Intune Managed Extension as Managed Installer** to **Enabled** (default). Save the policy.  
   - This enables the Intune Management Extension as the source for managed apps and allows WDAC to recognize those apps as trusted when the WDAC policy includes the appropriate rules.[^1]

2. After enabling the managed installer, wait for policy propagation. The managed installer tagging causes apps deployed through Intune to be identified as approved by App Control for Business, enabling smoother WDAC enforcement. It may take up to 10 minutes for the policy to appear as active in the admin center.[^1]

3. Create a base App Control for Business policy (the WDAC base policy):
   - In the Intune admin center, go to **Endpoint security** > **App Control for Business** > select the **App Control for Business** tab > **Create Policy**. The policy is automatically assigned a platform type.  
   - On **Basics**, specify:
     - **Name**: descriptive profile name.
     - **Description**: optional but recommended.
   - On **Configuration settings**, choose a **Configuration settings format**:
     - **Built-in controls** – configure trust settings without custom XML.
       - **Enable trust of Windows components and store apps** — Enabled by default.
       - **Select additional options for trusting apps** — choose:
         - **Trust apps with a good reputation**.
         - **Trust apps from managed installers**.
       - Behavior for all other apps depends on the first setting.
     - On **Scope tags**, apply as needed, then select **Next**.
   - On **Assignments**, add the target device groups, then select **Next**; then **Review + create** and **Create**. The policy is deployed to the assigned devices.[^1]

4. Use supplemental policies to expand trust as needed:
   - In Intune, go to **Endpoint security** > **App Control for Business** > **App Control for Business** tab, then select **Create Policy** and choose to create a **Supplemental Policy** targeting the same base policy groups.  
   - On **Basics**, provide a descriptive name/description.
   - On **Configuration settings**, select **Enter xml data** and upload your supplemental XML file that references the base policy’s PolicyID.
   - On **Assignments**, select the same groups as the base policy.
   - On **Review + create**, select **Create**. The supplemental policy is deployed and expands the base policy scope.[^1]

5. Deploy and verify WDAC audit policy (base policy in audit mode initially is recommended):
   - Use the Windows Defender App Control Wizard or equivalent to create the base policy in audit mode and then deploy via Intune as described above. When ready, you can switch to enforcement using the wizard’s policy editor and corresponding Intune deployment steps.  
   - After deployment, view policy details in the Intune admin center under the policy list to verify device assignment status and report availability.[^1]

6. Optional cleanup and maintenance:
   - If cleanup is required, you can remove the Intune managed installer or WDAC policies using targeted cleanup scripts referenced in Microsoft Intune WDAC guidance. For example:
     - CatCleanIMEOnly.ps1: [CatCleanIMEOnly.ps1](https://aka.ms/intune_WDAC/CatCleanIMEOnly)
     - CatCleanAll.ps1: [CatCleanAll.ps1](https://aka.ms/intune_WDAC/CatCleanAll)
   - These scripts and related cleanup procedures are described in the Intune WDAC documentation.[^1]

7. Monitor and report:
   - In the Intune admin center, navigate to **Endpoint security** > **App Control for Business**. Use the **Policies** tab to view policy details and the **Managed installer** tab to view device status and trends. Device status and reports update over time (up to 24 hours for full visibility).[^1]

Notes:
- App Control for Business policies are implemented using the WDAC framework and the Intune-managed installer mechanism. Ensure the base policy and any supplement policies target appropriate device groups and that the managed installer tagging is enabled before deploying WDAC rules that rely on those tags.[^1]

[^1]:https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy