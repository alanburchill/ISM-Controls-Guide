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
date_generated: "2026-01-06"
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

Enable the Attack Surface Reduction rule that blocks Office applications from creating executable content by deploying an Intune ASR policy.[^1] This approach aligns with the Essential Eight user application hardening guidance and Defender for Endpoint baselines.[^2][^3] By preventing Office from creating executable content, the configuration reduces risk from Office macros and other executable content.[^3] 

## Design Decision

> [!NOTE] Enable the ASR rule to block Office applications from creating executable content via Intune. This aligns with the control objective to prevent Microsoft Office from creating executable content.

## Prerequisites

* **Licensing:** Not provided in source documentation. [^1]
* **Permissions/Roles:** Not provided in source documentation. [^1]
* **Dependencies:** Not provided in source documentation. [^1]

## Implementation Steps

### Enable ASR rule to block Office apps from creating executable content via Intune

1. Open Graph Explorer and authenticate.  
2. Create a POST request, using the beta schema to the Attack Surface Reduction policy endpoint:  
   https://graph.microsoft.com/beta/deviceManagement/templates/0e237410-1367-4844-bd7f-15fb0f08943b/createInstance
3. Copy the JSON in the ACSC Windows Hardening Guidelines Attack Surface Reduction policy and paste it into the request body. The policy includes the ASR rule to block Office applications from creating executable content. [^1]
4. (Optional) modify the name value as necessary.

## References

[^1]: [Intune endpoint security Attack surface reduction settings - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-asr-profile-settings)

[^2]: [Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^3]: [Settings list for the Microsoft Intune security baseline for Microsoft Defender for Endpoint - Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/security-baseline-settings-defender)
