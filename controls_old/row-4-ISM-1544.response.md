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
date_generated: "2026-01-06"
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

Implement WDAC by using App Control for Business to enforce Microsoft’s recommended application blocklist on Windows devices. App Control for Business is the preferred Windows application control solution over AppLocker and provides policy APIs to configure trusted apps and drivers[^1]. Intune App Control for Business policies enable a managed installer and tagging of apps deployed by Intune, which WDAC uses to identify approved software across devices[^2].

## Design Decision

> [!NOTE] Use App Control for Business to implement WDAC policies, managed via Intune, to enforce Microsoft-recommended WDAC deployment with a managed installer workflow.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^3]

* **Permissions/Roles:** 
  1. Intune Administrator role required to enable the Intune managed installer. [^2]
  2. App Control for Business permission (includes rights for Delete, Read, Assign, Create, Update, and View Reports). [^2]
  3. To view reports for App Control for Business policy, accounts must have either App Control for Business permission with View Reports or Organization permission with Read. [^2]

* **Dependencies:** 
  Windows 10 or later (App Control for Business introduced in Windows 10); Intune service for App Control for Business policies; Intune Management Extension as a managed installer; RBAC for Intune App Control for Business policy management. [^1] [^2]

## Implementation Steps

### Create an App Control for Business policy

Use the following procedure to create a base App Control for Business policy for WDAC. This base policy can be expanded with supplemental policies.

1. Sign in to the Microsoft Intune admin center and go to **Endpoint security** > **App Control for Business** > select the **App Control for Business** tab > and then select **Create Policy**. App Control for Business policies are automatically assigned a platform type.[^2]

2. On **Basics**, enter the following properties:

   - **Name**: Enter a descriptive name for the profile. Name profiles so you can easily identify them later.
   - **Description**: Enter a description for the profile. This setting is optional but recommended.

3. On **Configuration settings**, choose a **Configuration settings format**:

   - **Enter xml data** – When you choose to enter XML data, you must provide the policy with a set of custom XML properties that define your App Control for Business policy. If you select this option but don't add XML properties to the policy, it acts as Not configured. An App Control for Business policy that isn't configured results in default behaviors on a device, with no added options from the ApplicationControl CSP.
   - **Built-in controls** – With this option you can easily approve all apps that are installed by a managed installer, and allow trust of Windows components and store apps. The following options are available:
     - **Enable trust of Windows components and store apps** – When this setting is *Enabled* (the default), managed devices can run Windows components and store apps, as well as other apps you might configure as trusted. Apps that aren't defined as trusted by this policy are blocked from running.
     - This setting also supports an *Audit only* mode. With audit mode, all events are logged in the local client logs, but apps aren't blocked from running.
     - **Select additional options for trusting apps** – For this setting you can select one or both of the following options:
       + **Trust apps with a good reputation** – This option allows devices to run reputable apps as defined by the Microsoft Intelligent Security Graph.
       + **Trust apps from managed installers** – This option allows devices to run the apps that were deployed by a managed installer. Behavior for all other apps and files that aren’t specified by rules in this policy depend on the configuration of *Enable trust of Windows components and store apps*:
         - If *Enabled*, files and apps are blocked from running on devices.
         - If set to *Audit only*, files and apps are audited only in local client logs.

4. On the **Scope tags** page, select any desired scope tags to apply, then select **Next**.

5. For **Assignments**, select the groups that receive the policy, but consider that WDAC policies apply to only the device scope. To continue, select **Next**.

6. For **Review + create**, review your settings and then select **Create**. When you select *Create*, your changes are saved, and the policy is assigned. The policy is also shown in the policy list.  

### Use supplemental policy

One or more supplemental policies can help expand the base policy to increase the circle of trust.

1. Use the Windows Defender Application Control Wizard or PowerShell cmdlets to generate an App Control for Business policy in XML format. To learn about the Wizard, see aka.ms/wdacWizard or Microsoft WDAC Wizard. When you create a policy in XML format, it must reference the *Policy ID* of the base policy. 

2. After your App Control for Business supplemental policy is created in XML format, sign in to the Microsoft Intune admin center and go to **Endpoint security** > **App Control for Business** > select the **App Control for Business** tab, and then select **Create Policy**.

3. On **Basics**, enter the following properties:
   - **Name**: Enter a descriptive name for the profile.
   - **Description**: Enter a description for the profile. This setting is optional but recommended.

4. On **Configuration settings**, for **Configuration settings format** select **Enter xml data** and upload your XML file.

5. For **Assignments**, select the same groups as assigned to the base policy you want the supplemental policy to apply to, and then select **Next**.

6. For **Review + create**, review your settings and then select **Create**. When you select *Create*, your changes are saved, and the policy is assigned. The policy is also shown in the policy list.

### Notes and references

- App Control for Business policies are an implementation of WDAC. To learn more, see the Windows Defender Application Control documentation and the Intune App Control for Business policies guidance.[^2]

## References

[^1]: [Use App Control to secure PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/security/app-control/application-control?view=powershell-7.5)

[^2]: [Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)

[^3]: [Windows edition and licensing requirements](https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control#windows-edition-and-licensing-requirements)
