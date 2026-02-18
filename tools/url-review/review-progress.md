# URL Review Progress

Generated: 2026-02-18  
Branch: research-review-controls  
Total files: 54

## Status Legend
- `[ ]` = Not reviewed
- `[OK]` = Reviewed, URL valid and relevant
- `[FIX]` = Issue found, fix applied
- `[SKIP]` = No footnotes / not applicable

---

## Review Status by File

| File | Status | Notes |
|------|--------|-------|
| ISM-0843.md | `[OK]` | ASD Blueprint app control, WDAC overview, E8 app control — all valid |
| ISM-0974.md | `[OK]` | E8 MFA CA policies, Compliant device/MFA CA policy, secure sign-in, phishing-resistant — all valid |
| ISM-1173.md | `[OK]` | CA compliant/hybrid device, secure sign-in for hybrid workers, operational security domain — all valid |
| ISM-1380.md | `[OK]` | Privileged access deployment, best practices, legacy PAW, MCSB privileged access, ASD Blueprint — all valid |
| ISM-1412.md | `[OK]` | E8 app hardening, Edge for Business Intune — both valid (Edge for Business is context for Intune usage) |
| ISM-1485.md | `[FIX]` | Removed duplicate [^2], removed Intune Education [^3][^5] |
| ISM-1486.md | `[OK]` | ms03-011/ms02-052 valid Java VM bulletins — relevant to Java hardening control |
| ISM-1488.md | `[OK]` | Single ref: E8 macro settings — valid |
| ISM-1504.md | `[OK]` | VLC MFA URL matches design decision (implementing MFA for Volume Licensing Central app) |
| ISM-1511.md | `[SKIP]` | No footnotes |
| ISM-1542.md | `[FIX]` | Fixed InTune→Intune typo |
| ISM-1544.md | `[OK]` | Single ref: application and driver control — valid |
| ISM-1585.md | `[FIX]` | Merged duplicate `[^4]` (same URL as `[^2]` device-restrictions-windows-10) into `[^2]` |
| ISM-1621.md | `[OK]` | E8 app hardening, UserApplicationHardening-RemoveFeatures.ps1 script, PowerShell scripts in Intune — all valid |
| ISM-1622.md | `[OK]` | E8 app hardening, ASD Blueprint WDAC, App Control with PowerShell, Use App Control to secure PowerShell — all valid |
| ISM-1654.md | `[OK]` | E8 app hardening, Disable IE11, Policy CSP IE, ASD Blueprint app hardening, IE lifecycle FAQ, Edge neededge redirect — all valid |
| ISM-1655.md | `[FIX]` | Replaced irrelevant Windows Roadmap `[^6]` with .NET 3.5 optional features doc |
| ISM-1659.md | `[FIX]` | Removed duplicate [^3] |
| ISM-1667.md | `[OK]` | E8 app hardening, ASR policy settings Intune — both valid |
| ISM-1668.md | `[FIX]` | Replaced GitHub raw URLs `[^8]``[^3]` with learn.microsoft.com/en-us/defender-endpoint/asr-rules-reference |
| ISM-1669.md | `[FIX]` | Replaced GitHub raw URLs `[^1]``[^3]` with learn.microsoft.com/en-us/defender-endpoint/asr-rules-reference |
| ISM-1670.md | `[OK]` | E8 app hardening, ASR Intune settings, ms16-102/CVE-2016-3319 PDF RCE — all valid for PDF child process blocking |
| ISM-1671.md | `[OK]` | Single ref: E8 macro settings — valid |
| ISM-1672.md | `[OK]` | Single ref: E8 macro settings — valid |
| ISM-1673.md | `[FIX]` | Replaced GitHub raw URLs `[^3]``[^6]` with learn.microsoft.com/en-us/defender-endpoint/asr-rules-reference |
| ISM-1674.md | `[OK]` | E8 macro settings, ASD Blueprint Office hardening, ransomware protection devices — all valid |
| ISM-1683.md | `[OK]` | Entra activity logs, ASD Blueprint auth hardening, MFA reporting — all valid |
| ISM-1685.md | `[OK]` | Manage emergency access accounts, MCSB PA-5 set up emergency access — both valid |
| ISM-1686.md | `[OK]` | Credential Guard configure, Remote Credential Guard, protected machine accounts, Intune endpoint protection profile, Credential Guard overview — all valid |
| ISM-1690.md | `[FIX]` | Fixed misleading title on `[^2]`: was "Autopatch enrollment steps" → now "Essential Eight patch operating systems" |
| ISM-1692.md | `[OK]` | ASD Blueprint Windows update patching, E8 patch apps, E8 patch OS — all valid |
| ISM-1693.md | `[OK]` | E8 patch apps, Hotpatch updates, Windows updates API overview — all valid |
| ISM-1696.md | `[OK]` | Both refs (e8-patch-app, e8-patch-os) correct |
| ISM-1698.md | `[FIX]` | Merged duplicate `[^6]` (same URL as `[^10]` deploy-vulnerability-assessment) into `[^10]` |
| ISM-1699.md | `[OK]` | E8 patch apps, Enable vulnerability scanning, Vulnerability management overview — all valid |
| ISM-1702.md | `[OK]` | E8 patch OS, Enable vulnerability scanning, Vulnerabilities in my organization — all valid |
| ISM-1703.md | `[OK]` | Single ref: E8 patch OS — valid |
| ISM-1704.md | `[FIX]` | Removed iOS-only section and [^2] |
| ISM-1808.md | `[OK]` | E8 patch OS, E8 patch apps — both valid |
| ISM-1810.md | `[OK]` | SQL Arc backup [^7] relevant — step 5 specifically covers Azure Arc-enabled SQL Server deployments |
| ISM-1811.md | `[OK]` | E8 backups, Azure backup MARS agent, PowerShell automation, Azure Backup architecture, MCSB backup recovery — all valid |
| ISM-1815.md | `[FIX]` | Removed duplicate [^2] |
| ISM-1823.md | `[OK]` | E8 app hardening, Intune settings catalog, E8 macro settings — all valid |
| ISM-1824.md | `[OK]` | Single ref: E8 app hardening — valid |
| ISM-1859.md | `[OK]` | E8 app hardening, E8 macro settings, Intune app deployment, ASR Intune settings, Block macros from internet — all valid |
| ISM-1860.md | `[OK]` | CVE-2016-3198 (Edge CSP bypass) and CVE-2016-3203 (Windows PDF RCE) — both valid and relevant to PDF hardening justification |
| ISM-1861.md | `[OK]` | LSA CSP policy, Credential Guard considerations, IoT Enterprise LTSC 2024, LSA protection configure, E8 restrict admin privs — all valid |
| ISM-1872.md | `[FIX]` | Fixed truncated/broken `[^9]` definition; merged duplicate `[^9]` (same URL as `[^3]` phishing-resistant MFA CA policy) into `[^3]` |
| ISM-1876.md | `[FIX]` | Removed duplicate [^6] |
| ISM-1896.md | `[FIX]` | Merged duplicate `[^2]` (same URL as `[^9]` device-guard-and-credential-guard) into `[^9]` |
| ISM-1897.md | `[OK]` | Remote Credential Guard, Configure Credential Guard, Intune endpoint protection profile — all valid |
| ISM-1900.md | `[OK]` | E8 patch OS, Defender Vulnerability Management overview — both valid |
| ISM-1901.md | `[OK]` | E8 patch apps, ASD Blueprint Windows update patching — both valid |
| ISM-1902.md | `[FIX]` | Fixed [^4] wrong Autopatch prerequisites URL |

---

## URLs Requiring Validation (Suspicious / Unverified)

### High Priority
| URL | Used In | Concern |
|-----|---------|---------|
| `https://learn.microsoft.com/en-us/security-updates/securitybulletins/2003/ms03-011` | ISM-1486 [^3] | 2003 security bulletin - very old |
| `https://learn.microsoft.com/en-us/security-updates/securitybulletins/2002/ms02-052` | ISM-1486 [^5] | 2002 security bulletin - very old |
| `https://learn.microsoft.com/en-us/volume-licensing-central/learning/mfa/how-to-enable-mfa` | ISM-1504 [^2] | VLC MFA - correct? |
| `https://www.microsoft.com/en-us/windows/business/roadmap` | ISM-1655 [^6] | Windows roadmap page - still valid? |
| `https://github.com/MicrosoftDocs/defender-docs/blob/public/defender-endpoint/attack-surface-reduction-rules-reference.md` | ISM-1668 [^8], ISM-1669 [^1][^3], ISM-1673 [^3][^6] | GitHub source file - should be hosted docs URL |
| `https://learn.microsoft.com/en-us/sql/sql-server/azure-arc/backup-local` | ISM-1810 [^7] | SQL Arc backup - relevant to ISM-1810? |
| `https://www.cve.org/CVERecord?id=CVE-2016-3198` | ISM-1860 [^4] | cve.org record for Edge CVE |
| `https://www.cve.org/CVERecord?id=CVE-2016-3203` | ISM-1860 [^5] | cve.org record for PDF CVE |

### Possible Duplicates
| File | Duplicate refs | Same URL? |
|------|---------------|-----------|
| ISM-1698.md | [^6] and [^10] | Both `deploy-vulnerability-assessment-defender-vulnerability-management` |
| ISM-1896.md | [^2] and [^9] | Both `device-guard-and-credential-guard` |
| ISM-1585.md | [^2] and [^4] | Both `device-restrictions-windows-10` |

---

## Confirmed Valid URLs (from previous pass)
- `https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden` ✅
- `https://learn.microsoft.com/en-us/compliance/anz/e8-patch-os` ✅
- `https://learn.microsoft.com/en-us/compliance/anz/e8-patch-app` ✅
- `https://learn.microsoft.com/en-us/compliance/anz/e8-mfa-configure-conditional-access-policies` ✅
- `https://learn.microsoft.com/en-us/windows/deployment/windows-autopatch/prepare/windows-autopatch-prerequisites` ✅
- `https://learn.microsoft.com/en-us/windows/deployment/windows-autopatch/overview/windows-autopatch-faq` ✅
