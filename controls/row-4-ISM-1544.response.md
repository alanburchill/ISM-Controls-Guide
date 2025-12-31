---
title: "Microsoft’s recommended application blocklist is implemented. (ISM-1544)"
ism_control: "ISM-1544"
revision: "3"
updated: "Dec-23"
guideline: "Guidelines for system hardening"
section: "Operating system hardening"
topic: "Application control"
essential_eight:
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
# Microsoft’s recommended application blocklist is implemented. (ISM-1544)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1544 |
| **Revision** | 3 |
| **Updated** | Dec-23 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | Application control |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

App Control for Business (WDAC) enforces the Microsoft-recommended application blocklist by restricting which drivers and applications may run on Windows devices. Implement WDAC policies using App Control for Business, via built-in controls or custom XML, and deploy them with Intune's App Control for Business policies and a managed installer to tag approved apps. Audit mode allows testing without blocking, while Enforce mode enforces the policy. [^1][^2][^5]

[^1]:Use App Control to secure PowerShell - PowerShell | Microsoft Learn(https://learn.microsoft.com/en-us/powershell/scripting/security/app-control/application-control?view=powershell-7.5)
[^2]:Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)
[^5]:Windows 11 Security Book - Application And Driver Control | Microsoft Learn(https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control)

## Design Decision

> [!NOTE] App Control for Business will be used to implement WDAC policies, deployed via Intune to define and enforce the approved apps and drivers baseline. This design aligns with the ImplementationGuidance to use App Control for Business for WDAC.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^2]

* **Permissions/Roles:** An Intune RBAC-enabled account is required to manage App Control for Business policies. Enable use of a managed installer requires the Intune Administrator role. Manage App Control for Business policy requires the App Control for Business permission (Delete, Read, Assign, Create, Update, and View Reports) or Organization permission with Read to view reports. [^2]

* **Dependencies:** Windows 10 includes App Control for Business. Windows Server 2022 and Windows 11 and later versions support App Control for Business contexts. An Intune environment with App Control for Business policies and the Intune Management Extension as a managed installer is required. For In-Memory OLTP scenarios, the Hekaton DLL generator must be designated as a WDAC Managed Installer. [^1][^2][^3]

[^1]:Use App Control to secure PowerShell - PowerShell | Microsoft Learn (https://learn.microsoft.com/en-us/powershell/scripting/security/app-control/application-control?view=powershell-7.5)
[^2]:Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune - Microsoft Intune | Microsoft Learn (https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)
[^3]:Create In-Memory OLTP App Control and Managed Installer Policies - SQL Server | Microsoft Learn (https://learn.microsoft.com/en-us/sql/relational-databases/in-memory-oltp/create-in-memory-oltp-app-control-managed-installer?view=sql-server-ver17)

## Implementation Steps

### Create App Control for Business base policy (WDAC)

1. Sign in to the [Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431). Navigate to **Endpoint security** > **App Control for Business** > select the **App Control for Business** tab > and then select **Create Policy**.[^1]

2. On the **Basics** page, enter:

   - **Name**: a descriptive profile name.
   - **Description**: optional description.

   These help identify policies later.[^1]

3. On **Configuration settings**, choose a configuration settings format:

   - **Enter xml data** or **Built-in controls**. The choice defines how trust rules are specified.[^1]

4. On the **Scope tags** page, select any desired scope tags to apply, then select **Next**.[^1]

5. For **Assignments**, select the groups that should receive the policy, then select **Next**.[^1]

6. For **Review + create**, review your settings and then select **Create**. The policy is saved and appears in the policy list.[^1]

### Create a supplemental App Control for Business policy (XML)

1. Use the Windows Defender Application Control Wizard or PowerShell cmdlets to generate an App Control for Business policy in XML format. To learn about the Wizard, see aka.ms/wdacWizard or Microsoft WDAC Wizard.[^1]

2. After your App Control for Business supplemental policy is created in XML format, sign in to the [Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) and go to **Endpoint security** > **App Control for Business** > select the **App Control for Business** tab, and then select **Create Policy**.[^1]

3. On **Basics**, enter the same properties as for the base policy:

   - **Name**: descriptive name for the supplemental policy.
   - **Description**: optional description.

   These help identify policies later.[^1]

4. On **Configuration settings**, for **Configuration settings format** select **Enter xml data** and upload your XML file. The supplemental policy XML must reference the base policy ID.[^1]

5. For **Assignments**, select the same groups as assigned to the base policy, and then select **Next**.[^1]

6. For **Review + create**, review your settings and then select **Create**. The supplemental policy is saved and appears in the policy list.[^1]

### Add a managed installer to your tenant

1. In the [Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), go to **Endpoint security** > **App Control for Business** > select the **Managed installer** tab and then select **Create**. The *Create Managed Installer Policy* workflow opens.[^1]

2. On the **Basics** page, enter:

   - **Name**: a descriptive name for the policy.
   - **Description**: optional description.

   These help identify policies later.[^1]

3. On **Settings**, set **Enable Intune Managed Extension as Managed Installer** to **Enabled** (the default). When enabled, devices with this policy use the managed installer. When disabled, the device doesn't actively use the managed installer.[^1]

4. On the **Scope tags** page, optionally select scope tags to apply, then select **Next**.[^1]

5. For **Assignments**, select the groups to receive the policy, then select **Next**.[^1]

6. For **Review + create**, review your settings and then select **Create**. The policy is saved and deployed to the assigned groups. It may take up to 10 minutes to appear in the tenant, and up to 30 minutes for delivery to devices.[^1]

### Remove the Intune Management Extension as a managed installer

#### Disable the Intune Managed Extension policy (required)

1. In the Intune admin center, go to **Endpoint security** > **App Control for Business** > select the **Managed installer** tab, and then select the policy you want to edit.

2. Edit the policy, and change **Enable Intune Managed Extension as Managed Installer** to **Disabled**, then save. New devices won't be configured with the Intune Management Extension as a managed installer. Devices already configured remain unaffected by this change.[^1]

#### Remove the Intune Management Extension as a managed installer on devices (optional)

1. Download the CatCleanIMEOnly.ps1 PowerShell script. This script is available at [CatCleanIMEOnly.ps1](https://aka.ms/intune_WDAC/CatCleanIMEOnly) from download.microsoft.com. Use Intune to run PowerShell scripts or other methods to deploy this script.[^1]

2. Run the script on devices that have the Intune Management Extension set as a managed installer. This script removes only the Intune Management Extension as a managed installer. Restart the Intune Management Extension service for changes to take effect.[^1]

3. After cleanup, you can verify the removal by checking policy status on devices. For manual cleanup outside Intune, refer to the Windows Security documentation.[^1]

> Note: The WDAC policy must still allow apps as configured; removing the managed installer does not automatically reconfigure WDAC rules.[^1]

[^1]:Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune(https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)