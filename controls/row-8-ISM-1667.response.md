---
title: "Microsoft Office is blocked from creating child processes."
ism_control: "ISM-1667"
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
# Microsoft Office is blocked from creating child processes.

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1667 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | User application hardening |
| **Topic** | Hardening user application configurations |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Configure **Block all Office applications from creating child processes** via Intune Endpoint Security Attack Surface Reduction rules and deploy **ScriptName.ps1** using **Intune policy deployment**.[^1]

[^1]: [Enable attack surface reduction rules - Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/defender-endpoint/enable-attack-surface-reduction)

## Design Decision

Use **Microsoft Defender for Endpoint** to (1) configure **Block all Office applications from creating child processes** and (2) deploy **ScriptName.ps1** via **Intune**.

> [!NOTE]
> Deploying **ScriptName.ps1** also disables **Other Feature**.

## Prerequisites

- **Permissions/Roles:** Sign in to Microsoft Defender XDR and have permission to create and manage Endpoint security policies (Windows Attack Surface Reduction rules).[^1]

- **Permissions/Roles:** Access to Microsoft Intune / Endpoint Manager to create and deploy ASR policies via Configuration profiles in Intune.[^2]

- **Permissions/Roles:** Target devices must be Windows 10, Windows 11, or Windows Server.[^1]

[^1]: [Manage Microsoft Defender Antivirus by using Defender for Endpoint Security Settings Management](https://learn.microsoft.com/en-us/defender-endpoint/mde-security-settings-management)
[^2]: [Intune endpoint security Attack surface reduction settings](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)

## Implementation Steps

### Configure ASR policy using Settings Catalog in Intune

1. In Intune, navigate to Endpoint Security > Attack surface reduction. Create a new policy or edit an existing one.[^1]

2. If creating a new policy, set the policy type to **Attack Surface Reduction Rules** and provide a name and description.[^1]

3. In the Configuration settings pane, select **Attack Surface Reduction** and then select the setting **Block all Office applications from creating child processes** and set it to **Block**.[^1]

4. Under the lists for exclusions (List of additional folders that need to be protected, List of apps that have access to protected folders, and Exclude files and paths from attack surface reduction rules), enter individual files and folders or import a CSV file with exclusions. Each line should be formatted as described in the UI instructions.[^1]

5. Save the policy and deploy it to the target devices or users.[^1]

| Setting | Value |
| ------- | ----- |
| **Block all Office applications from creating child processes** | **Block** |

> [!NOTE]
> Tip: Any of the rules might block behavior you find acceptable in your organization. In these cases, add the per-rule exclusions named "Attack Surface Reduction Only Exclusions." Additionally, change the rule from Enabled to Audit to prevent unwanted blocks. For more information, see Attack surface reduction rules deployment overview.[^2]

### Configure ASR policy using Defender for Endpoint UI

1. Sign in to Microsoft Defender XDR.[^2]

2. Go to Endpoints > Configuration management > Endpoint security policies > Windows policies > Create new policy.[^2]

3. From the Platform drop-down, select Windows 10, Windows 11, and Windows Server.[^2]

4. From the Template drop-down, select **Attack Surface Reduction Rules**.[^2]

5. Select Create policy. The Create a new policy page appears.[^2]

6. On the Basic page, enter a name and description for the profile, then select Next.[^2]

7. On the Configuration settings page, expand the groups of settings and configure the settings that you want to manage with this profile. From these groups, configure the setting **Block all Office applications from creating child processes** to **Block**.[^2]

8. Save the policy and assign it to a deployment group.[^2]

9. If the policy blocks legitimate behavior, add per-rule exclusions named **Attack Surface Reduction Only Exclusions** or switch the rule to Audit mode to observe impact before enforcing. [^2]

10. Note: This ASR rule is controlled via the GUID: D4F940AB-401B-4EFC-AADC-AD5F3C50688A. The rule corresponds to blocking Office applications from creating child processes.[^3]

11. Reference guidance and alignment notes: This policy aligns with ACSC recommendations and the Essential Eight, which include blocking Office apps from creating child processes as part of ASR hardening.[^5] Also, see ASD Office hardening guidance for additional context.[^4]

[^1]: [Enable attack surface reduction rules - Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/defender-endpoint/enable-attack-surface-reduction)
[^2]: [Attack Surface Reduction rules - Defender for Endpoint Security Settings Management](https://learn.microsoft.com/en-us/defender-endpoint/mde-security-settings-management)
[^3]: [Intune endpoint security Attack surface reduction settings](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)
[^4]: [ASD Blueprint: Microsoft Office hardening](https://blueprint.asd.gov.au/design/endpoints/windows/security/microsoft-office-hardening/)
[^5]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Additional related information

- Security advisory 4053440 outlines ASR capabilities for Office apps, including blocking child processes and related hardening guidance [Security Advisory 4053440](https://learn.microsoft.com/en-us/security-updates/securityadvisories/2017/4053440)