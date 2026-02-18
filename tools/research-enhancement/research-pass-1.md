# Research Enhancement Pass 1 — Progress Report

**Date:** 2026-02-18  
**Controls processed:** 5 (ISM-0843, ISM-0974, ISM-1173, ISM-1380, ISM-1412)  
**Research tool:** Tavily deep research  
**Branch:** `research-review-controls`

---

## Summary

| Control | Topic | Research finding | Enhancement applied | Verdict |
|---------|-------|-----------------|-------------------|---------|
| ISM-0843 | Application control | Significant gaps: HVCI, Managed Installer, rule type guidance, audit duration, policy size limit | Yes | Enhanced |
| ISM-0974 | MFA unprivileged users | Key gap: Authentication Strength (ML2 vs ML3) distinction absent; phishing-resistant MFA path missing | Yes | Enhanced |
| ISM-1173 | MFA privileged users | Same Authentication Strength gap; PIM integration at activation missing | Yes | Enhanced |
| ISM-1380 | Separate privileged environments | PIM/JIT configuration and break-glass account setup absent | Yes | Enhanced |
| ISM-1412 | Browser hardening | Specific policy settings table missing; baseline vs. custom gap not explained | Yes | Enhanced |

All 5 controls had clear, substantive gaps. All 5 were enhanced.

---

## Control detail

### ISM-0843 — Application control is implemented on workstations

**Research gap identified:**  
The original page covered the basic WDAC deployment path (wizard → OMA-URI → Intune) but was missing:
- Guidance on which **rule types** to use (publisher first, hash fallback, path as last resort)
- The role of **Managed Installer** to trust Intune-deployed packages without explicit rules
- **HVCI (Hypervisor-Protected Code Integrity)** recommendation
- **Audit-mode duration** guidance (2–4 weeks minimum)
- The **Intune OMA-URI 350 KB payload limit** and mitigation (supplemental policies)

**Enhancement applied:**
- Expanded Summary to explain publisher/hash/path priority and audit-before-enforce pattern
- Added footnote `[^4]` linking to ASD Blueprint WDAC page
- Added `Managed Installer` as a prerequisite dependency
- Added new `## Policy rule type guidance` section with a table of all rule types, their recommended use, and a NOTE on the OMA-URI size limit

**New footnotes added:**
- `[^4]`: ASD Blueprint — Windows Defender Application Control

---

### ISM-0974 — MFA for unprivileged users

**Research gap identified:**  
The original page gave correct step-by-step CA policy creation but used the generic "Require multi-factor authentication" grant throughout, with no mention of:
- **Authentication Strength** grant control (introduced in Entra ID)
- The **ML2 vs ML3 distinction** for acceptable authenticator types
- **Phishing-resistant MFA** path for higher-maturity deployments
- **Guest/B2B handling** limitation with phishing-resistant MFA

**Enhancement applied:**
- Expanded Summary to explain the ML2/ML3 CA grant difference
- Added new footnotes `[^3]` and `[^4]` linking to the Microsoft Learn ML2 and ML3 Essential Eight MFA pages
- Added new `## MFA grant control by maturity level` section with a table mapping ML2 and ML3 to the correct CA grant
- Added NOTE on Entra P1 licensing requirement for Authentication Strength
- Added NOTE on guest/cross-tenant inbound trust requirement for phishing-resistant MFA

**New footnotes added:**
- `[^3]`: Essential Eight MFA maturity level 2 — Microsoft Learn
- `[^4]`: Essential Eight MFA maturity level 3 — Microsoft Learn

---

### ISM-1173 — MFA for privileged users

**Research gap identified:**  
Mirror of ISM-0974 gap. The original page described a standard MFA CA policy but did not address:
- **Phishing-resistant MFA** requirement for ML3 privileged accounts (FIDO2, WHfB, CBA, passkeys only)
- **Authentication Strength → Phishing-resistant MFA** as the correct CA grant for ML3
- **PIM integration** — requiring phishing-resistant MFA at PIM role activation time

**Enhancement applied:**
- Expanded Summary with ML3 authentication strength requirement for privileged users and PIM integration note
- Added footnotes `[^5]`, `[^6]`, `[^7]` for ML3, Authentication Strengths, and PIM pages
- Updated step 7 of the implementation to show the ML3 alternative grant (Require authentication strength → Phishing-resistant MFA)
- Added three new entries in `## Additional related information`: ML3 page, Authentication Strengths, and the admin phishing-resistant MFA CA template

**New footnotes added:**
- `[^5]`: Essential Eight MFA maturity level 3 — Microsoft Learn
- `[^6]`: Authentication strengths in Conditional Access — Microsoft Learn
- `[^7]`: What is Microsoft Entra Privileged Identity Management? — Microsoft Learn

---

### ISM-1380 — Separate privileged operating environments

**Research gap identified:**  
The original page described a Conditional Access policy for trusted IP enforcement and PAW prerequisites, but was missing:
- **PIM/JIT configuration** steps and recommended activation settings
- **Emergency (break-glass) account** setup, including FIDO2 key requirement, exclusion from CA, and monitoring alerts
- No mention of what to do when the privileged environment must remain accessible if the primary identity infrastructure fails

**Enhancement applied:**
- Expanded Summary to introduce PIM as a complement and define the break-glass account requirement
- Added new `## Just-in-time privileged access with PIM` section with 5-step configuration guide
- Added new `## Emergency (break-glass) account configuration` section with 7-step setup guide and a monitoring NOTE
- Added two new `## Additional related information` entries:
  - Manage emergency access accounts in Microsoft Entra ID
  - Plan a Privileged Identity Management deployment

**No new footnotes added** (existing `[^1]` and `[^4]` cover the new sections adequately).

---

### ISM-1412 — Web browser hardening (Microsoft Edge)

**Research gap identified:**  
The original page explained how to import the ACSC Edge policy and deploy the Edge security baseline, but provided no guidance on:
- Which specific **Edge policy settings** are required by ACSC
- Which settings are **already covered by the Intune Edge security baseline** vs. which must be **added manually**
- The specific policy CSP names for the missing settings (extension blocklist, developer tools, DNS-over-HTTPS, SHA-1 certs, etc.)
- How to validate applied settings (`edge://policy`)

**Enhancement applied:**
- Expanded Summary to note the baseline-vs-custom gap
- Added footnotes `[^7]` and `[^8]` for the Intune Edge baseline settings docs and the ASD Blueprint ACSC Edge policy page
- Added new `## Policy settings: baseline vs. custom` section with a full table of ACSC-required settings, their baseline status (✅ covered / ⚠️ not configured), and the specific CSP/policy name and required value for each gap item
- Added NOTE on validating via `edge://policy`
- Added two new `## Additional related information` entries:
  - Microsoft Edge security baseline settings for Intune
  - ASD Blueprint ACSC Edge Hardening Guidelines configuration

**New footnotes added:**
- `[^7]`: Microsoft Edge security baseline settings for Intune
- `[^8]`: ASD Blueprint — ACSC Edge Hardening Guidelines configuration

---

## Files modified

- `controls/ISM-0843.md`
- `controls/ISM-0974.md`
- `controls/ISM-1173.md`
- `controls/ISM-1380.md`
- `controls/ISM-1412.md`

## Next controls in queue

The next batch (controls 6–10) will be:
- ISM-1485
- ISM-1486
- ISM-1488
- ISM-1504
- ISM-1511
