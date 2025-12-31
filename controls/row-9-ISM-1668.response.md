---
title: "Microsoft Office is blocked from creating executable content. (ISM-1668)"
ism_control: "ISM-1668"
revision: "0"
updated: "Sep-21"
guideline: "Guidelines for system hardening"
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
date_generated: "2025-12-25"
---
# Microsoft Office is blocked from creating executable content. (ISM-1668)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1668 |
| **Revision** | 0 |
| **Updated** | Sep-21 |
| **Guideline** | Guidelines for system hardening |
| **Section** | User application hardening |
| **Topic** | Hardening user application configurations |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

Microsoft Office is blocked from creating executable content by enabling the ASR rule via Intune.^[^1] Configure the Attack Surface Reduction setting Block Office applications from creating executable content in the Intune Endpoint Security policy.^[^1] This approach aligns with Essential Eight user application hardening guidance.^[^2]

## Design Decision

> [!NOTE] Enable the ASR rule to block Office applications from creating executable content via Intune.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^2]
* **Dependencies:** Not provided in source documentation. [^3]

[^1]:Intune endpoint security Attack surface reduction settings - Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)
[^2]:Essential Eight user application hardening - Essential Eight | Microsoft Learn(https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)
[^3]:Default configuration of Intune's Windows security baselines - Microsoft Intune | Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-mdm-all)

## Implementation Steps

### Enable ASR rule to block Office executable content

1. Open Graph Explorer and authenticate.[^2]

2. Create a POST request, using the beta schema to the Attack Surface Reduction policy endpoint:
   https://graph.microsoft.com/beta/deviceManagement/templates/0e237410-1367-4844-bd7f-15fb0f08943b/createInstance
   This creates a new ASR policy instance.[^2]

3. Copy the JSON from the ACSC Windows Hardening Guidelines Attack Surface Reduction policy and paste it into the request body. The referenced policy is available remotely:
   [ACSC Windows Hardening Guidelines-Attack Surface Reduction.json](https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/policies/ACSC%20Windows%20Hardening%20Guidelines-Attack%20Surface%20Reduction.json) . By importing this ASR Rule profile, Microsoft Office is blocked from creating executable content (3B576869-A4EC-4529-8536-B80A7769E899) and injecting code into other processes. [^2]

4. (Optional) Modify the *name* value in the request body if necessary. [^2]

> Notes
> - The ASR rule to block Office from creating executable content is part of the ACSC-recommended Attack Surface Reduction settings. The underlying policy references the executable-content block rule (3B576869-A4EC-4529-8536-B80A7769E899). [^1][^2]
> - This section mirrors the implementation approach described for blocking Office from creating executable content via an Intune ASR policy import. [^2]

[^1]: Intune endpoint security Attack surface reduction settings - Microsoft Learn(https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)
[^2]: ACSC Windows Hardening Guidelines-Attack Surface Reduction.json - Microsoft Intune ACSC guidelines(https://github.com/microsoft/Intune-ACSC-Windows-Hardening-Guidelines/blob/main/policies/ACSC%20Windows%20Hardening%20Guidelines-Attack%20Surface%20Reduction.json)