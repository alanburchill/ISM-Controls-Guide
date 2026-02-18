# Controls Review Status

Tracks the review progress of each file in `controls/`. Updated as each phase of review is completed.

## Review Phases

| Phase | Description | Status |
|-------|-------------|--------|
| **Lint** | markdownlint errors (MD025, MD060, MD012, etc.) | ✅ Complete — all 54 files clean (PR #11) |
| **Phase 0** | Prompt-leak artifact scan (`ImplementationGuidance`, internal placeholders) | ✅ Complete |
| **Phase 1** | URL validation — sampled Microsoft Learn (25) + ASD Blueprint/GitHub (22) | ✅ Complete |
| **Phase 2** | URL validation — remaining learn.microsoft.com patterns (redirects, 404s, deprecated) | ✅ Complete |
| **Phase 3** | Content accuracy — verify referenced pages support claims made | 🔄 In progress (14/54 complete) |

---

## Per-File Review Status

Legend: ✅ Reviewed & clean | ⚠️ Issues found → fixed | 🔲 Not yet reviewed | ❌ Issues outstanding

> Phases: **L** = Lint, **P0** = Prompt-leak, **P1/P2** = URL validation, **P3** = Content accuracy

| File | Control Description | L | P0 | P1/P2 | P3 | Notes |
|------|---------------------|---|----|-------|----|-------|
| [ISM-0843.md](../controls/ISM-0843.md) | Application control is implemented on workstations. | ✅ | ✅ | ⚠️ | ⚠️ | P1/P2: Fixed old WDAC deployment guide path. P3: Re-cited Group Policy claim from [^4] HoloLens page (wrong source) to [^2]; removed unused [^4] footnote; fixed deployment guide link text to match actual page title |
| [ISM-0974.md](../controls/ISM-0974.md) | MFA used to authenticate unprivileged users of systems. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed [^2] link text to reflect actual page title; fixed PCI-DSS [H] link text mismatch in Additional Info |
| [ISM-1173.md](../controls/ISM-1173.md) | MFA used to authenticate privileged users of systems. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed broken seg2_ops URL (wrong path `/microsoft-365/app-certification/` → `/microsoft-365-app-certification/`); corrected [^1] link text from section heading to page title |
| [ISM-1380.md](../controls/ISM-1380.md) | Privileged users use separate privileged and unprivileged operating environments. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed two broken `www.microsoft.com` PAW URLs (404) → learn.microsoft.com equivalents; updated [^3] title to reflect archived status; added preview caveat to Administrator Protection note |
| [ISM-1412.md](../controls/ISM-1412.md) | Web browsers are hardened using ASD and vendor hardening guidance. | ✅ | ⚠️ | ⚠️ | ⚠️ | P3: Removed wrong iOS/Android [^2] source; corrected [^2] dep reference to [^1]; fixed Edge policies link text mismatch |
| [ISM-1485.md](../controls/ISM-1485.md) | Web browsers do not process web advertisements from the internet. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed wrong [^2] source (MDE onboarding → e8-app-harden); added missing [^3] and [^5] footnote definitions (phantom citations); updated Additional Info link text for [^2] |
| [ISM-1486.md](../controls/ISM-1486.md) | Web browsers do not process Java from the internet. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed [^4] inside blockquote (moved to root); removed blockquote padding lines; added content to empty Justification heading |
| [ISM-1488.md](../controls/ISM-1488.md) | Microsoft Office macros in files originating from the internet are blocked. | ✅ | ✅ | ✅ | ✅ | P3: All URLs verified clean — no changes required |
| [ISM-1504.md](../controls/ISM-1504.md) | MFA used to authenticate users to online services handling sensitive data. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed Security defaults link text: `Configure Security Defaults for...` → `Security defaults in Microsoft Entra ID` |
| [ISM-1511.md](../controls/ISM-1511.md) | Backups of data, applications and settings are performed and retained. | ✅ | ✅ | ⚠️ | ⚠️ | P1/P2: Fixed disk-backup-overview URL. P3: Fixed 3 link text mismatches in Additional Info; removed broken `^[^1]`/`^[^2]` superscript markers from Summary (no definitions existed) |
| [ISM-1542.md](../controls/ISM-1542.md) | Microsoft Office is configured to prevent activation of OLE packages. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed 3× `InTune` → `Intune`; fixed wrong `[^2]` citation for Intune admin access → `[^1]` |
| [ISM-1544.md](../controls/ISM-1544.md) | Microsoft's recommended application blocklist is implemented. | ✅ | ✅ | ✅ | ⚠️ | P3: Fixed dangling `[^8]` (undefined 3× in Prerequisites) → replaced with `[^1]` |
| [ISM-1585.md](../controls/ISM-1585.md) | Web browser security settings cannot be changed by users. | ✅ | ✅ | ✅ | ⚠️ | P3: Added missing `[^3]` and `[^4]` footnote definitions (dangling refs); fixed 3 link text mismatches in Additional Info |
| [ISM-1621.md](../controls/ISM-1621.md) | Windows PowerShell 2.0 is disabled or removed. | ✅ | ✅ | ✅ | ⚠️ | P3: Removed `— Microsoft Learn` / `— GitHub` suffixes from footnote link texts; corrected subsection-heading link text in Additional Info to actual page title |
| [ISM-1622.md](../controls/ISM-1622.md) | PowerShell is configured to use Constrained Language Mode. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1654.md](../controls/ISM-1654.md) | Internet Explorer 11 is disabled or removed. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1655.md](../controls/ISM-1655.md) | .NET Framework 3.5 is disabled or removed. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1659.md](../controls/ISM-1659.md) | Microsoft's vulnerable driver blocklist is implemented. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1667.md](../controls/ISM-1667.md) | Microsoft Office is blocked from creating child processes. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1668.md](../controls/ISM-1668.md) | Microsoft Office is blocked from creating executable content. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1669.md](../controls/ISM-1669.md) | Microsoft Office is blocked from injecting code into other processes. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1670.md](../controls/ISM-1670.md) | PDF applications are blocked from creating child processes. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1671.md](../controls/ISM-1671.md) | Microsoft Office macros are disabled for users without a business requirement. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1672.md](../controls/ISM-1672.md) | Microsoft Office macro antivirus scanning is enabled. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1673.md](../controls/ISM-1673.md) | Microsoft Office macros are blocked from making Win32 API calls. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1674.md](../controls/ISM-1674.md) | Only approved Microsoft Office macros are allowed to execute. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1683.md](../controls/ISM-1683.md) | Successful and unsuccessful MFA events are centrally logged. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1685.md](../controls/ISM-1685.md) | Credentials for break glass, local admin and service accounts are managed. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1686.md](../controls/ISM-1686.md) | Credential Guard functionality is enabled. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1690.md](../controls/ISM-1690.md) | Patches for online services applied within two weeks (non-critical). | ✅ | ✅ | ⚠️ | 🔲 | Replaced deprecated security-controls-v2-posture URL with MCSB equivalent |
| [ISM-1692.md](../controls/ISM-1692.md) | Patches for productivity apps applied within 48 hours (critical). | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1693.md](../controls/ISM-1693.md) | Patches for other applications applied within one month. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1696.md](../controls/ISM-1696.md) | Patches for OS (workstations/non-internet servers) applied within 48 hours (critical). | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1698.md](../controls/ISM-1698.md) | Vulnerability scanner used daily for online services. | ✅ | ✅ | ⚠️ | 🔲 | Fixed auto-deploy-vulnerability-assessment URL slug (renamed) |
| [ISM-1699.md](../controls/ISM-1699.md) | Vulnerability scanner used weekly for productivity apps. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1702.md](../controls/ISM-1702.md) | Vulnerability scanner used fortnightly for OS (workstations/non-internet servers). | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1703.md](../controls/ISM-1703.md) | Vulnerability scanner used fortnightly for drivers. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1704.md](../controls/ISM-1704.md) | Unsupported productivity suites, browsers and security products are removed. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1808.md](../controls/ISM-1808.md) | Vulnerability scanner has an up-to-date vulnerability database. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1810.md](../controls/ISM-1810.md) | Backups are synchronised to enable restoration to a common point in time. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1811.md](../controls/ISM-1811.md) | Backups are retained in a secure and resilient manner. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1815.md](../controls/ISM-1815.md) | Event logs are protected from unauthorised modification and deletion. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1823.md](../controls/ISM-1823.md) | Office productivity suite security settings cannot be changed by users. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1824.md](../controls/ISM-1824.md) | PDF application security settings cannot be changed by users. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1859.md](../controls/ISM-1859.md) | Office productivity suites are hardened using ASD and vendor hardening guidance. | ✅ | ✅ | ⚠️ | 🔲 | Fixed e8-app-hard → e8-app-harden (404) |
| [ISM-1860.md](../controls/ISM-1860.md) | PDF applications are hardened using ASD and vendor hardening guidance. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1861.md](../controls/ISM-1861.md) | Local Security Authority protection functionality is enabled. | ✅ | ✅ | ⚠️ | 🔲 | Fixed windows-security/ and windows-iot/ path prefix errors |
| [ISM-1872.md](../controls/ISM-1872.md) | MFA for online services is phishing-resistant. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1876.md](../controls/ISM-1876.md) | Patches for online services applied within 48 hours (critical). | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1896.md](../controls/ISM-1896.md) | Memory integrity functionality is enabled. | ✅ | ⚠️ | ⚠️ | 🔲 | Fixed prompt-leak; fixed windows-security/ path prefix errors (2 URLs) |
| [ISM-1897.md](../controls/ISM-1897.md) | Remote Credential Guard functionality is enabled. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1900.md](../controls/ISM-1900.md) | Vulnerability scanner used fortnightly for firmware. | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1901.md](../controls/ISM-1901.md) | Patches for productivity apps applied within two weeks (non-critical). | ✅ | ✅ | ✅ | 🔲 | |
| [ISM-1902.md](../controls/ISM-1902.md) | Patches for OS (workstations/non-internet servers) applied within one month (non-critical). | ✅ | ✅ | ✅ | 🔲 | |

---

## Summary

| Phase | Files with issues found | Files fixed | Files clean |
|-------|------------------------|-------------|-------------|
| Lint (L) | 54 | 54 | 54/54 |
| Prompt-leak (P0) | 2 | 2 | 54/54 |
| URL validation (P1/P2) | 8 | 8 | 54/54 |
| Content accuracy (P3) | 13 | 13 | 14/54 |

## Changes Made (Commit `e23c449`)

| File | Change |
|------|--------|
| ISM-1412.md | Removed `ImplementationGuidance` placeholder; replaced deprecated `policy-csp-browser` link with `microsoft-edge-policies` |
| ISM-0843.md | Updated old `threat-protection/windows-defender-application-control` path to canonical App Control for Business deployment guide |
| ISM-1511.md | Fixed `backup-azure-disk-backup` (404) → `disk-backup-overview` |
| ISM-1690.md | Replaced deprecated `security-controls-v2-posture-vulnerability-management` with current MCSB equivalent |
| ISM-1698.md | Fixed `auto-deploy-vulnerability-assessment-defender-vulnerability-management` slug (renamed) |
| ISM-1859.md | Fixed `e8-app-hard` (404) → `e8-app-harden` |
| ISM-1861.md | Fixed `windows-security/identity-protection` and `windows-iot/iot-enterprise` path prefix errors |
| ISM-1896.md | Removed `ImplementationGuidance` placeholder; fixed two `windows-security/` path prefix errors |

## Changes Made (Phase 3 — Content Accuracy Review, files 5–14)

| File | Change |
|------|--------|
| ISM-1412.md | Removed wrong iOS/Android `[^2]` source (Manage Microsoft Edge on iOS/Android) — all ACSC hardening citations now use `[^1]`; fixed Additional Info `Microsoft Edge browser policies` → `Microsoft Edge - Policies` (actual title) |
| ISM-1485.md | Replaced wrong `[^2]` source (MDE onboarding — unrelated to ads blocking) with e8-app-harden page; added missing `[^3]` footnote definition (phantom citation); added missing `[^5]` footnote definition; updated Additional Info link text to match new `[^2]` source |
| ISM-1486.md | Fixed `[^4]` footnote definition inside a blockquote (will not render in kramdown) — moved to root level; removed blockquote padding lines `>\n>\n>`; added placeholder content to empty `### Justification` heading |
| ISM-1488.md | No changes — all URLs verified accurate |
| ISM-1504.md | Fixed Security defaults Additional Info link text: `Configure Security Defaults for Microsoft Entra ID` → `Security defaults in Microsoft Entra ID` (actual page title) |
| ISM-1511.md | Removed broken `^[^1]`/`^[^2]` superscript markers from Summary (no footnote definitions existed for them); fixed 3 Additional Info link texts: `Backup center overview` → `About Backup center for Azure Backup and Azure Site Recovery`; `How to enable Azure Backup` → `Azure Backup service documentation`; `Backups under ACSC Essential Eight` → `Why Pursue ACSC Essential Eight User Backup Guidelines?` |
| ISM-1542.md | Fixed `InTune` → `Intune` in Design Decision and 2 section headings; fixed wrong `[^2]` citation (MS14-064 security bulletin) for Intune admin access claim → `[^1]` (e8-app-harden) |
| ISM-1544.md | Fixed dangling `[^8]` (undefined footnote referenced 3× in Prerequisites) → replaced all with `[^1]` (Application and driver control) |
| ISM-1585.md | Added missing `[^3]` definition (LockdownFavorites → Edge policies reference); added missing `[^4]` definition (DoNotAllowUsersToChangePolicies → device-restrictions-windows-10); fixed 3 Additional Info link text mismatches: privacy settings title, site list location title, and Intune Education page title |
| ISM-1621.md | Removed `— Microsoft Learn` suffix from `[^1]` link text and `— GitHub` suffix from `[^2]`; removed `— Microsoft Learn` from `[^3]`; corrected Additional Info entry `Use Windows PowerShell to disable specific features` → `Add, remove, or hide Windows features` (actual page title; original text was a section heading within the page) |

## Changes Made (Phase 3 — Content Accuracy Review, first 4 files)

| File | Change |
|------|--------|
| ISM-0843.md | Re-cited [^4] HoloLens page (wrong source for Group Policy claim) → `[^2]` appcontrol-and-applocker-overview; re-cited PowerShell claim to `[^3]` e8-app-control; removed now-unused `[^4]` footnote definition; corrected deployment guide link text `App Control for Business Deployment Guide` → `Deploying App Control for Business policies` |
| ISM-0974.md | Corrected `[^2]` link text from generic heading `Create a Conditional Access policy` to reflect actual page title; corrected PCI-DSS link text in Additional Info from `Security domain: phishing-resistant passwordless authentication` → `Microsoft Entra ID and PCI-DSS Requirement 8` |
| ISM-1173.md | Fixed broken `[^4]` seg2_ops URL (`/microsoft-365/app-certification/` → `/microsoft-365-app-certification/`); corrected `[^1]` link text from section heading to actual page title |
| ISM-1380.md | Fixed `[^1]` broken `www.microsoft.com` PAW deployment URL → `learn.microsoft.com` equivalent; fixed broken `privileged-access-strategy` URL on `www.microsoft.com` → `learn.microsoft.com`; updated `[^3]` title to include `(archived)` to reflect Microsoft's archival notice; added `(preview — rollout deferred)` caveat to Administrator Protection note |
