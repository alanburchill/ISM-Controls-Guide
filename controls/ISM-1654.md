---
permalink: /controls/ISM-1654.html
title: "Internet Explorer 11 is disabled or removed."
ism_control: "ISM-1654"
revision: "0"
updated: "Sep-21"
guideline: ""
section: "Operating system hardening"
topic: "Hardening operating system configurations"
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
date_generated: "2026-01-13"
---

# Internet Explorer 11 is disabled or removed.

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1654 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | Hardening operating system configurations |
| **Essential Eight** | ML1, ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Configure **Disable Internet Explorer 11 as a standalone browser (User)** via Intune and deploy **UserApplicationHardening-RemoveFeatures.ps1** using the Intune 'Scripts' option.[^1]

[^1]: [Essential Eight user application hardening - Essential Eight Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Design Decision

Use **Intune** to (1) configure **Disable Internet Explorer 11 as a standalone browser (User)** and (2) deploy **UserApplicationHardening-RemoveFeatures.ps1** via **Scripts**.

> [!NOTE]
> Deploying **UserApplicationHardening-RemoveFeatures.ps1** also disables .NET Framework 3.5 (includes .NET 2.0 and 3.0) and Windows PowerShell 2.0.

## Prerequisites

- **Permissions/Roles:** Access to Microsoft Intune to create and deploy a Settings Catalog policy; ability to assign the script to a deployment group.[^1]

- **Dependencies:** Ability to create and deploy a Settings Catalog policy; access to the script **UserApplicationHardening-RemoveFeatures.ps1**.[^1]

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Implementation Steps

### Configure Policy using Settings Catalog

1. Create a new **Settings Catalog** policy.[^1]
2. Search for **Disable Internet Explorer 11 as a standalone browser (User)**.
3. Go to Administrative Templates\Windows Components\Internet Explorer and select the setting: **Disable Internet Explorer 11 as a standalone browser (User)**.
4. Enable the setting **Disable Internet Explorer 11 as a standalone browser (User)**.
5. Deploy the policy to a set of devices or users.

### Deploy Script using Intune Scripts

1. Add **UserApplicationHardening-RemoveFeatures.ps1** as a PowerShell script using Intune **Scripts**.[^1]
2. Configure the script with the following options:[^1]

| Setting | Value |
| ------- | ----- |
| Run this script using the logged on credentials | No |
| Enforce script signature check | No |
| Run script in 64-bit PowerShell Host | No |

3. Assign the script to a deployment group.[^1]

> [!NOTE]
> This script also disables **.NET Framework 3.5** (includes **.NET 2.0** and **3.0**) and **Windows PowerShell 2.0**.

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Additional related information

- Internet Explorer 11 policy and management guidance explains how to disable IE11 with policy and management tooling [Internet Explorer Policy CSP](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-internetexplorer)[^2]

- Disable Internet Explorer 11 deployment guidance in enterprise environments covers steps to disable IE11 via policy and administration tools [Disable Internet Explorer 11 - Microsoft Learn](https://learn.microsoft.com/en-us/deployedge/edge-ie-disable-ie11)[^3]

- Disable Internet Explorer 11 from Intune community guidance describes deployment considerations via Intune Scripts for IE11 [Disable Internet Explorer 11 from Intune](https://learn.microsoft.com/en-us/answers/questions/873769/disable-internet-explorer-11-from-intune)[^4]

- ASD Blueprint: User application hardening describes Essential Eight guidance for user level hardening including IE11 considerations [ASD Blueprint: User application hardening](https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/)[^5]

[^2]: https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-internetexplorer
[^3]: https://learn.microsoft.com/en-us/deployedge/edge-ie-disable-ie11
[^4]: https://learn.microsoft.com/en-us/answers/questions/873769/disable-internet-explorer-11-from-intune
[^5]: https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/