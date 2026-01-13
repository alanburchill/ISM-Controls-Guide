---
permalink: /controls/ISM-1655.html
title: ".NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed."
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
date_generated: "2026-01-13"
---

# .NET Framework 3.5 (includes .NET 2.0 and 3.0) is disabled or removed.

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

Disable or remove **.NET Framework 3.5 (includes .NET 2.0 and 3.0)** via deployment and deploy **UserApplicationHardening-RemoveFeatures.ps1** using the **InTune Scripts** option.[^1]

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Design Decision

Use **Microsoft Intune** to (1) configure **.NET Framework 3.5 (includes .NET 2.0 and 3.0) Disabled or Removed** and (2) deploy **UserApplicationHardening-RemoveFeatures.ps1** via **InTune 'Scripts' option**.

> [!NOTE]
> Deploying **UserApplicationHardening-RemoveFeatures.ps1** also disables **.NET Framework 3.5 (includes .NET 2.0 and 3.0)**.

## Prerequisites

- **Dependencies:** Access to the **UserApplicationHardening-RemoveFeatures.ps1** PowerShell script; the script turns off the .NET Framework 3.5 (includes .NET 2.0 and 3.0) feature, if installed.[^1]

[^1]: [Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Implementation Steps

### Deploy Script using Intune Scripts

1. Add **UserApplicationHardening-RemoveFeatures.ps1** as a PowerShell script using Intune Scripts.[^1]
2. Deploy the script to target devices using Intune Scripts.[^1]
3. The script disables the **.NET Framework 3.5** (includes .NET 2.0 and 3.0) feature, if installed.[^1]

> [!NOTE]
> Not provided in source documentation.

[^1]: [Essential Eight user application hardening - Essential Eight](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Additional related information

- ASD Blueprint for User Application Hardening provides essential eight guidance on hardening user applications and practical implementation considerations [ASD Blueprint: User application hardening](https://blueprint.asd.gov.au/security-and-governance/essential-eight/user-application-hardening/).[^2]