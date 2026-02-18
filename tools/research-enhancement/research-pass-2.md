# Research Enhancement Pass 2 — ISM-1485 to ISM-1511

Generated: 2026-07-12  
Branch: `research-review-controls`

## Controls enhanced

### ISM-1485 — Web browsers do not process web advertisements

**Gaps resolved:**
- Implementation Step 2 was entirely "Not provided in source documentation."
- Clarified that `AdsSettingForIntrusiveAdsSites` blocks only *intrusive* ads (defined by the Better Ads Standards), not all advertising.
- Added full 8-step Intune implementation: Chrome/Edge policy CSP paths, uBlock Origin force-install (optional ML3 note), DNS filtering alternative.
- Added a new footnote `[^3]` pointing to the Edge policy reference.

---

### ISM-1486 — Web browsers do not process Java from the internet

**Gaps resolved:**
- Implementation steps referenced IE mode settings from 2003/2002 NPAPI era. Major browsers (Chrome, Firefox, Edge, Safari) dropped NPAPI in 2015–2020, making Java in modern browsers impossible without a plug-in.
- Replaced outdated content with four modern sub-sections:
  1. Verify Java is not installed (Control Panel / `Get-Package`)
  2. Disable Internet Explorer 11 via Intune (Turn off Internet Explorer 11 as standalone browser)
  3. Configure MDM security baseline to restrict IE11 further
  4. (Optional) Block JRE via WDAC deny rule using custom policy XML
- Fixed MD022 lint (missing blank line before `### Justification`).

---

### ISM-1488 — Office macros from the internet are blocked

**Gaps resolved:**
- Mark of the Web (MOTW) mechanism was entirely absent — critical because it is the detection mechanism Office uses to identify internet-origin files.
- No ASR rule GUIDs or modes were listed.
- Added **MOTW explanation** (Zone.Identifier ADS, ZoneId=3, Office reads this to trigger macro block).
- Added note on MOTW bypass (FAT32 volumes strip ADS — store files only on NTFS).
- Added **ASR rules table** with all 4 relevant rule GUIDs, display names, and recommended modes (Block/Warn/Audit).
- Added `## Mark of the Web and macro blocking` section integrating the above.

---

### ISM-1504 — MFA for online services handling sensitive data

**Gaps resolved:**
- Summary scope was narrowed to "Volume Licensing Central" as the only example; expanded to clarify the control applies to all online services processing OFFICIAL: Sensitive or higher PSPF data.
- PSPF data classification context (OFFICIAL: Sensitive, PROTECTED) entirely missing.
- ML1/ML2/ML3 distinction table absent.
- Authentication Strength grant (phishing-resistant) not mentioned.
- Added:
  - Expanded summary paragraph explaining PSPF sensitivity classification.
  - `## MFA grant control by maturity level` table (ML1/ML2/ML3 methods and CA grant controls).
  - NOTE callout explaining why "Require authentication strength" is preferred over the legacy MFA grant at ML2/ML3.
  - Two new footnotes: `[^4]` (E8 MFA ISM reference) and `[^5]` (Authentication strengths concept).

---

### ISM-1511 — Backups of data, applications and settings

**Gaps resolved:**
- All four implementation sections contained only "Not provided in source documentation."
- Prerequisites section also blank.
- Added full prerequisites listing dependencies for all four backup scenarios.
- Added full implementation steps for all four sections:

| Section | Steps added |
|---------|-------------|
| **Workstations (KFM)** | Intune admin template: Silently move known folders, Prompt, Prevent redirect, Prevent personal OneDrive; verify via OneDrive Settings |
| **On-prem servers (MARS)** | Download agent + vault credentials; install; register with vault; set passphrase in Key Vault; schedule backup policy |
| **Azure VMs** | Create Recovery Services vault; assign RBAC (Contributor/Operator/VM Contributor); create backup policy with retention tiers; enable immutable vault (optionally lock); MUA via Resource Guard |
| **Microsoft 365** | Set up Backup via admin centre; assign M365 Backup Admin role; select workloads (Exchange, SPO, ODB); set retention up to 7 years; Purview immutable retention; test restore |
- Added 6 new footnotes covering KFM, MARS, VM backup, immutable vault, M365 Backup, and ACSC E8 backup guidance.

## Research sources

- Tavily deep research (model: mini) per control
- Microsoft Learn: `learn.microsoft.com/en-us/compliance/anz/e8-*`
- Microsoft Learn: `learn.microsoft.com/en-us/azure/backup/*`
- Microsoft Learn: `learn.microsoft.com/en-us/microsoft-365/backup/*`
- ACSC Essential Eight Maturity Model — Backups
