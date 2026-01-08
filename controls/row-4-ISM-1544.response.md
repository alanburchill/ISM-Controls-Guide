---
permalink: /controls-html/ISM-1544.html
title: "Microsoft’s recommended application blocklist is implemented. (ISM-1544)"
ism_control: "ISM-1544"
revision: "3"
updated: "Dec-23"
guideline: ""
section: "Operating system hardening"
topic: "Application control"
essential_eight:
  - "ML2"
  - "ML3"
pspf_levels:
  - "NC"
  - "OS"
  - "P"
  - "S"
  - "TS"
date_generated: "2026-01-08"
---
# Microsoft’s recommended application blocklist is implemented. (ISM-1544)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1544 |
| **Revision** | 3 |
| **Updated** | Dec-23 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | Application control |
| **Essential Eight** | ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

WDAC enforces application control on Windows endpoints by restricting execution to an approved set. Implement WDAC using App Control for Business to configure and deploy policies delivered through Intune, leveraging a combination of hash, publisher certificate, and path rules; enable Script Enforcement, Store Applications, and Dynamic Code Security, and enable Managed Installer. Begin in audit mode before enforcement, and apply Microsoft blocklists (e.g., Microsoft’s recommended application blocklist and Microsoft’s vulnerable driver blocklist) to align with the Essential Eight.  

[^2]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)  
[^4]: [Application control](https://blueprint.asd.gov.au/security-and-governance/essential-eight/application-control/)

## Design Decision

> [!NOTE] WDAC will be implemented using Windows Defender Application Control policies managed through Intune to enforce application control on Windows endpoints.

## Prerequisites

- **Dependencies:** Windows Defender Application Control (WDAC) is used to enforce application control on Windows workstations and is configured via Microsoft Intune for cloud-managed devices or via Group Policy for hybrid devices. [^1]

[^1]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)

## Implementation Steps

### WDAC deployment using App Control for Business via Intune

1. Plan deployment using App Control for Business (WDAC) via Intune for cloud-managed devices; for hybrid devices, configure via Group Policy.[^1]

2. Deploy WDAC in audit mode first to verify compatibility and capture policy-violation events before enforcing.[^1]

3. Create a WDAC policy that uses a combination of hash, publisher certificate, and path rules to define trusted software.[^1]

4. Leverage managed installers to populate the allow list; items deployed via the managed installer are added to the allow list.[^1]

5. Enable Script Enforcement and Constrained Language mode for Windows PowerShell to restrict script execution.[^1]

6. Enforce Windows Hardware Quality Labs signing for drivers; require EV signers for drivers; block unsigned drivers.[^1]

7. Apply blocklists as part of the WDAC policy, including Microsoft’s recommended application blocklist and Microsoft’s vulnerable driver blocklist.[^1]

8. Configure Update Policy No Reboot to allow policy updates without requiring a reboot.[^1]

9. Validate in audit mode, then transition to enforcement; monitor WDAC events and centralize logging for analysis (e.g., forward events to Log Analytics) per Essential Eight guidance.[^2]

[^1]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)
[^2]: [Application control](https://blueprint.asd.gov.au/security-and-governance/essential-eight/application-control/)