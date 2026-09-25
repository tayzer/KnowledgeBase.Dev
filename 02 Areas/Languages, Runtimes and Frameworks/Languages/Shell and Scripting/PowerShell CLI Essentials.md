---
date: 2025-11-25
status: Current
tags:
  - powershell
  - cli
  - devops
  - automation

---

# PowerShell CLI Essentials

## Quick Reference

**Definition:** Key PowerShell commands and patterns for automating tasks on Windows and cross-platform scenarios with PowerShell 7.

**When to use:**
- Automation, scripting deployments, dev machine setup, CI tasks.

**Key Takeaways:**
- **Use `Get-Help` and `Get-Command`** to discover cmdlets.
- **Prefer parameterized scripts** and `-WhatIf` for safe runs.
- Tip: **Choose an execution model:** `Start-Process` starts an external process; `Start-Job` runs background PowerShell work.

**Code Snippet:**
```powershell
# Inspect recently changed configuration files before any copy
Get-ChildItem -File -Filter *.config |
    Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-1) } |
    Select-Object FullName, LastWriteTime
```

**Gotchas:**
- Caution: **ExecutionPolicy** can block scripts; use signed scripts or set policy appropriately.
- Caution: **String vs. object pipelines:** PowerShell pipelines pass objects, not plain text.

---

## Deep Dive

### Scripting Best Practices
- Use `param()` block for parameters and `CmdletBinding()` for advanced features.
- Return structured objects rather than formatted strings for pipeline composition.

### Remoting & Automation
- Use `Invoke-Command` and `Enter-PSSession` for remote execution.
- For cross-platform automation, prefer PowerShell 7 (pwsh).

### Modules & Packaging
- Use modules to group related functions and `Publish-Module` to share internally.

---

## Review refinements

PowerShell pipelines pass objects. A practical inspection pipeline is Get-ChildItem -File | Where-Object Length -gt 1MB | Select-Object Name,Length. Inspect file-operation targets and use -LiteralPath for literal paths. -WhatIf works only on commands that support ShouldProcess. Use -ErrorAction Stop when a nonterminating error must abort a script. Start-Process and Start-Job solve different background execution needs. PowerShell 7 is cross-platform, but commands and utilities can still differ.

## Related Concepts
- [[Docker and .NET]] (scripts to build/push images)
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]] (automation with Az modules)

## Resources

- [PowerShell pipelines](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pipelines?view=powershell-7.5) (accessed 2026-09-24; PowerShell 7.5 documentation).

- [Microsoft Docs: PowerShell](https://learn.microsoft.com/en-us/powershell/)

## Practice Exercises
1. Write a script that provisions a resource group in Azure using the `Az` module.
2. Create a reusable module to perform backups and schedule it with Task Scheduler.

## Review Schedule
- [ ] Review 12 months after promotion; use the approval date as the anchor
