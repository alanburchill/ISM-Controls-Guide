---
title: "PowerShell is configured to use Constrained Language Mode."
ism_control: "ISM-1622"
revision: "0"
updated: "Oct-20"
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
# PowerShell is configured to use Constrained Language Mode.

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1622 |
| **Revision** | 0 |
| **Updated** | Oct-20 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | PowerShell |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Configure **PowerShell** to use **Constrained Language Mode** by implementing an enforce policy with **Windows Defender Application Control (WDAC)** and deploying it through **Intune**.[^1]

[^1]: [Essential Eight application control - Essential Eight - Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control)

## Design Decision

Use **Windows Defender Application Control** to configure **Constrained Language Mode** and deploy WDAC enforcement via **Intune**.

> [!NOTE]
> Deploying **ScriptName.ps1** also disables **Audit Policy**.

## Prerequisites

- **Licensing:** If the implementation uses Microsoft Intune to configure devices (e.g., deploying WDAC policies), target devices require Microsoft Intune Plan 1 licensing at minimum.[^1]

- **Permissions/Roles:** Access to the Microsoft Intune admin center to create and deploy a WDAC configuration profile for Windows 10 or later (Profile Type: Templates and Custom) in Configuration Profiles.[^2]

- **Dependencies:** Ability to create and deploy a WDAC policy via Intune, including:
  - Creating a policy XML and generating the CIP file, then renaming the CIP to BIN as needed;
  - Uploading the BIN under Base64 (File) in the Configuration Profile;
  - Deploying the Configuration Profile to the intended systems.[^3]

[^1]: [Guidelines for system hardening](https://www.cyber.gov.au/business-government/asds-cyber-security-frameworks/ism/cyber-security-guidelines/guidelines-for-system-hardening)
[^2]: [Essential Eight application control - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control)
[^3]: [Extension support for the management of Windows Defender Application Control (WDAC) enforced infrastructure](https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/extend/guides/application-control-infrastructure-extensions)

## Implementation Steps

### Create and Deploy WDAC Enforce Policy Using Windows Defender App Control Wizard and Intune

1. Open the **Windows Defender App Control Wizard** and select **Policy Editor**.[^1]
2. Create a new policy and switch to **Enforce** mode for WDAC.  
   Note: This disables Audit Mode to enable Constrained Language Mode for PowerShell.[^3]
3. Save the policy. The Wizard creates a CIP file. Copy this CIP file and rename the extension to **.BIN**.[^1]
4. In Microsoft Endpoint Manager Admin Center, go to **Devices** and then **Configuration Profiles**. Create a profile for Platform **Windows 10 or Later**, Profile Type **Templates and Custom**.[^1]
5. Create a name for the policy, for example, **Application Control – Enforce Policy**, and select Next.[^1]
6. Under **OMA-URI Settings**, select Add. Provide the policy as a **Base64 (File)** and reference the renamed **.BIN** file.[^1]
7. Save the profile and follow the prompts to create the Configuration Profile. Deploy the profile to the intended deployment group.[^1]
8. Exclude the previously created **Application – Audit Policy** from the intended system when switching to enforce.[^1]

### Validate WDAC Enforcement Status and Constrained Language Mode

1. After deployment, verify WDAC enforcement status using the Windows Admin Center WDAC extension. If the check reports that the PowerShell language mode is Constrained Language (PSLanguageMode.ConstrainedLanguage), WDAC is enforced.[^2]
2. Alternatively, verify that **PowerShell** is operating in **Constrained Language Mode** on targeted endpoints using Defender for Endpoint and related logging. Centralized logging of WDAC events supports validation.[^3]

[^1]: [Essential Eight application control - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control)
[^2]: [Extension support for the management of Windows Defender Application Control (WDAC) enforced infrastructure | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/extend/guides/application-control-infrastructure-extensions)
[^3]: [Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Additional related information

- ASD Blueprint for User application hardening provides guidance on WDAC and Constrained Language Mode in enterprise deployments [ASD Blueprint: User application hardening](https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/)

- Guidelines for system hardening outlines Constrained Language Mode and WDAC-related controls for PowerShell hardening [Guidelines for system hardening](https://www.cyber.gov.au/business-government/asds-cyber-security-frameworks/ism/cyber-security-guidelines/guidelines-for-system-hardening)