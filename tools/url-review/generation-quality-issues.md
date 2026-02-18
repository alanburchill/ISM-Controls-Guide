# Control Generation Quality Issues — Lessons Learned

**Review Date:** 2026-02-18 | **Files Reviewed:** 54

---

## Footnote Rules

1. **No duplicate URLs.** One URL = one footnote number. If the same URL is needed more than once, reuse the existing footnote number — never create a second definition for the same URL.
2. **Display text must match the real page title.** Do not invent a descriptive label; use the actual heading of the destination page.
3. **Never link to GitHub raw source files.** `github.com/MicrosoftDocs/.../blob/...` links render as unformatted markdown and may break. Derive the canonical URL: `MicrosoftDocs/defender-docs/blob/public/defender-endpoint/foo.md` → `https://learn.microsoft.com/en-us/defender-endpoint/foo`
4. **All footnote definitions must be complete.** Every `[^N]` reference in the body must have a matching complete `[^N]: [Title](URL)` definition. Every definition must have a non-empty title and URL — no truncated lines.
5. **Citations must directly support the specific claim they follow.** A URL that resolves is not enough — the page must actually contain the relevant information. Do not use product roadmaps, marketing pages, or overview pages to support specific technical claims.
6. **Use the most specific URL available.** Prefer the page that directly covers the claim over a broader overview page that only tangentially touches the topic.

---

## Content Scope Rules

1. **Target platform is Windows 10/11 enterprise via Microsoft Intune (commercial tier).** Do not include iOS, Android, macOS, Intune for Education, or consumer Windows content unless the control title explicitly requires it.
2. **Only cite docs applicable to the enterprise/government deployment context.** Intune for Education, volume licensing partner portals, and OEM-specific docs are not valid references for enterprise hardening controls.

---

## Naming

1. **Microsoft Intune** — always "Intune", never "InTune", "intune", or "INTUNE".

---

## Canonical URLs for Frequently Cited Pages

| Topic | URL | Display Title |
|-------|-----|---------------|
| E8 patch operating systems | `https://learn.microsoft.com/en-us/compliance/anz/e8-patch-os` | Essential Eight patch operating systems |
| E8 patch applications | `https://learn.microsoft.com/en-us/compliance/anz/e8-patch-app` | Essential Eight patch applications |
| E8 user application hardening | `https://learn.microsoft.com/en-us/compliance/anz/e8-app-harden` | Essential Eight user application hardening |
| E8 macro settings | `https://learn.microsoft.com/en-us/compliance/anz/e8-macro` | Essential Eight configure Microsoft Office macro settings |
| E8 MFA conditional access | `https://learn.microsoft.com/en-us/compliance/anz/e8-mfa-configure-conditional-access-policies` | Configure Essential Eight MFA conditional access policies |
| ASR rules reference | `https://learn.microsoft.com/en-us/defender-endpoint/attack-surface-reduction-rules-reference` | Attack surface reduction rules reference |
| Enable ASR rules | `https://learn.microsoft.com/en-us/defender-endpoint/enable-attack-surface-reduction` | Enable attack surface reduction rules |
| Autopatch prerequisites | `https://learn.microsoft.com/en-us/windows/deployment/windows-autopatch/prepare/windows-autopatch-prerequisites` | Windows Autopatch prerequisites |
| .NET Framework 3.5 on Windows | `https://learn.microsoft.com/en-us/dotnet/framework/install/dotnet-35-windows` | Install .NET Framework 3.5 on Windows |
