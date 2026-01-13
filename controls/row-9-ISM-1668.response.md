---
title: "Microsoft Office is blocked from creating executable content."
ism_control: "ISM-1668"
revision: "0"
updated: "Sep-21"
guideline: ""
section: "User application hardening"
topic: "Hardening user application configurations"
essential_eight:
  - "ML2"
  - "ML3"
pspf_levels:
  - "NC"
  - "OS"
  - "P"
  - "S"
  - "TS"
date_generated: "2026-01-13"
---
# Microsoft Office is blocked from creating executable content.

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1668 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | User application hardening |
| **Topic** | Hardening user application configurations |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Configure **Block Office from creating executable content** via **Intune** and deploy **ScriptName.ps1** using policy import and assignment.[^1]

[^1]: [Intune endpoint security Attack surface reduction settings](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)

## Design Decision

Use **Microsoft Intune** to (1) configure **Block Office applications from creating executable content** and (2) deploy **ScriptName.ps1** via **Intune deployment**.

> [!NOTE]
> Deploying **ScriptName.ps1** also disables OLE activation for Office macros.

## Prerequisites

### Dependencies

- Administrative access to the Microsoft Intune console to create, import, and deploy policies and policy sets; and to assign to user groups such as All Office Users. [^2]
- Ability to create and deploy a policy set that combines Microsoft 365 Apps for Windows 10 and later with the ACSC Office Hardening policy; includes creating and linking policy objects. [^2]
- Access to the ACSC Office Hardening policy files and the ASR policy for import into Intune; saved locally for import steps. [^1]
- Availability of a PowerShell script (OfficeMacroHardening-PreventActivationofOLE-Office2013.ps1) to prevent activation of OLE in Office macros; and ability to run scripts in Intune (as a device management action). [^2]
- When using ASR to block Office executable content, plan for testing in audit mode before enforcement. [^1]
- Ability to install and deploy Microsoft 365 Apps for Windows 10 and later; architecture set to 64-bit (recommended). [^2]
- Create and target a deployment group named All Office Users for policy assignment. [^2]
- The ASR policy will be configured to **Block Office applications from creating executable content** as part of the implementation plan. [^3]

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^2]: [Essential Eight configure Microsoft Office macro settings - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-macro)

[^3]: [Intune endpoint security Attack surface reduction settings - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)

[^4]: [Settings you can manage with Intune Endpoint Protection profiles for Windows devices - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-protection-windows-10)

## Implementation Steps

### Configure ASR policy using Settings Catalog

1. Create a new **Settings Catalog** policy in Intune.  
2. Search for **Block Office applications from creating executable content** and enable it.  
3. Deploy the policy to target devices or users (e.g., All Office Users).  

| Setting | Value |
| ------- | ----- |
| **Block Office applications from creating executable content** | Enabled |

2. Note: ASR rules are configured in audit mode by default and should be tested for compatibility before enforcement.[^1]

### Import ASR policy using Graph Explorer

1. Open Microsoft Graph Explorer and authenticate.  
2. Copy the JSON from the ACSC Windows Hardening Guidelines-Attack Surface Reduction policy and paste it in the request body to import the policy.  
3. Save the policy and assign it to the deployment group (e.g., All Office Users).  
4. Verify that the policy includes the rule to block Office from creating executable content.  
5. Note: This approach imports the ASR policy as provided by ACSC; test in audit mode before enforcement.[^1]

> [^1]: [Essential Eight user application hardening](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Additional related information

- Defender for Endpoint Baseline guidance shows per-rule Attack Surface Reduction settings including Block Office applications from creating executable content and how to configure them in Intune [Settings list for the Microsoft Intune security baseline for Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-defender)

- ASD Blueprint: Microsoft Office hardening discusses ASR design decisions and Office hardening mappings like Block Office from creating executable content [ASD Blueprint: Microsoft Office hardening](https://blueprint.asd.gov.au/design/endpoints/windows/security/microsoft-office-hardening/)