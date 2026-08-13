# PowerShell CLI Essentials
Date: 2025-11-25
Status: Needs Review
Tags: #powershell #cli #devops #automation

## 🎯 TL;DR / Quick Reference

**Definition:** Key PowerShell commands and patterns for automating tasks on Windows and cross-platform scenarios with PowerShell Core.

**When to use:**
- Automation, scripting deployments, dev machine setup, CI tasks.

**Key Takeaways:**
- ✅ **Use `Get-Help` and `Get-Command`** to discover cmdlets.
- ✅ **Prefer parameterized scripts** and `-WhatIf` for safe runs.
- ⚡ **Use `Start-Process` / `Start-Job`** for background tasks.

**Code Snippet:**
```powershell
# Find files and copy changed ones
Get-ChildItem -Path . -Recurse -Filter *.config | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-1) } | Copy-Item -Destination C:\backup
```

**Gotchas:**
- ⚠️ **ExecutionPolicy** can block scripts; use signed scripts or set policy appropriately.
- ⚠️ **String vs. object pipelines:** PowerShell pipelines pass objects, not plain text.

---

## 📚 Deep Dive

### Scripting Best Practices
- Use `param()` block for parameters and `CmdletBinding()` for advanced features.
- Return structured objects rather than formatted strings for pipeline composition.

### Remoting & Automation
- Use `Invoke-Command` and `Enter-PSSession` for remote execution.
- For cross-platform automation, prefer PowerShell Core (pwsh).

### Modules & Packaging
- Use modules to group related functions and `Publish-Module` to share internally.

---

## 🔗 Related Concepts
- [[Areas/Cloud and Platform Engineering/Containers and Orchestration/Containers/Docker and .NET]] (scripts to build/push images)
- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]] (automation with Az modules)

## 📖 Resources
- Microsoft Docs: PowerShell

## 🧪 Practice Exercises
1. Write a script that provisions a resource group in Azure using the `Az` module.
2. Create a reusable module to perform backups and schedule it with Task Scheduler.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 12 months
