---
permalink: /controls/ISM-0843.html
title: "Application control is implemented on workstations."
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
date_generated: "2026-01-13"
---

# Application control is implemented on workstations.

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

Not provided in source documentation.

## Design Decision

Use **App Control for Business** to (1) configure the **WDAC policy** and (2) deploy the policy via **Intune**.

> [!NOTE]
> Deploying WDAC policies via Intune centralizes control and enables managed installers.

## Prerequisites

- **Licensing:** **Microsoft Intune Plan 1** licensing is required if Intune is used to configure devices for **App Control for Business** policies.[^1]

- **Permissions/Roles:** Access to the **Microsoft Intune admin center** is required to create and manage **App Control for Business** policies.[^1]

- **Dependencies:** The Intune Management Extension must be configured as a managed installer to deploy **App Control for Business** policies via Intune.[^1]

[^1]: [Manage approved apps for Windows devices with App Control for Business policy and Managed Installers in Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-app-control-policy)

## Implementation Steps

### Configure App Control for Business policy using Intune UI

1. Sign in to the Microsoft Intune admin center. Go to Endpoint security > **App Control for Business** > select the **App Control for Business** tab and then select Create Policy.[^1]

2. On **Basics**, configure:
   - **Name**: Enter a descriptive name for the profile.
   - **Description**: Optional but recommended.

3. On **Configuration settings**, choose a Configuration settings format: **XML data**. If you select this option but don't add XML properties to the policy, it acts as Not configured.  
> [!NOTE]
> If you select XML data and don't add XML properties, the policy acts as Not configured.

4. On **Built-in controls**, configure:
   - **Enable trust of Windows components and store apps**: When this setting is Enabled (the default), managed devices can run Windows components and store apps, as well as other apps you might configure as trusted. Apps that aren't defined as trusted by this policy are blocked from running. This setting also supports an Audit only mode.

5. Under “Select additional options for trusting apps,” enable:
   - **Trust apps with a good reputation**
   - **Trust apps from managed installers**

6. On the **Scope tags** page, select any desired scope tags to apply, then select Next.

7. For **Assignments**, select the groups that receive the policy, then select Next. (Note: WDAC policies apply to only the device scope.)

8. On **Review + create**, review your settings and then select Create. When you select Create, your changes are saved, and the policy is assigned. The policy is also shown in the policy list.

| Setting | Value |
| ------- | ----- |
| Configuration format

## Additional related information

- ASD Blueprint: Windows Defender application control provides design decisions for deploying WDAC on Windows endpoints and management via Intune [ASD Blueprint: Windows Defender application control](https://blueprint.asd.gov.au/design/endpoints/windows/security/windows-defender-application-control/)

- ASD Blueprint: Application control outlines Essential Eight guidance for application control and cloud-managed deployment via Intune [ASD Blueprint: Application control](https://blueprint.asd.gov.au/security-and-governance/essential-eight/application-control/)

- Windows 11 Security Book - Application And Driver Control summarizes App Control and driver restrictions and how Smart App Control complements WDAC [Windows 11 Security Book - Application And Driver Control](https://learn.microsoft.com/en-us/windows/security/book/application-security-application-and-driver-control)

- Essential Eight application control provides guidance on implementing application control using WDAC and related controls for enterprise environments [Essential Eight application control](https://learn.microsoft.com/en-us/compliance/anz/e8-app-control)