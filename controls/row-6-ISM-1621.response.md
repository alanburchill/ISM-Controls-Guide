---
permalink: /controls-html/ISM-1621.html
title: "Windows PowerShell 2.0 is disabled or removed. (ISM-1621)"
ism_control: "ISM-1621"
revision: "1"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
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
date_generated: "2025-12-25"
---
# Windows PowerShell 2.0 is disabled or removed. (ISM-1621)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1621 |
| **Revision** | 1 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | PowerShell |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Windows PowerShell 2.0 is disabled or removed by deploying the UserApplicationHardening-RemoveFeatures.ps1 script.[^1] Deploy this script via Intune Remediations, which packages a detection script and a remediation script; the remediation runs only when the detection script reports the issue by exiting with code 1, and the scripts must be encoded in UTF-8.[^2] Configure Remediations with the following settings: Run this script using the logged-on credentials = No; Enforce script signature check = No; Run script in 64-bit PowerShell = No, and assign the remediation package to device groups or run on-demand as needed.[^2]

[^1]:Essential Eight user application hardening - Essential Eight(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)
[^2]:Use Remediations to Detect and Fix Support Issues - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/remediations)

## Design Decision

> [!NOTE] The design uses the provided UserApplicationHardening-RemoveFeatures.ps1 script, deployed via Intune Remediation Scripts, to disable or remove Internet Explorer 11, .NET Framework 3.5 (including 2.0 and 3.0), and Windows PowerShell 2.0, per ImplementationGuidance. Create a script package in Intune Remediations containing a detection script (exit code 1 when the issue is detected) and the remediation script; configure Run this script using the logged on credentials: No, Enforce script signature check: No, Run script in 64-bit PowerShell Host: No, and assign the package to the deployment group.

## Prerequisites

* **Licensing:** Windows Enterprise E3 or E5 (included in Microsoft 365 F3, E3, or E5); Windows Education A3 or A5 (included in Microsoft 365 A3 or A5); Windows Virtual Desktop Access (VDA) per user. [^2]

* **Permissions/Roles:** Intune administrator or a role with Run remediation permission (Remote tasks) to deploy Remediations; Run remediation on-demand requires this permission. [^2]

* **Dependencies:** 
  - UserApplicationHardening-RemoveFeatures.ps1 script to disable Windows PowerShell 2.0 and other features. [^1]
  - Remediations in Intune deploy script packages consisting of detection and remediation scripts; built-in script packages can be used for common items. [^2]

[^1]:Essential Eight user application hardening - Essential Eight | Microsoft Learn(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)
[^2]:Use Remediations to Detect and Fix Support Issues - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/remediations)

## Implementation Steps

### Deploy UserApplicationHardening-RemoveFeatures.ps1 via Intune Remediations

Not provided in source documentation.