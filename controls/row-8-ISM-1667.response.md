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
date_generated: "2026-01-15"
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

This control blocks all Office applications from creating child processes, reducing the attack surface by preventing Office from spawning subprocesses that could be abused for code execution or malware propagation[^1][^8]. Implementation is achieved by importing the ASR policy for Office child process blocking into Intune, as documented in the ACSC Windows Hardening Guidelines[^1].

### Justification

Not provided in source documentation.

[^1]: Essential Eight user application hardening (https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)
[^8]: Attack surface reduction policy settings for endpoint security in Intune (https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)

## Design Decision

> [!NOTE]
> The **Block all Office applications from creating child processes** ASR rule will be enabled via **Intune configuration profiles**. This will block Office applications from creating child processes.

## Prerequisites

- **Licensing:** Microsoft Intune Plan 1 licensing for target devices (typically in Microsoft 365 E3+)[^1]

- **Permissions/Roles:** 
  - Devices must be enrolled in Entra ID (Azure AD) and managed by **Intune**[^1]
  - Access to **Graph Explorer** for authentication and policy import to paste the ASR policy JSON[^1]

- **Dependencies:** 
  - Access to the ACSC Windows Hardening Guidelines ASR policy JSON (Attack Surface Reduction) from the ACSC guidelines to import into Intune[^1]
  - The ASR policy is deployed via an **Intune Endpoint Security** policy; plan for ASR deployment readiness[^1]
  - Plan to test ASR rules in audit mode before enforcement to verify compatibility[^1]

[^1]: [Essential Eight user application hardening](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Implementation Steps

### Enable ASR rule to block Office apps from creating child processes via Intune

1. Navigate to Graph Explorer and authenticate.[^1]
2. Copy the JSON in the **ACSC Windows Hardening Guidelines-Attack Surface Reduction.json** policy and paste it in the request body. The policy contains the specific ASR rule: **Block all Office applications from creating child processes** (D4F940AB-401B-4EFC-AADC-AD5F3C50688A). This ASR policy configures each of the ASR rules recommended by the ACSC in audit mode. ASR rules should be tested for compatibility issues in any environment before enforcement.[^1]
3. (Optional) modify the name value if necessary.[^1]

> [!NOTE]
> This implementation imports the ASR policy in audit mode to validate compatibility before enforcement.[^1]

[^1]: Essential Eight user application hardening (https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

## Additional related information

- Windows MDM security baseline settings reference for Microsoft Intune provides Defender baseline controls and ASR guidance, including blocking Office applications from creating child processes [Windows MDM security baseline settings reference for Microsoft Intune (mdm-august-2020)](https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-mdm-all)
- Block Office communication application from creating child processes rule details, including GUID and deployment guidance for Intune/ Defender for Endpoint [Block Office communication application from creating child processes](https://github.com/MicrosoftDocs/defender-docs/blob/public/defender-endpoint/attack-surface-reduction-rules-reference.md)
- ASD Blueprint: Microsoft Office hardening provides architecture-level guidance for hardening Office deployments with Defender for Endpoint and Intune policies [ASD Blueprint: Microsoft Office hardening](https://blueprint.asd.gov.au/design/endpoints/windows/security/microsoft-office-hardening/)
- Windows 365 Cloud PC security baseline settings reference for Microsoft Intune describes ASR policy and Office hardening coverage for Cloud PCs [Windows 365 Cloud PC security baseline settings reference for Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-windows-365)