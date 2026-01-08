---
title: "PowerShell is configured to use Constrained Language Mode. (ISM-1622)"
ism_control: "ISM-1622"
revision: "0"
updated: "Oct-20"
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
date_generated: "2026-01-06"
---
# PowerShell is configured to use Constrained Language Mode. (ISM-1622)

| Property | Value |
|----------|-------|
| **ISM Control** | ISM-1622 |
| **Revision** | 0 |
| **Updated** | Oct-20 |
| **Guideline** | Guidelines for system hardening |
| **Section** | Operating system hardening |
| **Topic** | PowerShell |
| **Essential Eight** | ML3 |
| **PSPF Levels** | NC, OS, P, S, TS |

## Summary

PowerShell is configured to use Constrained Language Mode.[^5]

Enable Constrained Language Mode via WDAC policy enforced through Intune.[^1]

WDAC policies can be deployed using a mobile device management solution such as Intune.[^1]

## Design Decision

> [!NOTE] Enable Constrained Language Mode by enforcing a WDAC policy through Intune.

## Prerequisites

* **Licensing:** Microsoft 365-related service licensing is described in Microsoft 365 and Office 365 service descriptions. [^1]
* **Permissions/Roles:** Appropriate permissions by administrators across the solutions used within this document. [^1]
* **Dependencies:** Windows 11 22H2 Enterprise; Using Intune for management solution; Defender for Endpoint (endpoint security solution); Microsoft Sentinel (Security information and event management). [^1]

## Implementation Steps

### Enable Constrained Language Mode via WDAC policy enforced through Intune

1. Plan WDAC-based Constrained Language Mode enforcement. Use WDAC as the primary mechanism and deploy via Intune to meet the Essential Eight requirements. [^1]

2. Create the WDAC policy.

   - If using the Windows Defender App Control Wizard:

     1. Open the Windows Defender App Control Wizard and select Policy Creator.
     2. In Policy Creator, select Multiple Policy Format and Base Policy, then Next.
     3. In Policy Template, choose Default Windows Mode or Allow Microsoft Mode.
     4. Modify the Policy Name and Policy File Location, then Next.
     5. In Policy Signing Rules, configure as needed, then Next.
     6. The Wizard generates the policy XML. Complete the wizard to prepare for deployment. [^4]

     Note: The WDAC Wizard guidance is the recommended path for WDAC policy creation and deployment. [^4]

   - If using PowerShell:

     - WDAC policies can be created with Configurable Code Integrity Cmdlets and edited to meet organizational requirements. See policy creation guidance for details. [^3]

3. Deploy the WDAC policy in audit mode via Intune.

   - Sign in to the Intune admin center and navigate to Devices > Configuration Profiles.
   - Create a profile: Platform – Windows 10 or Later, Profile Type Templates and Custom.
   - Name the policy (e.g., WDAC Audit) and proceed to configure OMA-URI settings.
   - Add an entry for the policy: OMA-URI = ./Vendor/MSFT/ApplicationControl/Policies/<PolicyGUID>/Policy; Data Type = Base64 (File).
   - Upload the policy BIN produced from the WDAC policy, then Save.
   - Deploy the profile to the intended device group. [^4]

4. Monitor and refine in audit mode.

   - Use WDAC event data to identify intended and blocked actions. Centralized logging should capture Application Control events for auditing purposes. [^4]

5. Switch from audit to enforcement.

   - In the WDAC policy workflow, open the policy in the Windows Defender App Control Wizard and switch to enforcement (disable Audit Mode) as part of the policy lifecycle.
   - Generate the updated policy and a new CIP file, then update the Intune profile with the new policy binary (compiledPolicy.bin) and the corresponding Policy GUID.
   - Re-deploy the configuration profile to enforce the policy on target devices. Ensure the previously created audit policy is not concurrently enforced where required. [^4]

6. Validate enforcement and Constrained Language Mode.

   - Verify that Constrained Language Mode is active on endpoints (e.g., PowerShell language mode reports ConstrainedLanguage).
   - Confirm App Control events are being generated and analyzed in Defender for Endpoint or a SIEM as appropriate. [^5]

7. Onboard endpoints to Defender for Endpoint for logging and detection.

   - Onboard devices to Defender for Endpoint to enable centralized telemetry, enabling ongoing monitoring of Constrained Language Mode and WDAC policy enforcement. [^2][^5]

8. References and supporting materials.

   - WDAC guidance and policy design details are documented in WDAC/Essential Eight materials and Intune deployment guidance. [^1][^4]
   - Constrained Language Mode is a security feature aligned with the Essential Eight requirements for PowerShell hardening. [^2][^5]

Notes

- The WDAC approach can be complemented with AppLocker in certain scenarios, but WDAC is the recommended solution for ML2/ML3 according to Microsoft guidance. [^1]
- If Using WDAC with a managed installer, ensure the appropriate configuration scripts or policy rules are included in the WDAC policy and deployed via Intune as described. [^1]

Footnotes

## References

[^1]: [Essential Eight application control - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control)

[^2]: [Essential Eight user application hardening - Essential Eight | Microsoft Learn](https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden)

[^3]: [Extension support for the management of Windows Defender Application Control (WDAC) enforced infrastructure | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/extend/guides/application-control-infrastructure-extensions)

[^4]: [Use Windows Defender Application Control on HoloLens 2 devices in Microsoft Intune - Microsoft Intune | Microsoft Learn](https://learn.microsoft.com/en-us/intune/intune-service/configuration/custom-profile-hololens)

[^5]: [PowerShell security features](https://learn.microsoft.com/en-us/powershell/scripting/security/security-features?view=powershell-7.5)
