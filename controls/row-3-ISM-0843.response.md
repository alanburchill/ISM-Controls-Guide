---
title: "Application control is implemented on workstations. (ISM-0843)"
ism_control: "ISM-0843"
revision: "9"
updated: "Sep-21"
guideline: ""
section: "Operating system hardening"
topic: "Application control"
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
date_generated: "2026-01-08"
---
# Application control is implemented on workstations. (ISM-0843)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-0843 |
| **Revision** | 9 |
| **Updated** | Sep-21 |
| **Guideline** | Not provided |
| **Section** | Operating system hardening |
| **Topic** | Application control |
| **Essential Eight** | ML1, ML2, ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

App Control for Business enforces application trust on Windows endpoints by allowing only verified apps and drivers to run. Configure WDAC policies through Intune as the managed installer, uploading policy XML to deploy across cloud-managed devices. WDAC relies on hash, publisher certificate, and path rules and supports Microsoft-recommended blocklists; the set of allowed applications is managed in Intune.[^1][^2]

[^1]: [App Control for Business](https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control#app-control-for-business#App Control for Business)

[^2]: [Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)

## Design Decision

> [!NOTE] App Control for Business will be implemented on Windows workstations using WDAC policies deployed via Intune. It will restrict execution to verified applications and drivers.

## Prerequisites

* **Licensing:** Microsoft Intune Plan 1 licensing at minimum. [^1]

* **Dependencies:** App Control for Business configuration is performed via Windows Defender Application Control and can be configured through Intune, including setting up Intune as a managed installer. WDAC policies can be uploaded as an XML file for Intune to package and deploy. WDAC is controlled via Intune for cloud-managed devices and Group Policy for hybrid devices. [^1][^2]

[^1]: [App Control for Business](https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control#app-control-for-business#App Control for Business)
[^2]: [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)

## Implementation Steps

### App Control for Business with Intune

1. Configure App Control for Business in the admin console and set Intune as the managed installer. [^1]

2. Use the built-in App Control for Business options in Intune and, if needed, upload WDAC policy XML for packaging and deployment. [^1]

3. Package and deploy WDAC policies via Intune. Intune can deploy policies as an XML file. [^1]

4. Enable the managed installer in Intune to simplify allowing line-of-business apps. [^1]

5. Deploy WDAC in Audit mode prior to enforcement to validate policy behavior. [^2]

6. Configure WDAC using a combination of publisher certificates and path rules to define trusted software boundaries. [^2]

7. Restrict the following filetypes to an approved set on workstations: executables, software libraries, scripts, installers, compiled HTML, HTML applications, control panel applets, and drivers. [^4]

8. Implement Microsoft’s blocklists: use the recommended application blocklist and the vulnerable driver blocklist. [^4]

9. Deploy WDAC policies via Intune as cloud-managed devices; for hybrid environments, complementary use of Group Policy is possible. [^2]

10. Enable logging of App Control events and forward them to a centralized analytics solution (e.g., Log Analytics). [^4]

11. Maintain and review the allowed applications list in the Intune portal on a regular cadence. [^4]

12. For ML2 and ML3 maturity levels, validate WDAC rule-sets annually (or more frequently). [^4]

13. After successful audit, transition from audit mode to enforcement to block untrusted applications. [^2]

[^1]: [App Control for Business](https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control#app-control-for-business#App Control for Business)
[^2]: [Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)
[^3]: [Application management](https://blueprint.asd.gov.au/design/platform/client/application-management/)
[^4]: [Essential Eight - Application control](https://blueprint.asd.gov.au/security-and-governance/essential-eight/application-control/)