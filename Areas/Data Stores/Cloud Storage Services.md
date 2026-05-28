# Cloud Storage Services
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #cloud-storage #object-storage #cloud #data

## 🎯 TL;DR / Quick Reference

**Definition:** A category of managed cloud services for storing large volumes of unstructured data, usually through object-storage APIs rather than traditional filesystem semantics.

**When to use:**
- File, media, backup, archive, and data-lake workloads that need high durability and elastic scale.
- Systems that benefit from managed storage, lifecycle rules, access policies, and cloud-native integrations.

**Key Takeaways:**
- ✅ **Elastic scale and durability** make cloud object storage a default choice for many file-based workloads.
- ✅ **Managed lifecycle and security controls** reduce operational burden.
- ⚠️ **Access patterns and pricing matter**: latency, request volume, retrieval charges, and egress costs can shape the right choice.

---

## 📚 Deep Dive

### What This Category Covers
These services are usually object stores rather than block or POSIX filesystems. They are excellent for durable storage, data distribution, static assets, and analytics staging, but they should not be treated as direct replacements for transactional databases.

### How To Choose Within This Category
- Choose based on cloud alignment: AWS, Azure, or GCP ecosystem fit.
- Choose based on data lifecycle needs: hot, infrequent-access, archive, retention, and compliance requirements.
- Choose based on access patterns: global distribution, analytics integration, eventing, and security model.

### Child Notes
- [[Amazon S3]] - AWS object storage with broad ecosystem support and mature lifecycle controls.
- [[Azure Blob Storage]] - Azure object storage for unstructured data with strong Microsoft ecosystem integration.
- [[Google Cloud Storage]] - GCP object storage with simple global object storage semantics and analytics alignment.

## 🔗 Related Concepts
- [[Data Warehouses]]
- [[Relational Databases]]

## 🔄 Review Schedule
- [ ] Review in 3 months