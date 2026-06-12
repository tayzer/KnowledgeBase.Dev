# Azure Blob Storage
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #azure #blob-storage #object-storage #cloud

## 🎯 TL;DR / Quick Reference

**Definition:** Microsoft Azure object storage service for unstructured data such as files, media, backups, logs, and analytics inputs.

**When to use:**
- Applications already aligned with Azure services and identity patterns.
- Large-scale storage of unstructured data with tiering, lifecycle, and access-control requirements.

**Key Takeaways:**
- ✅ **Strong Azure integration** makes it a natural fit for Microsoft-centric platforms.
- ✅ **Tiering and lifecycle options** help manage cost across hot and colder data.
- ⚠️ **Storage choices affect cost and access**: select tiers and access patterns intentionally.

---

## 📚 Deep Dive

### Good Fit
Azure Blob Storage is a strong fit for document storage, media delivery, application exports, backups, and data pipelines that already live in Azure.

### Design Considerations
- Choose storage tiers based on access frequency and retention patterns.
- Plan for security using managed identities, RBAC, shared access signatures, and encryption.
- Treat it as object storage, not a transactional database or general-purpose filesystem.

## 🔗 Related Concepts
- [[Cloud Storage Services]]
- [[AzureServicesOverview]]

## 🔄 Review Schedule
- [ ] Review in 3 months
