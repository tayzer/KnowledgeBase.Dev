---
date: 2026-06-23
status: Current
tags:
  - cloud-storage
  - object-storage
  - cloud
  - data

---

# Cloud Storage Services

## Quick Reference

**Definition:** Managed cloud services for durable unstructured data, usually exposed through object-storage APIs rather than database tables or POSIX filesystem semantics.

**When to use:**
- Files, media, exports, backups, archives, static assets, and data-lake landing zones.
- Workloads that need high durability, lifecycle rules, access policies, and cloud-native event integration.

**Key Takeaways:**
- Object storage is excellent for durable blobs, but it is not a transactional database.
- Access pattern, security model, lifecycle, request volume, retrieval tier, and egress cost shape the design.
- Storage services often sit beside databases: metadata in a database, large binary objects in object storage.

**Limit:** Providers differ in consistency, IAM, lifecycle, and retrieval/egress charges.

---

## Deep Dive

### Choose Object Storage When

- Data is naturally file-like: documents, images, logs, exports, backups, or lake data.
- The application mostly writes or reads whole objects rather than querying inside them.
- Lifecycle, retention, compliance, or integration with cloud analytics matters.

### Be Careful When

- You need transactional updates across many records.
- You need rich server-side querying over object content.
- You need low-latency random writes inside a file-like structure.

### Design Questions

- What metadata belongs in a database versus on the object?
- Who can read, write, delete, and list objects?
- What is the lifecycle: hot, cool, archive, retention, legal hold, deletion?
- How will the application handle versioning, overwrite races, malware scanning, and event processing?

### Child Notes

- [[Amazon S3]] - AWS object storage with broad ecosystem support and mature lifecycle controls.
- [[Azure Blob Storage]] - Azure object storage for unstructured data with strong Microsoft ecosystem integration.
- [[Google Cloud Storage]] - GCP object storage with simple global object storage semantics and analytics alignment.

## Provider boundaries and cost model

S3, Azure Blob, and Google Cloud Storage expose object-oriented APIs, but their consistency, access tiers/classes, replication, IAM, lifecycle, request charges, and egress rules differ. For a 1 TB archive, estimate storage, retrieval, request, and outbound network costs using current provider pricing before selecting a class. Object storage is not a substitute for a transactional metadata database.

## Sources

- [Azure Blob Storage introduction](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction) (accessed 2026-09-24).
- [Cloud Storage consistency](https://cloud.google.com/storage/docs/consistency) (accessed 2026-09-24).

- [Primary documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html) (accessed 2026-09-24).

## Related Concepts

- [[Data Warehouses]]
- [[Data Lakes]]
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Security and Privacy/_Index]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
