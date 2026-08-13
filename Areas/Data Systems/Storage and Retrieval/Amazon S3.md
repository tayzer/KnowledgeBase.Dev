# Amazon S3
Date: 2026-04-30
Status: Needs Review
Tags: #aws #s3 #object-storage #cloud

## 🎯 TL;DR / Quick Reference

**Definition:** AWS object storage service for durable, scalable storage of files, blobs, backups, archives, and data-lake assets.

**When to use:**
- Storing unstructured files such as media, exports, backups, logs, and static assets.
- Building durable object-storage layers for analytics, archival, or event-driven workflows inside AWS.

**Key Takeaways:**
- ✅ **High durability and scale** make S3 a default choice for many file-based workloads in AWS.
- ✅ **Lifecycle, versioning, and IAM integration** support long-term operational control.
- ⚠️ **It is object storage**: design around objects, prefixes, and policies rather than filesystem or database assumptions.

---

## 📚 Deep Dive

### Good Fit
S3 works well for application uploads, backup storage, static website assets, analytics staging, and long-term archive strategies.

### Design Considerations
- Model access around object keys and bucket policies rather than directory semantics.
- Pay attention to request patterns, lifecycle rules, retention, and retrieval or egress costs.
- Keep security boundaries explicit with IAM, bucket policies, and encryption settings.

## 🔗 Related Concepts
- [[Cloud Storage Services]]
- [[Data Warehouses]]

## 🔄 Review Schedule
- [ ] Review in 3 months
