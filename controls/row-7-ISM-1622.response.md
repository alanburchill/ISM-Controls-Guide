---
permalink: /controls-html/ISM-1622.html
title: "PowerShell is configured to use Constrained Language Mode. (ISM-1622)"
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
date_generated: "2026-01-08"
---
# PowerShell is configured to use Constrained Language Mode. (ISM-1622)

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

Enable Constrained Language Mode for PowerShell by enforcing a Windows Defender Application Control (WDAC) policy.[^3][^5] Deploy WDAC policies to cloud-managed devices using Intune; WDAC rules and policy updates are controlled via Intune.[^3][^6] Create WDAC policies via the WDAC Wizard (recommended) or via Configurable Code Integrity PowerShell cmdlets.[^1][^2]

[^1]: [Policy Rules and File Rules and Policy Creation](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control#essential-eight-application-control-using-wdac-for-ml2#Policy_rules_and_file_rules_and_policy_creation)
[^2]: [Policy_creation_methods](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control#essential-eight-application-control-using-wdac-for-ml2#Policy_creation_methods)
[^3]: [Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/#Windows Defender application control)
[^5]: [PowerShell restrictions under constrained language mode](https://learn.microsoft.com/en-us/powershell/scripting/security/app-control/how-app-control-works?view=powershell-7.5#powershell-restrictions-under-constrained-language-mode#PowerShell-restrictions-under-constrained-language-mode)
[^6]: [NoteWDAC](https://blueprint.asd.gov.au/design/platform/client/application-management/#NoteWDAC)

## Design Decision

> [!NOTE] Enable Constrained Language Mode for PowerShell by enforcing Windows Defender Application Control policies via Intune. This restricts PowerShell execution to approved language features on managed devices.

## Prerequisites

* **Dependencies:** WDAC (Windows Defender Application Control) must be available on Windows endpoints and configured to enforce Constrained Language Mode for PowerShell[^3][^5]. WDAC policy creation can be performed via PowerShell Config CI Cmdlets or the WDAC Wizard (recommended)[^1]. WDAC policies can be deployed via Intune for cloud-managed devices or Group Policy for hybrid devices[^3]. Audit mode must be used prior to enforcement when deploying WDAC[^3]. Intune can deploy configuration scripts and remediations to configure WDAC rules via the Intune management extension[^4]. Endpoint Manager deployments require WDAC rules; WDAC is used to restrict applications and is deployed via Intune or Endpoint Manager[^6].

[^1]: [Policy rules and file rules and policy creation](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control#essential-eight-application-control-using-wdac-for-ml2#Policy_rules_and_file_rules_and_policy_creation)
[^3]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/#Windows Defender application control)
[^4]: [Powershell Scripts and Remediations | ASD Windows hardening guidelines | Microsoft Intune - profile configurations | Security Baselines](https://blueprint.asd.gov.au/design/platform/client/device-security/)
[^5]: [How App Control works with PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/security/app-control/how-app-control-works?view=powershell-7.5#powershell-restrictions-under-constrained-language-mode#PowerShell-restrictions-under-constrained-language-mode)
[^6]: [Note | Windows Defender for Application Control (WDAC) is used to restricts the applications that users can run on Windows devices System Core (kernel). Applications deployed to Windows devices using Endpoint Manager need WDAC rules implemented as part of the deployment process.](https://blueprint.asd.gov.au/design/platform/client/application-management/#NoteWDAC)

## Implementation Steps

### Enable Constrained Language Mode via WDAC using Intune

1. Choose WDAC policy creation method:
   - There are two primary ways to create a WDAC policy: PowerShell Configurable Code Integrity Cmdlets or the WDAC Policy Wizard. [^1][^2]

2. Create the WDAC policy with the chosen method:
   - If using the WDAC Policy Wizard (recommended), use the wizard to create, edit, and merge policies; the tool uses the Config CI PowerShell cmdlets, and the output policy is equivalent to PowerShell-generated policy. [^2]
   - If using PowerShell, automate policy creation and policy XML generation with Config CI Cmdlets. [^1]

3. Configure the policy to enforce Constrained Language Mode for PowerShell:
   - Enable Script Enforcement in the policy. [^3]
   - Script Enforcement restricts PowerShell to Constrained Language Mode. [^5]

4. Enable Managed Installer support:
   - WDAC should enable Managed Installer so items deployed via a managed installer are added to the allow list. [^3]

5. Plan and execute deployment through Intune:
   - WDAC is controlled via Intune for cloud-managed devices. [^3]
   - Deploy WDAC policy through Intune; if needed, use Configuration Scripts or Remediations to apply policy updates. [^4]

6. Use Audit Mode before enforcement:
   - Deploy the policy in Audit Mode prior to switching to enforcement to observe behavior. [^3]

7. Refer to policy creation and WDAC design guidance as you implement:
   - For policy rules, file rules, and policy creation details, consult the WDAC policy documentation. [^1]
   - For Intune-based deployment approaches and remediation scripts, refer to the ASD platform guidance. [^4]

[^1]: [Policy rules and file rules and policy creation](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control#essential-eight-application-control-using-wdac-for-ml2#Policy_rules_and_file_rules_and_policy_creation)
[^2]: [Policy_creation_methods](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control#essential-eight-application-control-using-wdac-for-ml2#Policy_creation_methods)
[^3]: [Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/#Windows Defender application control)
[^4]: [Powershell Scripts and Remediations](https://blueprint.asd.gov.au/design/platform/client/device-security/)
[^5]: [PowerShell restrictions under constrained language mode](https://learn.microsoft.com/en-us/powershell/scripting/security/app-control/how-app-control-works?view=powershell-7.5#powershell-restrictions-under-constrained-language-mode)
[^6]: [NoteWDAC](https://blueprint.asd.gov.au/design/platform/client/application-management/#NoteWDAC)